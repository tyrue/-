module J
	class Type < Sprite
		#=================================================
		# 조합 한글 입력 시스템
		#-------------------------------------------------
		# 제작 : 허걱 (etcholic),
		#          (출처 : RPGXP 게임 공작소 (http://rpgxp.gameshot.net))
		# 수정 : 광땡 (psw0107_2) 배포용
		#=================================================
		Sh_others = [")", "!", "@", "#", "$", "%", "^", "&", "*", "("]
		
		HANGUL_FIRST_CHARACTER_TABLE = {"ㄱ"=>0,"ㄲ"=>1,"ㄴ"=>2,"ㄷ"=>3,"ㄸ"=>4,"ㄹ"=>5,"ㅁ"=>6,"ㅂ"=>7,"ㅃ"=>8,"ㅅ"=>9,"ㅆ"=>10,"ㅇ"=>11,"ㅈ"=>12,"ㅉ"=>13,"ㅊ"=>14,"ㅋ"=>15,"ㅌ"=>16,"ㅍ"=>17,"ㅎ"=>18}
		HANGUL_MID_CHARACTER_TABLE = {"ㅏ"=>0,"ㅐ"=>1,"ㅑ"=>2,"ㅒ"=>3,"ㅓ"=>4,"ㅔ"=>5,"ㅕ"=>6,"ㅖ"=>7,"ㅗ"=>8,"ㅘ"=>9,"ㅙ"=>10,"ㅚ"=>11,"ㅛ"=>12,"ㅜ"=>13,"ㅝ"=>14,"ㅞ"=>15,"ㅟ"=>16,"ㅠ"=>17,"ㅡ"=>18,"ㅢ"=>19,"ㅣ"=>20}
		HANGUL_LAST_CHARACTER_TABLE = {""=>0,"ㄱ"=>1,"ㄲ"=>2,"ㄳ"=>3,"ㄴ"=>4,"ㄵ"=>5,"ㄶ"=>6,"ㄷ"=>7,"ㄹ"=>8,"ㄺ"=>9,"ㄻ"=>10,"ㄼ"=>11,"ㄽ"=>12,"ㄾ"=>13,"ㄿ"=>14,"ㅀ"=>15,"ㅁ"=>16,"ㅂ"=>17,"ㅄ"=>18,"ㅅ"=>19,"ㅆ"=>20,"ㅇ"=>21,"ㅈ"=>22,"ㅊ"=>23,"ㅋ"=>24,"ㅌ"=>25,"ㅍ"=>26,"ㅎ"=>27}
		
		HANGUL_CHARACTER_TABLE = Array.new(19) do |cho_index|
			Array.new(21) do |jung_index|
				Array.new(28) do |jong_index|
					(0xAC00 + cho_index * 21 * 28 + jung_index * 28 + jong_index).to_a.pack('U*')
				end
			end
		end
		
		attr_reader :id
		attr_reader :skin
		attr_reader :file
		attr_reader :push
		attr_reader :click
		attr_reader :double_click
		attr_reader :bluck
		attr_accessor :hide
		attr_accessor :font
		
		def initialize(viewport = Viewport.new(0, 0, 640, 480))
			super(viewport)
			@id = viewport.item.index self
			@viewport = viewport
			@skin = viewport.skin
			@route = "Graphics/Jindow/" + @skin + "/Window/"
			@file = @route + "type"
			
			@font = Font.new(User_Edit::FONT_DEFAULT_NAME, 13)
			@font.alpha = 2
			@font.color.set(255, 255, 255, 255)
			
			@push = false
			@click = false
			@double_click = false
			@double_wait = 0
			@press_wait = 0
			@hide = false
			@edit = true
			@bluck = false
			@start = false
			@input_hangul = false
			@char = nil
			@text = []
			@o_text = ""
			
			@piece = [nil] * 4
			return self
		end
		
		def file=(val)
			@file = @route + val
		end
		
		def refresh?
			return @start
		end
		
		def set(command)
			reset_pieces
			@text = command.scan(/./)
			self
		end
		
		def reset_pieces
			@char = nil
			@piece.fill(nil)
		end
		
		def view
			command = @text.join
			return if @o_text == command
			
			@o_text = command
			if self.bitmap.text_size(command).width > self.bitmap.width
				return @text.pop
			else
				self.bitmap.clear
				for x in 0..self.bitmap.width
					for y in 0..self.bitmap.height
						self.bitmap.set_pixel(x, y, @memory.color[x][y])
					end
				end
				
				command = "*" * command.scan(/./).size if @hide
				
				self.bitmap.draw_text(self.bitmap.rect, "#{command}|", 0)
				self.bitmap.draw_text(self.bitmap.rect, @input_hangul ? "한" : "영", 2)
			end
		end
		
		def result
			return @text.join
		end
		
		def bluck?
			return @bluck
		end
		
		def bluck=(val)
			if val != @bluck
				@bluck = val
				$inputKeySwitch = val
				self.tone.set(val ? -64 : 0, val ? -64 : 0, val ? 64 : 0)
				update_bluck_for_other_items(val)
			end
		end
		
		def update_bluck_for_other_items(val)
			return unless val
			@viewport.item.each do |i|
				next if i == self || !i.respond_to?(:JS?) || !i.JS?
				i.bluck = false
			end
		end
		
		def refresh(x, y, width, height, hangul = true)
			@start = true
			@input_hangul = hangul
			if x.rect?
				y = x.y
				width = x.width
				height = x.height
				x = x.x
			end
			self.x = x
			self.y = y
			self.bitmap = Bitmap.new(width, height)
			
			ul = Sprite.new
			um = Sprite.new
			ur = Sprite.new
			
			ml = Sprite.new
			mr = Sprite.new
			
			dl = Sprite.new
			dm = Sprite.new
			dr = Sprite.new
			
			ul.bitmap = Bitmap.new(@file + "_ul")
			ur.bitmap = Bitmap.new(@file + "_ur")
			dl.bitmap = Bitmap.new(@file + "_dl")
			dr.bitmap = Bitmap.new(@file + "_dr")
			
			ow = self.bitmap.width - ul.bitmap.width - ur.bitmap.width
			oh = self.bitmap.height - ul.bitmap.height - dl.bitmap.height
			
			um.bitmap = Bitmap.new(ow, ul.bitmap.height, @file + "_um", 1)
			ml.bitmap = Bitmap.new(ul.bitmap.width, oh, @file + "_ml", 1)
			mr.bitmap = Bitmap.new(ur.bitmap.width, oh, @file + "_mr", 1)
			dm.bitmap = Bitmap.new(ow, dl.bitmap.height, @file + "_dm", 1)
			
			self.bitmap.blt(0, 0, ul.bitmap, ul.bitmap.rect)
			self.bitmap.blt(ul.bitmap.width, 0, um.bitmap, um.bitmap.rect)
			self.bitmap.blt(self.bitmap.width - ur.bitmap.width, 0, ur.bitmap, ur.bitmap.rect)
			self.bitmap.blt(0, ul.bitmap.height, ml.bitmap, ml.bitmap.rect)
			self.bitmap.blt(self.bitmap.width - mr.bitmap.width, ur.bitmap.height, mr.bitmap, mr.bitmap.rect)
			self.bitmap.blt(0, self.bitmap.height - dl.bitmap.height, dl.bitmap, dl.bitmap.rect)
			self.bitmap.blt(dl.bitmap.width, self.bitmap.height - dl.bitmap.height, dm.bitmap, dm.bitmap.rect)
			self.bitmap.blt(self.bitmap.width - dr.bitmap.width, self.bitmap.height - dr.bitmap.height, dr.bitmap, dr.bitmap.rect)
			
			self.bitmap.font = @font
			self.bitmap.font.alpha = @font.alpha
			self.bitmap.font.beta = @font.beta
			self.bitmap.font.gamma = @font.gamma
			
			@memory = JS.get_bitmap(self)
			ul.dispose
			um.dispose
			ur.dispose
			ml.dispose
			mr.dispose
			dl.dispose
			dm.dispose
			dr.dispose
			
			self.view
			return self
		end
		
		#---- update 시작 ----#
		def update
			super
			return unless refresh?
			
			handle_click
			handle_enter_key 
			
			return unless bluck?
			return unless Hwnd.highlight? == @viewport
			
			update_key if @edit
			
			if @piece[3] == nil
				@piece[0] = nil
				@piece[1] = nil
				@piece[2] = nil
			end
			
			process_character
			self.view
		end
		
		def handle_click
			@click = false if @click
			return unless Input.mouse_lbutton
			
			if !@push && Mouse.arrive_sprite_rect?(self) && @viewport.base?
				@push = true
				self.bluck = true
			elsif @push
				@push = false
			end
		end
		
		def handle_enter_key
			return unless Hwnd.highlight? == @viewport
			return unless self.bluck?
			return unless Key.trigger?(4) # 엔터
			
			@click = true 
		end
		
		def process_character
			hangul_character?(@char) ? make_hangul : reset_pieces
		end
		
		def hangul_character?(char)
			HANGUL_FIRST_CHARACTER_TABLE[char] || HANGUL_MID_CHARACTER_TABLE[char]
		end
		#---- update 끝 ----#
		
		def click=(value)
			@click = value
			self.bluck = value
		end
		
		def make_hangul
			text = @char
			
			if @piece[3].nil?
				handle_initial_state(text)
			else
				handle_combination(text)
			end
		end
		
		def handle_initial_state(text)
			return if text.nil?
			
			if HANGUL_MID_CHARACTER_TABLE[text]
				@piece[0], @piece[1], @piece[2] = nil, text, nil
			else
				@piece[0], @piece[1], @piece[2] = text, nil, nil
			end
			make_p
		end
		
		def handle_combination(text)
			if HANGUL_MID_CHARACTER_TABLE[text]
				handle_mid_character(text)
			else
				handle_final_or_consonant(text)
			end
		end
		
		def handle_mid_character(text)
			sw = true
			if @piece[0] && @piece[1].nil? && @piece[2].nil?
				@piece[1] = text
			elsif @piece[0].nil? && @piece[1] && @piece[2].nil?
				sw = handle_mid_with_existing_mid(text)
			elsif @piece[0].nil? && @piece[1].nil? && @piece[2]
				sw = handle_mid_with_final(text)
			elsif @piece[0] && @piece[1] && @piece[2].nil?
				sw = handle_mid_with_first_and_mid(text)
			elsif @piece[0] && @piece[1] && @piece[2]
				return handle_mid_with_all(text)
			end
			make_p
			edit_text(@piece[3]) if sw
		end
		
		def handle_final_or_consonant(text)
			sw = true
			if @piece[0] && @piece[1].nil? && @piece[2].nil?
				sw = handle_final_with_first(text)
			elsif @piece[0].nil? && @piece[1] && @piece[2].nil?
				@piece[0], @piece[1] = text, nil
				sw = false
			elsif @piece[0].nil? && @piece[1].nil? && @piece[2]
				return handle_final_with_existing_final(text)
			elsif @piece[0] && @piece[1] && @piece[2].nil?
				@piece[2] = text
			elsif @piece[0] && @piece[1] && @piece[2]
				return handle_final_with_all(text)
			end
			make_p
			edit_text(@piece[3]) if sw
		end
		
		def handle_mid_with_existing_mid(text)
			uni = get_union(@piece[1], text)
			@piece[1] = uni || text
			return !uni.nil?
		end
		
		def handle_mid_with_final(text)
			div_piece = divide_piece(@piece[2])
			if div_piece == @piece[2]
				@piece[0], @piece[1], @piece[2] = @piece[2], text, nil
				return false
			else
				@piece[2] = div_piece[0]
				@piece[0], @piece[1], @piece[2] = div_piece[1], text, nil
				return true
			end
		end
		
		def handle_mid_with_first_and_mid(text)
			uni = get_union(@piece[1], text)
			if uni.nil?
				if %w[ㅝ ㅞ ㅟ ㅘ ㅙ ㅚ ㅢ].include?(@piece[1])
					return false
				else
					if HANGUL_MID_CHARACTER_TABLE[@text[@text.size - 1]] != nil
						@piece[0] = nil
					end
					@piece[1] = text
				end
				return false
			else
				@piece[1] = uni
				return true
			end
		end
		
		def handle_mid_with_all(text)
			div_piece = divide_piece(@piece[2])
			if div_piece == @piece[2]
				@piece[2] = nil
				make_p
				edit_text(@piece[3])
				@piece[0], @piece[1], @piece[2] = div_piece, text, nil
			else
				@piece[2] = div_piece[0]
				make_p
				edit_text(@piece[3])
				@piece[0], @piece[1], @piece[2] = div_piece[1], text, nil
			end
			make_p
			@text.push(@piece[3])
			return
		end
		
		def handle_final_with_first(text)
			uni = get_union(@piece[0], text)
			if uni.nil?
				@piece[0] = text
				return false
			else
				@piece[0], @piece[2] = nil, uni
				return true
			end
		end
		
		def handle_final_with_existing_final(text)
			div_piece = divide_piece(@piece[2])
			uni = div_piece == @piece[2] ? get_union(@piece[2], text) : get_union(div_piece[1], text)
			
			if uni.nil?
				if @text.last == text
					@piece[0], @piece[2] = text, nil
				end
				return make_p
			end
			
			if div_piece == @piece[2]
				@piece[2] = nil
				@piece[0], @piece[2] = nil, uni
				return make_p
			else
				@piece[2] = div_piece[0]
				make_p
				edit_text(@piece[3])
				@piece[0], @piece[1], @piece[2] = nil, nil, uni
				make_p
				@text.push(@piece[3])
				return
			end
		end
		
		def handle_final_with_all(text)
			div_piece = divide_piece(@piece[2])
			uni = div_piece == @piece[2] ? get_union(@piece[2], text) : get_union(div_piece[1], text)
			
			if uni.nil?
				if @text.last == text
					@piece[0], @piece[1], @piece[2] = @piece[2], nil, nil
					return make_p
				end
			else
				if div_piece == @piece[2]
					@piece[2] = uni
					make_p
					return edit_text(@piece[3])
				else
					@piece[2] = div_piece[0]
					make_p
					edit_text(@piece[3])
					@piece[0], @piece[1], @piece[2] = nil, nil, uni
					make_p
					return @text.push(@piece[3])
				end
			end
		end
		
		def make_p
			first, mid, last = @piece[0], @piece[1], @piece[2]
			
			@piece[3] =
			if first && mid && last
				combine_hangul_characters(first, mid, last)
			elsif first && mid
				combine_hangul_characters(first, mid)
			elsif first
				first
			elsif mid
				mid
			elsif last
				last
			else
				nil
			end
		end
		
		def combine_hangul_characters(first, mid, last = "")
			begin
				first_char = HANGUL_FIRST_CHARACTER_TABLE[first]
				mid_char = HANGUL_MID_CHARACTER_TABLE[mid]
				last_char = HANGUL_LAST_CHARACTER_TABLE[last] || 0
				
				unless HANGUL_LAST_CHARACTER_TABLE[last]
					@piece[3] = HANGUL_CHARACTER_TABLE[first_char][mid_char][last_char]
					@text.push(@piece[3])
					@piece[0], @piece[1], @piece[2] = @piece[2], nil, nil
					return @piece[0]
				end
				
				HANGUL_CHARACTER_TABLE[first_char][mid_char][last_char]
			rescue => e
				nil
			end
		end
		
		def edit_text(text)
			@text = @text[0...-2] + [text]
		end
		
		def delete_piece
			if @piece[2] != nil
				div_piece = divide_piece(@piece[2])
				if @piece[0] != nil
					if div_piece == @piece[2]
						@piece[2] = nil
						@char = @piece[1]
						make_p
						return
					else
						@piece[2] = div_piece[0]
						@char = @piece[2]
						make_p
						return
					end
				else
					if div_piece == @piece[2]
						@piece[2] = nil
						make_p
						return
					else
						@piece[0] = div_piece[0]
						@piece[2] = nil
						@char = @piece[0]
						make_p
						return
					end
				end
			elsif @piece[1] != nil
				div_piece = divide_piece(@piece[1])
				if @piece[0] != nil
					if div_piece == @piece[1]
						@piece[1] = nil
						@char = @piece[0]
						make_p
						return
					else
						@piece[1] = div_piece[0]
						@char = @piece[1]
						make_p
						return
					end
				else
					if div_piece == @piece[1]
						@piece[1] = nil
						make_p
						return
					else
						@piece[1] = div_piece[0]
						make_p
						return
					end
				end
			else
				reset_pieces
			end
		end
		
		def delete_text
			@char = nil
			return play_buzzer_se if @text.empty?
			
			delete_piece
			@text.pop
			@text.push(@piece[3]) if @piece[3]
			self.view
		end
		
		def play_buzzer_se
			$game_system.se_play($data_system.buzzer_se)
		end
		
		def get_union(text1, text2)
			case text1
			when "ㄱ" then "ㅅ" == text2 ? "ㄳ" : nil
			when "ㄴ" then get_union_ㄴ(text2)
			when "ㄹ" then get_union_ㄹ(text2)
			when "ㅂ" then "ㅅ" == text2 ? "ㅄ" : nil
			when "ㅗ" then get_union_ㅗ(text2)
			when "ㅜ" then get_union_ㅜ(text2)
			when "ㅡ" then "ㅣ" == text2 ? "ㅢ" : nil
			else nil
			end
		end
		
		def get_union_ㄴ(text2)
			case text2
			when "ㅈ" then "ㄵ"
			when "ㅎ" then "ㄶ"
			else nil
			end
		end
		
		def get_union_ㄹ(text2)
			case text2
			when "ㄱ" then "ㄺ"
			when "ㅁ" then "ㄻ"
			when "ㅂ" then "ㄼ"
			when "ㅅ" then "ㄽ"
			when "ㅌ" then "ㄾ"
			when "ㅍ" then "ㄿ"
			when "ㅎ" then "ㅀ"
			else nil
			end
		end
		
		def get_union_ㅗ(text2)
			case text2
			when "ㅏ" then "ㅘ"
			when "ㅐ" then "ㅙ"
			when "ㅣ" then "ㅚ"
			else nil
			end
		end
		
		def get_union_ㅜ(text2)
			case text2
			when "ㅓ" then "ㅝ"
			when "ㅔ" then "ㅞ"
			when "ㅣ" then "ㅟ"
			else nil
			end
		end
		
		def divide_piece(text)
			case text
			when "ㄳ" then ["ㄱ", "ㅅ"]
			when "ㄵ" then ["ㄴ", "ㅈ"]
			when "ㄶ" then ["ㄴ", "ㅎ"]
			when "ㄺ" then ["ㄹ", "ㄱ"]
			when "ㄻ" then ["ㄹ", "ㅁ"]
			when "ㄼ" then ["ㄹ", "ㅂ"]
			when "ㄽ" then ["ㄹ", "ㅅ"]
			when "ㄾ" then ["ㄹ", "ㅌ"]
			when "ㄿ" then ["ㄹ", "ㅍ"]
			when "ㅀ" then ["ㄹ", "ㅎ"]
			when "ㅄ" then ["ㅂ", "ㅅ"]
			when "ㅘ" then ["ㅗ", "ㅏ"]
			when "ㅙ" then ["ㅗ", "ㅐ"]
			when "ㅚ" then ["ㅗ", "ㅣ"]
			when "ㅝ" then ["ㅜ", "ㅓ"]
			when "ㅞ" then ["ㅜ", "ㅔ"]
			when "ㅟ" then ["ㅜ", "ㅣ"]
			when "ㅢ" then ["ㅡ", "ㅣ"]
			else text
			end
		end
		
		def update_key
			handle_backspace
			handle_language_switch
			handle_space
			Key.press?(KEY_SHIFT) ? handle_shift_keys : handle_number_keys
			@input_hangul ? handle_hangul_input : handle_english_input
		end
		
		def handle_backspace
			if Key.trigger?(KEY_BACKSPACE) || Key.repeat?(KEY_BACKSPACE)
				delete_text
				return
			end
		end
		
		def handle_language_switch
			if Key.trigger?(98) || Key.trigger?(KEY_ALT)  # 한 / 영 전환
				@input_hangul = !@input_hangul
				self.bitmap.draw_text(self.bitmap.rect, @input_hangul ? "한" : "영", 2)
				return
			end
		end
		
		def handle_space
			if Key.trigger?(KEY_SPACE) || Key.repeat?(KEY_SPACE)
				@text.push(" ")
				@char = " "
				return
			end
		end
		
		def handle_shift_keys
			special_keys = {
				62 => "\?", 65 => ":", 66 => "}", 67 => "~", 68 => "{", 69 => "_",
				70 => "\"", 71 => "|", KEY_0 => Sh_others[0], KEY_1 => Sh_others[1], KEY_2 => Sh_others[2],
				KEY_3 => Sh_others[3], KEY_4 => Sh_others[4], KEY_5 => Sh_others[5], KEY_6 => Sh_others[6],
				KEY_7 => Sh_others[7], KEY_8 => Sh_others[8], KEY_9 => Sh_others[9]
			}
			handle_special_keys(special_keys)
		end
		
		def handle_number_keys
			number_keys = {
				60 => ",", 61 => ".", 62 => "/", 65 => ";", 66 => "]", 67 => "`",
				68 => "[", 69 => "-", 70 => "'", 71 => "\\", KEY_0 => 0, KEY_1 => 1, KEY_2 => 2,
				KEY_3 => 3, KEY_4 => 4, KEY_5 => 5, KEY_6 => 6,
				KEY_7 => 7, KEY_8 => 8, KEY_9 => 9,
				
				50 => 0, 51 => 1, 52 => 2,
				53 => 3, 54 => 4, 55 => 5, 56 => 6,
				57 => 7, 58 => 8, 59 => 9,
			}
			handle_special_keys(number_keys)
		end
		
		def handle_special_keys(key_map)
			key_map.each do |key, value|
				if Key.trigger?(key) || Key.repeat?(key)
					@text.push(value.to_s)
					@char = value
					return
				end
			end
		end
		
		def handle_hangul_input
			hangul_keys = {
				KEY_A => "ㅁ", KEY_B => "ㅠ", KEY_C => "ㅊ", KEY_D => "ㅇ", KEY_E => { "default" => "ㄷ", "shift" => "ㄸ" },
				KEY_F => "ㄹ", KEY_G => "ㅎ", KEY_H => "ㅗ", KEY_I => "ㅑ", KEY_J => "ㅓ", KEY_K => "ㅏ",
				KEY_L => "ㅣ", KEY_M => "ㅡ", KEY_N => "ㅜ", KEY_O => { "default" => "ㅐ", "shift" => "ㅒ" },
				KEY_P => { "default" => "ㅔ", "shift" => "ㅖ" }, KEY_Q => { "default" => "ㅂ", "shift" => "ㅃ" },
				KEY_R => { "default" => "ㄱ", "shift" => "ㄲ" }, KEY_S => "ㄴ", KEY_T => { "default" => "ㅅ", "shift" => "ㅆ" },
				KEY_U => "ㅕ", KEY_V => "ㅍ", KEY_W => { "default" => "ㅈ", "shift" => "ㅉ" }, KEY_X => "ㅌ",
				KEY_Y => "ㅛ", KEY_Z => "ㅋ"
			}
			handle_character_input(hangul_keys)
		end
		
		def handle_english_input
			(KEY_A..KEY_Z).each do |i|
				if Key.trigger?(i) || Key.repeat?(i)
					char = (Key.press?(KEY_SHIFT) ? 65 : 97) + (i - KEY_A)
					@text.push(char.chr)
					@char = char.chr
					return
				end
			end
		end
		
		def handle_character_input(key_map)
			key_map.each do |key, value|
				if Key.trigger?(key) || Key.repeat?(key)
					char = value.is_a?(Hash) ? (Key.press?(KEY_SHIFT) ? value["shift"] : value["default"]) : value
					@text.push(char)
					@char = char
					return
				end
			end
		end
	end
end
