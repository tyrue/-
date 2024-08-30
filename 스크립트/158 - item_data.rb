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
WEAPON_SE_DATA[104] = ["철도"]
WEAPON_SE_DATA[118] = ["철도"]

WEAPON_SE_DATA[24] = ["야월도"]
WEAPON_SE_DATA[25] = ["야월도"]

WEAPON_SE_DATA[26] = ["현철중검"]
WEAPON_SE_DATA[106] = ["현철중검"]
WEAPON_SE_DATA[120] = ["현철중검"]
WEAPON_SE_DATA[126] = ["현철중검"]
WEAPON_SE_DATA[129] = ["현철중검"]

WEAPON_SE_DATA[31] = ["활"]

WEAPON_SE_DATA[108] = ["현랑부"]
WEAPON_SE_DATA[109] = ["현랑부"]
WEAPON_SE_DATA[110] = ["현랑부"]
WEAPON_SE_DATA[111] = ["현랑부"]

WEAPON_SE_DATA[114] = ["주작의검"]

WEAPON_SE_DATA[115] = ["심판의낫"]

WEAPON_SE_DATA[117] = ["괴력선창"]

WEAPON_SE_DATA[123] = ["현무의검"]

WEAPON_SE_DATA[124] = ["일월대도"]
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
		@Trade_ban_item = {}
		@trade_switch_start = {
			1 => 500,
			2 => 1700
		}
		
		add_trade_ban_items($data_items, 0) if $data_items
		add_trade_ban_items($data_weapons, 1) if $data_weapons
		add_trade_ban_items($data_armors, 2) if $data_armors
		
		add_additional_trade_bans
	end
	
	def add_trade_ban_items(data, type)
		@Trade_ban_item[type] ||= {}
		
		data.each do |item|
			next unless item && item.name != ""
			@Trade_ban_item[type][item.id] = item.price <= 0 ? 1 : 0
		end
	end
	
	def add_additional_trade_bans
		add_bans_item
		add_bans_weapon
		add_bans_armor
	end
	
	def add_bans_item
		type = 0
		add_bans(type, 46, 2) # 암호수리검
		add_bans(type, 52, 2) # 청룡의 비늘
		add_bans(type, 53, 2) # 화룡의 비늘
		
		add_bans(type, 84, 2) # 용왕의 증표
		add_bans(type, 85, 2) # 주몽의 증표
		add_bans(type, 86, 2) # 현무의 증표
		
		add_bans(type, 114, 2) # 팔괘
		add_bans(type, 117, 2) # 청룡 보옥
		add_bans(type, 118, 2) # 현무 보옥
		add_bans(type, 119, 2) # 반고의 심장
		add_bans(type, 126, 2) # 청룡의 뿔
		add_bans(type, 163, 2) # 일본주막비서
		add_bans(type, 217, 2) # 고균도주막비서
	end
	
	def add_bans_weapon
		type = 1
		# 교환 불가 무기 추가
		# 신수둔각도
		add_bans(type, 1, 2)
		add_bans(type, 2, 2)
		add_bans(type, 3, 2)
		add_bans(type, 4, 2)
		
		# 4차 무기
		add_bans(type, 6, 2)
		add_bans(type, 7, 2)
		add_bans(type, 8, 2)
		add_bans(type, 9, 2)
		
		add_bans(type, 116, 2)  # 진일신검손상
		add_bans(type, 128, 2)  # 용량제구봉?
		add_bans(type, 131, 2)  # 다문창
		add_bans(type, 132, 2)  # 인어장군지팡이
		
		add_bans(type, 12) # 구곡검
		add_bans(type, 13) # 영후단봉
		add_bans(type, 11)  # 대모홍접선
		add_bans(type, 14)  # 협가검
		
		# 기타 무기 설정
		add_bans(type, 15)  # 석단장
		add_bans(type, 16)  # 백사도
		add_bans(type, 17)  # 음양도
		
		add_bans(type, 26)  # 녹호박별검
		add_bans(type, 108)  # 백화검
		add_bans(type, 110)  # 현랑부
		add_bans(type, 112)  # 양첨목봉
		add_bans(type, 114)  # 주작의검
		add_bans(type, 115)  # 심판의낫
		
		add_bans(type, 117)  # 괴력선창
		add_bans(type, 123)  # 현무염도
		add_bans(type, 124)  # 얼음검
		
		add_bans(type, 126)  # 참마도
		add_bans(type, 127)  # 청룡신검
		
		add_bans(type, 129)  # 도깨비방망이
		add_bans(type, 130)  # 산적왕의칼
		
		add_bans(type, 134)  # 일화접선
		add_bans(type, 135)  # 진일신검
		add_bans(type, 136)  # 이가닌자의검
		add_bans(type, 138)  # 청일기창
		
		add_bans(type, 141)  # 용마제일검
		add_bans(type, 142)  # 용마제사검
		add_bans(type, 143)  # 용마제칠검
		add_bans(type, 144)  # 용마제팔검
		add_bans(type, 145)  # 용마제구검
		
		add_bans(type, 146)  # 용랑제일봉
		add_bans(type, 147)  # 용랑제사봉
		add_bans(type, 148)  # 용랑제칠봉
		add_bans(type, 149)  # 용랑제팔봉
		add_bans(type, 150)  # 용랑제구봉
		
		add_bans(type, 152, 2)  # 용마제칠검(손상)
		add_bans(type, 153, 2)  # 용마제팔검(손상)
		
		add_bans(type, 154, 2)  # 용랑제칠봉(손상)
		add_bans(type, 155, 2)  # 용랑제팔봉(손상)
	end
	
	def add_bans_armor
		type = 2
		
		add_bans(type, 32, 2)  # 현인의영혼
		add_bans(type, 41, 2)   # 검황의영혼
		add_bans(type, 52, 2)   # 진인의영혼
		add_bans(type, 54, 2)   # 귀검의영혼
		
		add_bans(type, 12)   # 주술갑옷
		add_bans(type, 13)  # 남자타라의 옷
		add_bans(type, 14)   # 해골갑옷
		add_bans(type, 15)  # 수선도사의머리띠
		add_bans(type, 16)   # 수정귀걸이
		
		add_bans(type, 19)  # 청선투구
		add_bans(type, 20)  # 청선팔찌
		add_bans(type, 21)   # 해골목걸이
		add_bans(type, 22)   # 황금투구
		add_bans(type, 23)   # 황금팔찌
		add_bans(type, 24)   # 용왕둔갑두루마리
		add_bans(type, 25)   # 강건부
		
		add_bans(type, 28)   # 보무의목걸이
		add_bans(type, 29)   # 투명구두
		add_bans(type, 30)   # 가릉빈가의날개옷
		add_bans(type, 33)   # 도깨비부적
		
		add_bans(type, 36)   # 기원부
		add_bans(type, 39)   # 정화의방패
		add_bans(type, 40)   # 여신의방패
		add_bans(type, 42)   # 황혼의갑주
		add_bans(type, 43)   # 산신의정화
		add_bans(type, 44)   # 황혼의활복
		add_bans(type, 45)   # 인어반지
		add_bans(type, 46)   # 진주반지
		add_bans(type, 57)  # 호박투구
		add_bans(type, 58)   # 진호박투구
		add_bans(type, 60)   # 황금호박투구
		
		# 망또 시리즈
		add_bans(type, 47)  # 망또1
		add_bans(type, 48)  # 망또2
		add_bans(type, 49)  # 망또3
		add_bans(type, 55)  # 망또4
		add_bans(type, 56)  # 망또5
		
		add_bans(type, 50)  # 용왕의반지'진
		add_bans(type, 51)  # 용왕의투구'진
		
		add_bans(type, 61)  # 연청투구
		add_bans(type, 62)  # 연홍투구
		add_bans(type, 63)  # 비취의목걸이
		add_bans(type, 64)  # 수정의목걸이
		add_bans(type, 70)  # 주술투구
		add_bans(type, 71)  # 주술팔찌
		add_bans(type, 72)  # 해골목걸이
		add_bans(type, 73)  # 가릉빈가의날개옷'진
		add_bans(type, 74)  # 황금투구
		add_bans(type, 75)  # 황금팔찌
		
		# 반지 및 투구
		(80..97).each { |id| add_bans(type, id, 0) }
		
		add_bans(type, 98, 0)  # 재생의부적
	end
	
	
	def add_bans(type, id, state = 1)
		@Trade_ban_item[type][id] = state
	end
	
	# 교환 가능 아이템인가?
	def trade_state(id, type)
		return 2 if @Trade_ban_item[type][id] == 2 # 절대 귀속
		return 0 if @Trade_ban_item[type][id] == 0
		return 0 if check_trade_switch(id, type)
		return 1
	end
	
	def is_trade_ok?(id, type)
		return trade_state(id, type) == 0
	end
	
	def check_trade_switch(id, type)
		return false unless @trade_switch_start[type]
		
		sw_id = @trade_switch_start[type] + id
		return $game_switches[sw_id]
	end
	
	def trade_switch(id, type, state = false)
		sw_id = @trade_switch_start[type] + id
		$game_switches[sw_id] = state
	end
	
	def process_one_trade_switch(id, type)
		return unless check_trade_switch(id, type)
		
		trade_switch(id, type, false)
		name = case type
		when 0 then $data_items[id].name
		when 1 then $data_weapons[id].name
		when 2 then $data_armors[id].name
		end
		
		$console.write_line("#{name}의 1회 교환이 해제되었습니다.")
	end
	
	def weapon_se(id)
		default_root = "무기/"
		file_name = WEAPON_SE_DATA[id] ? WEAPON_SE_DATA[id][0] : "기본"
		file_name = default_root + file_name
		
		play_weapon_se(file_name, default_root)
	end
	
	def play_weapon_se(file_name, default_root)
		$game_system.se_play(file_name.to_s)
	rescue
		$game_system.se_play(default_root + "기본")
	end
end

