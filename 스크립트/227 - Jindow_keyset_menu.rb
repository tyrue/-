#----------------------------------------------------------------------------------
# *진도우 단축키 확인 창
#----------------------------------------------------------------------------------
class Jindow_Keyset_menu < Jindow
	DESCRIPTION_TEXTS = [
		"단축키는 키보드 숫자 또는 키패드 숫자(0~9)",
		"'-', '=', 'z', 'x'가 가능합니다.",
		nil,  # Placeholder for dynamic text
		"단축키를 입력해 주세요"
	]
	
	DESCRIPTION_SIZES = [14, 14, 15, 14]
	
	BUTTON_NAMES = ["확인", "취소"]
	
	def initialize(id, type)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 250, 130)
		self.name = "⊙ 단축키 지정"
		@head = true
		@mark = true
		@drag = true
		@close = true
		
		self.refresh("Keyset_menu") 
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@select_k = nil
		@check_id = id
		@type = type
		@id_value = fetch_id_value
		
		create_descriptions
		create_buttons
	end
	
	def fetch_id_value
		case @type
		when 0 then $data_items[@check_id]
		when 1 then $data_weapons[@check_id]
		when 2 then $data_armors[@check_id]
		when 3 then $data_skills[@check_id]
		end
	end
	
	def create_descriptions
		@description = []
		@description_v = DESCRIPTION_TEXTS.dup
		@description_v[2] = "#{@id_value.name}의 단축키 지정" if @id_value
		
		@description_v.each_with_index do |text, i|
			sprite = Sprite.new(self)
			sprite.bitmap = Bitmap.new(400, 30)
			font_size = DESCRIPTION_SIZES[i] || 13
			sprite.bitmap.font.size = font_size
			sprite.x = 0 
			sprite.y = (font_size + 1) * i
			
			sprite.bitmap.font.alpha = 3
			sprite.bitmap.font.beta = 1
			sprite.bitmap.font.color.set(255, 255, 255, 255)
			sprite.bitmap.font.gamma.set(0, 0, 0, 255)
			sprite.bitmap.draw_text(0, 0, self.width, font_size + 1, text, 0) if text
			@description << sprite
		end
	end
	
	def create_buttons
		@button = []
		BUTTON_NAMES.each_with_index do |name, i|
			button = J::Button.new(self).refresh(60, name)
			button.x = (button.width + 10) * i
			button.y = @description.last.y + @description.last.height
			@button << button
		end
	end
	
	def update
		super
		update_descriptions
		check_buttons
	end
	
	def update_descriptions
		key = $ABS.item_keys.keys.find { |k| Input.trigger?(k) }
		return unless key
		
		len = @description_v.length - 1
		sprite = @description[len]
		sprite.bitmap.clear
		sprite.bitmap.font.gamma.set(255, 255, 255, 255)
		
		case key
		when *Input::Numberkeys.values
			set_description_text(sprite, "키보드 숫자 : #{key - 48}", [255, 0, 0, 255])
		when *Input::Numberpad.values
			set_description_text(sprite, "키패드 숫자 : #{key - 96}", [0, 0, 255, 255])
		else
			key_s = case key
			when Input::Underscore then "-"
			when Input::Equal then "="
			when Input::Letters["Z"] then "z"
			when Input::Letters["X"] then "x"
			else ""
			end
			set_description_text(sprite, "단축키 : #{key_s}", [0, 0, 255, 255])
		end
		
		@select_k = key
	end
	
	def set_description_text(sprite, text, color)
		sprite.bitmap.font.color.set(*color)
		sprite.bitmap.draw_text(0, 0, sprite.width, sprite.height, text, 0)
	end
	
	def check_buttons
		if @button[0].click
			assign_key if @select_k
			Hwnd.dispose("Keyset_menu")
		elsif @button[1].click
			Hwnd.dispose("Keyset_menu")
		end
	end
	
	def assign_key
		case @type
		when 0..2
			$ABS.item_keys[@select_k] = @check_id
			$ABS.skill_keys[@select_k] = 0
		when 3
			$ABS.skill_keys[@select_k] = @check_id
			$ABS.item_keys[@select_k] = 0
		end
	end
end
