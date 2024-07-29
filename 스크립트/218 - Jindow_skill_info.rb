#----------------------------------------------------------------------------------
# * 진도우 스킬창
#----------------------------------------------------------------------------------
class Jindow_Skill_Info < Jindow
	def initialize(data)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 350, 100)
		@data = data
		setup_window
		setup_key_button
		setup_skill_type
		setup_description
		setup_skill_info
		setup_skill_info_sprites
		finalize_window
	end
	
	def setup_window
		self.name = "⊙ 스킬 정보 (#{@data.name})"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.x = Mouse.x + 5
		self.y = Mouse.y + 5
		self.refresh("Skill_Info")
	end
	
	def setup_key_button
		@button_key = J::Button.new(self).refresh(60, "단축키 지정")
		@button_key.x = 0
		@button_key.y = 0
		@draw_y = @button_key.y + @button_key.height + 2
	end
	
	def setup_skill_type
		@skill_data = $rpg_skill_data[@data.id]
		@txt_power = @data.power
		@txt_name_arr = determine_skill_type
		sprite = create_sprite(@draw_y, self.width, 15 * 3, 15)
		
		@txt_name_arr.each_with_index do |str, i|
			@txt_name_arr[i] = "[#{str}] "
		end
		
		draw_text(sprite, @txt_name_arr.to_s)
	end
	
	def setup_description
		return if @data.description.empty?
		
		@description = create_sprite(@draw_y, self.width, 80, 14)
		draw_text(@description, @data.description)
		@draw_y += 14
	end
	
	def create_sprite(y, width, height, font_size)
		sprite = Sprite.new(self)
		sprite.y = y
		sprite.bitmap = Bitmap.new(width, height)
		set_sprite_font(sprite.bitmap.font, font_size)
		sprite
	end
	
	def set_sprite_font(font, size)
		font.alpha = 3
		font.beta = 1
		font.color.set(255, 255, 255, 255)
		font.gamma.set(0, 0, 0, 255)
		font.size = size
	end
	
	def draw_text(sprite, text)
		w = h = 0
		line = 1
		bitmap = sprite.bitmap
		text.scan(/./).each do |char|
			rect = bitmap.text_size(char)
			if w + rect.width > self.width
				h += rect.height
				line += 1
				w = 0
			end
			bitmap.draw_text(w, h, rect.width, rect.height, char)
			w += rect.width
			@max_x = [@max_x, w].max
		end
		@draw_y = sprite.y + bitmap.font.size * line + 2
	end
	
	def setup_skill_info
		@s_info = compile_skill_info
	end
	
	def determine_skill_type
		arr = []
		@skill_data.type.each do |type|
			txt = case type
			when "range"
				case @data.scope
				when 1 then "원거리"
				when 2 then "전체"
				end
			when "explode" then "폭발"
			when "heal" then "회복"
			when "buff" then "축복"
			when "debuff" then "저주"
			end
			arr << txt if txt
		end
		
		arr << "파티" if @skill_data.is_party
		arr << "일반" if arr.empty?
		arr
	end
	
	def compile_skill_info
		s_info = []
		s_info.push(format_skill_power(@skill_data.power_arr)) if @skill_data.power_arr
		if @txt_power > 0
			s_info.push("기본 공격력 : #{@txt_power}")
			s_info.push("")
		end
		
		if @skill_data.heal_type
			t = case @skill_data.heal_type
			when "hp" then "체력"
			when "sp" then "마력"
			end
			
			s_info.push("회복 타입 : #{t}") 
			s_info.push(format_heal_data(@skill_data.heal_value_per)) if @skill_data.heal_value_per
			s_info.push("기본 회복량 : #{@skill_data.heal_value}") if @skill_data.heal_value && @skill_data.heal_value > 0
			s_info.push("")
		end
		
		s_info.push(format_skill_cost(@skill_data.cost_arr)) if @skill_data.cost_arr
		if @data.sp_cost > 0
			s_info.push("기본 소모 : 마력 #{@data.sp_cost}")
			s_info.push("")
		end
		
		s_info.push("거리 : #{@skill_data.range_value}") if @skill_data.range_value
		s_info.push("폭발 범위 : #{@skill_data.explode_range}") if @skill_data.explode_range
		if @skill_data.hit_num
			s_info.push("타격수 : #{@skill_data.hit_num}") 	
			s_info.push("")
		end
		
		stat_rate = compile_stat_rate
		if stat_rate
			s_info.push("능력치 영향도")
			s_info.push(format_stat_text(stat_rate))
			s_info.push("")
		end
		
		if @skill_data.buff_data
			s_info.push("버프 효과")
			s_info.push(format_buff_data(@skill_data.buff_data))
			s_info.push("")
		end
		
		s_info.push("지속 시간 : #{@skill_data.buff_time}초") if @skill_data.buff_time
		s_info.push("재사용 시간 : #{@skill_data.mash_time}초") if @skill_data.mash_time
		s_info
	end
	
	def format_skill_cost(data)
		type, p_hp, p_sp = data
		txt = "소모 : "
		txt += type == 0 ? "현재 " : "전체 "
		txt += "체력 #{(p_hp * 100).to_i}% " if p_hp > 0
		txt += "마력 #{(p_sp * 100).to_i}%" if p_sp > 0
		txt
	end
	
	def format_skill_power(data)
		type, p_hp, p_sp, val = data
		@txt_power = val
		
		txt = "공격력 : "
		txt += type == 0 ? "현재 " : "전체 "
		txt += "체력 #{(p_hp * 100).to_i}% " if p_hp > 0
		txt += "마력 #{(p_sp * 100).to_i}%" if p_sp > 0
		txt
	end
	
	def format_heal_data(data)
		type, p_hp, p_sp = data
		
		txt = "회복량 : "
		txt += type == 0 ? "현재 " : "전체 "
		txt += "체력 #{(p_hp * 100).to_i}% " if p_hp > 0
		txt += "마력 #{(p_sp * 100).to_i}%" if p_sp > 0
		txt
	end
	
	def format_buff_data(data)
		txt = ""
		data.each do |type, val|
			type_s = case type
			when "str" then "힘"
			when "int" then "지력"
			when "dex" then "민첩"
			when "agi" then "손재주"
			when "per_str" then "힘(비율)"
			when "per_int" then "지력(비율)"
			when "per_dex" then "민첩(비율)"
			when "per_agi" then "손재주(비율)"	
			when "pdef" then "물리 방어력"
			when "mdef" then "마법 방어력"		
			when "speed" then "속도"
			else "기타"		
			end
			
			txt += type_s 
			if type_s != "기타" && val && val != 0
				txt += val > 0 ? " +" : " "
				txt += "#{val} "
			end
		end
		txt
	end
	
	def compile_stat_rate
		[@data.str_f, @data.dex_f, @data.agi_f, @data.int_f].select { |rate| rate > 0 }.empty? ? nil : [@data.str_f, @data.dex_f, @data.agi_f, @data.int_f]
	end
	
	def format_stat_text(stat_rate)
		txt = ""
		txt += "힘 [#{stat_rate[0]}%] " if stat_rate[0] > 0
		txt += "민첩 [#{stat_rate[1]}%] " if stat_rate[1] > 0
		txt += "손재주 [#{stat_rate[2]}%] " if stat_rate[2] > 0
		txt += "지력 [#{stat_rate[3]}%]" if stat_rate[3] > 0
		txt
	end
	
	def setup_skill_info_sprites
		return if @s_info.empty?
		
		font_size = 13
		@s_info2 = []
		
		@s_info.each_with_index do |info, i|
			if info == ""
				@draw_y += font_size
				next
			end
			
			sprite = create_sprite(@draw_y, self.width, font_size * 2.2, font_size)
			draw_text(sprite, info.to_s)
			@s_info2[i] = sprite
		end
	end
	
	def finalize_window
		self.width = @max_x + 3
		self.height = @draw_y + 20
		self.window_ini
		self.refresh("Skill_Info")
	end
	
	def update
		super
		return unless @button_key.click
		if Hwnd.include?("Keyset_menu")
			Hwnd.dispose("Keyset_menu")
		end
		Jindow_Keyset_menu.new(@data.id, 3)
	end
end
