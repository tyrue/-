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
	1 => [7, [[0, 5, 4], [0, 6, 4]]],     # 신수마법
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
	1 => [7, [[0, 5, 5], [0, 6, 5]]],       # 신수마법
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
	93 => [67, [[0, 29, 15], [0, 30, 15]]],    # 태양의희원
	95 => [78, [[0, 30, 30], [0, 31, 3]]],     # 생명의희원
	94 => [90, [[0, 31, 3], [0, 37, 3]]],      # 금강불체 
	120 => [99, [[0, 99, 4], [0, 100, 4]]],    # 부활
}

# 도적
REQ_SKILL_DATA[4] = {
	5 => [5, [[0, 3, 30], [0, 74, 10]]],       # 누리의기원
	26 => [8, [[0, 5, 10], [0, 6, 10]]],      # 누리의힘
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
# ----- 몬스터 스킬 주문 외우는 데이터---------#
# ----------------------------------#
#															[[시간초, "주문", (색깔 타입), (애니메이션 id)], []...]
ABS_ENEMY_SKILL_CASTING = {}
ABS_ENEMY_SKILL_CASTING[151] = [[1, "멀리 날려주마!!!!"]] # 청룡의 포효
ABS_ENEMY_SKILL_CASTING[152] = [[1, "물러나라..!"]] # 현무의 포효
ABS_ENEMY_SKILL_CASTING[153] = [[0.5, "!백호검무!!!!"]] # 백호검무
ABS_ENEMY_SKILL_CASTING[154] = [[1.3, "여의주의 힘을 받은 용이여..."], [1.3, "그대 이름은 청룡일지다..."], [1.3, "네 주인 이름으로 명하노니"], [1, "네 분노를 적에게 발산하라!"]] # 청룡마령참
ABS_ENEMY_SKILL_CASTING[155] = [[3, "암흑에 물들어라.."]] # 암흑진파
ABS_ENEMY_SKILL_CASTING[156] = [[2, "명계의 검은 용이여...!"], [1, "지금, 계약에 따라 소환될지어다!!"]] # 흑룡광포
ABS_ENEMY_SKILL_CASTING[158] = [[4, "지옥에서 불타버려라!!"]] # 지옥겁화
ABS_ENEMY_SKILL_CASTING[159] = [[2, "미천한 필멸자여.."], [1, "하늘 높은 줄 모르고 날뛰는구나.."], [0.5, "너의 나약함을 깨닫게 하리라!!"]] # 혈겁만파
ABS_ENEMY_SKILL_CASTING[160] = [[1.5, "바람처럼 나타나 그림자처럼 사라지리라..."], [1.5, "이 순간, 모든 것을 내 검 아래 휩쓸테니...!"], [0.5, "압도적인 힘에 절망하라!!"]] # 분혼경천
ABS_ENEMY_SKILL_CASTING[161] = [[1.5, "영원한 공허의 무수한 파편들이여.."], [1.3, "대지와 하늘의 연결을 허용하노니..."], [1, "지금 이 땅의 운명을 새로 써내려라!!!"]] # 폭류유성
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

# $game_variables[19] 플레이어 힘
# $game_variables[20] 플레이어 민첩
# $game_variables[21] 플레이어 지력
# $game_variables[22] 플레이어 손재주

class Rpg_skill
	attr_accessor :base_str
	attr_accessor :base_int
	attr_accessor :base_agi
	attr_accessor :base_dex
	attr_accessor :player_base_move_speed
	attr_accessor :battler 
	attr_accessor :character
	
	def initialize(battler = nil)
		@base_str = 0
		@base_agi = 0
		@base_int = 0
		@base_dex = 0
		@base_move_speed = 3
		
		@battler = battler
		@character = case @battler
		when Game_Actor then $game_player
		when ABS_Enemy then @battler.event
		when Game_NetPlayer then @battler
		end
	end
	
	def process_skill(id, is_my = true, enemy = nil)
		skill = $data_skills[id]
		self.buff(id, is_my) # 이게 버프 스킬인지 확인
		self.debuff(id, is_my) # 이게 디버프 스킬인지 확인
		self.heal(id, is_my) # 이게 회복 스킬인지 확인
		self.active_skill(id, enemy) # 액티브 스킬 행동 커스텀 확인
		self.skill_chat(skill) # 스킬 사용시 말하는 것
	end
	
	def update
		self.update_buff
	end
	
	def update_buff() # 버프 지속 효과 (일정 주기마다 해야하는 것 등)
		sec = Graphics.frame_rate
		
		@battler.buff_time.each do |id, time|
			next if time <= 0 # 버프가 끝난상태면 무시
			
			data = $rpg_skill_data[id]		
			next unless data.cycle_time
			
			if data.is_move_stop && @character.moving?
				@battler.buff_time[id] = 1
				next
			end	
			next unless (Graphics.frame_count % (sec * data.cycle_time) == 0)
			
			ani_id = data.cycle_animation || data.skill_data.animation1_id 
			@character.ani_array.push(ani_id) 
			next unless data.cycle_action
			
			data.cycle_action.each do |action|
				case action
				when "heal" then heal(id)
				when "heal_debuff" then heal_debuff(id)
				end
			end 
		end
	end
	
	def check_speed_buff()
		speed = 0
		for data in @battler.buff_time
			next if data[1] <= 0 # 버프가 끝난상태면 무시
			id = data[0]
			next if $rpg_skill_data[id].buff_data == nil
			
			buff_data = $rpg_skill_data[id].buff_data
			buff_data.each do |d|
				speed += d[1] if d[0] == "speed"
			end
		end
		return speed
	end
	
	# 파티 버프
	def party_buff(id)
		return unless @character == $game_player
		
		ani_id = $data_skills[id].animation1_id # 스킬 사용 측 애니메이션 id
		@character.ani_array.push(ani_id)
		
		data = {
			"id" => id,
			"value" => 0
		}
		message = data.map { |key, value| "#{key}:#{value}" }.join("|")
		Network::Main.send_with_tag("party_heal", message)
	end
	
	# 자기 힐
	def heal(id, my_heal = true, value = 0)
		data = $rpg_skill_data[id]
		return unless data.type.include?("heal")
		return if data.type.include?("debuff")
		return heal_process(data, value) unless my_heal 
		
		heal_v = data.heal_value
		heal_arr = data.heal_value_per # [타입, hp, sp]
		
		if heal_arr
			t, h, s = heal_arr
			heal_v += case t
			when 0 then @battler.hp * h + @battler.sp * s # 현재
			when 1 then @battler.maxhp * h + @battler.maxsp * s # 전체
			end
		end
		
		heal_v += ((@battler.maxhp + @battler.maxsp) * 0.001)
		heal_v *= (1.0 + @battler.atk / 100.0) * (1 + (@battler.int / 1000.0)) if data.is_party
		
		heal_process(data, heal_v)
		skill_cost_custom(id) 
		
		return unless data.is_party
		m_data = {
			"id" => id,
			"value" => heal_v
		}
		message = m_data.map { |key, value| "#{key}:#{value}" }.join("|")
		Network::Main.send_with_tag("party_heal", message)
	end
	
	def heal_debuff(id)
		data = $rpg_skill_data[id]
		return unless (data.type.include?("heal") && data.type.include?("debuff"))
		
		heal_v = data.heal_value
		heal_arr = data.heal_value_per # [타입, hp, sp]
		
		if heal_arr
			t, h, s = heal_arr
			heal_v += case t
			when 0 then @battler.hp * h + @battler.sp * s # 현재
			when 1 then @battler.maxhp * h + @battler.maxsp * s # 전체
			end
		end
		
		heal_process(data, heal_v)
	end
	
	def heal_process(data, heal_v)
		type = data.heal_type
		heal_v = heal_v.to_i
		
		case type
		when "hp"	
			@battler.hp += heal_v
			@battler.critical = "heal"
		when "sp"
			@battler.sp += heal_v
			@battler.critical = "heal_sp"
		when "all"
			@battler.hp += heal_v
			@battler.sp += heal_v
			@battler.critical = "heal"
		when "com"
			$game_temp.common_event_id = data.heal_value
		end
		
		@battler.critical = "player_hit" if heal_v < 0
		@battler.damage = heal_v.abs.to_s
		@battler.hp = [@battler.hp, 1].max
		@battler.sp = [@battler.sp, 0].max
	end
	
	# 이미 버프가 걸려있는지 확인
	def check_buff(id)
		return (@battler.buff_time[id] != nil and @battler.buff_time[id] > 0)
	end
	
	# 버프 사용
	def buff_active(id, my_buff = true)
		buff(id, my_buff) # 이게 버프 스킬인지 확인
		debuff(id, my_buff) # 이게 디버프 스킬인지 확인
		@character.ani_array.push($data_skills[id].animation1_id || 0 )  # 스킬 사용 측 애니메이션 id
	end
	
	# 버프
	def buff(id, my_buff = true)
		skill_data = $rpg_skill_data[id]
		return unless skill_data.type.include?("buff")
		return if skill_data.type.include?("debuff")
		
		check_time = check_buff(id)
		buff_time_set = skill_data.buff_time * Graphics.frame_rate
		apply_buff_time(id, buff_time_set)
		party_buff(id) if skill_data.is_party && my_buff
		
		return if check_time
		return unless skill_data.buff_data
		
		skill_data.buff_data.each do |type, val|
			process_buff_effect(type.to_s, val, false, id)
		end
		true
	end
	
	def debuff(id, my_buff = true)
		skill_data = $rpg_skill_data[id]
		return unless skill_data.type.include?("debuff")
		return if my_buff
		
		check_time = check_buff(id)
		buff_time_set = skill_data.buff_time * Graphics.frame_rate
		apply_buff_time(id, buff_time_set)
		
		return if check_time
		return unless skill_data.buff_data
		
		skill_data.buff_data.each do |type, val|
			process_buff_effect(type.to_s, val, false, id)
		end
	end
	
	def apply_buff_time(id, buff_time_set)
		@battler.buff_time[id] = buff_time_set
		$ABS.skill_console(id) if @battler.is_a?(Game_Actor)
	end
	
	def process_buff_effect(type, val, is_close, id)
		case type
		when "str", "dex", "int", "agi", "mdef", "pdef"
			apply_stat_effect([type, val], is_close)
		when "per_str", "per_dex", "per_int", "per_agi", "per_mdef", "per_pdef"
			apply_percentage_effect([type, val], is_close)
		when "speed"
			change_move_speed(val, is_close)
		else
			apply_custom_effect(id, [type, val], is_close) 
		end
	end
	
	# 버프 끄기
	def buff_del(id)
		skill_data = $rpg_skill_data[id]
		@battler.buff_time[id] = 0
		return unless skill_data.buff_data
		
		skill_data.buff_data.each do |type, val|
			process_buff_effect(type.to_s, val, true, id)
		end
	end
	
	def apply_stat_effect(data, is_close = false)
		stat = data[0].to_sym
		value = data[1].to_i * (is_close ? -1 : 1)
		@battler.send("#{stat}=", @battler.send(stat) + value)
		
		return if @battler == $game_party.actors[0]
		return unless eval("@base_#{stat}")
		
		instance_variable_set("@base_#{stat}", instance_variable_get("@base_#{stat}") + value) 		
	end
	
	def apply_percentage_effect(data, is_close = false)
		stat = data[0].sub("per_", "").to_sym
		base = @battler.take_base_stat(stat)
		n = (base * (data[1].to_f - 1.0)).to_i * (is_close ? -1 : 1)
		@battler.send("#{stat}=", @battler.send(stat) + n)
		
		return if @battler != $game_party.actors[0]
		return if eval("@base_#{stat}") == nil
		instance_variable_set("@base_#{stat}", instance_variable_get("@base_#{stat}") + n)
	end
	
	def change_move_speed(value, is_close = false)
		@character.move_speed += value * (is_close ? -1 : 1)
		
		return unless @character == $game_player
		Network::Main.send_with_tag("5", "@move_speed = #{@character.move_speed};")
	end
	
	def apply_custom_effect(id, data, is_close = false)
		return unless @battler.is_a?(Game_Actor)
		
		type, val = data
		case id
		when 28, 35, 50 # 둔갑
			$game_temp.common_event_id = !is_close ? val.to_i : 41
		when 66  # 신수둔각도
			if is_close
				$game_party.actors[0].equip(0, 0)
				[1, 2, 3, 4].each { |id| $game_party.lose_weapon(id, 999) }
				$game_system.se_play("장비")
				$game_party.actors[0].equip(0, $game_variables[41]) if $game_switches[50] and $game_variables[41] > 0
				return
			end
			
			$game_variables[41] = $game_party.actors[0].weapon_id if $game_party.actors[0].weapon_id > 4 # 대충 현재 착용 했던 무기 아이디 저장
			w_id = 1
			w_id = 4 if $game_switches[1] # 청룡
			w_id = 2 if $game_switches[2] # 백호
			w_id = 1 if $game_switches[3] # 주작
			w_id = 3 if $game_switches[4] # 현무
			
			$game_party.gain_weapon(w_id, 1)
			$game_party.actors[0].equip(0, w_id)
		when 131, 141, 142
			!is_close ? self.투명 : self.투명해제
		when 134
			$console.write_line(is_close ? "분신이 사라집니다." : "분신을 생성합니다.")
		when 140
			$console.write_line(is_close ? "운기가 종료 됩니다." : "마력을 회복합니다.")
		when 143
			$console.write_line("투명을 유지합니다.")  
			self.party_buff(142)
		else
			# 처리할 게 없을 때
		end
	end
	
	def casting_chat(data)
		return unless @character
		
		sec = data[0]
		msg = data[1]
		type = data[2] || 3
		
		if msg 
			$chat_b.input(msg, type, sec, @character)
			Network::Main.socket.send "<map_chat>#{name}&#{msg}&#{type}</map_chat>\n" if @character == $game_player
			Network::Main.socket.send "<monster_chat>#{@character.id}&#{msg}&#{type}</monster_chat>\n" if @character != $game_player 
		end
	end
	
	# 스킬에 따른 대화를 생성하고 채팅을 보내는 함수
	def skill_chat(skill)
		id = skill.id
		name = @battler.name
		msg = nil
		type = 3
		sec = 4
		
		# 각 스킬에 대한 메시지 생성
		msg = case id
		when 44 then "#{skill.name}!!" # 헬파이어
		when 53, 57, 69 then "삼매진화!!" # 삼매진화
		when 58, 67, 101, 103, 106, 123, 133, 135, 137, 138 then "!!#{skill.name}!!" # 지정된 스킬
		when 79 then "!!#{skill.name}!!" # 동귀어진
		when 143 then "!!#{skill.name}!!" # 기문방술
		when 151, 152 then "크롸롸롸롸!" # 청룡 포효, 현무 포효
		when 154 then "!!#{skill.name}!!" # 청룡마령참
		when 155, 156 then "#{skill.name}!!" # 암흑진파, 흑룡광포
		when 157 then type = 4; "가소롭다!!" # 회복
		when 158, 159, 160, 161 then "!!#{skill.name}!!" # 지정된 스킬
		when 162 then "나에게 벗어날 수 없다!!"
		end
		
		if msg
			$chat_b.input(msg, type, sec, @character)
			Network::Main.socket.send "<map_chat>#{name}&#{msg}&#{type}</map_chat>\n" if @character == $game_player
			Network::Main.socket.send "<monster_chat>#{@character.id}&#{msg}&#{type}</monster_chat>\n" if @character != $game_player
		end
	end
	
	def calculate_critical(attribute)
		rate = 0
		power = 0
		@battler.buff_time.each do |id, time|
			next if time <= 0
			
			skill_data = $rpg_skill_data[id]
			buff_data = skill_data.send(attribute)
			next unless buff_data
			
			rate += buff_data[0] || 0
			power += buff_data[1] || 0
		end
		[rate, power]
	end
	
	def critical_rate()
		calculate_critical(:attack_critical)
	end
	
	def critical_skill_rate()
		calculate_critical(:skill_critical)
	end
	
	
	#[(파워 계산량)[타입(현재(0), 전체(1)), 체력, 마력, 기본값], (자원 소모량)[타입(현재(0), 전체(1)), 체력, 마력]]
	def skill_power_custom(id, power)
		case id
		when 6 # 도토리 던지기
			return 1
		end
		
		skill_data = $rpg_skill_data[id]
		return power unless skill_data.power_arr 
		
		data = skill_data.power_arr
		
		# 0 : 현재, 1 : 전체
		type = data[0] || -1
		p_hp = data[1] ||  0
		p_sp = data[2] || 0
		val = data[3] || 0
		return power if type == -1 || type == 2
		
		power = power.to_f
		power += case type
		when 0 then (@battler.hp * p_hp) + (@battler.sp * p_sp) # 현재 
		when 1 then (@battler.maxhp * p_hp) + (@battler.maxsp * p_sp) # 전체
		end
		
		power += val
		return power.to_i
	end
	
	# 비례 데미지 스킬
	def damage_by_skill(damage, id)
		skill_data = $rpg_skill_data[id]
		data = skill_data.power_arr
		return damage unless data
		
		# 2 : 비례데미지
		type = data[0] || -1
		p_hp = data[1] || 0
		p_sp = data[2] || 0
		val = data[3] || 0
		return damage unless type == 2
		
		damage = damage.to_f
		damage += (@battler.maxhp * p_hp) + val
		@battler.sp -= @battler.maxsp * p_sp # 마력 깎기
		return damage.to_i
	end
	
	def skill_cost_custom(id)
		skill_data = $rpg_skill_data[id]
		return unless skill_data.cost_arr 
		
		data = skill_data.cost_arr 
		type = data[0] || -1
		c_hp = data[1] || 0
		c_sp = data[2] || 0
		return if type == -1
		
		case type
		when 0 # 현재 
			@battler.hp -= @battler.hp * c_hp
			@battler.sp -= @battler.sp * c_sp
		when 1 # 전체
			@battler.hp -= @battler.maxhp * c_hp
			@battler.sp -= @battler.maxsp * c_sp
		end
		
		@battler.hp = [@battler.hp.to_i, 1].max
		@battler.sp = @battler.sp.to_i
	end
	
	# 액티브 스킬 커스텀
	def active_skill(id, enemy)
		skill_data = $rpg_skill_data[id]
		return unless skill_data.is_active
		
		case id
		when 15 # 공력증강
			공력증강
		when 73 # 광량돌격
			광량돌격
		when 132
			비영승보(enemy)
		when 162
			추격(enemy)
		end		
	end
	
	def 공력증강
		r = rand(100)
		if(r <= 40)			
			$console.write_line("실패했습니다.") if @character == $game_player
			@character.ani_array.push(158)
			return 
		end
		
		@battler.hp /= 2
		@battler.hp = 1 if @battler.hp <= 0
		@battler.sp += @battler.maxsp
		@character.ani_array.push(135)
	end
	
	def 투명
		$state_trans = true # 현재 자신이 투명상태인걸 뜻함
		Network::Main.send_trans(true)
	end
	
	def 투명해제
		if self.check_buff(143) # 기문방술 걸려있을 땐 해제 안함
			$state_trans = true
			return 
		end
		return if $state_trans == false
		
		Network::Main.send_trans(false)
		$state_trans = false
		
		# 투명 버프 해제
		$game_party.actors[0].buff_time[131] = 1 if self.check_buff(131) # 투명 1성
		$game_party.actors[0].buff_time[141] = 1 if self.check_buff(141) # 투명 2성
		$game_party.actors[0].buff_time[142] = 1 if self.check_buff(142) # 투명 3성
	end
	
	def 광량돌격
		move_num = 10 # 스킬 범위만큼
		x = @character.x
		y = @character.y
		d = @character.direction
		for i in 0...move_num
			break unless @character.passable?(x, y, d)			
			x += (d == 6 ? 1 : d == 4 ? -1 : 0)
			y += (d == 2 ? 1 : d == 8 ? -1 : 0)
		end
		@character.moveto(x, y)
	end
	
	def 비영승보(enemy = nil)
		return if @character == nil
		
		x = @character.x
		y = @character.y
		d = @character.direction
		
		enemy = 비영_passable2?(x, y, d) unless enemy
		return unless enemy
		
		data = 비영_passable?(enemy, d) # [x, y, d]
		if data != nil
			@character.moveto(data[0], data[1]) 
			@character.direction = data[2]
		end
		$ABS.player_melee(true) if @character == $game_player
	end
	
	def move_coordinates(x, y, direction)
		case direction
		when 2 then [x, y + 1]
		when 4 then [x - 1, y]
		when 6 then [x + 1, y]
		when 8 then [x, y - 1]
		else [x, y]
		end
	end
	
	def check_points(enemy, direction)
		x, y = enemy.x, enemy.y
		n_x, n_y = move_coordinates(x, y, direction)
		n_x2, n_y2 = move_coordinates(x, y, (direction == 2 || direction == 8) ? 4 : 2)
		n_x3, n_y3 = move_coordinates(x, y, (direction == 2 || direction == 8) ? 6 : 8)
		[[n_x, n_y], [n_x2, n_y2], [n_x3, n_y3]]
	end
	
	def object_check(objects, new_x, new_y)
		objects.each do |obj|
			next if obj.through 
			next if obj.character_name.empty?
			next if obj == @character
			
			return obj if obj.x == new_x && obj.y == new_y
		end
		nil
	end
	
	def map_object_check(new_x, new_y)
		objects = $game_map.events.values + Network::Main.mapplayers.values + [$game_player]
		object_check(objects, new_x, new_y)
	end
	
	def 비영_passable?(enemy, direction)
		check_points = check_points(enemy, direction)
		
		check_points.each do |new_x, new_y|
			next unless $game_map.valid?(new_x, new_y) && $game_map.passable?(new_x, new_y, 10 - direction)
			
			next if map_object_check(new_x, new_y)
			
			sx = new_x - enemy.x
			sy = new_y - enemy.y
			
			new_direction = if sx.abs > 0
				sx > 0 ? 4 : 6
			elsif sy.abs > 0
				sy > 0 ? 8 : 2
			else
				direction
			end
			
			return [new_x, new_y, new_direction]
		end
		nil
	end
	
	def 비영_passable2?(x, y, direction)
		new_x, new_y = move_coordinates(x, y, direction)
		map_object_check(new_x, new_y) || map_object_check(x, y)
	end
	
	def 추격(enemy)
		return unless @character 
		return unless enemy
		return if @battler.is_a?(ABS_Enemy) && !@battler.aggro
		
		@character.moveto(enemy.x, enemy.y)
		@character.ani_array.push(158)
	end
	
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
	
	# 평타 공격시 버프, 디버프에 대한 데미지 계산
	def damage_calculation_attack(damage)
		# 가해자 입장
		@battler.buff_time.each do |id, time|
			data = $rpg_skill_data[id]
			next if time <= 0
			next unless data.attack_power_per
			
			damage *= data.attack_power_per
			damage = skill_power_custom(id, damage)
			skill_cost_custom(id)
		end
		
		return damage.to_i
	end
	
	# 스킬 공격시 버프, 디버프에 대한 데미지 계산
	def damage_calculation_skill(damage)
		# 가해자 입장
		@battler.buff_time.each do |id, time|
			data = $rpg_skill_data[id]
			next unless data.skill_power_per
			next if time <= 0
			
			damage *= data.skill_power_per
		end
		return damage
	end
	
	def damage_calculation_defense(damage)
		# 피해자 입장
		@battler.buff_time.each do |id, time|
			data = $rpg_skill_data[id]
			next if time <= 0
			next unless data.defense_per
			
			damage -= damage * data.defense_per
		end
		
		if @battler.is_a?(Game_Actor)
			
		elsif @battler.is_a?(ABS_Enemy)
			damage = 1 if @battler.id == 41 # 청자다람쥐
		end
		return damage
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
