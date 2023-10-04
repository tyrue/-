# -----------------------설정 데이터들----------------------------------#
sec = 60 # 1초
SKILL_DIRECTION = {} # 범위 스킬 방향 및 개수

RANGE_SKILLS = {}	# 원거리 스킬
RANGE_EXPLODE = {}	# 폭발 스킬

SKILL_MASH_TIME = {} # 스킬 딜레이
SKILL_BUFF_TIME = {} # 스킬 지속 시간 

SKILL_POWER_CUSTOM = {} # 스킬 파워 설정
SKILL_COST_CUSTOM = {} # 스킬 소모 자원 설정

HEAL_SKILL = {} # 치유 마법 (기원류)
PARTY_HEAL_SKILL = {} # 치유마법 (희원류)

BUFF_SKILL = {} # 버프 스킬 값 저장
PARTY_BUFF_SKILL = {} # 파티 버프 스킬 아이디 저장

ACTIVE_SKILL = {} # 액티브 스킬 행동 커스텀

NEED_SKILL_ACTIVE_ITEM = {} # 스킬 사용하기 위한 재료

SKILL_ACTIVE_MESSAGE = {} # 스킬 사용시 메시지
# //////////////////////////end///////////////////////////////#

# ----------------------- 회복 --------------------------------#
#HEAL_SKILL[id] = [힐 값, 파티 버프 여부] # 누리의힘

HEAL_SKILL[5] = [75]  		# 누리의기원
HEAL_SKILL[21] = [100]		# 바다의기원
HEAL_SKILL[27] = [170]		# 동해의기원
HEAL_SKILL[29] = [300]		# 천공의기원
HEAL_SKILL[36] = [500]		# 구름의기원
HEAL_SKILL[48] = [1000]		# 태양의기원
HEAL_SKILL[54] = [2000]		# 태양의기원 1성
HEAL_SKILL[55] = [5000]		# 현인의기원
HEAL_SKILL[157] = [5000]	# 적 회복 스킬
HEAL_SKILL[43] = [1]			# 위태응기
# //////////////////////////end///////////////////////////////#

# ----------------------- 파티 회복 --------------------------------#
PARTY_HEAL_SKILL[81] = [170]  	# 동해의희원
PARTY_HEAL_SKILL[83] = [200]  	# 천공의희원
PARTY_HEAL_SKILL[86] = [75] 	 	# 바다의희원
PARTY_HEAL_SKILL[87] = [200]  	# 천공의희원
PARTY_HEAL_SKILL[89] = [500]  	# 구름의희원
PARTY_HEAL_SKILL[93] = [1000] 	# 태양의희원
PARTY_HEAL_SKILL[92] = [1]  		# 공력주입
PARTY_HEAL_SKILL[95] = [3000]  	# 생명의희원
PARTY_HEAL_SKILL[117] = [1]  		# 백호의희원
PARTY_HEAL_SKILL[118] = [7000]  # 신령의희원
PARTY_HEAL_SKILL[119] = [15000] # 봉황의희원
PARTY_HEAL_SKILL[120] = [1]  		# 부활
# //////////////////////////end///////////////////////////////#

# ----------------------- 버프 --------------------------------#
#BUFF_SKILL[id] = [time, 파티 버프 여부, [[스텟, 값, (버프 해제시 되돌릴 값)], []..]] # 누리의힘
# 주술사
BUFF_SKILL[26] = [180, false, [["str", 20]] ] # 누리의힘
BUFF_SKILL[28] = [60, false, [["com", 40]] ] # 야수
BUFF_SKILL[35] = [60, false, [["com", 42]] ] # 비호
BUFF_SKILL[42] = [180, true, [["per_int", 1.2, 0]] ] # 주술마도

