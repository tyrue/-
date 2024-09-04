# 신수 스킬 아이디
SINSU_SKILL_ID = 
[
	1, # 신수마법
	10, # 신수 1성
	16, # 신수 2성
	22, # 신수 3성
	30, # 신수 4성
	37 # 신수 5성
]

# 성황당 스킬 데이터
SEONG_HWANG = {}
SEONG_HWANG[0] = [17] # 부여성
SEONG_HWANG[1] = [135] # 국내성
SEONG_HWANG[2] = [135] # 국내성
SEONG_HWANG[3] = [204] # 용궁
SEONG_HWANG[4] = [85]  # 고균도
SEONG_HWANG[5] = [234] # 일본
SEONG_HWANG[6] = [298] # 대방성
SEONG_HWANG[7] = [326] # 현도성
SEONG_HWANG[8] = [369] # 장안성
SEONG_HWANG[9] = [384] # 가릉도
SEONG_HWANG[10] = [392] # 폭염도

# 비영사천문 스킬 데이터
BIYEONG = {}
# d : 방향, 1 : 동, 2 : 서, 3 : 남, 4: 북
BIYEONG[0] = [1, [66, 33], [5, 30], [34, 68], [34, 2]] # 부여성
BIYEONG[1] = [123, [118, 60], [7, 60], [63, 109], [63, 12]] # 국내성
BIYEONG[2] = [110, [35, 16], [1, 16], [17, 33], [17, 2]] # 12지신
BIYEONG[3] = [203, [52, 23], [4, 24], [27, 43], [29, 8]] # 용궁
BIYEONG[4] = [60, [56, 33], [4, 32], [39, 57], [29, 10]] # 고균도
BIYEONG[5] = [230, [114, 30], [5, 31], [64, 90], [55, 2]] # 일본
BIYEONG[6] = [276, [113, 61], [8, 61], [61, 108], [61, 10]] # 대방성
BIYEONG[7] = [301, [113, 61], [8, 61], [61, 108], [61, 10]] # 현도성
BIYEONG[8] = [303, [113, 61], [8, 61], [61, 108], [61, 10]] # 장안성
BIYEONG[9] = [374, [58, 20], [12, 17], [28, 33], [27, 9]] # 가릉도
BIYEONG[10] = [391, [43, 29], [7, 25], [24, 37], [26, 9]] # 폭염도

# 업그레이드 하는 스킬들
UPGRADE_SKILL_ID = {}
UPGRADE_SKILL_ID[1] =	[1, 10, 16, 22, 30, 37] # 뢰진주류
UPGRADE_SKILL_ID[2] =	[2, 11, 17, 23, 31, 38] # 백열주류
UPGRADE_SKILL_ID[3] =	[3, 12, 18, 24, 32, 39] # 화염주류
UPGRADE_SKILL_ID[4] =	[4, 13, 19, 25, 33, 40] # 자무주류

UPGRADE_SKILL_ID[5]	= [64, 72, 76] # 십량분법류
UPGRADE_SKILL_ID[6]	= [65, 75] # 뢰마도
UPGRADE_SKILL_ID[7]	= [74, 78, 80, 102] # 십리건곤
UPGRADE_SKILL_ID[8] = [131, 141, 142] # 투명
UPGRADE_SKILL_ID[9] = [49, 52, 56] # 성려멸주

# 0~15 : 도토리, 토끼고기, 사슴고기, 녹용
# 15~25 : 쥐고기, 박쥐고기, 뱀고기
# 25~35 : 웅담, 호랑이고기
# 35~45 : 여우고기, 산돼지, 숲돼지고기
# 45~55 : 짙은호랑이고기, 돼지의뿔
# 55~85 : 호박, 진호박
# 85~99 : 진호박, 불의혼, 불의결정

