module RPG
	class Weapon
		attr_accessor :hp_plus
		attr_accessor :sp_plus
		attr_accessor :hp_plus_per
		attr_accessor :sp_plus_per
		
		alias initialize_plus initialize
		def initialize
			@hp_plus = 0
			@sp_plus = 0
			@hp_plus_per = 0.0
			@sp_plus_per = 0.0
			initialize_plus
		end
	end
	
	class Armor
		attr_accessor :hp_plus
		attr_accessor :sp_plus
		attr_accessor :hp_plus_per
		attr_accessor :sp_plus_per
		
		alias initialize_plus initialize
		def initialize
			@hp_plus = 0
			@sp_plus = 0
			@hp_plus_per = 0.0
			@sp_plus_per = 0.0
			initialize_plus
		end
	end
end

# 무기 옵션 처리
class Set_Weapon_plus
	def initialize
		@data = {}
		
		# 전사 스킬
		@data[1] = [50, 30]			# 주작의 검
		@data[2] = [50, 30]     # 백호의 검 
		@data[3] = [50, 30] 		# 현무의 검 
		@data[4] = [50, 30]    	# 청룡의 검 
		
		# 4차 무기
		@data[6] = [0, 7000]    	# 현자금봉
		@data[7] = [7000, 0]    	# 검성기검
		@data[8] = [0, 7000]    	# 진선역봉
		@data[9] = [7000, 0]    	# 태성태도
		
		# 중국무기
		@data[11] = [2000, 200000]    	# 대모홍접선
		@data[12] = [200000, 1000]    	# 구곡검
		@data[13] = [2000, 200000]    	# 영후단봉
		@data[14] = [200000, 1000]    	# 협가검
		
		@data[15] = [1000, 1000]    	# 석단장
		@data[16] = [5500, 5500]    	# 백사도
		@data[17] = [50000, 50000]    	# 음양도
		
		# 일반무기
		@data[24] = [100, 0]    	# 야월도
		@data[25] = [200, 0]    	# 흑월도
		
		@data[106] = [150, 0]    	# 현철중검
		@data[120] = [300, 0]    	# 흑철중검
		
		@data[105] = [0, 100]    	# 영혼마령봉
		@data[107] = [0, 250]    	# 불의영혼봉
		
		@data[133] = [0, 100]    	# 해골죽장
		@data[137] = [0, 250]    	# 영혼죽장
		
		# 대장간 제작 무기
		@data[110] = [150, 150]    	# 현랑부
		@data[108] = [300, 300]    	# 백화검
		@data[114] = [500, 500]    	# 주작의검
		@data[126] = [1200, 1200]    	# 참마도
		
		# 용궁무기
		@data[115] = [40000, 40000]    # 심판의낫
		@data[117] = [4500, 4500]    	# 괴력선창
		@data[131] = [700, 700]    	# 다문창
		@data[132] = [1300, 1300]    	# 인어장군지팡이
		
		# 일본무기
		@data[134] = [2000, 100000]    	# 일화접선
		@data[135] = [100000, 2000]    	# 진일신검
		@data[136] = [2000, 2000]    	# 이가닌자의검
		@data[138] = [100000, 2000]    	# 청일기창
		
		# 용무기
		@data[142] = [200, 0]    	# 용마제사검
		@data[143] = [1000, 100]    	# 용마제칠검
		@data[144] = [25000, 250]    	# 용마제팔검
		@data[145] = [500000, 12500]    	# 용마제구검
		
		
		@data[147] = [0, 200]    	# 용랑제사봉
		@data[148] = [100, 1000]    	# 용랑제칠봉
		@data[149] = [500, 25000]    	# 용랑제팔봉
		@data[150] = [12500, 500000]    	# 용랑제구봉
		
		# 기타
		@data[123] = [15000, 15000]    	# 현무염도
		@data[124] = [350, 700]    	# 얼음검
		@data[127] = [5000, 5000]    	# 청룡신검
		@data[129] = [300, 200]    	# 도깨비방망이
		@data[130] = [1400, 1400]    	# 산적왕의 칼
		
		
		for d in @data
			id = d[0]
			hp = d[1][0]
			sp = d[1][1]
			
			$data_weapons[id].hp_plus = hp if hp != nil 
			$data_weapons[id].sp_plus = sp if sp != nil
		end
	end
end


