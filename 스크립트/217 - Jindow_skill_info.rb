#----------------------------------------------------------------------------------
# *진도우 스킬창
#----------------------------------------------------------------------------------
class Jindow_Skill_Info < Jindow
	
	def initialize(data)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 200, 100)
		@data = data
		self.name = "⊙ 스킬 정보 (#{@data.name})"
		@head = true
		@mark = true
		@drag = true
		@close = true
		
		self.x = Mouse.x + 5
		self.y = Mouse.y + 5
		self.refresh "Skill_Info"
		
		@button_key = J::Button.new(self).refresh(60, "단축키 지정")
		@button_key.x = 0
		@button_key.y = 0
		
		@skill_power_data = SKILL_POWER_CUSTOM[@data.id]
		@skill_cost_data = SKILL_COST_CUSTOM[@data.id]
		@txt_power = @data.power
		@txt_name = ""
		
		# 스킬명, 스킬 내용, 마나 소모량
		@s_info = []
		@txt_name = "[원거리]" if RANGE_SKILLS[@data.id] != nil and @data.scope == 1
		@txt_name = "[전체]" if RANGE_SKILLS[@data.id] != nil and @data.scope == 2
		@txt_name = "[범위]" if RANGE_EXPLODE[@data.id] != nil
		@txt_name = "[회복]" if HEAL_SKILL[@data.id] != nil
		@txt_name = "[파티 회복]" if PARTY_HEAL_SKILL[@data.id] != nil
		@txt_name = "[버프]" if BUFF_SKILL[@data.id] != nil
		@txt_name = "[파티 버프]" if PARTY_BUFF_SKILL[@data.id] != nil
		
		@s_info.push("#{@txt_name}")	if @txt_name != ""
			
		if @skill_cost_data != nil
			data = @skill_cost_data[0]
			type = data[0]
			p_hp = (data[1] * 100).to_i
			p_sp = (data[2] * 100).to_i
			
			txt = "소모 : "
			case type
			when 0
				txt += "현재 "
			when 1
				txt += "전체 "
			end
			txt += "체력 #{p_hp}% " if p_hp > 0
			txt += "마력 #{p_sp}%" if p_sp > 0
			
			@s_info.push(txt)
		end
		@s_info.push("기본 소모 : 마력 #{@data.sp_cost}") if @data.sp_cost > 0
		@s_info.push("")
		
		if @skill_power_data != nil
			data = @skill_power_data[0]
			type = data[0]
			p_hp = (data[1] * 100).to_i
			p_sp = (data[2] * 100).to_i
			val = data[3] 
			
			txt = "공격력 : "
			case type
			when 0
				txt += "현재 "
			when 1
				txt += "전체 "
			end
			txt += "체력 #{p_hp}% " if p_hp > 0
			txt += "마력 #{p_sp}%" if p_sp > 0
			@txt_power += val
			@s_info.push(txt)
		end
		@s_info.push("기본 공격력 : #{@txt_power}") if @txt_power > 0
		
		@heal_txt = HEAL_SKILL[@data.id][0] if HEAL_SKILL[@data.id] != nil
		@heal_txt = PARTY_HEAL_SKILL[@data.id][0] if @heal_txt == nil and PARTY_HEAL_SKILL[@data.id] != nil
		if @heal_txt != nil
			@s_info.push("기본 회복량 : #{@heal_txt}")
		end
		
		@s_info2 = []
		
		@d_x = 0
		@d_y = @button_key.y + @button_key.height
		for i in 0...@s_info.size
			@s_info2[i] = Sprite.new(self)
			@s_info2[i].bitmap = Bitmap.new(self.width, 20)
			@s_info2[i].bitmap.font.size = 13
			@s_info2[i].x = @d_x
			@s_info2[i].y = @d_y + (@s_info2[i].bitmap.font.size + 4) * i
			@s_info2[i].bitmap.font.alpha = 3
			@s_info2[i].bitmap.font.beta = 1
			@s_info2[i].bitmap.font.color.set(255, 255, 255, 255) 
			@s_info2[i].bitmap.font.gamma.set(0, 0, 0, 255)
			@s_info2[i].bitmap.draw_text(0, 0, @s_info2[i].width, @s_info2[i].height, @s_info[i].to_s, 0)
		end
		
		height = @s_info2[@s_info2.size - 1].y + @s_info2[@s_info2.size - 1].height + 10
		skill_description_add(@data) # 스킬 설명 추가
		
		if @data.description != ""
			@description = Sprite.new(self)
			@description.y = @s_info2[@s_info2.size - 1].y + @s_info2[@s_info2.size - 1].height + 10				
			@description.bitmap = Bitmap.new(self.width, 80)
			@description.bitmap.font.color.set(255, 255, 255, 255)
			@description.bitmap.font.alpha = 3
			@description.bitmap.font.beta = 1
			@description.bitmap.font.gamma.set(0, 0, 0, 255)
			@description.bitmap.font.size = 14
			
			w = 0
			h = 0
			for i in @data.description.scan(/./)
				rect = @description.bitmap.text_size(i)
				if w + rect.width > self.width
					h += rect.height
					w = 0
					@description.bitmap.draw_text(w, h, rect.width, rect.height, i)
					w += rect.width
				else
					@description.bitmap.draw_text(w, h, rect.width, rect.height, i)
					w += rect.width
				end
			end
			height = @description.y + @description.height + 10
		end
		
		self.height = height
		self.refresh("Skill_Info")
	end
	
	def skill_description_add(skill_data)
		#skill_data.description += "ok"
	end
	
	
	def update
		super
		if @button_key != nil and @button_key.click
			if not Hwnd.include?("Keyset_menu")
				Jindow_Keyset_menu.new(@data.id, 3)
			else
				Hwnd.dispose("Keyset_menu")
				Jindow_Keyset_menu.new(@data.id, 3)
			end
		end
	end
	
end