# 도사
BUFF_SKILL[50] = [60, true, [["com", 40]] ] # 야수수금술
BUFF_SKILL[51] = [180, true, [["str", 30]] ] # 대지의힘
BUFF_SKILL[88] = [60, true, [["per_str", 1.2, 0]] ] # 분량력법
BUFF_SKILL[90] = [60, true, [["per_agi", 1.2, 0]] ] # 분량방법
BUFF_SKILL[91] = [60, false, [["com", 129]] ] # 석화기탄
BUFF_SKILL[46] = [180, true, [["mdef", 10], ["pdef", 10]] ] # 무장
BUFF_SKILL[47] = [180, true, [["mdef", 15], ["pdef", 15]] ] # 보호
BUFF_SKILL[94] = [5, false] # 금강불체
BUFF_SKILL[121] = [10, true] # 신령지익진
BUFF_SKILL[122] = [10, true] # 파력무참진

# 전사
BUFF_SKILL[62] = [180, false, [["dex", 50]] ] # 수심각도
BUFF_SKILL[63] = [180, false, [["agi", 50]] ] # 반영대도
BUFF_SKILL[64] = [180, false, [["per_str", 1.1, 0]] ] # 십량분법
BUFF_SKILL[66] = [60, false, [["custom", 1]] ] # 신수둔각도
BUFF_SKILL[71] = [10, false, [["per_str", 1.6, 0]] ] # 혼신의힘
BUFF_SKILL[72] = [180, false, [["per_str", 1.2, 0]] ] # 구량분법
BUFF_SKILL[76] = [180, false, [["per_str", 1.3, 0]] ] # 팔량분법

# 도적
BUFF_SKILL[130] = [180, false, [["dex", 50], ["agi", 50]] ] # 무영보법
BUFF_SKILL[131] = [20, false, [["custom", 1]] ] # 투명
BUFF_SKILL[141] = [20, false, [["custom", 1]] ] # 투명 1성
BUFF_SKILL[142] = [30, false, [["custom", 1]] ] # 투명 2성
BUFF_SKILL[134] = [120, false, [["custom", 1]] ] # 분신
BUFF_SKILL[136] = [180, true, [["speed", 0.5]] ] # 운상미보
BUFF_SKILL[140] = [10, false, [["custom", 1]] ] # 운기

BUFF_SKILL[99] = [360, false, [["speed", 0.5]] ] # 속도시약
# //////////////////////////end///////////////////////////////#

# -----------------------액티브 커스텀 스킬--------------------------------#
ACTIVE_SKILL[15] = []
ACTIVE_SKILL[73] = [] # 광량돌격
ACTIVE_SKILL[132] = [] # 비영승보
# //////////////////////////end///////////////////////////////#

