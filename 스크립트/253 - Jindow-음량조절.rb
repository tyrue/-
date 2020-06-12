#----------------------------------------------------------------------------------
# *배경음 및 효과음 음량 조절
# 제작자: 크랩훕흐
#----------------------------------------------------------------------------------
class Jindow_volume < Jindow
	
	#정보 설정
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 500, 400)
		self.name = "음량 조절"
		@head = true
		@drag = true
		@close = true
		self.refresh "volume"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@menu = [
			"배경음",
			"효과음"
		]
		
		@start_x = 0 # 텍스트 스프라이트 초기 x, y
		@start_y = 0
		@font_size = 12
		
		@text = []
		for i in 0..@menu.size
			@text[i] = Sprite.new(self)
			@text[i].bitmap = Bitmap.new(100, 20) # x, y 크기의 비트맵 상자를 생성
			@text[i].x = @start_x
			@text[i].y = @start_y + @font_size * i
			@text[i].bitmap.font.size = @font_size
			@text[i].bitmap.font.color.set(0, 0, 0, 255)
			@text[i].bitmap.draw_text(0, 0, 100, 20, "#{@menu[i]} : ", 0)
		end
	end
	
	# 12 : 배경음, 13 : 효과음
	def update
		super
		
		
	end
end

