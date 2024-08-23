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
		@data[112] = [500, 500]    	# 양첨목봉
		@data[114] = [750, 750]    	# 주작의검
		@data[26] = [1000, 1000]    	# 녹호박별검
		@data[126] = [1300, 1300]    	# 참마도
		
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
		@data[130] = [1700, 1700]    	# 뇌령진도
		
		for w in $data_weapons
			next unless w
			d = @data[w.id]
			next unless d
			$data_weapons[w.id].hp_plus = d[0] || 0 
			$data_weapons[w.id].sp_plus = d[1] || 0
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
		@data[57] = [100, 100]		# 호박투구
		@data[58] = [300, 300]		# 진호박투구
		@data[60] = [1000, 1000]		# 황금호박투구
		
		@data[61] = [300, 1500]		# 연청투구
		@data[62] = [1500, 300]		# 연홍투구
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
				
		for a in $data_armors
			next unless a
			d = @data[a.id]
			next unless d
			$data_armors[a.id].hp_plus = d[0] || 0 
			$data_armors[a.id].sp_plus = d[1] || 0
		end
	end
end


class Game_Actor
	EQUIP_TYPES = {
		0 => :weapon,
		1 => :armor1,
		2 => :armor2,
		3 => :armor3,
		4 => :armor4
	}
	
	# 장비 착용할 때 체력, 마력 추가 하기
	def change_hsp(base_equip, change_equip, type)
		equip_data = type.zero? ? $data_weapons : $data_armors
		temp_hp = maxhp
		temp_sp = maxsp
		
		if equip_data[base_equip]
			temp_hp -= equip_data[base_equip].hp_plus || 0
			temp_sp -= equip_data[base_equip].sp_plus || 0
		end
		
		if equip_data[change_equip]
			temp_hp += equip_data[change_equip].hp_plus || 0
			temp_sp += equip_data[change_equip].sp_plus || 0
		end
		
		self.maxhp = temp_hp
		self.maxsp = temp_sp
	end
	
	alias edit_equip equip
	def equip(equip_type, id)
		equip_id = eval("@#{EQUIP_TYPES[equip_type]}_id")
		case equip_type
		when 0
			return if !id.zero? && $game_party.weapon_number(id).zero?
			change_hsp(equip_id, id, equip_type)
			$game_party.gain_weapon(equip_id, 1)
			$game_party.lose_weapon(id, 1)
		when 1..5
			return if !id.zero? && $game_party.armor_number(id).zero?
			update_auto_state($data_armors[equip_id], $data_armors[id])
			change_hsp(equip_id, id, equip_type)
			$game_party.gain_armor(equip_id, 1)
			$game_party.lose_armor(id, 1)
		end
		instance_variable_set("@#{EQUIP_TYPES[equip_type]}_id", id)
	end
	
	def take_base_stat(stat)
		rpg = $game_party.actors[0].rpg_skill
		n = send(stat)
		n -= take_equipment_stat(stat)
		n -= rpg.send("base_#{stat}") if rpg.respond_to?("base_#{stat}")
		return n
	end
	
	def take_base_max_stat(stat)
		base_stat = send("max#{stat}")
		EQUIP_TYPES.values.each { |equip_type|
			equip_id = eval("@#{equip_type}_id")
			armor = equip_type.to_sym == :weapon ? $data_weapons[equip_id] : $data_armors[equip_id]
			next unless armor
			base_stat -= (armor.send("#{stat}_plus") || 0) if armor.respond_to?("#{stat}_plus")
		}
		return base_stat
	end
	
	def take_equipment_stat(stat)
		result = 0
		EQUIP_TYPES.values.each { |equip_type|
			equip_id = eval("@#{equip_type}_id")
			armor = equip_type.to_sym == :weapon ? $data_weapons[equip_id] : $data_armors[equip_id]
			next unless armor
			result += (armor.send("#{stat}_plus") || 0) if armor.respond_to?("#{stat}_plus")
			result += (armor.send("#{stat}") || 0) if armor.respond_to?("#{stat}")
		}
		return result
	end
end