# -----------------------원거리 스킬--------------------------------#
# 범위, 이동속도, 캐릭터이름, 후 딜레이 시간, 넉백 범위, 히트수
# 주술사
RANGE_SKILLS[1] = [10, 10, "공격스킬2", 4, 0] 	#뢰진주
RANGE_SKILLS[2] = [10, 10, "공격스킬2", 4, 0] 	#백열주
RANGE_SKILLS[3] = [10, 10, "공격스킬2", 4, 0] 	#화염주
RANGE_SKILLS[4] = [10, 10, "공격스킬2", 4, 0] 	#자무주
RANGE_SKILLS[10] = [10, 10, "공격스킬2", 4, 0] #뢰진주 1성
RANGE_SKILLS[11] = [10, 10, "공격스킬2", 4, 0] #백열주 1성
RANGE_SKILLS[12] = [10, 10, "공격스킬2", 4, 0] #화염주 1성
RANGE_SKILLS[13] = [10, 10, "공격스킬2", 4, 0] #자무주 1성
RANGE_SKILLS[14] = [10, 10, "공격스킬2", 4, 0] #뢰진주 첨
RANGE_SKILLS[16] = [10, 10, "공격스킬2", 4, 0] #뢰진주 2성
RANGE_SKILLS[17] = [10, 10, "공격스킬2", 4, 0] #백열주 2성
RANGE_SKILLS[18] = [10, 10, "공격스킬2", 4, 0] #화염주 2성
RANGE_SKILLS[19] = [10, 10, "공격스킬2", 4, 0] #자무주 2성
RANGE_SKILLS[22] = [10, 10, "공격스킬2", 4, 0] #뢰진주 3성
RANGE_SKILLS[23] = [10, 10, "공격스킬2", 4, 0] #백열주 3성
RANGE_SKILLS[24] = [10, 10, "공격스킬2", 4, 0] #화염주 3성
RANGE_SKILLS[25] = [10, 10, "공격스킬2", 4, 0] #자무주 3성
RANGE_SKILLS[30] = [10, 10, "공격스킬2", 4, 0] #뢰진주 4성
RANGE_SKILLS[31] = [10, 10, "공격스킬2", 4, 0] #백열주 4성
RANGE_SKILLS[32] = [10, 10, "공격스킬2", 4, 0] #화염주 4성
RANGE_SKILLS[33] = [10, 10, "공격스킬2", 4, 0] #자무주 4성
RANGE_SKILLS[37] = [10, 10, "공격스킬2", 4, 0] #뢰진주 5성
RANGE_SKILLS[38] = [10, 10, "공격스킬2", 4, 0] #백열주 5성
RANGE_SKILLS[39] = [10, 10, "공격스킬2", 4, 0] #화염주 5성
RANGE_SKILLS[40] = [10, 10, "공격스킬2", 4, 0] #자무주 5성
RANGE_SKILLS[44] = [10, 10, "공격스킬2", 4, 0] #헬파이어
RANGE_SKILLS[49] = [10, 10, "공격스킬2", 4, 0] #성려멸주
RANGE_SKILLS[52] = [10, 10, "공격스킬2", 4, 0] #성려멸주 1성
RANGE_SKILLS[56] = [10, 10, "공격스킬2", 4, 0] #성려멸주 2성
RANGE_SKILLS[58] = [12, 6, "공격스킬2", 4, 0, 3] #지폭지술
RANGE_SKILLS[68] = [12, 6, "공격스킬2", 4, 0, 3] #폭류유성

# 전사
# 범위, 이동속도, 캐릭터이름, 후 딜레이 시간, 넉백 범위, 히트수
RANGE_SKILLS[65] = [10, 10, "공격스킬2", 4, 0] #뢰마도
RANGE_SKILLS[67] = [0, 5, "", 4, 0] #건곤대나이
RANGE_SKILLS[73] = [0, 6, "공격스킬2", 4, 0] #광량돌격
RANGE_SKILLS[74] = [1, 5, "공격스킬2", 4, 0] #십리건곤
RANGE_SKILLS[75] = [10, 10, "공격스킬2", 4, 0] #뢰마도 1성
RANGE_SKILLS[77] = [1, 10, "공격스킬2", 4, 7] #유비후타
RANGE_SKILLS[78] = [1, 5, "공격스킬2", 4, 0] #십리건곤 1성
RANGE_SKILLS[79] = [0, 5, "", 4, 0, 10] #동귀어진
RANGE_SKILLS[80] = [1, 5, "공격스킬2", 4, 0] #십리건곤 2성
RANGE_SKILLS[101] = [0, 5, "공격스킬2", 4, 0, 2] #백호참
RANGE_SKILLS[102] = [2, 10, "공격스킬2", 4, 0] #백리건곤 1성
RANGE_SKILLS[104] = [12, 5, "공격스킬2", 4, 0, 3] #포효검황
RANGE_SKILLS[105] = [12, 5, "공격스킬2", 4, 0, 3] #혈겁만파
RANGE_SKILLS[106] = [4, 10, "공격스킬2", 4, -3, 4] #초혼비무

# 도사
RANGE_SKILLS[123] = [12, 5, "공격스킬2", 4, 0, 3] #귀염추혼소

# 도적
RANGE_SKILLS[133] = [0, 5, "", 4, 0] #필살검무
RANGE_SKILLS[138] = [15, 10, "공격스킬2", 4, 0, 7] #무형검
RANGE_SKILLS[139] = [12, 5, "", 4, 0, 3] #분혼경천