# 장비 옵션 처리
class Set_Armor_plus
	def initialize
		@data = {}
		# 투구
		@data[2] 	= [0, 30]     	# 지력의투구1
		@data[15] = [100, 100]		# 수선도사 머리띠
		@data[18] = [200, 150]		# 용왕의투구 모조
		@data[19] = [200, 150]		# 청선투구
		@data[22] = [300, 200]		# 황금투구(모조)
		@data[53] = [60, 0]				# 힘의투구1
		@data[61] = [300, 1000]		# 연청투구
		@data[62] = [1500, 100]		# 연홍투구
		@data[70] = [500, 300]		# 주술투구
		@data[74] = [5000, 3000]		# 황금투구
		
		# 갑옷
		@data[1] 	= [1, 1, 100, 100]				# 초심자의갑주
		@data[12] = [500, 300] 		# 주술갑옷
		@data[13] = [100, 100]    # 남자타라의옷
		@data[14] = [700, 1000]		# 해골갑옷
		@data[30] = [10000, 10000]	# 가릉빈가의 날개옷
		@data[32] = [300, 1000]		# 현인의영혼
		@data[41] = [1500, 300]		# 검황의영혼
		@data[42] = [2000, 2000]	# 황혼의갑주
		@data[43] = [3500, 3500]	# 산신의정화
		@data[44] = [375, 275]		# 황혼의활복
		@data[52] = [300, 1000]		# 진인의영혼
		@data[54] = [300, 1000]		# 귀검의영혼
		@data[73] = [30000, 30000]		# 가릉빈가의날개옷'진
		
		
		# 장신구
		@data[16] = [80, 100]			# 수정귀걸이
		@data[17] = [100, 150]		# 용왕의반지 모조
		@data[20] = [200, 150]		# 청선팔찌
		@data[21] = [200, 150]		# 해골목걸이
		@data[23] = [300, 200]		# 황금팔찌
		@data[45] = [100, 100]		# 인어반지
		@data[46] = [150, 150]		# 진주반지
		@data[50] = [500, 300]		# 용왕의반지'진
		@data[51] = [500, 300]		# 용왕의투구'진
		@data[63] = [100, 2000]		# 비취의목걸이
		@data[64] = [2000, 0]			# 수정의목걸이
		@data[71] = [500, 300]		# 주술팔찌
		@data[72] = [500, 300]		# 해골목걸이
		@data[75] = [5000, 3000]	# 황금팔찌
		
		# 방패
		@data[39] = [300, 200]		# 정화의방패
		@data[40] = [500, 400]		# 여신의방패
		
		
		for d in @data
			id = d[0]
			hp = d[1][0]
			sp = d[1][1]
			hp_per = d[1][2]
			sp_per = d[1][3]
			
			$data_armors[id].hp_plus = hp if hp != nil 
			$data_armors[id].sp_plus = sp if sp != nil
			$data_armors[id].hp_plus_per = hp_per if hp_per != nil 
			$data_armors[id].sp_plus_per = sp_per if sp_per != nil
		end
	end
end


