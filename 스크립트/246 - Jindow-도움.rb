#----------------------------------------------------------------------------------
# *배경음 및 효과음 음량 조절
# 제작자: 크랩훕흐
#----------------------------------------------------------------------------------
class Jindow_help < Jindow
	
	#정보 설정
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 500, 250)
		self.name = "도움말"
		@head = true
		@drag = true
		@close = true
		#self.refresh "help"
		
		self.x = 640 / 2 - self.width / 2
		self.y = 480 / 2 - self.height / 2
		
		@text_size = 17 # 폰트 사이즈
		@text_size2 = 13 # 폰트 사이즈
		
		@page = 0 # 현재 페이지
		@page_max_num = 10 # 한 페이지에 최대 보여질 개수
		
		@helps = [
			["[s]", "무기를 들어야 일반공격 할 수 있습니다."],
			["[i]", "인벤토리를 열 수 있습니다."],
			["[c]", "현재 자신의 상태창을 열 수 있습니다."],
			["[k]", "현재 습득한 스킬 목록을 볼 수 있습니다."],
			["[j]", "현재 단축키에 등록한 목록을 볼 수 있습니다."],
			["[l]", "현재 접속한 유저 목록을 볼 수 있습니다."],
			["[p]", "파티창을 열 수 있습니다."],
			["[;]", "감정표현을 할 수 있습니다."],
			["[m]", "현재 맵의 미니맵을 확인 할 수 있습니다."],
			["[e]", "UI를 on/off 할 수 있습니다."],
			["[r]", "버프/딜레이창을 on/off할 수 있습니다."],
			["[f]", "대화창을 on/off할 수 있습니다."],
			["[v]", "콘솔 창을 on/off할 수 있습니다."],
			["[alt+enter]", "전체화면으로 변경할 수 있습니다."],
			["[z/del/space]", "npc와 상호작용 및 아이템을 습득 할 수 있습니다."],
			["[`]", "시스템 창을 열 수 있습니다."],
			["[g]", "길드 창을 열 수 있습니다.(아직 미구현입니다)"],
		]
		@page_max = @helps.size / @page_max_num # 페이지의 최대 개수
		
		# 도움말 텍스트
		@text = Sprite.new(self)
		@text.bitmap = Bitmap.new(self.width, self.height)
		@text.x = 0
		@text.y = 0
		@text.bitmap.font.color = Color.new(100, 200, 200)
		@text.bitmap.font.size = @text_size
		
		@text2 = Sprite.new(self)
		@text2.bitmap = Bitmap.new(self.width, self.height)
		@text2.x = 0
		@text2.y = 0
		@text2.bitmap.font.size = @text_size2
		
		@t_color = Color.new(255, 100, 100)
		@ex_size = 3
		@ex_size_x = 140
		
		temp_y = 0
		for i in 0...@page_max_num
			n = (@page * @page_max_num) + i
			break if @helps[n] == nil
			@text.bitmap.draw_frame_text(0, i * (@text_size + @ex_size), self.width, (@text_size + @ex_size), @helps[n][0])
			@text2.bitmap.draw_frame_text(@ex_size_x, i * (@text_size + @ex_size) + (@text_size - @text_size2), self.width, @text_size2, @helps[n][1])
			temp_y = i * (@text_size + @ex_size)
		end
		
		@prev_button = J::Button.new(self).refresh(30, "◀")
		@prev_button.x = self.width / 2 - @prev_button.width
		@prev_button.y = temp_y + (@text_size + @ex_size)
		
		@next_button = J::Button.new(self).refresh(30, "▶")
		@next_button.x = @prev_button.x + @prev_button.width + 5
		@next_button.y = @prev_button.y
		
		@text_page = Sprite.new(self)
		@text_page.y = @next_button.y + 20 
		@text_page.bitmap = Bitmap.new(100, 20)
		@text_page.bitmap.draw_frame_text(0, 0, self.width, 20, "#{@page + 1} / #{@page_max + 1}")
		
		self.height = @text_page.y + 40
		self.refresh "help"
	end
	
	def update
		super
		if @prev_button.click
			@page = (@page - 1)
			@page = @page < 0 ? @page_max : @page
			
			@text.bitmap.clear
			@text2.bitmap.clear
			@text_page.bitmap.clear
			@text_page.bitmap.draw_frame_text(0, 0, self.width, 20, "#{@page + 1} / #{@page_max + 1}")
			
			for i in 0...@page_max_num
				n = (@page * @page_max_num) + i
				break if @helps[n] == nil
				@text.bitmap.draw_frame_text(0, i * (@text_size + @ex_size), self.width, (@text_size + @ex_size), @helps[n][0])
				@text2.bitmap.draw_frame_text(@ex_size_x, i * (@text_size + @ex_size) + (@text_size - @text_size2), self.width, @text_size2, @helps[n][1])
			end
		end
		
		if @next_button.click
			@page = (@page + 1)
			@page = @page > @page_max ? 0 : @page
			
			@text.bitmap.clear
			@text2.bitmap.clear
			@text_page.bitmap.clear
			@text_page.bitmap.draw_frame_text(0, 0, self.width, 20, "#{@page + 1} / #{@page_max + 1}")
			
			for i in 0...@page_max_num
				n = (@page * @page_max_num) + i
				break if @helps[n] == nil
				@text.bitmap.draw_frame_text(0, i * (@text_size + @ex_size), self.width, (@text_size + @ex_size), @helps[n][0])
				@text2.bitmap.draw_frame_text(@ex_size_x, i * (@text_size + @ex_size) + (@text_size - @text_size2), self.width, @text_size2, @helps[n][1])
			end
		end
	end
end