# 적 스킬
RANGE_SKILLS[45] = [10, 4.5, "공격스킬", 4, 0] #산적 건곤
RANGE_SKILLS[59] = [5, 3, "공격스킬", 4, 0] #주작의 노도성황
RANGE_SKILLS[61] = [5, 3, "공격스킬", 4, 0] #백호의 건곤대나이
RANGE_SKILLS[85] = [4, 3, "공격스킬2", 4, 0] # 필살검무
RANGE_SKILLS[151] = [10, 10, "청룡", 4, 7, 3] # 청룡의 포효
RANGE_SKILLS[152] = [10, 10, "현무", 4, 7, 3] # 현무의 포효
RANGE_SKILLS[153] = [4, 10, "공격스킬2", 4, 0, 2] # 백호검무
RANGE_SKILLS[154] = [10, 3, "용", 4, 6, 10] # 청룡마령참
RANGE_SKILLS[155] = [7, 2, "공격스킬", 4, 1, 2] # 암흑진파
RANGE_SKILLS[156] = [8, 2, "공격스킬", 4, 1, 3] # 흑룡광포
RANGE_SKILLS[158] = [10, 4, "공격스킬", 4, 1] # 지옥겁화
RANGE_SKILLS[159] = [10, 3, "공격스킬", 4, 3, 10] # 혈겁만파
RANGE_SKILLS[160] = [10, 3, "공격스킬", 4, 3, 10] # 분혼경천
RANGE_SKILLS[161] = [10, 3, "공격스킬", 4, 3, 10] # 폭류유성
# //////////////////////////end///////////////////////////////#

# ---------------------------폭발 스킬--------------------------#
# 범위, 이동속도, 이미지 이름, 폭발범위, 딜레이, 넉백, 히트수
# 주술사
RANGE_EXPLODE[53] = [10, 10, "공격스킬2", 3, 4, 0] #삼매진화
RANGE_EXPLODE[57] = [10, 10, "공격스킬2", 3, 4, 0] #삼매진화 1성
RANGE_EXPLODE[69] = [10, 10, "공격스킬2", 4, 4, 0, 2] # 삼매진화 2성

# 전사
RANGE_EXPLODE[103] = [1, 6, "공격스킬2", 4, 4, 0, 2] # 어검술

# 도사
RANGE_EXPLODE[96] = [7, 10, "공격스킬2", 2, 4, 0, 5] # 지진
RANGE_EXPLODE[124] = [7, 6, "공격스킬2", 2, 4, 0, 5] # 지진'첨

# 도적
RANGE_EXPLODE[135] = [0, 6, "공격스킬", 2, 4, 0] # 백호검무
RANGE_EXPLODE[137] = [0, 6, "공격스킬2", 3, 4, 0, 3] #이기어검

# 기타
RANGE_EXPLODE[6] = [10, 10, "도토리", 3, 4, 0] 	# 도토리 던지기
# //////////////////////////end///////////////////////////////#


# -------------------------스킬 공격력 설정----------------------------#
# 주술사
# [[타입(현재(0), 전체(1)), 체력, 마력, 기본값]]
SKILL_POWER_CUSTOM[44] = [[0, 0, 1.5, 10]] # 헬파이어
SKILL_POWER_CUSTOM[53] = [[0, 0, 2.0, 10]] # 삼매진화
SKILL_POWER_CUSTOM[57] = [[0, 0, 2.5, 10]] # 삼매진화 1성
SKILL_POWER_CUSTOM[69] = [[0, 0, 2.0, 10]] # 삼매진화 2성

SKILL_POWER_CUSTOM[49] = [[1, 0, 0.16, 200]] # 성려멸주
SKILL_POWER_CUSTOM[52] = [[1, 0, 0.22, 200]] # 성려멸주 1성
SKILL_POWER_CUSTOM[56] = [[1, 0, 0.3, 200]] # 성려멸주 2성

SKILL_POWER_CUSTOM[58] = [[0, 0, 0.5, 10]] # 지폭지술
SKILL_POWER_CUSTOM[68] = [[0, 0.7, 0.7, 10]] # 폭류유성