# 3 도토리, 74 토끼고기, 5 사슴고기, 6 녹용
REQ_SKILL_DATA = {}
# data[스킬 아이디] : [스킬 필요레벨, [[재료 타입, 재료 아이디, 재료 개수], [...]]]
# 전사
REQ_SKILL_DATA[1] = {
	5 => [5, [[0, 3, 30], [0, 74, 10]]],   # 누리의기원
	26 => [6, [[0, 5, 5], [0, 6, 5]]],   # 누리의힘
	62 => [10, [[0, 7, 5], [0, 8, 5]]],   # 수심각도, 쇠고기, 돼지고기
	74 => [12, [[0, 9, 10], [0, 10, 7]]],  # 십리건곤
	63 => [18, [[0, 10, 10], [0, 104, 10]]],# 반영대도
	64 => [25, [[0, 11, 10], [0, 12, 10]]], # 십량분법
	65 => [30, [[0, 12, 10], [0, 50, 10]]], # 뢰마도
	27 => [35, [[0, 19, 10], [0, 20, 10]]], # 동해의기원
	66 => [40, [[0, 19, 20], [0, 20, 15]]], # 신수둔각도
	77 => [45, [[0, 22, 10], [0, 28, 3]]],  # 유비후타
	67 => [50, [[0, 22, 20], [0, 59, 1]]],  # 건곤대나이
	140 => [56, [[0, 29, 20], [0, 30, 10]]],# 운기
	71 => [62, [[0, 29, 10], [0, 30, 10]]], # 혼신의힘
	73 => [64, [[0, 29, 10], [0, 30, 30]]], # 광량돌격
	29 => [67, [[0, 29, 5], [0, 30, 5]]],   # 천공의기원
	72 => [70, [[0, 29, 20], [0, 30, 20]]], # 구량분법
	43 => [78, [[0, 29, 10], [0, 30, 25]]], # 위태응기
	78 => [80, [[0, 29, 15], [0, 30, 15]]], # 십리건곤 1성
	75 => [82, [[0, 29, 10], [0, 30, 30]]], # 뢰마도 1성
	80 => [89, [[0, 31, 3], [0, 37, 1]]],   # 십리건곤 2성
	76 => [91, [[0, 30, 10], [0, 31, 3]]],  # 팔량분법
	79 => [99, [[0, 99, 4], [0, 100, 4]]],  # 동귀어진
}

# 주술사
REQ_SKILL_DATA[2] = {
	5 => [5, [[0, 3, 30], [0, 74, 10]]],     # 누리의기원
	1 => [6, [[0, 5, 4], [0, 6, 4]]],     # 신수마법
	46 => [10, [[0, 7, 5], [0, 8, 10]]],     # 무장
	10 => [15, [[0, 9, 20], [0, 10, 20]]],   # 신수 1성
	15 => [20, [[0, 10, 15], [0, 104, 15]]], # 공력증강
	16 => [23, [[0, 104, 10], [0, 11, 15]]], # 신수 2성
	47 => [27, [[0, 11, 10], [0, 12, 10]]],  # 보호
	21 => [30, [[0, 11, 10], [0, 50, 10]]],  # 바다의기원
	22 => [35, [[0, 50, 20], [0, 19, 5]]],   # 신수 3성
	20 => [40, [[0, 19, 7], [0, 20, 7]]],    # 마법집중
	27 => [45, [[0, 19, 10], [0, 20, 10]]],  # 동해의기원
	28 => [50, [[0, 20, 10], [0, 22, 10]]],  # 야수
	29 => [54, [[0, 22, 10], [0, 28, 3]]],   # 천공의기원
	182 => [56, [[0, 22, 10], [0, 28, 3]]],   # 저주
	30 => [60, [[0, 29, 10], [0, 30, 5]]],   # 신수 4성
	34 => [63, [[0, 29, 5], [0, 30, 5]]],    # 귀환
	35 => [65, [[0, 29, 5], [0, 30, 5]]],    # 비호
	36 => [70, [[0, 29, 15], [0, 30, 15]]],  # 구름의기원
	37 => [76, [[0, 29, 10], [0, 30, 30]]],  # 신수 5성
	41 => [85, [[0, 30, 10], [0, 31, 3]]],   # 체마혈식
	42 => [90, [[0, 30, 10], [0, 31, 3]]],   # 주술마도
	44 => [99, [[0, 99, 4], [0, 100, 4]]],   # 헬파이어
}

