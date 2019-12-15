#----------------------------------------------------------------------------------
# *진도우 단축키 확인 창
#----------------------------------------------------------------------------------
class Jindow_Keyset_menu < Jindow
	
	def initialize(id, type)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 200, 100)
		self.name = "⊙ 단축키 지정"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh("Keyset_menu") 
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@select_k = nil
		@id = id
		@type = type
		@id_value = nil
		case @type
		when 0
			@id_value = $data_items[@id]
		when 1
			@id_value = $data_weapons[@id]
		when 2
			@id_value = $data_armors[@id]
		when 3
			@id_value = $data_skills[@id]
		end
		
		@description = []
		@description_v = [
			"단축키는 키보드의 숫자 또는",
			"키패드의 숫자만 가능합니다.(0~9)",
			"#{@id_value.name}의 단축키 지정",
			" "
		]
		@description_size = [
			12,
			12,
			13
		]
		@d_x = 0
		@d_y = 0
		
		for i in 0...@description_v.length
			@description[i] = Sprite.new(self)
			@description[i].bitmap = Bitmap.new(400, 30)
			if @description_size[i] != nil
				@description[i].bitmap.font.size = @description_size[i] 
			else
				@description[i].bitmap.font.size = 13
			end
			@description[i].x = @d_x
			@description[i].y = @d_y + (@description[i].bitmap.font.size * i)
			@description[i].bitmap.font.alpha = 3
			@description[i].bitmap.font.beta = 1
			@description[i].bitmap.font.color.set(255, 255, 255, 255) 
			@description[i].bitmap.font.gamma.set(0, 0, 0, 255)
			if @description_v[i] != nil
				@description[i].bitmap.draw_text(0, 0, @description[i].width, @description[i].height, @description_v[i], 0)
			end
		end
		
		@button = []
		@button_n = [
			"확인",
			"취소"
		]
		for i in 0..1
			@button[i] = J::Button.new(self).refresh(60, @button_n[i])
			@button[i].x = (@button[i].width + 10) * i 
			@button[i].y = @description[@description.length - 1].y + @description[@description.length - 1].height
		end
		
	end
	
	def update
		super
		len = @description_v.length - 1
		
		for key in $ABS.item_keys.keys
			#Check is the the key is pressed
			next if !Input.trigger?(key)
			@description[len].bitmap.clear
			@description[len].bitmap.font.gamma.set(255, 255, 255, 255) 	
			if (Input::Numberkeys.values.include? key)
				@description[len].bitmap.font.color.set(255, 0, 0, 255)
				@description[len].bitmap.draw_text(0, 0, @description[len].width, @description[len].height, "키보드 숫자 : #{key - 48}", 0)
				@select_k = key
			elsif (Input::Numberpad.values.include? key) 	
				@description[len].bitmap.font.color.set(0, 0, 255, 255)
				@description[len].bitmap.draw_text(0, 0, @description[len].width, @description[len].height, "키패드 숫자 : #{key - 96}", 0)
				@select_k = key
			end
		end
		
		if @button[0].click
			if @select_k != nil
				case @type
				when 0..2
					$ABS.item_keys[@select_k] = @id
					$ABS.skill_keys[@select_k] = 0
				when 3
					$ABS.skill_keys[@select_k] = @id
					$ABS.item_keys[@select_k] = 0
				end
			end
			Hwnd.dispose("Keyset_menu")
		elsif @button[1].click
			Hwnd.dispose("Keyset_menu")
		end
	end
end