# 전사
# [[타입(현재(0), 전체(1)), 체력, 마력, 기본값]]
SKILL_POWER_CUSTOM[67] = [[0, 0.9, 0, 30]] # 건곤대나이
SKILL_POWER_CUSTOM[73] = [[0, 0.4, 0, 30]] # 광량돌격
SKILL_POWER_CUSTOM[79] = [[0, 1.3, 0.01, 100]] # 동귀어진
SKILL_POWER_CUSTOM[101] = [[0, 1.2, 0.1, 60]] # 백호참
SKILL_POWER_CUSTOM[103] = [[0, 1.0, 0.7, 60]] # 어검술
SKILL_POWER_CUSTOM[104] = [[0, 0.3, 0.3, 20]] # 포효검황
SKILL_POWER_CUSTOM[105] = [[0, 0.7, 0.7, 100]] # 혈겁만파
SKILL_POWER_CUSTOM[106] = [[0, 0.2, 1.0, 100]] # 초혼비무

SKILL_POWER_CUSTOM[74] = [[1, 0.1, 0, 20]] # 십리건곤
SKILL_POWER_CUSTOM[78] = [[1, 0.15, 0.01, 30]] # 십리건곤 2성
SKILL_POWER_CUSTOM[80] = [[1, 0.20, 0.01, 40]] # 십리건곤 3성
SKILL_POWER_CUSTOM[102] = [[1, 0.25, 0.07, 50]] # 백리건곤 1성

# 도사
SKILL_POWER_CUSTOM[96] = [[1, 0, 0.02, 100]] # 지진
SKILL_POWER_CUSTOM[123] = [[0, 0.6, 1.3, 100]] # 귀염추혼소
SKILL_POWER_CUSTOM[124] = [[1, 0.01, 0.1, 100]] # 지진'첨

# 도적
SKILL_POWER_CUSTOM[133] = [[0, 1.0, 0.5, 20]] # 필살검무
SKILL_POWER_CUSTOM[137] = [[0, 0.4, 0.4, 20]] # 이기어검
SKILL_POWER_CUSTOM[138] = [[0, 0.09, 0.18, 50]] # 무형검
SKILL_POWER_CUSTOM[139] = [[0, 0.7, 0.7, 100]] # 분혼경천

SKILL_POWER_CUSTOM[135] = [[1, 0.1, 0.15, 20]] # 백호검무
SKILL_POWER_CUSTOM[131] = [[1, 0.01, 0, 0]] # 투명1성
SKILL_POWER_CUSTOM[141] = [[1, 0.01, 0, 0]] # 투명2성
SKILL_POWER_CUSTOM[142] = [[1, 0.02, 0.02, 0]] # 투명3성

# 적 스킬
# [[타입(2 : 몬스터), 전체 체력 피해 비율, 전체 마력 피해 비율, 기본값]]
SKILL_POWER_CUSTOM[151] = [[2, 0.05, 0.05, 100]] # 청룡의포효
SKILL_POWER_CUSTOM[152] = [[2, 0.05, 0.05, 100]] # 현무의포효
SKILL_POWER_CUSTOM[154] = [[2, 3.00, 3.00, 100]] # 청룡마령참
SKILL_POWER_CUSTOM[155] = [[2, 0.02, 0.10, 100]] # 암흑진파
SKILL_POWER_CUSTOM[156] = [[2, 0.2, 0.2, 100]] # 흑룡광포
SKILL_POWER_CUSTOM[158] = [[2, 1.00, 0.3, 100]] # 지옥겁화
SKILL_POWER_CUSTOM[159] = [[2, 3.00, 3.00, 100]] # 혈겁만파
SKILL_POWER_CUSTOM[160] = [[2, 3.00, 3.00, 100]] # 분혼경천
SKILL_POWER_CUSTOM[161] = [[2, 3.00, 3.00, 100]] # 폭류유성
# //////////////////////////end///////////////////////////////#

