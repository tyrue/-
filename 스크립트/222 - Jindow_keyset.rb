#----------------------------------------------------------------------------------
# *진도우 단축키 확인 창
#----------------------------------------------------------------------------------
class Jindow_Keyset < Jindow
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 250, 170)
		self.name = "⊙ 단축키 확인"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh("Keyset") 
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@keyset = []
		@keyset2 = []
		
		@x2 = 125
		
		@s1 = Sprite.new(self)
		@s1.bitmap = Bitmap.new(100, 20) # x, y 크기의 비트맵 상자를 생성
		@s1.x = 0
		@s1.y = 0
		@s1.bitmap.font.size = 13
		@s1.bitmap.font.color.set(0, 0, 0, 255)
		@s1.bitmap.draw_text(0, 0, 100, 20, "키보드 숫자", 0)
		
		@s2 = Sprite.new(self)
		@s2.bitmap = Bitmap.new(100, 20) # x, y 크기의 비트맵 상자를 생성
		@s2.x = @x2
		@s2.y = 0
		@s2.bitmap.font.size = 13
		@s2.bitmap.font.color.set(0, 0, 0, 255)
		@s2.bitmap.draw_text(0, 0, 100, 20, "키패드 숫자", 0)
		
		@k_value = []
		@i = -1
		# $ABS.skill_keys.sort # [k, v]에서 k 순으로 정렬됨
		for key in $ABS.skill_keys.sort
			@i += 1
			next if key[1] == nil or key[1] == 0
			next if !$game_party.actors[0].skill_learn?(key[1])
			@k_value[@i] = $data_skills[key[1]].name
		end
		
		@i = -1
		for key in $ABS.item_keys.sort
			@i += 1
			next if key[1] == nil or key[1] == 0
			@k_value[@i] = $data_items[key[1]].name
		end
		
		for i in 0..9
			@keyset[i] = Sprite.new(self)
			@keyset[i].bitmap = Bitmap.new(150, 20) # width, height 크기의 비트맵 상자를 생성
			@keyset[i].x = 0
			if i == 0
				@keyset[i].y = (10) * 15
			else
				@keyset[i].y = (i) * 15
			end
			@keyset[i].bitmap.font.size = 13
			@keyset[i].bitmap.font.color.set(0, 0, 0, 255)
			@keyset[i].bitmap.draw_text(0, 0, 150, 20, "#{i} : #{@k_value[i].to_s}", 0)
			
			@keyset2[i] = Sprite.new(self)
			@keyset2[i].bitmap = Bitmap.new(150, 20) # x, y 크기의 비트맵 상자를 생성
			@keyset2[i].x = @x2
			if i == 0
				@keyset2[i].y = (10) * 15
			else
				@keyset2[i].y = (i) * 15
			end
			@keyset2[i].bitmap.font.size = 13
			@keyset2[i].bitmap.font.color.set(0, 0, 0, 255)
			@keyset2[i].bitmap.draw_text(0, 0, 150, 20, "#{i} : #{@k_value[i + 10].to_s}", 0)
		end
		
	end
	
	def update
		super
	end
end