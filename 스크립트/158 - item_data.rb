# 무기에 따라 휘두르는 효과음 다르게 하기
# WEAPON_SE_DATA[id] = ["실행할 SE 파일 이름"]
WEAPON_SE_DATA = {}
WEAPON_SE_DATA[1] = ["주작의검"]
WEAPON_SE_DATA[2] = ["백호의검"]
WEAPON_SE_DATA[3] = ["현무의검"]
WEAPON_SE_DATA[4] = ["청룡의검"]

WEAPON_SE_DATA[6] = ["4차무기"]
WEAPON_SE_DATA[7] = ["4차무기"]
WEAPON_SE_DATA[8] = ["4차무기"]
WEAPON_SE_DATA[9] = ["4차무기"]

WEAPON_SE_DATA[11] = ["대모홍접선"]
WEAPON_SE_DATA[12] = ["협가검"]
WEAPON_SE_DATA[13] = ["협가검"]
WEAPON_SE_DATA[14] = ["협가검"]

WEAPON_SE_DATA[15] = ["석단장"]
WEAPON_SE_DATA[16] = ["석단장"]
WEAPON_SE_DATA[17] = ["석단장"]

WEAPON_SE_DATA[22] = ["철도"]
WEAPON_SE_DATA[23] = ["철도"]
WEAPON_SE_DATA[118] = ["철도"]
WEAPON_SE_DATA[119] = ["철도"]

WEAPON_SE_DATA[24] = ["야월도"]
WEAPON_SE_DATA[25] = ["야월도"]

WEAPON_SE_DATA[26] = ["현철중검"]
WEAPON_SE_DATA[106] = ["현철중검"]
WEAPON_SE_DATA[120] = ["현철중검"]
WEAPON_SE_DATA[126] = ["현철중검"]

WEAPON_SE_DATA[31] = ["활"]

WEAPON_SE_DATA[108] = ["현랑부"]
WEAPON_SE_DATA[109] = ["현랑부"]
WEAPON_SE_DATA[110] = ["현랑부"]
WEAPON_SE_DATA[111] = ["현랑부"]

WEAPON_SE_DATA[114] = ["주작의검"]

WEAPON_SE_DATA[115] = ["심판의낫"]

WEAPON_SE_DATA[117] = ["괴력선창"]

WEAPON_SE_DATA[123] = ["현무의검"]

WEAPON_SE_DATA[125] = ["일월대도"]
WEAPON_SE_DATA[130] = ["일월대도"]

WEAPON_SE_DATA[127] = ["청룡의검"]

WEAPON_SE_DATA[131] = ["다문창"]
WEAPON_SE_DATA[132] = ["다문창"]

WEAPON_SE_DATA[134] = ["일본전설"]
WEAPON_SE_DATA[135] = ["일본전설"]
WEAPON_SE_DATA[138] = ["청일"]

WEAPON_SE_DATA[136] = ["이가"]

WEAPON_SE_DATA[141] = ["용마"]
WEAPON_SE_DATA[142] = ["용마"]
WEAPON_SE_DATA[143] = ["용마"]
WEAPON_SE_DATA[144] = ["용마"]
WEAPON_SE_DATA[145] = ["용마"]

WEAPON_SE_DATA[146] = ["용랑"]
WEAPON_SE_DATA[147] = ["용랑"]
WEAPON_SE_DATA[148] = ["용랑"]
WEAPON_SE_DATA[149] = ["용랑"]
WEAPON_SE_DATA[150] = ["용랑"]

WEAPON_SE_DATA[152] = ["용마"]
WEAPON_SE_DATA[153] = ["용마"]
WEAPON_SE_DATA[154] = ["용랑"]
WEAPON_SE_DATA[155] = ["용랑"]


# 용무기 강화 데이터
# DRAGON_WEAPON_DATA[weapon_id] = [강화확률, 필요한 은나무가지 개수, 성공시 얻는 무기, 실패시 얻는 무기]
DRAGON_WEAPON_DATA = {}
DRAGON_WEAPON_DATA[141] = [70, 1, 142] # 용마제일검
DRAGON_WEAPON_DATA[142] = [40, 2, 143] # 용마제사검
DRAGON_WEAPON_DATA[143] = [10, 3, 144, 152] # 용마제칠검
DRAGON_WEAPON_DATA[144] = [3, 4, 145, 153] # 용마제팔검

DRAGON_WEAPON_DATA[146] = [70, 1, 147] # 용랑제일봉
DRAGON_WEAPON_DATA[147] = [40, 2, 148] # 용랑제사봉
DRAGON_WEAPON_DATA[148] = [10, 3, 149, 154] # 용랑제칠봉
DRAGON_WEAPON_DATA[149] = [3, 4, 150, 155] # 용랑제팔봉

class Item_data
	attr_accessor :Trade_ban_item

	
	def initialize
		@Trade_ban_item = []
		@Trade_ban_weapon = []
		@Trade_ban_armor = []
		# 가격이 0인 아이템들은 교환 불가 아이템
		
		if $data_items != nil
			for item in $data_items
				if item != nil
					if item.name != "" and item.price <= 0
						#p item.name
						@Trade_ban_item.push(item.id) 
					end
				end
			end
		end
		
		if $data_weapons != nil
			for item in $data_weapons
				if item != nil
					if item.name != "" and item.price <= 0
						#p item.name
						@Trade_ban_weapon.push(item.id) 
					end
				end
			end
		end
		
		if $data_armors != nil
			for item in $data_armors
				if item != nil
					if item.name != "" and item.price <= 0
						#p item.name
						@Trade_ban_armor.push(item.id) 
					end
				end
			end
		end
				
		# 교환불가 아이템 추가
		@Trade_ban_item.push(46) # 암호수리검
		@Trade_ban_item.push(52) # 청룡의 비늘
		@Trade_ban_item.push(53) # 화룡의 비늘
		@Trade_ban_item.push(114) # 팔괘
		@Trade_ban_item.push(117) # 청룡 보옥
		@Trade_ban_item.push(118) # 현무 보옥
		@Trade_ban_item.push(119) # 반고의 심장
		@Trade_ban_item.push(163) # 일본주막비서
		@Trade_ban_item.push(217) # 고균도주막비서
		
		# 교환 불가 무기 추가
		# 4차 무기
		@Trade_ban_weapon.push(6)
		@Trade_ban_weapon.push(7)
		@Trade_ban_weapon.push(8)
		@Trade_ban_weapon.push(9) 
		
		# 교환 불가 장비 추가
	end
	
	# 교환 가능 아이템인가?
	def is_trade_ok(id, type)
		case type
		when 0 # 아이템
			return !@Trade_ban_item.include?(id)
		when 1 # 무기
			return !@Trade_ban_weapon.include?(id)
		when 2 # 장비
			return !@Trade_ban_armor.include?(id)
		end
	end
	
	def weapon_se(id)
		default_root = "Audio/SE/무기/"
		file_name = WEAPON_SE_DATA[id] != nil ? WEAPON_SE_DATA[id][0] : "기본"
		file_name = default_root + file_name
		
		begin
			Audio.se_play(file_name.to_s, $game_variables[13])
		rescue
			file_name = default_root + "기본"
			Audio.se_play(file_name, $game_variables[13])
		end
		Network::Main.socket.send("<se_play>#{file_name.to_s}</se_play>\n")	# range 스킬 사용했다고 네트워크 알리기
	end
end