# 도사
REQ_SKILL_DATA[3] = {
	86 => [5, [[0, 3, 30], [0, 74, 10]]],   # 바다의희원
	1 => [6, [[0, 5, 5], [0, 6, 5]]],       # 신수마법
	46 => [8, [[0, 7, 2], [0, 8, 10]]],       # 무장
	47 => [10, [[0, 9, 3], [0, 10, 3]]],    # 보호
	15 => [13, [[0, 9, 10], [0, 10, 10]]],     # 공력증강
	96 => [20, [[0, 11, 15], [0, 12, 15]]],    # 지진
	81 => [23, [[0, 19, 5], [0, 20, 5]]],    # 동해의희원
	83 => [30, [[0, 19, 10], [0, 20, 10]]],     # 천공의희원
	90 => [35, [[0, 19, 20], [0, 20, 15]]],    # 분량방법
	50 => [40, [[0, 28, 2], [0, 22, 10]]],     # 야수수금술
	88 => [50, [[0, 29, 10], [0, 30, 10]]],    # 분량력법
	89 => [55, [[0, 29, 15], [0, 30, 15]]],    # 구름의희원
	92 => [60, [[0, 29, 10], [0, 30, 30]]],    # 공력주입
	93 => [70, [[0, 29, 15], [0, 30, 15]]],    # 태양의희원
	95 => [80, [[0, 29, 20], [0, 30, 20]]],     # 생명의희원
	94 => [90, [[0, 31, 3], [0, 37, 3]]],      # 금강불체 
	120 => [99, [[0, 99, 4], [0, 100, 4]]],    # 부활
}

# 도적
REQ_SKILL_DATA[4] = {
	5 => [5, [[0, 3, 30], [0, 74, 10]]],       # 누리의기원
	26 => [6, [[0, 5, 10], [0, 6, 10]]],      # 누리의힘
	1 => [10, [[0, 9, 15], [0, 10, 15]]],      # 신수마법
	27 => [15, [[0, 10, 10], [0, 104, 20]]],   # 동해의기원
	130 => [20, [[0, 11, 15], [0, 12, 15]]],   # 무영보법
	131 => [23, [[0, 11, 10], [0, 12, 20]]],   # 투명
	10 => [27, [[0, 12, 10], [0, 50, 10]]],    # 신수마법 1성
	132 => [30, [[0, 50, 20], [0, 19, 10]]],   # 비영승보
	16 => [35, [[0, 19, 10], [0, 20, 10]]],    # 신수마법 2성
	29 => [40, [[0, 28, 5], [0, 22, 15]]],     # 천공의기원
	140 => [50, [[0, 29, 20], [0, 30, 10]]],   # 운기
	133 => [56, [[0, 29, 15], [0, 30, 5]]],    # 필살검무
	64 => [64, [[0, 29, 10], [0, 30, 15]]],    # 십량분법
	34 => [70, [[0, 29, 5], [0, 30, 5]]],      # 귀환
	141 => [75, [[0, 29, 15], [0, 30, 20]]],   # 투명 1성
	144 => [80, [[0, 29, 5], [0, 30, 5]]],     # 급소타격
	43 => [81, [[0, 29, 10], [0, 30, 25]]],    # 위태응기
	142 => [88, [[0, 30, 20], [0, 31, 3]]],    # 투명 2성
	134 => [99, [[0, 99, 4], [0, 100, 4]]],    # 분신
}


# -------------END----------------- #


