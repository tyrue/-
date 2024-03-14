#----------------------------------------------------------------------------------
# *진도우 단축키 확인 창
#----------------------------------------------------------------------------------
class Jindow_Keyset < Jindow
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 250, 270)
		self.name = "⊙ 단축키 확인"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh("Keyset") 
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@keyset = {}
		@keyset2 = {}
		
		@x2 = 125
		
		@s1 = Sprite.new(self)
		@s1.bitmap = Bitmap.new(100, 20) # x, y 크기의 비트맵 상자를 생성
		@s1.x = 0
		@s1.y = 0
		@s1.bitmap.font.size = 15
		@s1.bitmap.font.color.set(255, 0, 0, 255)
		@s1.bitmap.draw_text(0, 0, 100, 20, "키보드 단축키", 0)
		
		@s2 = Sprite.new(self)
		@s2.bitmap = Bitmap.new(100, 20) # x, y 크기의 비트맵 상자를 생성
		@s2.x = @x2
		@s2.y = 0
		@s2.bitmap.font.size = 15
		@s2.bitmap.font.color.set(0, 0, 255, 255)
		@s2.bitmap.draw_text(0, 0, 100, 20, "키패드 단축키", 0)
		
		@k_value = {}
		for key in $ABS.skill_keys.sort
			k = key[0]
			v = key[1]
			@k_value[k] = ""
			
			next if v == nil or v == 0
			@k_value[k] = $data_skills[v].name if $data_skills[v] != nil
		end
		
		for key in $ABS.item_keys.sort
			k = key[0]
			v = key[1]
			
			next if v == nil or v == 0
			@k_value[k] = $data_items[v].name if $data_items[v] != nil
		end
		
		i = 0
		i2 = 0
		for key in $ABS.skill_keys.sort
			k = key[0]
			v = key[1]
			
			key_s = ""
			type_x = 0
			type_y = i
			
			case k
			when Input::Underscore
				key_s = "-"
			when Input::Equal
				key_s = "="
			when Input::Letters["Z"]
				key_s = "z"
			when Input::Letters["X"]
				key_s = "x"
			when Input::Numberkeys[0]..Input::Numberkeys[9]
				key_s = (k - 48).to_s
			when Input::Numberpad[0]..Input::Numberpad[9] 
				key_s = (k - 96).to_s
				type_x = @x2
				type_y = i2
				i2 += 1
				i -= 1
			end
			
			@keyset[k] = Sprite.new(self)
			@keyset[k].bitmap = Bitmap.new(150, 20) # width, height 크기의 비트맵 상자를 생성
			@keyset[k].x = type_x
			@keyset[k].y = (type_y) * 17 + (@s1.y + @s1.height + 2)
			
			@keyset[k].bitmap.font.size = 13
			@keyset[k].bitmap.font.color.set(0, 0, 0, 255)
			
			@keyset[k].bitmap.draw_text(0, 0, 150, 20, "#{key_s} : #{@k_value[k]}", 0)
			i += 1
		end
	end
	
	def update
		super
	end
end