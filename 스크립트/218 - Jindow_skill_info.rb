#----------------------------------------------------------------------------------
# * 진도우 스킬창
#----------------------------------------------------------------------------------
class Jindow_Skill_Info < Jindow
	def initialize(data)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 220, 100)
		@data = data
		setup_window
		setup_description
		setup_skill_info
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
		
		@button_key = J::Button.new(self).refresh(60, "단축키 지정")
		@button_key.x = 0
		@button_key.y = 0
	end
	
	def setup_description
		return if @data.description.empty?
		@d_x = 0
		@d_y = @button_key.y + @button_key.height + 2
		
		@description = Sprite.new(self)
		@description.y = @d_y
		@description.bitmap = Bitmap.new(self.width, 80)
		set_sprite_font(@description.bitmap.font)
		@description.bitmap.font.size = 14
		
		draw_description_text
	end
	
	def set_sprite_font(font)
		font.alpha = 3
		font.beta = 1
		font.color.set(255, 255, 255, 255)
		font.gamma.set(0, 0, 0, 255)
	end
	
	def draw_description_text
		w = 0
		h = 0
		@data.description.scan(/./).each do |char|
			rect = @description.bitmap.text_size(char)
			if w + rect.width > self.width
				h += rect.height
				w = 0
			end
			@description.bitmap.draw_text(w, h, rect.width, rect.height, char)
			w += rect.width
		end
		
		@d_y = @description.y + h + @description.bitmap.font.size * 2 
	end
	
	def setup_skill_info
		@skill_power_data = SKILL_POWER_CUSTOM[@data.id]
		@skill_cost_data = SKILL_COST_CUSTOM[@data.id]
		@txt_power = @data.power
		@txt_name = determine_skill_type
		@s_info = compile_skill_info
		setup_skill_info_sprites
	end
	
	def determine_skill_type
		return "[원거리]" if RANGE_SKILLS[@data.id] && @data.scope == 1
		return "[전체]" if RANGE_SKILLS[@data.id] && @data.scope == 2
		return "[범위]" if RANGE_EXPLODE[@data.id]
		return "[회복]" if HEAL_SKILL[@data.id]
		return "[파티 회복]" if PARTY_HEAL_SKILL[@data.id]
		return "[버프]" if BUFF_SKILL[@data.id]
		return "[파티 버프]" if PARTY_BUFF_SKILL[@data.id]
		""
	end
	
	def compile_skill_info
		s_info = []
		s_info.push(@txt_name) unless @txt_name.empty?
		
		if @skill_cost_data
			data = @skill_cost_data[0]
			s_info.push(format_skill_cost(data))
		end
		
		if @data.sp_cost > 0
			s_info.push("기본 소모 : 마력 #{@data.sp_cost}") 
			s_info.push("")
		end
		
		if @skill_power_data
			data = @skill_power_data[0]
			s_info.push(format_skill_power(data))
		end
		
		if @txt_power > 0
			s_info.push("기본 공격력 : #{@txt_power}") 
			s_info.push("")
		end
		
		heal_txt = determine_heal_amount
		if heal_txt
			s_info.push("기본 회복량 : #{heal_txt.first}")
			s_info.push("")
		end
		
		range, hit_num = determine_range_and_hits
		if range && hit_num
			s_info.push("범위 : #{range}")
			s_info.push("타격수 : #{hit_num}")
			s_info.push("")
		end
		
		if (stat_rate = compile_stat_rate)
			s_info.push("능력치 영향도")
			
			stat_text = ""
			stat_text += "힘 [#{stat_rate[0]}%] " if stat_rate[0] > 0 
			stat_text += "민첩 [#{stat_rate[1]}%]" if stat_rate[1] > 0 
			s_info.push("#{stat_text}") if stat_text != ""
			
			stat_text = ""
			stat_text += "손재주 [#{stat_rate[2]}%] " if stat_rate[2] > 0 
			stat_text += "지력 [#{stat_rate[3]}%]" if stat_rate[3] > 0
			s_info.push("#{stat_text}") if stat_text != ""
			s_info.push("")
		end
		
		if (buff_time = determine_buff_time)
			s_info.push("지속 시간 : #{buff_time}초")
		end
		
		if (mash_time = determine_mash_time)
			s_info.push("재사용 시간 : #{mash_time}초")
			s_info.push("")
		end
		
		s_info
	end
	
	def format_skill_cost(data)
		type = data[0]
		p_hp = (data[1] * 100).to_i
		p_sp = (data[2] * 100).to_i
		txt = "소모 : "
		txt += type == 0 ? "현재 " : "전체 "
		txt += "체력 #{p_hp}% " if p_hp > 0
		txt += "마력 #{p_sp}%" if p_sp > 0
		txt
	end
	
	def format_skill_power(data)
		type = data[0]
		p_hp = (data[1] * 100).to_i
		p_sp = (data[2] * 100).to_i
		val = data[3]
		@txt_power = val
		txt = "공격력 : "
		txt += type == 0 ? "현재 " : "전체 "
		txt += "체력 #{p_hp}% " if p_hp > 0
		txt += "마력 #{p_sp}%" if p_sp > 0
		txt
	end
	
	def determine_heal_amount
		val = HEAL_SKILL[@data.id] || PARTY_HEAL_SKILL[@data.id]
		return val
	end
	
	def determine_range_and_hits
		if RANGE_SKILLS[@data.id]
			[RANGE_SKILLS[@data.id][0], RANGE_SKILLS[@data.id][5] || 1]
		elsif RANGE_EXPLODE[@data.id]
			[RANGE_EXPLODE[@data.id][3], RANGE_EXPLODE[@data.id][6] || 1]
		end
	end
	
	def compile_stat_rate
		return nil if (@data.str_f == 0 && @data.dex_f == 0 && @data.agi_f == 0 && @data.int_f == 0) 
		[@data.str_f, @data.dex_f, @data.agi_f, @data.int_f]
	end
	
	def determine_buff_time
		buff_time = BUFF_SKILL[@data.id]
		buff_time ? buff_time.first.to_f : nil
	end
	
	def determine_mash_time
		mash_time = SKILL_MASH_TIME[@data.id]
		mash_time ? mash_time.first / 60.0 : nil
	end
	
	def setup_skill_info_sprites
		@s_info2 = []
		font_size = 13
		
		@s_info.each_with_index do |info, i|
			next if info == ""
			@s_info2[i] = Sprite.new(self)
			@s_info2[i].bitmap = Bitmap.new(self.width, font_size + 2)
			@s_info2[i].bitmap.font.size = font_size
			@s_info2[i].x = @d_x
			@s_info2[i].y = @d_y + (font_size + 2) * i
			set_sprite_font(@s_info2[i].bitmap.font)
			@s_info2[i].bitmap.draw_text(0, 0, @s_info2[i].width, @s_info2[i].height, info.to_s, 0)
		end
	end
	
	def finalize_window
		self.height = @s_info2.last.y + @s_info2.last.height + 10
		self.window_ini
		self.refresh("Skill_Info")
	end
	
	def skill_description_add(skill_data)
		#skill_data.description += "ok"
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