class Game_Actor
	# 장비 착용할 때 체력, 마력 추가 하기
	def change_hsp(base_equip = 0, change_equip = 0, type = -1)
		return if type == -1 
		case type
		when 0
			temp_hp = maxhp
			temp_sp = maxsp
			
			temp_hp -= $data_weapons[base_equip].hp_plus if $data_weapons[base_equip] != nil and $data_weapons[base_equip].hp_plus != nil
			temp_sp -= $data_weapons[base_equip].sp_plus if $data_weapons[base_equip] != nil and $data_weapons[base_equip].sp_plus != nil
			
			temp_hp += $data_weapons[change_equip].hp_plus if $data_weapons[change_equip] != nil and $data_weapons[change_equip].hp_plus != nil
			temp_sp += $data_weapons[change_equip].sp_plus if $data_weapons[change_equip] != nil and $data_weapons[change_equip].sp_plus != nil
			
			self.maxhp = temp_hp
			self.maxsp = temp_sp
		else
			temp_hp = maxhp
			temp_sp = maxsp
			
			temp_hp -= $data_armors[base_equip].hp_plus if $data_armors[base_equip] != nil and $data_armors[base_equip].hp_plus != nil
			temp_sp -= $data_armors[base_equip].sp_plus if $data_armors[base_equip] != nil and $data_armors[base_equip].sp_plus != nil
			
			temp_hp += $data_armors[change_equip].hp_plus if $data_armors[change_equip] != nil and $data_armors[change_equip].hp_plus != nil
			temp_sp += $data_armors[change_equip].sp_plus if $data_armors[change_equip] != nil and $data_armors[change_equip].sp_plus != nil
			
			self.maxhp = temp_hp
			self.maxsp = temp_sp
		end
	end
	
	alias edit_equip equip
	def equip(equip_type, id)
		case equip_type
		when 0  # Weapon
			if id == 0 or $game_party.weapon_number(id) > 0
				change_hsp(@weapon_id, id, equip_type)
				$game_party.gain_weapon(@weapon_id, 1)
				@weapon_id = id
				$game_party.lose_weapon(id, 1)
			end
		when 1  # Shield
			if id == 0 or $game_party.armor_number(id) > 0
				update_auto_state($data_armors[@armor1_id], $data_armors[id])
				change_hsp(@armor1_id, id, equip_type)
				$game_party.gain_armor(@armor1_id, 1)
				@armor1_id = id
				$game_party.lose_armor(id, 1)
			end
		when 2  # Head
			if id == 0 or $game_party.armor_number(id) > 0
				update_auto_state($data_armors[@armor2_id], $data_armors[id])
				change_hsp(@armor2_id, id, equip_type)
				$game_party.gain_armor(@armor2_id, 1)
				@armor2_id = id
				$game_party.lose_armor(id, 1)
			end
		when 3  # Body
			if id == 0 or $game_party.armor_number(id) > 0
				update_auto_state($data_armors[@armor3_id], $data_armors[id])
				change_hsp(@armor3_id, id, equip_type)
				$game_party.gain_armor(@armor3_id, 1)
				@armor3_id = id
				$game_party.lose_armor(id, 1)
			end
		when 4  # Accessory
			if id == 0 or $game_party.armor_number(id) > 0
				update_auto_state($data_armors[@armor4_id], $data_armors[id])
				change_hsp(@armor4_id, id, equip_type)
				$game_party.gain_armor(@armor4_id, 1)
				@armor4_id = id
				$game_party.lose_armor(id, 1)
			end
		end
	end
	
	def take_base_str
		n = str
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n -= weapon != nil ? weapon.str_plus : 0
		n -= armor1 != nil ? armor1.str_plus : 0
		n -= armor2 != nil ? armor2.str_plus : 0
		n -= armor3 != nil ? armor3.str_plus : 0
		n -= armor4 != nil ? armor4.str_plus : 0
		n -= $rpg_skill.base_str
		return n.to_i
	end
	
	def take_base_dex
		n = dex
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n -= weapon != nil ? weapon.dex_plus : 0
		n -= armor1 != nil ? armor1.dex_plus : 0
		n -= armor2 != nil ? armor2.dex_plus : 0
		n -= armor3 != nil ? armor3.dex_plus : 0
		n -= armor4 != nil ? armor4.dex_plus : 0
		n -= $rpg_skill.base_dex
		return n.to_i
	end
	#--------------------------------------------------------------------------
	# ● 기본 신속함의 취득
	#--------------------------------------------------------------------------
	def take_base_agi
		n = agi
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n -= weapon != nil ? weapon.agi_plus : 0
		n -= armor1 != nil ? armor1.agi_plus : 0
		n -= armor2 != nil ? armor2.agi_plus : 0
		n -= armor3 != nil ? armor3.agi_plus : 0
		n -= armor4 != nil ? armor4.agi_plus : 0
		n -= $rpg_skill.base_agi
		return n.to_i
	end
	#--------------------------------------------------------------------------
	# ● 기본 마력의 취득
	#--------------------------------------------------------------------------
	def take_base_int
		n = int
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n -= weapon != nil ? weapon.int_plus : 0
		n -= armor1 != nil ? armor1.int_plus : 0
		n -= armor2 != nil ? armor2.int_plus : 0
		n -= armor3 != nil ? armor3.int_plus : 0
		n -= armor4 != nil ? armor4.int_plus : 0
		n -= $rpg_skill.base_int
		return n.to_i
	end
	
	
	def take_base_maxhp
		base_hp = maxhp
		
		id = weapon_id
		base_hp -= $data_weapons[id].hp_plus if id != 0 and $data_weapons[id].hp_plus != nil
		
		id = armor1_id
		base_hp -= $data_armors[id].hp_plus if id != 0 and $data_armors[id].hp_plus != nil
		
		id = armor2_id
		base_hp -= $data_armors[id].hp_plus if id != 0 and $data_armors[id].hp_plus != nil
		
		id = armor3_id
		base_hp -= $data_armors[id].hp_plus if id != 0 and $data_armors[id].hp_plus != nil
		
		id = armor4_id
		base_hp -= $data_armors[id].hp_plus if id != 0 and $data_armors[id].hp_plus != nil
		
		return base_hp
	end
	
	def take_base_maxsp
		base_sp = maxsp
		
		id = weapon_id
		base_sp -= $data_weapons[id].sp_plus if id != 0 and $data_weapons[id].sp_plus != nil
		
		id = armor1_id
		base_sp -= $data_armors[id].sp_plus if id != 0 and $data_armors[id].sp_plus != nil
		
		id = armor2_id
		base_sp -= $data_armors[id].sp_plus if id != 0 and $data_armors[id].sp_plus != nil
		
		id = armor3_id
		base_sp -= $data_armors[id].sp_plus if id != 0 and $data_armors[id].sp_plus != nil
		
		id = armor4_id
		base_sp -= $data_armors[id].sp_plus if id != 0 and $data_armors[id].sp_plus != nil
		
		return base_sp
	end
	
	# 기본 물리방어력
	def take_base_pdef
		n = @pdef
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n -= weapon != nil ? weapon.pdef : 0
		n -= armor1 != nil ? armor1.pdef : 0
		n -= armor2 != nil ? armor2.pdef : 0
		n -= armor3 != nil ? armor3.pdef : 0
		n -= armor4 != nil ? armor4.pdef : 0
		return n
	end
	
	# 기본 마법방어력
	def take_base_mdef
		n = @mdef
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n -= weapon != nil ? weapon.mdef : 0
		n -= armor1 != nil ? armor1.mdef : 0
		n -= armor2 != nil ? armor2.mdef : 0
		n -= armor3 != nil ? armor3.mdef : 0
		n -= armor4 != nil ? armor4.mdef : 0
		return n
	end
end