# ----------------------------------#
# ----- 직업별 승급 필요 체력, 마력---------#
# ----------------------------------#
NEED_ADVANCE_RESOURCE = {} # 각 요소는 승급시 필요 체/마
NEED_ADVANCE_RESOURCE[0] = [
	[15000, 10000], 
	[50000, 80000], 
	[150000, 250000], 
	[300000, 600000]] # 주술사

NEED_ADVANCE_RESOURCE[1] = [
	[35000, 2000], 
	[200000, 5000], 
	[600000, 10000], 
	[1400000, 150000]] # 전사

NEED_ADVANCE_RESOURCE[2] = [
	[12000, 8000], 
	[40000, 70000], 
	[100000, 200000], 
	[250000, 500000]] # 도사

NEED_ADVANCE_RESOURCE[3] = [
	[35000, 2000], 
	[200000, 5000], 
	[600000, 10000], 
	[1400000, 150000]] # 도적

# 승급 차수당 경험치 판매 단위
NEED_ADVANCE_EXP = [
	[1_000_000, 1_000_000], 		# 0차 
	[3_000_000, 3_000_000], # 1차 
	[6_000_000, 6_000_000], # 2차 
	[10_000_000, 10_000_000], # 3차 
	[10_000_000, 10_000_000], # 4차
]
# -------------END----------------- #