# -------------------------스킬 소모 자원 설정----------------------------#
# 주술사
# [[타입(현재(0), 전체(1)), 체력, 마력]]
SKILL_COST_CUSTOM[44] = [[0, 0, 1.0]] # 헬파이어
SKILL_COST_CUSTOM[53] = [[0, 0, 1.0]] # 삼매진화
SKILL_COST_CUSTOM[57] = [[0, 0, 1.0]] # 삼매진화 1성
SKILL_COST_CUSTOM[69] = [[0, 0, 1.0]] # 삼매진화 2성

SKILL_COST_CUSTOM[49] = [[1, 0, 1.0 / 20.0]] # 성려멸주
SKILL_COST_CUSTOM[52] = [[1, 0, 1.0 / 20.0]] # 성려멸주 1성
SKILL_COST_CUSTOM[56] = [[1, 0, 1.0 / 20.0]] # 성려멸주 2성

SKILL_COST_CUSTOM[58] = [[0, 0, 1.0]] # 지폭지술
SKILL_COST_CUSTOM[68] = [[0, 0.5, 0.5]] # 폭류유성

# 전사
# [[타입(현재(0), 전체(1)), 체력, 마력]]
SKILL_COST_CUSTOM[67] = [[0, 2.0 / 3.0, 0]] # 건곤대나이
SKILL_COST_CUSTOM[73] = [[0, 0.4, 0.10]] # 광량돌격
SKILL_COST_CUSTOM[79] = [[0, 1.0, 1.0]] # 동귀어진
SKILL_COST_CUSTOM[101] = [[0, 0.5, 0.05]] # 백호참
SKILL_COST_CUSTOM[103] = [[0, 0.5, 0.35]] # 어검술
SKILL_COST_CUSTOM[104] = [[0, 0.4, 0.3]] # 포효검황
SKILL_COST_CUSTOM[105] = [[0, 0.5, 1.0]] # 혈겁만파
SKILL_COST_CUSTOM[106] = [[0, 0.3, 1.0]] # 초혼비무

SKILL_COST_CUSTOM[74] = [[1, 1.0 / 20.0, 0]] # 십리건곤
SKILL_COST_CUSTOM[78] = [[1, 1.0 / 20.0, 0]] # 십리건곤 1성
SKILL_COST_CUSTOM[80] = [[1, 1.0 / 20.0, 0]] # 십리건곤 2성
SKILL_COST_CUSTOM[102] = [[1, 1.0 / 20.0, 0.01]] # 백리건곤 1성

# 도사
# [[타입(현재(0), 전체(1)), 체력, 마력]]
SKILL_COST_CUSTOM[43] = [[0, 0, 1.0]] # 위태응기
SKILL_COST_CUSTOM[92] = [[0, 0, 1.0]] # 공력주입
SKILL_COST_CUSTOM[117] = [[0, 0, 1.0]] # 백호의희원
SKILL_COST_CUSTOM[123] = [[0, 0.3, 0.5]] # 귀염추혼소

SKILL_COST_CUSTOM[118] = [[1, 0, 0.02]] # 신령의희원
SKILL_COST_CUSTOM[119] = [[1, 0, 0.02]] # 봉황의희원
SKILL_COST_CUSTOM[96] = [[1, 0, 1.0 / 12.0]] # 지진
SKILL_COST_CUSTOM[124] = [[1, 0.01, 0.5]] # 지진'첨

# 도적
SKILL_COST_CUSTOM[131] = [[1, 0.01, 0]] # 투명1성
SKILL_COST_CUSTOM[141] = [[1, 0.01, 0]] # 투명2성
SKILL_COST_CUSTOM[142] = [[1, 0.01, 0]] # 투명3성
SKILL_COST_CUSTOM[135] = [[1, 0.1, 0.1]] # 백호검무

SKILL_COST_CUSTOM[133] = [[0, 0.3, 1.0]] # 필살검무
SKILL_COST_CUSTOM[137] = [[0, 0.4, 0.4]] # 이기어검
SKILL_COST_CUSTOM[138] = [[0, 0.1, 0.15]] # 무형검
SKILL_COST_CUSTOM[139] = [[0, 0.5, 1.0]] # 분혼경천
# //////////////////////////end///////////////////////////////#

