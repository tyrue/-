#----------------------------------------------------------------------------------
# *배경음 및 효과음 음량 조절
# 제작자: 크랩훕흐
#----------------------------------------------------------------------------------
class Jindow_volume < Jindow
	
	#정보 설정
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 200, 100)
		self.name = "음량 조절"
		@head = true
		@drag = true
		@close = true
		self.refresh "volume"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@menu_t = [
			["배경음 : ", $game_variables[12]],
			["효과음 : ", $game_variables[13]]
		]
		
		@menu = []
		@start_x = 0 # 텍스트 스프라이트 초기 x, y
		@start_y = 20
		@font_size = 12
		@button_size = 30
		
		@text = []
		@menu2 = [] # on, off 버튼
		@menu_t2 = ["Max", "Min"]
		for i in 0...@menu_t.size
			@text[2 * i] = Sprite.new(self)
			@text[2 * i].bitmap = Bitmap.new(60, 20) # x, y 크기의 비트맵 상자를 생성
			@text[2 * i].x = @start_x
			@text[2 * i].y = @start_y + @font_size * (i * 2)
			@text[2 * i].bitmap.font.size = @font_size
			@text[2 * i].bitmap.font.color.set(0, 0, 0, 255)
			@text[2 * i].bitmap.draw_text(0, 0, 100, 20, "#{@menu_t[i][0]}", 0)
			
			@menu[2 * i] = J::Button.new(self).refresh(@button_size.to_i, "◀")
			@menu[2 * i].x = @text[2 * i].x + @text[2 * i].width + 10
			@menu[2 * i].y = @text[2 * i].y
			
			@text[2 * i + 1] = Sprite.new(self)
			@text[2 * i + 1].bitmap = Bitmap.new(30, 20) # x, y 크기의 비트맵 상자를 생성
			@text[2 * i + 1].x = @menu[2 * i].x + @menu[2 * i].width + 10
			@text[2 * i + 1].y = @menu[2 * i].y
			@text[2 * i + 1].bitmap.font.size = @font_size
			@text[2 * i + 1].bitmap.font.color.set(0, 0, 0, 255)
			@text[2 * i + 1].bitmap.draw_text(0, 0, 100, 20, "#{@menu_t[i][1]}", 0)
			
			@menu[2 * i + 1] = J::Button.new(self).refresh(@button_size.to_i, "▶")
			@menu[2 * i + 1].x = @text[2 * i + 1].x + @text[2 * i + 1].width + 10
			@menu[2 * i + 1].y = @text[2 * i + 1].y
			
			for j in 0...@menu_t2.size
				@menu2[j + i * @menu_t.size] = J::Button.new(self).refresh(@button_size.to_i, @menu_t2[j].to_s)
				@menu2[j + i * @menu_t.size].x = @menu[2 * i + 1].x + @menu[2 * i + 1].width + @button_size.to_i * j
				@menu2[j + i * @menu_t.size].y = @menu[2 * i + 1].y
			end
		end
		
		self.width = @menu2[@menu2.size - 1].x + @menu2[@menu2.size - 1].width + 10
		self.refresh "volume"
	end
	
	# 12 : 배경음, 13 : 효과음
	def update
		super
		if @menu[0].click
			if $game_variables[12] > 0
				$game_variables[12] -= 10
				$game_variables[12] = 0 if $game_variables[12] < 0
				$game_system.bgm_play($game_system.playing_bgm)
				
				@text[1].bitmap.clear
				@text[1].bitmap.font.size = @font_size
				@text[1].bitmap.font.color.set(0, 0, 0, 255)
				@text[1].bitmap.draw_text(0, 0, 100, 20, "#{$game_variables[12]}", 0)
			else
				$game_variables[12] = 0
			end
		elsif @menu[1].click
			if $game_variables[12] < 100
				$game_variables[12] += 10
				$game_variables[12] = 100 if $game_variables[12] > 100
				$game_system.bgm_play($game_system.playing_bgm)
				
				@text[1].bitmap.clear
				@text[1].bitmap.font.size = @font_size
				@text[1].bitmap.font.color.set(0, 0, 0, 255)
				@text[1].bitmap.draw_text(0, 0, 100, 20, "#{$game_variables[12]}", 0)
			else
				$game_variables[12] = 100
			end
		elsif @menu[2].click
			if $game_variables[13] > 0
				$game_variables[13] -= 10
				$game_variables[13] = 0 if $game_variables[13] < 0
				
				@text[3].bitmap.clear
				@text[3].bitmap.font.size = @font_size
				@text[3].bitmap.font.color.set(0, 0, 0, 255)
				@text[3].bitmap.draw_text(0, 0, 100, 20, "#{$game_variables[13]}", 0)
			else
				$game_variables[13] = 0
			end
		elsif @menu[3].click
			if $game_variables[13] < 100
				$game_variables[13] += 10
				$game_variables[13] = 100 if $game_variables[13] > 100
				
				@text[3].bitmap.clear
				@text[3].bitmap.font.size = @font_size
				@text[3].bitmap.font.color.set(0, 0, 0, 255)
				@text[3].bitmap.draw_text(0, 0, 100, 20, "#{$game_variables[13]}", 0)
			else
				$game_variables[13] = 100
			end
		end
		
		# 배경음
		# on
		if @menu2[0].click
			$game_variables[12] = 100
			$game_system.bgm_play($game_system.playing_bgm)
			
			@text[1].bitmap.clear
			@text[1].bitmap.font.size = @font_size
			@text[1].bitmap.font.color.set(0, 0, 0, 255)
			@text[1].bitmap.draw_text(0, 0, 100, 20, "#{$game_variables[12]}", 0)
		end
		# off
		if @menu2[1].click
			$game_variables[12] = 0
			$game_system.bgm_play($game_system.playing_bgm)
			
			@text[1].bitmap.clear
			@text[1].bitmap.font.size = @font_size
			@text[1].bitmap.font.color.set(0, 0, 0, 255)
			@text[1].bitmap.draw_text(0, 0, 100, 20, "#{$game_variables[12]}", 0)
		end
		
		# 효과음
		# on
		if @menu2[2].click
			$game_variables[13] = 100
			
			@text[3].bitmap.clear
			@text[3].bitmap.font.size = @font_size
			@text[3].bitmap.font.color.set(0, 0, 0, 255)
			@text[3].bitmap.draw_text(0, 0, 100, 20, "#{$game_variables[13]}", 0)
		end
		# off
		if @menu2[3].click
			$game_variables[13] = 0
			
			@text[3].bitmap.clear
			@text[3].bitmap.font.size = @font_size
			@text[3].bitmap.font.color.set(0, 0, 0, 255)
			@text[3].bitmap.draw_text(0, 0, 100, 20, "#{$game_variables[13]}", 0)
		end
	end
end

