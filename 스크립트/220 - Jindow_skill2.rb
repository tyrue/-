#----------------------------------------------------------------------------------
# *진도우 스킬창
#----------------------------------------------------------------------------------
class Jindow_Skill < Jindow
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 400, 100)
		self.name = "⊙ 스킬창"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh "Skill"
		
		@actor = $game_party.actors[0]
		@data = []
		
		for i in 0...@actor.skills.size
			skill = $data_skills[@actor.skills[i]]
			if skill != nil
				@data.push(skill)
			end
		end
		
		skill_button = []
		@page_n = 10
		
		@page = []
		@now_page = 1
		@max_page = @data.size / @page_n + 1
		
		@s1 = Sprite.new(self)
		@s1.bitmap = Bitmap.new(100, 20) # x, y 크기의 비트맵 상자를 생성
		@s1.x = 5
		@s1.y = 0
		@s1.bitmap.font.size = 12
		@s1.bitmap.font.color.set(0, 0, 0, 255)
		@s1.bitmap.draw_text(0, 0, 100, 20, "페이지 : #{@now_page}", 0)
		
		@s2 = Sprite.new(self)
		@s2.bitmap = Bitmap.new(200, 20) # x, y 크기의 비트맵 상자를 생성
		@s2.x = 5
		@s2.y = @s1.y + @s1.height + 2
		@s2.bitmap.font.size = 12
		@s2.bitmap.font.color.set(0, 0, 0, 255)
		@s2.bitmap.draw_text(0, 0, @s2.width, 20, "마우스 왼쪽:스킬 사용 / 마우스 오른쪽:정보 확인", 0)
		
		@p_x = 30
		for i in 0...@page_n
			@page[i] = J::Button.new(self).refresh(120, "#{i + 1} : " + @data[i].name, 0)
			@page[i].x = @p_x
			@page[i].y = (@page[i].y + @page[i].height + 3) * (i) + (@s2.y + @s2.height)
		end
		
		@prev_button = J::Button.new(self).refresh(30, "◀")
		@prev_button.x = 60
		@prev_button.y = @page[@page_n - 1].y + @page[@page_n - 1].height+ 10
		
		@next_button = J::Button.new(self).refresh(30, "▶")
		@next_button.x = @prev_button.x + @prev_button.width + 5
		@next_button.y = @page[@page_n - 1].y + @page[@page_n - 1].height+ 10
		
		self.width = @s2.x + @s2.width
		self.height = @next_button.y + @next_button.height + 10
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		self.refresh("Skill")
	end
	
	def update
		super
		if @prev_button.click
			for i in 0...@page_n
				break if @page[i] == nil
				@page[i].dispose if !@page[i].disposed?
				@page[i] == nil
			end
			if @now_page == 1
				@now_page = @max_page 
			else
				@now_page -= 1
			end
			@s1.bitmap.clear
			@s1.bitmap.draw_text(0, 0, 100, 20, "페이지 : #{@now_page}", 0)
			
			for i in 0...@page_n
				break if @data[(@now_page - 1) * @page_n + i] == nil
				@page[i] = J::Button.new(self).refresh(120, "#{(@now_page - 1) * @page_n + i + 1} : " + @data[(@now_page - 1) * @page_n + i].name, 0)
				@page[i].x = @p_x
				@page[i].y = (@page[i].y + @page[i].height + 3) * (i) + (@s2.y + @s2.height)
			end
		end
		
		if @next_button.click
			for i in 0...@page_n
				break if @page[i] == nil
				@page[i].dispose if !@page[i].disposed?
				@page[i] == nil
			end
			
			if @now_page == @max_page
				@now_page = 1
			else
				@now_page += 1
			end
			@s1.bitmap.clear
			@s1.bitmap.draw_text(0, 0, 100, 20, "페이지 : #{@now_page}", 0)
			
			for i in 0...@page_n
				break if @data[(@now_page - 1) * @page_n + i] == nil
				@page[i] = J::Button.new(self).refresh(120, "#{(@now_page - 1) * @page_n + i + 1} : " + @data[(@now_page - 1) * @page_n + i].name, 0)
				@page[i].x = @p_x
				@page[i].y = (@page[i].y + @page[i].height + 3) * (i) + (@s2.y + @s2.height)
			end
		end
		
		for i in 0...@page_n
			next if @page[i] == nil
			next if @page[i].disposed?
			
			if @page[i].click  
				$ABS.player_skill(@data[(@now_page - 1) * @page_n + i].id)
				$ABS.player_explode(@data[(@now_page - 1) * @page_n + i].id)
			elsif @page[i].r_click
				Hwnd.dispose("Skill_Info")
				Jindow_Skill_Info.new(@data[(@now_page - 1) * @page_n + i])
			end
		end
	end
	
end