# -------------------------스킬 딜레이----------------------------#
# 주술사
# 스킬 딜레이 [원래 딜레이, 현재 남은 딜레이]
SKILL_MASH_TIME[44] = [5 * sec, 0] # 헬파이어
SKILL_MASH_TIME[53] = [5 * sec, 0] # 삼매진화
SKILL_MASH_TIME[57] = [4 * sec, 0] # 삼매진화 2성
SKILL_MASH_TIME[58] = [150 * sec, 0] # 지폭지술
SKILL_MASH_TIME[68] = [150 * sec, 0] # 폭류유성
SKILL_MASH_TIME[69] = [3.5 * sec, 0] # 삼매진화 3성

# 전사
SKILL_MASH_TIME[65] = [3 * sec, 0] # 뢰마도
SKILL_MASH_TIME[66] = [180 * sec, 0] # 신수둔각도
SKILL_MASH_TIME[67] = [2 * sec, 0] # 건곤대나이
SKILL_MASH_TIME[71] = [90 * sec, 0] # 혼신의힘
SKILL_MASH_TIME[73] = [5 * sec, 0] # 광량돌격
SKILL_MASH_TIME[75] = [1 * sec, 0] # 뢰마도 2성
SKILL_MASH_TIME[77] = [1 * sec, 0] # 유비후타
SKILL_MASH_TIME[79] = [180 * sec, 0] # 동귀어진
SKILL_MASH_TIME[101] = [1 * sec, 0] # 백호참
SKILL_MASH_TIME[103] = [8 * sec, 0] # 어검술
SKILL_MASH_TIME[104] = [150 * sec, 0] # 포효검황
SKILL_MASH_TIME[105] = [150 * sec, 0] # 혈겁만파
SKILL_MASH_TIME[106] = [30 * sec, 0] # 초혼비무

# 도사
SKILL_MASH_TIME[94] = [10 * sec, 0] # 금강불체
SKILL_MASH_TIME[117] = [5 * sec, 0] # 백호의희원
SKILL_MASH_TIME[121] = [30 * sec, 0] # 신령지익진
SKILL_MASH_TIME[122] = [30 * sec, 0] # 파력무참진
SKILL_MASH_TIME[123] = [90 * sec, 0] # 귀염추혼소
SKILL_MASH_TIME[124] = [20 * sec, 0] # 지진'첨

# 도적
SKILL_MASH_TIME[133] = [1 * sec, 0] # 필살검무
SKILL_MASH_TIME[134] = [150 * sec, 0] # 분신
SKILL_MASH_TIME[135] = [3 * sec, 0] # 백호검무
SKILL_MASH_TIME[137] = [18 * sec, 0] # 이기어검
SKILL_MASH_TIME[138] = [1.5 * sec, 0] # 무형검
SKILL_MASH_TIME[139] = [150 * sec, 0] # 분혼경천

# 적 스킬
SKILL_MASH_TIME[85] = [2 * sec, 0] # 필살검무
SKILL_MASH_TIME[151] = [10 * sec, 0] # 청룡포효
SKILL_MASH_TIME[152] = [10 * sec, 0] # 현무포효
SKILL_MASH_TIME[153] = [3 * sec, 0] # 백호검무
SKILL_MASH_TIME[154] = [30 * sec, 0] # 청룡마령참
SKILL_MASH_TIME[155] = [10 * sec, 0] # 암흑진파
SKILL_MASH_TIME[156] = [10 * sec, 0] # 흑룡광포
SKILL_MASH_TIME[157] = [10 * sec, 0] # 회복스킬
SKILL_MASH_TIME[158] = [90 * sec, 0] # 지옥겁화
SKILL_MASH_TIME[159] = [90 * sec, 0] # 혈겁만파
SKILL_MASH_TIME[160] = [90 * sec, 0] # 분혼경천
SKILL_MASH_TIME[161] = [90 * sec, 0] # 폭류유성

# 기타
SKILL_MASH_TIME[6] = [1 * sec, 0] # 도토리 던지기
# //////////////////////////end///////////////////////////////#