class Rpg_skill
	# 직업별 배울 마법 찾기
	def find_will_learn_skill(type) # 직업
		# data[스킬 아이디] : [스킬 필요레벨, [[재료 타입, 재료 아이디, 재료 개수], [...]]]
		actor = $game_party.actors[0]
		sorted_skills = REQ_SKILL_DATA[type].sort_by { |_, data| data[0] }
		
		temp = case
		when $game_switches[1] then 0
		when $game_switches[2] then 1
		when $game_switches[3] then 2
		when $game_switches[4] then 3
		else 0
		end
		
		sorted_skills.each do |id, data|
			s_id = id + (SINSU_SKILL_ID.include?(id) ? temp : 0)
			
			# 업그레이드 되는 스킬이면 이전 하위 스킬을 건너뜀
			next if UPGRADE_SKILL_ID.values.any? do |arr|
				arr.include?(s_id) && arr.any? { |u_id| actor.skill_learn?(u_id) && (s_id <= u_id) }
			end
			
			return id unless actor.skill_learn?(s_id)
		end
		
		return nil
	end
	
	# 해당 스킬을 배우는데 필요한 재료
	def req_skill_item(type, id) # 직업, 배우려고하는 아이디
		return nil unless id
		
		# data[스킬 아이디] : [스킬 필요레벨, [[재료 타입, 재료 아이디, 재료 개수], [...]]]
		# type : 1 전사, 2 주술사, 3 도사, 4 도적
		data = REQ_SKILL_DATA[type][id]
		return nil unless data 
		
		temp = case
		when $game_switches[1] then 0
		when $game_switches[2] then 1
		when $game_switches[3] then 2
		when $game_switches[4] then 3
		else 0
		end
		
		id += temp if SINSU_SKILL_ID.include?(id)
		
		return {
			"level" => data[0],
			"skill_id" => id,
			"req_data" => data[1]
		}
	end
	
	# 승급시 필요 체력, 마력 반환하는 함수
	def need_advancement_resource
		self.job_select # 현재 상태 초기화
		# NEED_ADVANCE_RESOURCE[0] = [[4500, 4500], [10000, 15000], [25000, 40000], [70000, 120000]] # 주술사
		idx = -1
		idx = 0 if $game_switches[6] # 주술사
		idx = 1 if $game_switches[156] # 전사
		idx = 2 if $game_switches[144] # 도사	
		idx = 3 if $game_switches[426] # 도적	
		
		return if idx == -1
		return if NEED_ADVANCE_RESOURCE[idx] == nil
		return if NEED_ADVANCE_RESOURCE[idx][$job_degree.to_i] == nil
		
		$game_variables[195] = NEED_ADVANCE_RESOURCE[idx][$job_degree.to_i][0] # 승급 필요 체
		$game_variables[196] = NEED_ADVANCE_RESOURCE[idx][$job_degree.to_i][1] # 승급 필요 마
	end
	
	# 자기 직업 스위치 온
	def job_select
		# 주술사, 전사, 도사, 도적
		job_switches = [6, 156, 144, 426]  # 직업 스위치
		degree_switches = [0, 143, 150, 155, 358]  # 승급 차수 스위치
		job_data = {
			0 => [2, 3, 5, 6, 14],    # 주술사
			1 => [7, 8, 9, 10, 15],   # 전사
			2 => [4, 11, 12, 13, 16], # 도사
			3 => [17, 18, 19, 20, 21] # 도적
		}
		reset_switches(job_switches + degree_switches)
		
		c_id = $game_party.actors[0].class_id
		my_job_type, $job_degree = find_job_and_degree(c_id, job_data)
		return unless my_job_type
		
		job_switch = job_switches[my_job_type]
		
		$game_switches[job_switch] = true 
		(1..$job_degree).each { |i| $game_switches[degree_switches[i]] = true }
		
		[my_job_type, $job_degree]
	end
	
	def reset_switches(switches)
		switches.each { |id| $game_switches[id] = false }
	end
	
	def find_job_and_degree(c_id, job_data)
		job_data.each do |type, ids|
			ids.each_with_index do |val, degree|
				return [type, degree] if c_id == val
			end
		end
		[nil, 0]  # 기본값으로 반환
	end
	
	def set_learn_skill_data(data)
		$temp_level = data["level"]
		$game_variables[32] = data["skill_id"]
		$temp_req_string = build_requirements_string(data["req_data"], "다네.", "라네.")
	end
	
	def build_requirements_string(req_data, msg1 = "습니다.", msg2 = "입니다.")
		req_string_arr = []
		req_string_arr << "필요한 재료는 다음과 같#{msg1}" # 시작 메시지
		
		temp_str = ""
		i = 1
		req_data.each do |type, id, num|
			temp_str += "\n" if i % 4 == 0
			
			name = fetch_item_name(type, id)
			num = change_number_unit(num)
			temp_str += case type
			when 0..2 then "[#{name} #{num}개] "
			when 3 then "[#{num}전] "
			end
			i += 1
		end
		
		req_string_arr << "#{temp_str}#{msg2}"
		return req_string_arr.join("\n")
	end
	
	def fetch_item_name(type, id)
		case type
		when 0 then $data_items[id].name
		when 1 then $data_weapons[id].name
		when 2 then $data_armors[id].name
		when 3 then "금전"
		end
	end
	
	def check_learn_skill_data(data)
		actor = $game_party.actors[0]
		success, msg = check_need_item(data["req_data"], "하다네.")
		unless success
			$temp_req_string = msg
			return false
		end
		
		lose_need_item_data(data["req_data"])
		actor.learn_skill(data["skill_id"])
		return true
	end
	
	# 스킬을 사용하기 위한 재료가 준비 됐는지 확인
	def check_need_skill_item(id)
		skill_data = $rpg_skill_data[id]
		return true unless skill_data.need_item
		
		success, msg = check_need_item(skill_data.need_item) 
		unless success
			$console.write_line(msg)
			return false
		end
		
		lose_need_item_data(skill_data.need_item)
		return true
	end
	
	# 필효한 재료가 준비 됐는지 확인
	def check_need_item(need_data, suffix = "합니다.")
		msg = ""
		return [false, msg] unless need_data
		
		need_data.each do |item_data|
			sw, item, my_num = check_item_num(item_data)
			unless sw
				msg = build_missing_item_message(item_data, item, my_num)
				msg += suffix
				return [false, msg]
			end
		end
		return [true, msg]
	end
	
	def lose_need_item_data(need_data)
		need_data.each { |item_data| lose_item_num(item_data) } # 재료 아이템 소모
	end
	
	def check_item_num(data)
		type, id, req_num = data
		my_num, item = case type
		when 0 then [$game_party.item_number(id), $data_items[id]]
		when 1 then [$game_party.weapon_number(id), $data_weapons[id]]
		when 2 then [$game_party.armor_number(id), $data_armors[id]]
		when 3 then [$game_party.gold, nil]
		end
		
		[my_num >= req_num, item, my_num]
	end
	
	def lose_item_num(data)
		type, id, num = data
		case type
		when 0 then $game_party.lose_item(id, num) # 아이템
		when 1 then $game_party.lose_weapon(id, num) # 무기
		when 2 then $game_party.lose_armor(id, num)# 방어구
		when 3 then $game_party.lose_gold(num) # 금전
		end
	end
	
	def build_missing_item_message(data, item, my_num)
		type, _, num = data
		n = change_number_unit(num - my_num)
		case type
		when 0..2 then "#{item.name}(이)가 #{n}개 부족"
		when 3 then "금전이 #{n}전 부족"
		end
	end
	
	def check_advance_resource(buy_type = "")
		job_type, degree = job_select # 직업 타입과 승급 차수
		actor = $game_party.actors[0]
		
		exp = actor.exp
		base_hp = actor.take_base_max_stat("hp")
		base_sp = actor.take_base_max_stat("sp")
		
		unit_hp, unit_sp = 100, 50 # 한 번당 오르는 체마 단위
		limit_hp, limit_sp = MAXHP_LIMIT, MAXSP_LIMIT
		limit_hp, limit_sp = NEED_ADVANCE_RESOURCE[job_type][degree].map {|val| val + 10000} if degree <= 3
		unit_hp_exp, unit_sp_exp = NEED_ADVANCE_EXP[degree] # 한번당 필요한 경험치 단위
		
		if degree >= 4
			val = 200000.0
			unit_hp_exp = (unit_hp_exp * ((base_hp / val) + 1.0)).to_i
			unit_sp_exp = (unit_sp_exp * ((base_sp / val) + 1.0)).to_i
		end
		
		can_buy_hp = (exp / unit_hp_exp).to_i
		can_buy_sp = (exp / unit_sp_exp).to_i
		
		msg = [
			"자네의 경험치 #{change_number_unit(unit_hp_exp)}를 희생하여 체력 #{unit_hp} 또는",
			"경험치 #{change_number_unit(unit_sp_exp)}를 희생하여 마력 #{unit_sp}을 증가 시킬 수 있다네..."
		]
		$temp_req_string = msg.join("\n")
		
		return [base_hp, unit_hp, limit_hp, unit_hp_exp, can_buy_hp] if buy_type == "hp"
		return [base_sp, unit_sp, limit_sp, unit_sp_exp, can_buy_sp] if buy_type == "sp"
		return []
	end
end

class Game_Actor < Game_Battler
	#--------------------------------------------------------------------------
	# * Learn Skill
	#     skill_id : skill ID
	#--------------------------------------------------------------------------
	alias rpg_skill_learn learn_skill
	def learn_skill(skill_id)
		rpg_skill_learn(skill_id) # 이전 함수 코드 실행
		$console.write_line("마법 #{$data_skills[skill_id].name}을(를) 배웠다!") if $login_check
		
		# 업그레이드 되는 스킬이면 이전 하위 스킬을 지움
		UPGRADE_SKILL_ID.values.each do |u_skill|
			next if !u_skill.include?(skill_id)
			
			u_skill.each do |id|
				return if id == skill_id
				next if !skill_learn?(id)
				
				forget_skill(id) 
				$console.write_line("이전 마법 #{$data_skills[id].name}은(는) 사라졌다!") if $login_check
			end			
		end
		
		# 투명 등 숙련도 설정
		$game_variables[10] = case skill_id
		when 131 then 0
		when 141 then 1
		when 142 then 2
		end
	end
end