# -----------------------방향 설정--------------------------------#
# 스킬의 이동 방향 배열, 배열 원소의 개수가 동시에 나가는 스킬의 개수
# 도사
SKILL_DIRECTION[124] = [1, 2, 3, 4, 6, 7, 8, 9] # 지진'첨

# 적 스킬
SKILL_DIRECTION[151] = [1, 2, 3, 4, 6, 7, 8, 9] # 청룡의 포효
SKILL_DIRECTION[152] = [1, 2, 3, 4, 6, 7, 8, 9] # 현무의 포효
SKILL_DIRECTION[153] = [2, 4, 6, 8] # 백호검무

# //////////////////////////end///////////////////////////////#

# ----------------------- 필요한 아이템 ----------------------------#
# [아이템 타입, 아이템 id, 개수], []....
NEED_SKILL_ACTIVE_ITEM[6] = [[0, 3, 10]] # 도토리 던지기, 도토리 1개
# //////////////////////////end///////////////////////////////#

# ----------------------- 스킬 사용시 메시지 ----------------------------#
# 											 [스킬 사용시 말할거, 말풍선 지속시간, 말풍선 타입]
SKILL_ACTIVE_MESSAGE[44] = ["DEFAULT!!", 4, 3] # 헬파이어
# //////////////////////////end///////////////////////////////#

# ----------------------- 평타, 스킬 비례 데미지 설정 ----------------------------#
DAMAGE_CAL_ATTACK = {}
DAMAGE_CAL_ATTACK[71] = [5] # 혼신의힘
DAMAGE_CAL_ATTACK[88] = [1.3] # 분량력법
DAMAGE_CAL_ATTACK[134] = [3] # 분신
DAMAGE_CAL_ATTACK[122] = [2.0] # 파력무참진

DAMAGE_CAL_DEFENSE = {}
DAMAGE_CAL_DEFENSE[47] = [0.25] # 보호
DAMAGE_CAL_DEFENSE[90] = [0.3] # 분량방법
DAMAGE_CAL_DEFENSE[94] = [0.99] # 금강불체
DAMAGE_CAL_DEFENSE[121] = [0.5] # 신령지익진

DAMAGE_CAL_SKILL = {}
DAMAGE_CAL_SKILL[42] = [1.2] # 주술마도
DAMAGE_CAL_SKILL[71] = [1.5] # 혼신의힘
DAMAGE_CAL_SKILL[88] = [1.3] # 분량력법
DAMAGE_CAL_SKILL[134] = [1.1] # 분신
DAMAGE_CAL_SKILL[122] = [2.0] # 파력무참진
# //////////////////////////end///////////////////////////////#

# ----------------------- 범위 마법 범위 보여주기 ----------------------------#
SHOW_SKILL_EFECT = {}
# 주술
SHOW_SKILL_EFECT[53] = 1 #삼매진화
SHOW_SKILL_EFECT[57] = 1 #삼매진화 1성
SHOW_SKILL_EFECT[69] = 1 # 삼매진화 2성

# 전사
SHOW_SKILL_EFECT[103] = 1 # 어검술

# 도사
SHOW_SKILL_EFECT[96] = 1 # 지진
SHOW_SKILL_EFECT[124] = 1 # 지진'첨

# 도적
SHOW_SKILL_EFECT[135] = 1 # 백호검무
SHOW_SKILL_EFECT[137] = 1 #이기어검

# 기타
SHOW_SKILL_EFECT[6] = 1 	# 도토리 던지기

# 적 스킬
SHOW_SKILL_EFECT[154] = 1
SHOW_SKILL_EFECT[155] = 1
SHOW_SKILL_EFECT[156] = 1
SHOW_SKILL_EFECT[158] = 1
SHOW_SKILL_EFECT[159] = 1
SHOW_SKILL_EFECT[160] = 1
SHOW_SKILL_EFECT[161] = 1
SHOW_SKILL_EFECT[200] = 1

# //////////////////////////end///////////////////////////////#
# -------------------------설정 데이터 끝-----------------------------#