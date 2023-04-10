$exp_limit = 20 # 한번에 최대 얻을 수 있는 경험치 퍼센트
$exp_event = 0 # 경험치 이벤트

SDK.log("Mr.Mo's ABS", "Mr.Mo", 4.5, "01/04/06")
#--------------------------------------------------------------------------
# * Begin SDK Enable Test
#--------------------------------------------------------------------------
if SDK.state("Mr.Mo's ABS") == true
	#--------------------------------------------------------------------------
	# * Constants - MAKE YOUR EDITS HERE
	#--------------------------------------------------------------------------
	CAN_DASH = false  #Can the player Dash?
	CAN_SNEAK = false #Can the player sneak?
	#--------------------------------------------------------------------------
	ATTACK_KEY = Input::Letters["S"]
	#~ ATTACK_KEY = 32
	#--------------------------------------------------------------------------
	# Do not change the '=> 0', part.
	# To Add more just make a new line; there are 10 examples :P
	# Besides Numberkeys, you can use;
	#  Input::Letters["LETTER"] Make sure the letter is in CAPS. 
	#  Input::Numberpad[number]
	#  Input::Fkeys[number]
	#  For more keys look in to the Input Script
	# 넘버 패드로 스킬 지정 
	SKILL_KEYS = {
		Input::Numberpad[0] => 0,
		Input::Numberpad[1] => 0,
		Input::Numberpad[2] => 0,
		Input::Numberpad[3] => 0,
		Input::Numberpad[4] => 0,
		Input::Numberpad[5] => 0,
		Input::Numberpad[6] => 0,
		Input::Numberpad[7] => 0,
		Input::Numberpad[8] => 0,
		Input::Numberpad[9] => 0,
		
		Input::Numberkeys[0] => 0,
		Input::Numberkeys[1] => 0,
		Input::Numberkeys[2] => 0,
		Input::Numberkeys[3] => 0,
		Input::Numberkeys[4] => 0,
		Input::Numberkeys[5] => 0,
		Input::Numberkeys[6] => 0,
		Input::Numberkeys[7] => 0,
		Input::Numberkeys[8] => 0,
		Input::Numberkeys[9] => 0,
	}
	# 위 숫자로 아이템 지정
	ITEM_KEYS =  {
		Input::Numberpad[0] => 0,
		Input::Numberpad[1] => 0,
		Input::Numberpad[2] => 0,
		Input::Numberpad[3] => 0,
		Input::Numberpad[4] => 0,
		Input::Numberpad[5] => 0,
		Input::Numberpad[6] => 0,
		Input::Numberpad[7] => 0,
		Input::Numberpad[8] => 0,
		Input::Numberpad[9] => 0,
		
		Input::Numberkeys[0] => 0,
		Input::Numberkeys[1] => 0,
		Input::Numberkeys[2] => 0,
		Input::Numberkeys[3] => 0,
		Input::Numberkeys[4] => 0,
		Input::Numberkeys[5] => 0,
		Input::Numberkeys[6] => 0,
		Input::Numberkeys[7] => 0,
		Input::Numberkeys[8] => 0,
		Input::Numberkeys[9] => 0,
	}
	#--------------------------------------------------------------------------
	SNEAK_KEY = Input::Letters["Z"]
	DASH_KEY = Input::Letters["X"]
	#--------------------------------------------------------------------------
	# Add Dash and Sneak animation_suffix here.
	DASH_ANIMATION = "_dash"
	SNEAK_ANIMATION = "_sneak"
	# Change characterset when dash or sneak?
	DASH_SHO_AN = false
	SNEAK_SHO_AN = false
	#--------------------------------------------------------------------------
	# You do not need to add the animation suffixes if you don't want the player
	# to animate when attacking.
	#--------------------------------------------------------------------------
	#Ranged Weapons 범위 무기
	RANGE_WEAPONS = {}
	# RANGE_WEAPONS[Weapon_ID] = 
	#[Character Set Name, Move Speed, Animation, Ammo, Range,  Mash Time(in seconds), Kick Back(in tiles),Animation Suffix]
	# Leave kickback 0 if you don't want kick back effect.
	#-------------------------------------------------------------------------
	#Ranged Skills
	RANGE_SKILLS = {}
	# RANGE_SKILLS[Skill_ID] = [Range, Move Speed, Character Set Name, Mash Time(in seconds), Kick Back(in tiles)]
	# 범위, 이동속도, 캐릭터이름, 후 딜레이 시간, 넉백 범위, 히트수
	# 주술사 스킬
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
	RANGE_SKILLS[58] = [10, 6, "공격스킬2", 4, 0, 3] #지폭지술
	RANGE_SKILLS[68] = [10, 6, "공격스킬2", 4, 0, 3] #폭류유성
	
	#전사 스킬
	RANGE_SKILLS[65] = [10, 10, "공격스킬2", 4, 0] #뢰마도
	RANGE_SKILLS[67] = [0, 5, "", 4, 0] #건곤대나이
	RANGE_SKILLS[69] = [0, 5, "", 4, 0] #???
	RANGE_SKILLS[70] = [0, 5, "", 4, 0] #???
	RANGE_SKILLS[73] = [0, 6, "공격스킬2", 4, 0] #광량돌격
	RANGE_SKILLS[74] = [1, 5, "공격스킬2", 4, 0] #십리건곤
	RANGE_SKILLS[75] = [10, 10, "공격스킬2", 4, 0] #뢰마도 1성
	RANGE_SKILLS[77] = [1, 10, "공격스킬2", 4, 7] #유비후타
	RANGE_SKILLS[78] = [1, 5, "공격스킬2", 4, 0] #십리건곤 1성
	RANGE_SKILLS[79] = [0, 5, "", 4, 0, 10] #동귀어진
	RANGE_SKILLS[80] = [1, 5, "공격스킬2", 4, 0] #십리건곤 2성
	RANGE_SKILLS[82] = [0, 5, "", 4, 0] #적반의기원
	RANGE_SKILLS[101] = [0, 5, "공격스킬2", 4, 0, 3] #백호참
	RANGE_SKILLS[102] = [2, 6, "공격스킬2", 4, 0] #백리건곤 1성
	RANGE_SKILLS[104] = [10, 5, "공격스킬2", 4, 0, 3] #포효검황
	RANGE_SKILLS[105] = [10, 5, "공격스킬2", 4, 0, 3] #혈겁만파
	RANGE_SKILLS[106] = [4, 10, "공격스킬2", 4, -3, 5] #초혼비무
	#도사 스킬
	# 부활 스킬을 넣어볼까 생각
	
	#도적 스킬
	RANGE_SKILLS[133] = [0, 5, "", 4, 0] #필살검무
	RANGE_SKILLS[138] = [10, 10, "공격스킬2", 4, 0, 5] #무형검
	RANGE_SKILLS[139] = [10, 5, "", 4, 0, 3] #분혼경천
	
	# 									범위, 이동속도, 캐릭터이름, 후 딜레이 시간, 넉백 범위, (타격수)
	# 적 캐릭터 스킬
	RANGE_SKILLS[45] = [8, 4, "공격스킬", 4, 1] #산적 건곤
	RANGE_SKILLS[59] = [5, 3, "공격스킬", 4, 0] #주작의 노도성황
	RANGE_SKILLS[61] = [5, 3, "공격스킬", 4, 0] #백호의 건곤대나이
	RANGE_SKILLS[85] = [5, 4, "공격스킬2", 4, 4] # 필살검무
	RANGE_SKILLS[151] = [7, 4, "청룡", 4, 4, 4, 3] # 청룡의 포효
	RANGE_SKILLS[152] = [7, 4, "현무", 4, 4, 4, 3] # 현무의 포효
	RANGE_SKILLS[153] = [3, 5, "공격스킬2", 4, 0] # 백호검무
	RANGE_SKILLS[154] = [6, 3, "용", 4, 6] # 청룡마령참
	RANGE_SKILLS[155] = [5, 2, "공격스킬", 4, 1] # 암흑진파
	RANGE_SKILLS[156] = [7, 2, "공격스킬", 4, 1] # 흑룡광포
	RANGE_SKILLS[158] = [10, 4, "공격스킬", 4, 1] # 지옥겁화
	RANGE_SKILLS[159] = [10, 3, "공격스킬", 4, 3] # 혈겁만파
	RANGE_SKILLS[160] = [10, 3, "공격스킬", 4, 3] # 분혼경천
	
	#--------------------------------------------------------------------------
	#Ranged Explosives
	# 폭발 범위
	RANGE_EXPLODE = {}
	# RANGE_EXPLODE[Skill_ID] = [Range, Move Speed, Character Set Name, Explosive Range, Mash Time(in seconds), Kick Back(in tiles)]
	# 폭발 스킬 = 					범위, 이동속도, 이미지 이름, 폭발범위, 딜레이, 넉백, 히트수
	RANGE_EXPLODE[6] = [10, 10, "도토리", 3, 4, 0] 	# 도토리 던지기
	
	# 주술사 스킬
	RANGE_EXPLODE[53] = [10, 10, "공격스킬2", 2, 4, 0] #삼매진화
	RANGE_EXPLODE[57] = [10, 10, "공격스킬2", 2, 4, 0] #삼매진화 1성
	RANGE_EXPLODE[69] = [10, 10, "공격스킬2", 3, 4, 0, 2] # 삼매진화 2성
	
	# 전사스킬
	RANGE_EXPLODE[103] = [1, 6, "공격스킬2", 3, 4, 0, 3] # 어검술
	
	# 도적 스킬
	RANGE_EXPLODE[135] = [0, 6, "공격스킬", 2, 4, 0] # 백호검무
	RANGE_EXPLODE[137] = [0, 6, "공격스킬2", 3, 4, 0, 2] #이기어검
	
	# 도사 스킬
	RANGE_EXPLODE[96] = [10, 6, "공격스킬2", 2, 4, 0, 3] # 지진
	
	# 적 스킬
	
	
	#--------------------------------------------------------------------------
	# 범위 스킬 방향 및 개수
	# 스킬의 이동 방향 배열, 배열 원소의 개수가 동시에 나가는 스킬의 개수
	SKILL_DIRECTION = {}
	
	SKILL_DIRECTION[151] = [1, 2, 3, 4, 6, 7, 8, 9] # 청룡의 포효
	SKILL_DIRECTION[152] = [1, 2, 3, 4, 6, 7, 8, 9] # 현무의 포효
	SKILL_DIRECTION[153] = [2, 4, 6, 8] # 백호검무
	
	
	#--------------------------------------------------------------------------
	# Since Melee weapons aren't listed I made this for customazation of melee weapons.
	MELEE_CUSTOM = {}
	# if left blank the default mash time will be MASH_TIME(below)
	# No need to use the animation suffix if you don't plan to animate the player's character set.
	# MELEE_CUSTOM[Weapon_ID] = [Mash Time(in seconds), Kick Back(in tiles), animation suffix]
	#무기 딜레이
	#~ MELEE_CUSTOM[101] = [5, 0]
	
	#--------------------------------------------------------------------------
	# Since some skills won't be listed(i.e non-ranged) I made this for customazation of melee weapons.
	SKILL_CUSTOM = {}
	# if left blank the default mash time will be MASH_TIME(below)
	# No need to use the animation suffix if you don't plan to animate the player's character set.
	# SKILL_CUSTOM[Skill_ID] = [Mash Time(in seconds), Kick Back(in tiles), animation suffix]
	SKILL_CUSTOM[1] = [3, 0]
	SKILL_CUSTOM[7] = [3, 0]
	SKILL_CUSTOM[8] = [3, 0, "_cast"]
	#--------------------------------------------------------------------------
	# 플레이어가 죽을때 게임오버 할거냐
	GAME_OVER_DEAD = false # 아니
	# 리더가 죽으면 다음 멤버가 리더가 될거?
	NEXT_LEADER = false #아니
	#--------------------------------------------------------------------------
	#Mash Time
	# 공격 딜레이 초단위
	MASH_TIME = 4
	
	sec = 60 # 1초
	# 스킬 딜레이 [원래 딜레이, 현재 남은 딜레이]
	SKILL_MASH_TIME = {}
	SKILL_MASH_TIME[6] = [1 * sec, 0] # 도토리 던지기
	
	# 주술사
	SKILL_MASH_TIME[44] = [7 * sec, 0] # 헬파이어
	SKILL_MASH_TIME[53] = [7 * sec, 0] # 삼매진화
	SKILL_MASH_TIME[57] = [6.5 * sec, 0] # 삼매진화 1성
	SKILL_MASH_TIME[58] = [90 * sec, 0] # 지폭지술
	SKILL_MASH_TIME[68] = [150 * sec, 0] # 폭류유성
	SKILL_MASH_TIME[69] = [5 * sec, 0] # 삼매진화 2성
	
	# 전사
	SKILL_MASH_TIME[65] = [5 * sec, 0] # 뢰마도
	SKILL_MASH_TIME[67] = [2 * sec, 0] # 건곤대나이
	SKILL_MASH_TIME[73] = [10 * sec, 0] # 광량돌격
	SKILL_MASH_TIME[75] = [3 * sec, 0] # 뢰마도 1성
	SKILL_MASH_TIME[77] = [1 * sec, 0] # 유비후타
	SKILL_MASH_TIME[79] = [30 * sec, 0] # 동귀어진
	SKILL_MASH_TIME[101] = [1 * sec, 0] # 백호참
	SKILL_MASH_TIME[103] = [8 * sec, 0] # 어검술
	SKILL_MASH_TIME[104] = [90 * sec, 0] # 포효검황
	SKILL_MASH_TIME[105] = [150 * sec, 0] # 혈겁만파
	SKILL_MASH_TIME[106] = [15 * sec, 0] # 초혼비무
	
	# 도적
	SKILL_MASH_TIME[133] = [1 * sec, 0] # 필살검무
	SKILL_MASH_TIME[135] = [2 * sec, 0] # 백호검무
	SKILL_MASH_TIME[137] = [20 * sec, 0] # 이기어검
	SKILL_MASH_TIME[138] = [3 * sec, 0] # 무형검
	SKILL_MASH_TIME[139] = [150 * sec, 0] # 분혼경천
	
	# 도사
	SKILL_MASH_TIME[117] = [5 * sec, 0] # 백호의희원
	SKILL_MASH_TIME[121] = [5 * sec, 0] # 신령지익진
	SKILL_MASH_TIME[122] = [5 * sec, 0] # 파력무참진
	
	# 적 스킬
	SKILL_MASH_TIME[151] = [5 * sec, 0] # 청룡포효
	SKILL_MASH_TIME[152] = [5 * sec, 0] # 현무포효
	SKILL_MASH_TIME[154] = [30 * sec, 0] # 청룡마령참
	SKILL_MASH_TIME[155] = [5 * sec, 0] # 암흑진파
	SKILL_MASH_TIME[156] = [5 * sec, 0] # 흑룡광포
	SKILL_MASH_TIME[157] = [10 * sec, 0] # 회복스킬
	SKILL_MASH_TIME[158] = [20 * sec, 0] # 지옥겁화
	SKILL_MASH_TIME[159] = [30 * sec, 0] # 혈겁만파
	SKILL_MASH_TIME[160] = [30 * sec, 0] # 분혼경천
	
	
	# 스킬 지속 시간 [원래 지속 시간, 현재 남은 시간]
	SKILL_BUFF_TIME = {}
	# 주술사
	SKILL_BUFF_TIME[9] = [180 * sec, 0] # 무장
	SKILL_BUFF_TIME[46] = [180 * sec, 0] # 무장
	SKILL_BUFF_TIME[20] = [180 * sec, 0] # 보호
	SKILL_BUFF_TIME[47] = [180 * sec, 0] # 보호
	SKILL_BUFF_TIME[26] = [180 * sec, 0] # 누리의힘
	SKILL_BUFF_TIME[28] = [120 * sec, 0] # 야수
	SKILL_BUFF_TIME[35] = [120 * sec, 0] # 비호
	SKILL_BUFF_TIME[42] = [180 * sec, 0] # 주술마도
	SKILL_BUFF_TIME[51] = [180 * sec, 0] # 대지의힘
	
	
	# 전사
	SKILL_BUFF_TIME[62] = [180 * sec, 0] # 수심각도
	SKILL_BUFF_TIME[63] = [180 * sec, 0] # 반영대도
	SKILL_BUFF_TIME[64] = [180 * sec, 0] # 십량분법
	SKILL_BUFF_TIME[66] = [60 * sec, 0] # 신수둔각도
	SKILL_BUFF_TIME[72] = [180 * sec, 0] # 구량분법
	SKILL_BUFF_TIME[76] = [180 * sec, 0] # 팔량분법
	SKILL_BUFF_TIME[71] = [60 * sec, 0] # 혼신의힘
	
	
	# 도사
	SKILL_BUFF_TIME[50] = [60 * sec, 0] # 야수금술술
	SKILL_BUFF_TIME[88] = [60 * sec, 0] # 분량력법
	SKILL_BUFF_TIME[90] = [60 * sec, 0] # 분량방법
	SKILL_BUFF_TIME[91] = [60 * sec, 0] # 석화기탄
	SKILL_BUFF_TIME[94] = [6 * sec, 0] # 금강불체
	SKILL_BUFF_TIME[121] = [10 * sec, 0] # 신령지익진
	SKILL_BUFF_TIME[122] = [10 * sec, 0] # 파력무참진
	
	# 도적
	SKILL_BUFF_TIME[130] = [180 * sec, 0] # 무영보법
	SKILL_BUFF_TIME[131] = [60 * sec, 0] # 투명
	SKILL_BUFF_TIME[134] = [60 * sec, 0] # 분신
	SKILL_BUFF_TIME[136] = [180 * sec, 0] # 운상미보
	SKILL_BUFF_TIME[140] = [10 * sec, 0] # 운기
	SKILL_BUFF_TIME[141] = [60 * sec, 0] # 투명 1성
	SKILL_BUFF_TIME[142] = [60 * sec, 0] # 투명 2성
	
	# 기타
	SKILL_BUFF_TIME[99] = [180 * sec, 0] # 속도시약
	
	# 무기 격 스킬 : 데미지, 애니메이션 id, 확률
	WEAPON_SKILL = {}
	# 신수둔각도
	WEAPON_SKILL[1] = [1000, 154, 3]   		# 주작의검
	WEAPON_SKILL[2] = [1000, 154, 3]   		# 백호의검
	WEAPON_SKILL[3] = [1000, 154, 3]   		# 현무의검
	WEAPON_SKILL[4] = [1000, 154, 3]   		# 청룡의검
	
	# 4차 무기
	WEAPON_SKILL[6] = [50000, 165, 20]   		# 현자금봉
	WEAPON_SKILL[7] = [50000, 165, 20]   		# 검성기검
	WEAPON_SKILL[8] = [50000, 165, 20]   		# 진선역봉
	WEAPON_SKILL[9] = [50000, 165, 20]   		# 태성태도
	
	# 중국무기
	WEAPON_SKILL[11] = [700000, 115, 15]   		# 대모홍접선
	WEAPON_SKILL[12] = [700000, 117, 15]   		# 구곡검
	WEAPON_SKILL[13] = [700000, 166, 15]   		# 영후단봉
	WEAPON_SKILL[14] = [700000, 125, 15]   		# 협가검
	WEAPON_SKILL[17] = [100000, 196, 90]   		# 음양도
	
	# 기타 검
	WEAPON_SKILL[114] = [3000, 153, 40]   		# 주작의검
	WEAPON_SKILL[115] = [1000000, 194, 5] 		# 심판의 낫
	WEAPON_SKILL[117] = [100000, 120, 5] 		# 괴력선창
	WEAPON_SKILL[126] = [5000, 154, 40]   		# 참마도
	WEAPON_SKILL[127] = [60000, 184, 40]   		# 청룡신검
	WEAPON_SKILL[123] = [100000, 192, 40]   		# 현무염도
	
	# 일본
	WEAPON_SKILL[136] = [15000, 1, 40]   		# 이가닌자의검
	WEAPON_SKILL[134] = [400000, 170, 30]   		# 일화접선
	WEAPON_SKILL[135] = [400000, 171, 30]   		# 진일신검
	WEAPON_SKILL[138] = [400000, 164, 30]   		# 청일기창
	
	# 용무기
	WEAPON_SKILL[142] = [1000, 123, 10]   		# 용마제사검
	WEAPON_SKILL[143] = [50000, 123, 10]   		# 용마제칠검
	WEAPON_SKILL[144] = [400000, 123, 5]   		# 용마제팔검
	WEAPON_SKILL[145] = [3200000, 174, 5]   		# 용마제구검
	
	WEAPON_SKILL[147] = [1000, 141, 10]   		# 용랑제사봉
	WEAPON_SKILL[148] = [50000, 141, 10]   		# 용랑제칠봉
	WEAPON_SKILL[149] = [400000, 141, 5]   		# 용랑제팔봉
	WEAPON_SKILL[150] = [3200000, 176, 5]   		# 용랑제구봉
	
	# 특정 장비 착용시 효과 : [[효과 주기, 효과, 값(%)], [...], ..]
	EQUIP_EFFECTS = {} 
	# 장신구
	EQUIP_EFFECTS[28] = [[1 * sec, "buff", 46], [1 * sec, "buff", 47]] # 보무의목걸이
	EQUIP_EFFECTS[29] = [[0.5 * sec, "buff", 131]] # 투명구두
	EQUIP_EFFECTS[72] = [[10 * sec, "hp", 2], [10 * sec, "sp", 2]] # 해골목걸이
	EQUIP_EFFECTS[75] = [[10 * sec, "hp", 4], [10 * sec, "sp", 4]] # 황금팔찌
	
	# 방패 
	EQUIP_EFFECTS[36] = [[10 * sec, "sp", 3]] # 기원부
	EQUIP_EFFECTS[25] = [[10 * sec, "hp", 3]] # 강건부
	EQUIP_EFFECTS[33] = [[10 * sec, "hp", 1.5], [10 * sec, "sp", 1.5]] # 도깨비부적
	EQUIP_EFFECTS[39] = [[10 * sec, "hp", 1], [10 * sec, "sp", 1]] # 정화의방패
	EQUIP_EFFECTS[40] = [[10 * sec, "hp", 1], [10 * sec, "sp", 1]] # 여신의방패
	EQUIP_EFFECTS[98] = [[3 * sec, "hp", 1], [3 * sec, "sp", 1]] # 재생의부적
	
	# 갑옷
	EQUIP_EFFECTS[30] = [[1 * sec, "buff", 136]] # 가릉빈가의날개옷
	EQUIP_EFFECTS[73] = [[1 * sec, "buff", 136]] # 가릉빈가의날개옷'진
	
	# 투구
	EQUIP_EFFECTS[61] = [[10 * sec, "sp", 2]] # 연청투구
	EQUIP_EFFECTS[62] = [[10 * sec, "hp", 2]] # 연홍투구
	EQUIP_EFFECTS[74] = [[10 * sec, "hp", 4], [10 * sec, "sp", 4]] # 황금투구
	
	# 백만 넘어가는 체력 설정
	ABS_ENEMY_HP = {}
	ABS_ENEMY_HP[37]  = [2000000000, 0] # 무적토끼
	ABS_ENEMY_HP[269] = [2000000, 0] # 무적다람쥐
	
	# 기타
	ABS_ENEMY_HP[61] = [3000000, 1] # 주작
	ABS_ENEMY_HP[62] = [3000000, 1] # 백호
	
	ABS_ENEMY_HP[98] = [1200000, 1] # 비류장군
	
	ABS_ENEMY_HP[102] = [30000000, 1] # 반고
	ABS_ENEMY_HP[112] = [8000000, 1] # 청룡
	ABS_ENEMY_HP[113] = [8000000, 1] # 현무
	
	# 12 지신
	ABS_ENEMY_HP[119] = [1200000, 1] # 백호왕
	ABS_ENEMY_HP[123] = [500000, 1] # 뱀왕
	ABS_ENEMY_HP[128] = [700000, 1] # 원숭이왕
	ABS_ENEMY_HP[132] = [1200000, 1] # 건룡
	ABS_ENEMY_HP[133] = [1200000, 1] # 감룡
	ABS_ENEMY_HP[134] = [1200000, 1] # 진룡
	
	# 용궁
	ABS_ENEMY_HP[156] = [1500000, 1] # 상어장군
	ABS_ENEMY_HP[158] = [3000000, 1] # 해파리장군
	ABS_ENEMY_HP[159] = [10000000, 1] # 거북장군
	
	# 일본
	ABS_ENEMY_HP[186] = [800000, 1] # 무사
	ABS_ENEMY_HP[189] = [1500000, 1] # 주마관
	ABS_ENEMY_HP[191] = [2000000, 1] # 유성지
	ABS_ENEMY_HP[192] = [3000000, 1] # 해골왕
	ABS_ENEMY_HP[193] = [5000000, 1] # 파괴왕
	
	# 중국
	ABS_ENEMY_HP[220] = [1200000, 1]# 산소괴왕
	ABS_ENEMY_HP[224] = [3200000, 1]# 괴성왕
	ABS_ENEMY_HP[228] = [5200000, 1]# 뇌신왕
	
	ABS_ENEMY_HP[229] = [1200000, 0]# 연청천구
	ABS_ENEMY_HP[230] = [1200000, 0]# 연자천구
	ABS_ENEMY_HP[231] = [12000000, 1] # 천구왕
	
	ABS_ENEMY_HP[232] = [40000000, 1] # 산신대왕
	ABS_ENEMY_HP[233] = [2000000, 0]# 산신전사
	ABS_ENEMY_HP[234] = [1200000, 0]# 산신도사
	ABS_ENEMY_HP[235] = [2000000, 0]# 산신도적
	ABS_ENEMY_HP[236] = [1700000, 0]# 산신주술사
	
	# 환상의섬
	ABS_ENEMY_HP[246] = [3000000, 1]	# 선장망령
	
	ABS_ENEMY_HP[250] = [1300000, 0]	# 철보장
	ABS_ENEMY_HP[251] = [1500000, 0]	#	철거인
	ABS_ENEMY_HP[252] = [20000000, 1]	# 마려
	
	ABS_ENEMY_HP[253] = [5000000, 1]	# 현무
	ABS_ENEMY_HP[257] = [2000000, 1]	# 태산
	ABS_ENEMY_HP[258] = [30000000, 1]	# 길림장군
	ABS_ENEMY_HP[259] = [400000000, 1]# 가릉빈가
	
	# 몬스터 경험치 설정
	ENEMY_EXP = {} # [var, (hp_per, sp_per)(배율)]
	# 파티 퀘스트
	ENEMY_EXP[45] = [30000, 0.6, 0.6] # 산속군사
	ENEMY_EXP[91] = [200000, 3.0, 3.0] # 비류성창병
	ENEMY_EXP[96] = [400000, 3.0, 3.0] # 비류성자객
	ENEMY_EXP[97] = [500000, 3.0, 3.0] # 입구지키미
	ENEMY_EXP[98] = [3000000, 100.0, 100.0] # 비류장군
	
	ENEMY_EXP[254] = [750000, 5.0, 5.5] # 뇌랑
	ENEMY_EXP[255] = [750000, 5.0, 5.5] # 왕가
	ENEMY_EXP[256] = [1000000, 8.2, 8.8] # 조왕
	ENEMY_EXP[257] = [5000000, 20.0, 25.0] # 태산
	ENEMY_EXP[258] = [30000000, 500.0, 500.0] # 길림장군
	
	# 중국
	ENEMY_EXP[231] = [150000000] # 천구왕
	ENEMY_EXP[232] = [300000000] # 산신대왕
	
	# 환상의섬
	ENEMY_EXP[252] = [200000000] # 마려
	ENEMY_EXP[259] = [4000000000] # 가릉빈가
	#--------------------------------------------------------------------------
	#데미지 뜨게 할거임?
	DISPLAY_DAMAGE = true
	#--------------------------------------------------------------------------
	#단축키 등록 메시지
	HOTKEY_SAY = "단축키등록"
	#--------------------------------------------------------------------------
	#Terrain Tag
	PASS_TAG = 1
	#--------------------------------------------------------------------------
	ANIMATE_PLAYER = false
	ANIMATE_ENEMY = false
	
	# 레벨업 표시
	DISPLAY_LEVELUP = true
	# 레벨업시 음악
	LEVELUP_MUSIC = "Level UP"
	#--------------------------------------------------------------------------
	#Fade dead?
	FADE_DEAD = true
	#--------------------------------------------------------------------------
	#Can Hurt Allies
	CAN_HURT_ALLY = true
	#--------------------------------------------------------------------------
	ANIMATION_DIVIDE = 2
	#--------------------------------------------------------------------------
	DAMAGE_FONT_NAME = "맑은 고딕"
	#--------------------------------------------------------------------------
	DAMAGE_FONT_SIZE = 20
	#--------------------------------------------------------------------------
	# To change the color you need to adjust the numbers below.
	# The numbers reperesnt 3 colors, red, greend and blue. All you have to do is
	# just change the numbers.
	# Color.new(RED,GREEN,BLUE)
	DAMAGE_FONT_COLOR = Color.new(0,0,0)
	#--------------------------------------------------------------------------
	# 부활 아이템 있으면 부활 가능~
	REVIVE = true
	# Death(Knockout) state Id
	DEATH_STATE_ID = 1
	#--------------------------------------------------------------------------
	# * Class Mo ABS - DO NOT EDIT BELOW, if you don't know what you are doing :)
	#--------------------------------------------------------------------------
	
	
	class MrMo_ABS
		#--------------------------------------------------------------------------
		# * Public Instance Variables
		#--------------------------------------------------------------------------
		attr_accessor :enemies     #Enemy List
		attr_accessor :can_dash    #Player Dash Boolean
		attr_accessor :can_sneak   #Player Sneak Boolean
		attr_accessor :can_update_states # Update States
		attr_accessor :attack_key  #Attack Key
		attr_accessor :skill_keys  #Skill Keys
		attr_accessor :item_keys   #Item Keys
		attr_accessor :range
		attr_accessor :damage_display
		attr_accessor :dash_max
		attr_accessor :dash_min
		attr_accessor :sneak_max
		attr_accessor :sneak_min
		attr_accessor :active
		attr_accessor :button_mash
		#--------------------------------------------------------------------------
		# * Object Initialization
		# 생성자, 변수 초기화
		#--------------------------------------------------------------------------
		def initialize
			#ABS Enemy Variables
			@enemies = {}
			#Attack Key
			@attack_key = ATTACK_KEY
			#Skill Keys
			@skill_keys = SKILL_KEYS
			#Item Keys
			@item_keys = ITEM_KEYS
			
			#Button Mash (스킬 후딜레이)
			@skill_mash = {}
			# 아이템 후딜레이
			@item_mash = 0
			# 공격키 후 딜레이
			@attack_mash = 0
			
			#Ranged Skills and Weapons
			@range = []
			#Display Demage true:false
			@damage_display = DISPLAY_DAMAGE
			#Player Animated?
			@player_ani = ANIMATE_PLAYER
			#Enemy Animated?
			@enemy_ani = ANIMATE_ENEMY
			#Get Hate
			@get_hate = true
			
			# ABS Active
			@active = true
			
			
		end
		# 반환 함수들
		#--------------------------------------------------------------------------
		# * Range Weapons
		#--------------------------------------------------------------------------
		def RANGE_WEAPONS
			return RANGE_WEAPONS
		end
		#--------------------------------------------------------------------------
		# * Damage Font Size
		#--------------------------------------------------------------------------
		def DAMAGE_FONT_SIZE
			return DAMAGE_FONT_SIZE
		end
		#--------------------------------------------------------------------------
		# * Damage Font Name
		#--------------------------------------------------------------------------
		def DAMAGE_FONT_NAME
			return DAMAGE_FONT_NAME
		end
		#--------------------------------------------------------------------------
		# * Damage Font Color
		#--------------------------------------------------------------------------
		def DAMAGE_FONT_COLOR
			return DAMAGE_FONT_COLOR
		end
		#--------------------------------------------------------------------------
		# * Range Skills
		#--------------------------------------------------------------------------
		def RANGE_SKILLS
			return RANGE_SKILLS
		end
		#--------------------------------------------------------------------------
		# * Range Explode
		#--------------------------------------------------------------------------
		def RANGE_EXPLODE
			return RANGE_EXPLODE
		end
		#--------------------------------------------------------------------------
		# * Hotkey
		#--------------------------------------------------------------------------
		def HOTKEY_SAY
			return HOTKEY_SAY
		end
		#--------------------------------------------------------------------------
		# * Pass Tag
		#--------------------------------------------------------------------------
		def PASS_TAG
			return PASS_TAG
		end
		#--------------------------------------------------------------------------
		# * Animation Divide
		#--------------------------------------------------------------------------
		def ANIMATION_DIVIDE
			return ANIMATION_DIVIDE
		end
		#--------------------------------------------------------------------------
		# * ABS Refresh(Event, List, Characterset Name) 새로고침
		#--------------------------------------------------------------------------
		def refresh(event, list, character_name)
			@get_hate = true
			#Delete the event from the list
			@enemies.delete(event.id)
			#Skip the event if its invisible or doesn't contain a list
			# 캐릭터 파일 이름이 없거나, 이벤트가 없다면 무시
			return if event.character_name == "" or list == nil
			#Get the parameters 속성 받아오기, 주석처리한걸
			parameters = SDK.event_comment_input(event, 11, "ABS")
			#Skip if the paramete is NIL 속성이 없다면 무시
			return if parameters.nil?
			#Get Enemy ID
			id = parameters[0].split
			#Get Enemy
			enemy = $data_enemies[id[1].to_i]
			#Skip If Enemy is NIL 적이 없다면 무시
			return if enemy == nil
			@enemies[event.id] = ABS_Enemy.new(enemy.id)
			#Set Event ID
			@enemies[event.id].event_id = event.id
			#Get Event 
			event.name = "[id#{@enemies[event.id].name}]" if @enemies[event.id].name != ""
			@enemies[event.id].event = event
			
			n = id[1].to_i
			if $enemy_spec.spec(n) != nil #
				spec = $enemy_spec.spec(n)
				
				#Set Behavior
				@enemies[event.id].behavior = spec[0].to_i
				#Set See Range
				@enemies[event.id].see_range = spec[1].to_i
				#Set Hear Range
				@enemies[event.id].hear_range = spec[2].to_i
				#Set Closest Enemy Boolean
				@enemies[event.id].closest_enemy = spec[3]
				#Set Hate Group
				@enemies[event.id].hate_group = spec[4]   
				#Set Aggresiveness
				@enemies[event.id].aggressiveness = spec[5]
				#Set Speed
				@enemies[event.id].temp_speed = spec[6].to_i
				#Set Frequency
				@enemies[event.id].temp_frequency = spec[7].to_i
				#Set Trigger
				@enemies[event.id].trigger = spec[8]
				#Respawn
				if spec[9] != nil
					@enemies[event.id].respawn = spec[9].to_i * 6
				end
				
			else
				#Set Behavior
				behavior = parameters[1].split
				@enemies[event.id].behavior = behavior[1].to_i
				#Set See Range
				see_range = parameters[2].split
				@enemies[event.id].see_range = see_range[1].to_i
				#Set Hear Range
				hear_range = parameters[3].split
				@enemies[event.id].hear_range = hear_range[1].to_i
				#Set Closest Enemy Boolean
				closest_enemy = parameters[4].split
				@enemies[event.id].closest_enemy = eval(closest_enemy[1])
				#Set Hate Group
				hate_group = parameters[5].split
				@enemies[event.id].hate_group = eval(hate_group[1])    
				#Set Aggresiveness
				aggressiveness = parameters[6].split
				@enemies[event.id].aggressiveness = aggressiveness[1].to_i
				#Set Speed
				speed = parameters[7].split
				@enemies[event.id].temp_speed = speed[1].to_i
				#Set Frequency
				freq = parameters[8].split
				@enemies[event.id].temp_frequency = freq[1].to_i
				#Set Trigger
				trigger = parameters[9].split
				@enemies[event.id].trigger= [trigger[1].to_i, trigger[2].to_i, trigger[3].to_i]
				#Respawn
				if parameters[10] != nil
					respawn = parameters[10].split 
					@enemies[event.id].respawn = respawn[1].to_i * 6
				end
			end
			@enemies[event.id].aggro = $is_map_first
			@enemies[event.id].aggressiveness = (@enemies[event.id].aggressiveness * 45.0 + rand(3) - 2) / 45.0 
			
			
		end
		#--------------------------------------------------------------------------
		# * Make Hate Points(Enemy)
		#--------------------------------------------------------------------------
		def make_hate_points(e)
			#Get all the enemies of the enemy
			e.hate_points[$game_player.event_id] = rand(999)
			for id in e.hate_group
				#See if the ID in the Hate group is in the enemy ID 
				for enemy in @enemies.values
					#Skip NIL values
					next if enemy == nil
					if enemy.enemy_id == id
						#Insert in to the list if the enemy is in hate group
						e.hate_points[enemy.event_id] = rand(999)
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Update(Frame) 1프레임마다 실행되는 함수
		#--------------------------------------------------------------------------
		def update
			#Update Player
			if (Graphics.frame_count % (Graphics.frame_rate / 3) == 0)
				$skill_Delay_Console.refresh if $skill_Delay_Console != nil and $skill_Delay_Console.tog
			end
			update_player if @active
			#Update Enemy AI
			update_enemy if @enemies != {} and @active
			for range in @range
				next if range == nil
				range.update
			end
			$rpg_skill.update_buff
			update_equip_effects
		end
		
		#--------------------------------------------------------------------------
		# * 몬스터가 리스폰 될떄 현재 맵에서 랜덤으로 스폰 될 수 있도록
		#--------------------------------------------------------------------------
		def rand_spawn(e) # 몬스터 데이터를 받음
			# 제자리 스폰할 애들은 냅두기
			return if e.name.include?("무적토끼")
			
			x = e.x
			y = e.y
			d = e.direction
			
			h = $game_map.height
			w = $game_map.width
			
			count = 0
			while count < 10000
				count += 1
				x = rand(w)
				y = rand(h)
				if $game_map.passable?(x, y, d)
					e.moveto(x, y)
					return
				end
			end
		end
		
		
		#--------------------------------------------------------------------------
		# * ABS 비활성화 여부 확인
		#--------------------------------------------------------------------------
		def active_ok
			return false if Hwnd.include?("NetPartyInv")
			return false if Hwnd.include?("Trade")
			return false if Hwnd.include?("Keyset_menu")# 파티 초대, 교환 창이 켜지지 않았다면?
			return false if Hwnd.include?("Npc_dialog")
			return false if Hwnd.include?("Item_Drop")
			return false if $map_chat_input.active # 채팅이 활성화 된게 아니라면
			return true
		end
		
		#--------------------------------------------------------------------------
		# * 로그아웃 등 스킬 버프, 딜레이 초기화
		#--------------------------------------------------------------------------
		def close_buff
			# 스킬 딜레이 초기화
			for skill_mash in SKILL_MASH_TIME
				if skill_mash[1][1] > 0
					skill_mash[1][1] = 0
				end
			end
			
			# 버프 지속시간 초기화
			for skill_mash in SKILL_BUFF_TIME
				if skill_mash[1][1] > 0
					skill_mash[1][1] = 0 
					$rpg_skill.buff_del(skill_mash[0])
				end
			end
			
			if $skill_Delay_Console != nil
				$skill_Delay_Console.refresh
				$skill_Delay_Console.refresh
				$skill_Delay_Console.dispose
			end
		end
		
		
		#--------------------------------------------------------------------------
		# 특정 장비를 착용할 때 효과 
		#--------------------------------------------------------------------------
		def update_equip_effects
			equip = []
			equip.push($game_party.actors[0].weapon_id)
			equip.push($game_party.actors[0].armor1_id)
			equip.push($game_party.actors[0].armor2_id)
			equip.push($game_party.actors[0].armor3_id)
			equip.push($game_party.actors[0].armor4_id)
			
			# EQUIP_EFFECTS[33] = [[10 * sec, "hp", 1], [10 * sec, "sp", 1]] # 도깨비부적
			
			for id in equip
				if EQUIP_EFFECTS[id] != nil
					data = EQUIP_EFFECTS[id]
					for d in data
						if (Graphics.frame_count % d[0] == 0)
							type = d[1]
							val = d[2]
							case type
							when "hp"
								$game_party.actors[0].hp += ($game_party.actors[0].maxhp * val / 100.0).to_i 
							when "sp"
								$game_party.actors[0].sp += ($game_party.actors[0].maxsp * val / 100.0).to_i
							when "com"
								$game_temp.common_event_id = val
							when "buff"
								$rpg_skill.buff_active(val) if(!$rpg_skill.check_buff(val)) # 이게 버프 스킬인지 확인
							when "custom"	
								case id
								when 1
								end
							end
						end
					end
				end
			end
		end
		
		
		#--------------------------------------------------------------------------
		# * Update Enemy AI(Frame)
		#--------------------------------------------------------------------------
		def update_enemy
			# 적 리스트 가져옴
			for enemy in @enemies.values
				#Skip NIL values
				next if enemy == nil
				if enemy.dead?
					next
				else # 죽지도 않았는데 캐릭터가 없다? 그러면 죽어
					if enemy.event.character_name == ""
						@enemies.delete(enemy.event.id)
						next 
					end
				end
				# 적 캐릭터의 상태 업데이트
				update_enemy_state(enemy)
				
				# 적 캐릭터의 스킬 쿨타임 업데이트
				update_enemy_skill_mash(enemy)
				
				# 화면에 없는 적 캐릭터는 무시
				#next if !in_screen?(enemy.event)
				# 적 캐릭터의 적대 관계 형성
				make_hate_points(enemy) if @get_hate
				
				# 적 체력에 따른 페이즈 관리
				update_enemy_phase(enemy)
				
				# 전투중이아니고 공격성 ai가 false면 무시
				if !enemy.in_battle and !update_enemy_ai(enemy)
					next 
				end
				
				if enemy.in_battle and enemy.behavior != 0
					update_enemy_battle(enemy) 
				end
			end
			@get_hate = false
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 상태 업데이트 : 버프, 디버프등 상태 
		#--------------------------------------------------------------------------
		def update_enemy_state(enemy)
			
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 스킬 쿨타임 업데이트 : 버프, 디버프등 상태 
		#--------------------------------------------------------------------------
		def update_enemy_skill_mash(enemy)
			if enemy.skill_mash != nil
				for mash in enemy.skill_mash
					if mash[1] > 0
						enemy.skill_mash[mash[0]] -= 1
					end
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * Update Enemy Battle(Enemy)
		#--------------------------------------------------------------------------
		def update_enemy_battle_check(enemy)
			return true if enemy.attacking == nil
			return true if enemy.attacking.actor.dead?
			return true if !enemy.hate_group.include?(enemy.attacking.enemy_id)
			return true if !(in_range?(enemy.event, enemy.attacking.event, enemy.see_range) or in_range?(enemy.event, enemy.attacking.event, enemy.hear_range))
			return true if !enemy.aggro
			return false 
		end
		
		def update_enemy_battle(enemy)
			# 만약 적의 시야에 들어오지 않거나 목표로 설정한 적이 죽었거나 어그로가 풀리면 원래대로 돌아옴
			if update_enemy_battle_check(enemy)	
				# 원래 움직임으로 돌아옴
				restore_movement(enemy)
				# 적대모드 풀림
				enemy.in_battle = false
				enemy.attacking = nil
				return
			end      
			
			return if update_enemy_casting(enemy)
			# 공격주기마다 행동 시작
			update_enemy_attack(enemy, enemy.attacking) if Graphics.frame_count % (enemy.aggressiveness * 45.0).to_i == 0
			# Skip this if the attack killed the enemy
			return if enemy == nil or enemy.attacking == nil or enemy.event.moving?
			enemy.event.move_to(enemy.attacking.event) if !in_range?(enemy.event, enemy.attacking.event, 1)
			enemy.event.turn_to(enemy.attacking.event) if !in_direction?(enemy.event, enemy.attacking.event) and in_range?(enemy.event, enemy.attacking.event, 1)
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 공격성
		#--------------------------------------------------------------------------
		def update_enemy_ai(enemy)
			#Get the enemy behavior
			b = enemy.behavior
			return true if b == 0 # Dummy
			#Next enemy if this enemy can't see the player
			return true if b == 1 and !can_enemy_see(enemy)
			#Next enemy if this enemy can't hear the player
			return true if b == 2 and !can_enemy_hear(enemy)
			#Next enemy if this enemy can't see or hear the player
			return true if b == 3 and !can_enemy_see(enemy) and !can_enemy_hear(enemy)
			#Next if its not
			return true if b == 4 and !enemy_ally_in_battle?(enemy)
			#Next enemy if this enemy can't see or hear the player
			return true if b == 5 and !can_enemy_see(enemy) and !can_enemy_hear(enemy) and !enemy_ally_in_battle?(enemy)
			#Return false
			return false
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터가 강력한 스킬을 사용하기전 주문 외우는 함수
		#--------------------------------------------------------------------------
		def update_enemy_casting(enemy)
			if enemy.casting_mash > 0
				enemy.casting_mash -= 1 
				
				if enemy.casting_mash <= 0
					enemy.casting_idx += 1
					data = ABS_ENEMY_SKILL_CASTING[enemy.casting_action.skill_id]
					if data[enemy.casting_idx] == nil
						enemy.casting_idx = 0
						return false
					else
						enemy.casting_mash = data[enemy.casting_idx][0] * Graphics.frame_rate
						$rpg_skill.casting_chat(data[enemy.casting_idx], enemy.event)
						return true
					end
				else
					return true
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 행동, 공격 또는 스킬
		#--------------------------------------------------------------------------
		def update_enemy_attack(e, actor)
			# 만약 행동 리스트가 없으면 무시함
			return if e.actions == nil or e.actions == [] or e == nil
			
			# 행동 리스트 얻음
			for action in e.actions
				# 공격 행동이 아니면 무시
				if e.casting_action != nil
					next if action != e.casting_action
				else
					next if enemy_pre_attack(e, action)
				end
				
				# 행동의 타입
				case action.kind
				when 0 # 기본공격
					#Get the action 기본 액션 가져옴
					case action.basic
					when 0 #Attack
						next if !in_range?(e.event, actor.event, 1) or !in_direction?(e.event, actor.event)
						# 공격 당할 대상 정하기
						a = actor if actor.is_a?(ABS_Enemy) # ABS_Enemy클래스에 속하면 적
						a = $game_party.actors[0] if !actor.is_a?(ABS_Enemy) # ABS_Enemy클래스에 속하지 않으면 플레이어
						# 기본 공격 데미지 계산
						a.attack_effect(e)
						# 애니메이션 실행
						e.event.animation_id = e.animation1_id
						Network::Main.ani(e.event.id, e.animation1_id, 1)
						animate(e.event, e.event.character_name+"_melee") if @enemy_ani
						
						#Show Animation
						hit_enemy(actor,e) if a.damage != "Miss" and a.damage != 0
						#Check if enemy's enemy is dead, 적의 적이 죽었니? 플레이어도 포함 될 수 있음
						return if enemy_dead?(a, e)
						#Make enemy
						return if !a.is_a?(ABS_Enemy) # a가 플레이어면 무시
						return if a.attacking == e and a.in_battle # a가 적 캐릭이면 e를 쫒아감
						
						# a가 적캐릭터일 경우 e를 적대하게 됨
						a.attacking = e
						#The enemy is now in battle
						a.in_battle = true
						#Setup movement
						setup_movement(e)
						
						return
					when 1..3 #Nothing
						return
					end
					
				when 1..2 #Skill 적 캐릭의 스킬 사용
					#Get the skill
					skill = $data_skills[action.skill_id]
					#Return if the skill is NIL
					
					next if skill == nil
					next if !e.can_use_skill?(skill) if e.casting_action == nil
					if RANGE_SKILLS.has_key?(skill.id) # 만약 원거리 스킬이라면
						range = RANGE_SKILLS[skill.id][0]
						next if !in_range?(e.event, actor.event, range + 1)
					elsif RANGE_EXPLODE.has_key?(skill.id)
						range = RANGE_EXPLODE[skill.id][0]
						next if !in_range?(e.event, actor.event, range + 1)
					end
					
					# 스킬 쿨타임 갱신
					if SKILL_MASH_TIME[skill.id] != nil 
						e.skill_mash[skill.id] = SKILL_MASH_TIME[skill.id][0] 
					end
					
					# 캐스팅 갱신
					if e.casting_mash <= 0 and e.casting_action == nil
						cast_data = ABS_ENEMY_SKILL_CASTING[skill.id]
						if cast_data != nil 
							e.casting_mash = cast_data[0][0] * Graphics.frame_rate
							e.casting_action = action
							$rpg_skill.casting_chat(cast_data[0], e.event)
							return
						end
					end
					
					# 캐스팅 초기화
					if e.casting_action != nil
						e.casting_mash = 0
						e.casting_action = nil
						e.casting_idx
					end
					
					# 스킬을 받는 타입
					case skill.scope
					when 1 # One Enemy 적 한놈만 
						# Animate the enemy
						e.event.animation_id = skill.animation1_id
						Network::Main.ani(e.event.id, skill.animation1_id, 1)
						animate(e.event, e.event.character_name+"_cast") if @enemy_ani
						
						if RANGE_SKILLS.has_key?(skill.id) # 만약 원거리 스킬이라면
							if SKILL_DIRECTION.has_key?(skill.id)
								for dir in SKILL_DIRECTION[skill.id]
									@range.push(Game_Ranged_Skill.new(e.event, e, skill, dir)) # e가 날리는 스킬을 구현해줌
									Network::Main.socket.send("<show_range_skill>#{0},#{e.event.id},#{skill.id},#{0},#{dir}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
								end
							end
							@range.push(Game_Ranged_Skill.new(e.event, e, skill)) # e가 날리는 스킬을 구현해줌
							Network::Main.socket.send("<show_range_skill>#{0},#{e.event.id},#{skill.id},#{0},#{e.event.direction}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
							
							e.sp -= skill.sp_cost
							Network::Main.socket.send("<monster_sp>#{e.event.id},#{e.sp}</monster_sp>\n")	if skill.sp_cost != 0 # 몬스터 마력 공유
							$rpg_skill.skill_chat(skill, e.event)
							return
							
						elsif RANGE_EXPLODE.has_key?(skill.id)
							if SKILL_DIRECTION.has_key?(skill.id)
								for dir in SKILL_DIRECTION[skill.id]
									@range.push(Game_Ranged_Explode.new(e.event, e, skill, dir))
									Network::Main.socket.send("<show_range_skill>#{0},#{e.event.id},#{skill.id},#{1},#{dir}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
								end	
							end
							@range.push(Game_Ranged_Explode.new(e.event, e, skill))
							Network::Main.socket.send("<show_range_skill>#{0},#{e.event.id},#{skill.id},#{1},#{e.event.direction}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
							
							#Take off SP
							e.sp -= skill.sp_cost
							Network::Main.socket.send("<monster_sp>#{e.event.id},#{e.sp}</monster_sp>\n")	if skill.sp_cost != 0 # 몬스터 마력 공유
							$rpg_skill.skill_chat(skill, e.event)
							return
						end
						return
						
					when 2 #All Emenies 적 전체
						next if !RANGE_SKILLS.has_key?(skill.id)
						#Animate the enemy
						e.event.animation_id = skill.animation1_id
						Network::Main.ani(e.event.id, skill.animation1_id, 1)
						animate(e.event, e.event.character_name+"_cast") if @enemy_ani
						
						# 스킬 범위내 있는 모든 적 추가
						enemies = get_all_range(e.event, RANGE_SKILLS[skill.id][0])
						enemies.push($game_player) if e.hate_group.include?(0) and in_range?($game_player, e.event, RANGE_SKILLS[skill.id][0])
						enemies_net = get_all_range_net(e.event, RANGE_SKILLS[skill.id][0]) if e.hate_group.include?(0)
						
						old_hp = e.hp
						for enemy in enemies
							# 나한테 적이 아니면 공격 안하게 함
							next if !e.hate_group.include?(enemy.id)
							#Skip NIL values
							next if enemy == nil
							next if !enemy.is_a?(Game_Player) and enemy.dead? 
							
							enemy.actor.effect_skill(e, skill)
							hit_enemy(enemy, e, skill.animation2_id) if enemy.actor.damage != "Miss" and enemy.actor.damage != 0
							next if enemy_dead?(enemy.actor, e)
							#Skip this enemy if its dead
							next if enemy.is_a?(Game_Player)
							next if enemy.attacking == e and enemy.in_battle
							#If its alive, put it in battle
							enemy.in_battle = true
							#Make it attack the player
							enemy.attacking = e
							#Setup movement
							setup_movement(e)
						end
						
						if enemies_net != nil
							for player in enemies_net
								Network::Main.socket.send("<e_skill_effect>#{player.name},#{e.event.id},#{skill.id}</e_skill_effect>\n")	# 몬스터 마력 공유
							end
						end
						
						e.sp -= skill.sp_cost
						Network::Main.socket.send("<monster_sp>#{e.event.id},#{e.sp}</monster_sp>\n")	if skill.sp_cost != 0# 몬스터 마력 공유
						Network::Main.socket.send("<hp>#{$game_map.map_id},#{e.event.id},#{e.hp}</hp>\n") if old_hp != e.hp
						$rpg_skill.skill_chat(skill, e.event)
						return		
						
					when 3..4, 7 # 자기 자신에게 사용하는 스킬
						#Animate the enemy
						e.event.animation_id = skill.animation1_id
						
						animate(e.event, e.event.character_name+"_cast") if @enemy_ani
						Network::Main.ani(e.event.id, skill.animation1_id, 1)
						
						old_hp = e.hp
						$rpg_skill.heal(skill.id, e) # 이게 회복 스킬인지 확인
						
						e.sp -= skill.sp_cost
						$rpg_skill.skill_chat(skill, e.event)
						
						Network::Main.socket.send("<monster_sp>#{e.event.id},#{e.sp}</monster_sp>\n")	 if skill.sp_cost != 0# 몬스터 마력 공유
						Network::Main.socket.send("<hp>#{$game_map.map_id},#{e.event.id},#{e.hp}</hp>\n") if old_hp != e.hp
						return
					end
					return
				end
			end
		end
		
		
		
		#--------------------------------------------------------------------------
		# * Update Player  실시간 반영 되는 함수
		#--------------------------------------------------------------------------
		def update_player
			# 스킬 딜레이 갱신
			for skill_mash in SKILL_MASH_TIME
				if skill_mash[1][1] > 0
					skill_mash[1][1] -= 1 
					if skill_mash[1][1] == 0
						$console.write_line("#{$data_skills[skill_mash[0]].name} 딜레이 끝")
					end
				end
			end
			
			# 버프 지속시간 갱신
			for skill_mash in SKILL_BUFF_TIME
				if skill_mash[1][1] > 0
					skill_mash[1][1] -= 1 
					if skill_mash[1][1] == 0
						$console.write_line("#{$data_skills[skill_mash[0]].name} 끝")
						$rpg_skill.buff_del(skill_mash[0]) # 버프 끝 표시
					end
				end
			end
			
			# 후 딜레이 처리
			@item_mash -= 1 if @item_mash > 0
			@attack_mash -= 1 if @attack_mash > 0
			for s_mash in @skill_mash
				@skill_mash[s_mash[0]] -= 1 if s_mash[1] > 0
			end
			
			if active_ok
				check_item if @item_mash == 0 # 아이템 단축키 눌렸니?
				@actor = $game_party.actors[0]
				
				# 공격키가 눌렸니?
				if Input.trigger?(@attack_key) and @attack_mash == 0
					# 만약 죽은 상태면 공격 못함
					if $game_switches[296]# 유저 죽음 스위치가 켜져있다면 패스
						$console.write_line("귀신은 할 수 없습니다.")
						return 
					end
					player_range if RANGE_WEAPONS.has_key?(@actor.weapon_id)
					player_melee
				end
				
				# 만약 스킬 사용 불가 지역이면 콘솔로 말하고 무시
				# 스킬 단축키가 눌렸니?
				for key in @skill_keys.keys
					next if @skill_keys[key] == nil or @skill_keys[key] == 0
					next if !Input.trigger?(key)
					id = @skill_keys[key] # 스킬 아이디 가져옴
					next if @skill_mash[id] != nil and @skill_mash[id] > 0
					
					if RANGE_EXPLODE.has_key?(id)
						return player_explode(id)
					else
						return player_skill(id)
					end
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * Check Item  아이탬 단축키를 이용해서 사용할 경우
		#--------------------------------------------------------------------------
		def check_item
			#Check for item usage
			for key in @item_keys.keys
				# 해당 키에 등록된 아이템이 없으면 무시
				next if @item_keys[key] == nil or @item_keys[key] == 0
				next if !Input.trigger?(key)
				
				item = $data_items[@item_keys[key]] # 아이템데이터 가져옴
				target = $game_party.actors[0]
				return if !target.item_effect(item)
				
				$game_player.animation_id = item.animation1_id 
				Network::Main.ani(Network::Main.id, item.animation1_id)
				$game_system.se_play(item.menu_se)
				$game_party.lose_item(item.id, 1) if item.consumable
				@item_mash = 3
				return $game_temp.common_event_id = item.common_event_id if item.common_event_id > 0
			end
		end
		
		#--------------------------------------------------------------------------
		# * 캐릭터의 범위 무기
		#--------------------------------------------------------------------------
		def player_range
			#Get the weapon
			w = RANGE_WEAPONS[@actor.weapon_id]
			#Return if the ammo isn't there
			return if w[3] != 0 and $game_party.item_number(w[3]) == 0
			$game_player.animation_id = $data_weapons[@actor.weapon_id].animation1_id
			#Add mash time
			@attack_mash = (w[5] == nil ? MASH_TIME*10 : w[5]*10)
			#Delete an ammo
			$game_party.lose_item(w[3], 1) if w[3] != 0
			#Make the attack
			@range.push(Game_Ranged_Weapon.new($game_player, @actor, @actor.weapon_id))
			#Animate
			return if w[7] == nil
			animate($game_player, $game_player.character_name+w[7].to_s) if @player_ani
			return
		end
		
		#--------------------------------------------------------------------------
		# * 플레이어의 기본공격
		#--------------------------------------------------------------------------
		def player_melee(sw = false) # 왠지 여기서 때리는 모션 만들 수 있을 듯?
			# m은 무기 각 공격 딜레이를 말함, 만약 없으면 기본 공격속도
			m = MELEE_CUSTOM[@actor.weapon_id]
			if m != nil and m[0] != nil
				@attack_mash = m[0] * 10
			else
				@attack_mash = MASH_TIME * 10
			end
			
			# 만약 스킬로 인한 공격이라면..?
			if sw
				@attack_mash = MASH_TIME * 6 
			end
			
			Audio.se_play("Audio/SE/무기001-검", $game_variables[13])
			Network::Main.ani(Network::Main.id, 191)
			
			for e in @enemies.values
				# 적이 없거나 적이 죽으면 공격 안함
				next if e == nil or e.dead?
				# 적이 캐릭터가 보는 방향에 없거나 바로 앞에 없으면 무시
				next if !in_direction?($game_player, e.event) or !in_range?($game_player, e.event, 1)
				# 때릴 수 없거나 아군이면 공격 못함
				next if !CAN_HURT_ALLY and e.hate_group.include?(0)
				# Show Weapon Aniamtion
				$game_player.animation_id = $data_weapons[@actor.weapon_id].animation1_id if $data_weapons[@actor.weapon_id] != nil
				
				if $data_weapons[@actor.weapon_id] != nil
					a = $data_weapons[@actor.weapon_id].animation2_id 
				else
					a = 109 # 기본 이펙트
				end
				
				e.event.animation_id = a
				Network::Main.ani(e.event.id, a, 1)
				e.attack_effect(@actor)
				# 몬스터타격 데미지 계산
				if e.damage != "Miss" and e.damage != 0
					Audio.se_play("Audio/SE/타격", $game_variables[13])					
				end
				
				#Return if the enemy is dead
				return if enemy_dead?(e,@actor)
				return if !e.hate_group.include?(0)
				
				e.attacking = $game_player
				e.in_battle = true
				setup_movement(e)
				
			end
			
			# 다른 플레이어 공격 처리
			for player in Network::Main.mapplayers.values
				next if player == nil
				next if !in_direction?($game_player, player) or !in_range?($game_player, player, 1)
				# 해당 대상 애니메이션 재생하도록 보냄
				ani_id = $data_weapons[$game_party.actors[0].weapon_id].animation2_id if $data_weapons[$game_party.actors[0].weapon_id] != nil
				ani_id = 109 if ani_id == nil
				$ani_character[player.netid.to_i].animation_id = ani_id if $ani_character[player.netid.to_i] != nil
				Network::Main.ani(player.netid, ani_id)
				
				# 상대방 이름
				Network::Main.socket.send("<attack_effect>#{player.name}</attack_effect>\n")
				
				$state_trans = false
				$game_variables[9] = 1
			end
		end
		
		
		#==============================#
		#=====무기 격 설정 - 크랩훕흐======#
		#=============================#
		def weapon_skill(id, e)
			r = rand(100)
			ani = 0
			dmg = 0
			return 0 if WEAPON_SKILL[id] == nil
			ra = WEAPON_SKILL[id][2] # 발동 확률
			
			if r < ra
				dmg = WEAPON_SKILL[id][0]
				ani = WEAPON_SKILL[id][1]
			end
			
			if dmg != 0 and dmg != nil
				if ani != 0 and ani != nil
					e.event.animation_id = ani
					Network::Main.ani(e.event.id, ani, 1)
				end
				
				return dmg.to_i
			end
			return 0
		end
		
		#==============================#
		#=====스킬 딜레이 알려줌 - 크랩훕흐======#
		#=============================#
		def skill_console(id)
			# 스킬 딜레이 표시
			skill_mash_time = SKILL_MASH_TIME[id]
			if skill_mash_time != nil and skill_mash_time[1] <= 0
				skill_mash_time[1] = skill_mash_time[0]
				$console.write_line("#{$data_skills[id].name} 딜레이 : #{skill_mash_time[0] / Graphics.frame_rate}초")
				$skill_Delay_Console.write_line(id)
			end
			
			# 버프의 지속시간 표시
			skill_mash_time = SKILL_BUFF_TIME[id]
			if skill_mash_time != nil and skill_mash_time[1] != skill_mash_time[0]
				skill_mash_time[1] = skill_mash_time[0]
				$console.write_line("#{$data_skills[id].name} 지속시간 : #{skill_mash_time[0] / Graphics.frame_rate}초")
				$skill_Delay_Console.write_line(id)
			end
		end
		
		# 맵을 이동하기위한 함수
		def map_m(id, x, y)
			if $game_map.map_id != id
				
				
				$game_temp.player_transferring = true # 이동 가능
				$game_temp.player_new_map_id = id
				$game_temp.player_new_x = x
				$game_temp.player_new_y = y
				
				
			else
				count = 0
				while count < 10000
					count += 1
					if $game_map.passable?(x, y, 2)
						$game_player.moveto(x, y)
						return
					else
						x += (rand(3) - 1)
						y += (rand(3) - 1)
					end
				end
			end
		end
		
		#==============================#
		#=====성황당 - 크랩훕흐===========#
		#=============================#
		def skill_sung
			x = 11
			y = 8
			m_id = 17
			case $game_variables[8]
			when 0 # 부여성
				m_id = 17
			when 1, 2 # 국내성
				m_id = 135
			when 3 # 용궁
				m_id = 204
			when 4 # 고균도
				m_id = 85
			when 5 # 일본
				m_id = 234
			when 6 # 대방성
				m_id = 298
			when 7 # 현도성
				m_id = 326
			when 8 # 장안성
				m_id = 369
			when 9 # 가릉도
				m_id = 384
			when 10 # 폭염도
				m_id = 392
			end
			map_m(m_id, x, y)
		end
		
		
		#=============================#
		#=====비영사천문 - 크랩훕흐===========#
		#=============================#
		def skill_byung(d) # d : 방향, 0 : 동, 1 : 서, 2 : 남, 3: 북
			if $game_switches[296]# 유저 죽음 스위치가 켜져있다면 패스
				$console.write_line("귀신은 할 수 없습니다.")
				return 
			end
			
			r = 3
			case $game_variables[8] # 맵 번호
			when 0 # 부여성
				id = 1
				case d
				when 0
					map_m(id, 66 + rand(r), 33 + rand(r))
				when 1
					map_m(id, 5 + rand(r), 30 + rand(r))
				when 2
					map_m(id, 34 + rand(r), 68 + rand(r))
				when 3
					map_m(id, 34 + rand(r), 2 + rand(r))
				end
				
			when 1 # 국내성
				id = 123
				case d
				when 0
					map_m(id, 118 + rand(r), 60 + rand(r))
				when 1
					map_m(id, 7 + rand(r), 60 + rand(r))
				when 2
					map_m(id, 63 + rand(r), 109 + rand(r))
				when 3
					map_m(id, 63 + rand(r), 12 + rand(r))
				end
				
			when 2 # 12지신
				id = 110
				case d
				when 0
					map_m(id, 35 + rand(r), 16 + rand(r))
				when 1
					map_m(id, 1 + rand(r), 16 + rand(r))
				when 2
					map_m(id, 17 + rand(r), 33 + rand(r))
				when 3
					map_m(id, 17 + rand(r), 2 + rand(r))
				end
				
			when 3 # 용궁
				id = 203
				case d
				when 0
					map_m(id, 52, 23)
				when 1
					map_m(id, 4, 24)
				when 2
					map_m(id, 27, 43)
				when 3
					map_m(id, 29, 8)
				end
				
			when 4 # 고균도
				id = 60
				case d
				when 0
					map_m(id, 56 + rand(r), 33 + rand(r))
				when 1
					map_m(id, 4 + rand(r), 32 + rand(r))
				when 2
					map_m(id, 39 + rand(r), 57 + rand(r))
				when 3
					map_m(id, 29 + rand(r), 10 + rand(r))
				end
				
			when 5 # 일본
				id = 230
				case d
				when 0
					map_m(id, 114 + rand(r), 30 + rand(r))
				when 1
					map_m(id, 5 + rand(r), 31 + rand(r))
				when 2
					map_m(id, 64 + rand(r), 90 + rand(r))
				when 3
					map_m(id, 55 + rand(r), 2 + rand(r))
				end
				
			when 6 # 대방성
				id = 276
				case d
				when 0
					map_m(id, 113 + rand(r), 61 + rand(r))
				when 1
					map_m(id, 8 + rand(r), 61 + rand(r))
				when 2
					map_m(id, 61 + rand(r), 108 + rand(r))
				when 3
					map_m(id, 61 + rand(r), 10 + rand(r))
				end
				
			when 7 # 현도성
				id = 301
				case d
				when 0
					map_m(id, 113 + rand(r), 61 + rand(r))
				when 1
					map_m(id, 8 + rand(r), 61 + rand(r))
				when 2
					map_m(id, 61 + rand(r), 108 + rand(r))
				when 3
					map_m(id, 61 + rand(r), 10 + rand(r))
				end
				
			when 8 # 장안성
				id = 303
				case d
				when 0
					map_m(id, 113 + rand(r), 61 + rand(r))
				when 1
					map_m(id, 8 + rand(r), 61 + rand(r))
				when 2
					map_m(id, 61 + rand(r), 108 + rand(r))
				when 3
					map_m(id, 61 + rand(r), 10 + rand(r))
				end
				
				# 동서남북
			when 9 # 가릉도
				id = 374
				case d
				when 0
					map_m(id, 58 + rand(r), 20 + rand(r))
				when 1
					map_m(id, 12 + rand(r), 17 + rand(r))
				when 2
					map_m(id, 28 + rand(r), 33 + rand(r))
				when 3
					map_m(id, 27 + rand(r), 9 + rand(r))
				end
				
			when 10 # 폭염도
				id = 391
				case d
				when 0
					map_m(id, 43 + rand(r), 29 + rand(r))
				when 1
					map_m(id, 7 + rand(r), 25 + rand(r))
				when 2
					map_m(id, 24 + rand(r), 37 + rand(r))
				when 3
					map_m(id, 26 + rand(r), 9 + rand(r))
				end
				
			when -1
				
			end
			case d
			when 0
				$console.write_line("동쪽에 이르렀으니... ")
			when 1
				$console.write_line("서쪽에 이르렀으니... ")
			when 2
				$console.write_line("남쪽에 이르렀으니... ")
			when 3
				$console.write_line("북쪽에 이르렀으니... ")
			end
			Network::Main.ani(Network::Main.id, 129)
		end
		
		#--------------------------------------------------------------------------
		# *  플레이어의 스킬 공격
		#--------------------------------------------------------------------------
		def player_skill(id)
			@actor = $game_party.actors[0]
			#Get Skill
			skill = $data_skills[id]
			# 단축키에 스킬이 없으면 실행 안됨
			return if skill == nil
			# 액터가 가지고 있는 스킬이 아님
			return if !@actor.skills.include?(skill.id)
			# 마력이 부족하면 무시
			if @actor.sp < skill.sp_cost
				$console.write_line("마력이 부족합니다.")
				return
			end
			# 엑터가 사용할 수 없는 상황이면 무시
			if !@actor.can_use_skill?(skill) and skill.id != 8 and skill.id != 120 #성황령, 부활은 죽을 때 사용하는 거니까 죽어서 사용할 수 있어야함
				$console.write_line("귀신은 할 수 없습니다.")
				return 
			end
			
			# 스킬 사용 불가 지역
			if $game_switches[352] or $game_switches[25]
				$console.write_line("스킬 사용 불가 지역입니다.")
				return
			end
			
			id = skill.id 
			
			# 아직 스킬 딜레이가 남아있다면 무시
			skill_mash = SKILL_MASH_TIME[id]
			if skill_mash != nil and skill_mash[1]/60.0 > 0
				$console.write_line("딜레이가 남아있습니다. #{'%.1f' % (skill_mash[1]/60.0)}초")
				return
			end
			
			return if !$rpg_skill.check_need_skill_item(skill.id) # 스킬 사용 재료가 부족하면 취소
			
			#Animate
			if SKILL_CUSTOM.has_key?(id)
				l = SKILL_CUSTOM[id]
				animate($game_player, $game_player.character_name+l[2].to_s) if @player_ani
			else
				animate($game_player, $game_player.character_name+"_cast") if @player_ani
			end
			
			$rpg_skill.heal(id) # 이게 회복 스킬인지 확인
			$rpg_skill.party_heal(id) # 이게 파티 회복 스킬인지 확인
			$rpg_skill.buff(id) # 이게 버프 스킬인지 확인
			$rpg_skill.party_buff(id) # 파티 버프 스킬인지 확인
			$rpg_skill.active_skill(id) # 액티브 스킬 행동 커스텀 확인
			$rpg_skill.skill_chat(skill) # 스킬 사용시 말하는 것
			skill_console(id)   # 스킬 딜레이 표시
			
			# 커먼 이벤트 실행
			if skill.common_event_id > 0
				# Common event call reservation
				$game_temp.common_event_id = skill.common_event_id
			end
			
			# 스킬 애니메이션 
			$game_player.animation_id = skill.animation1_id
			Network::Main.ani(Network::Main.id, skill.animation1_id)
			
			#Get the skill scope
			# 스킬 맞는 쪽
			case skill.scope
			when 0 # 자기 자신
				@actor.sp -= skill.sp_cost
				@skill_mash[id] = MASH_TIME * 2
			when 1 #Enemy 적
				# 원거리 스킬인가?
				if RANGE_SKILLS.has_key?(skill.id)
					# 원거리 스킬 캐릭터 생성
					@range.push(Game_Ranged_Skill.new($game_player, @actor, skill))
					Network::Main.socket.send("<show_range_skill>#{1},#{Network::Main.id},#{skill.id},#{0}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
					@actor.sp -= skill.sp_cost
					w = RANGE_SKILLS[id]
					# 스킬 사용 후 딜레이
					@skill_mash[id] = (w[3] == nil ? MASH_TIME * 10 : w[3] * 10)
					return
				end
				
				
			when 2 #All Emenies 적 전체
				#Play the animation on player
				$game_player.animation_id = skill.animation1_id
				#Take off SP
				@actor.sp -= skill.sp_cost
				id = skill.id
				
				hit_num = 1
				
				#If the skill is ranged
				if RANGE_SKILLS.has_key?(skill.id)
					enemies = get_all_range($game_player, RANGE_SKILLS[skill.id][0])
					w = RANGE_SKILLS[id]
					#Add mash time
					@skill_mash[id] = (w[3] == nil ? MASH_TIME * 10 : w[3] * 10) 
					hit_num = RANGE_SKILLS[skill.id][5] == nil ? 1 : [RANGE_SKILLS[skill.id][5], 1].max
					
				else
					if SKILL_CUSTOM[id] != nil
						@skill_mash[id] = (SKILL_CUSTOM[id] == nil ? MASH_TIME*10 : SKILL_CUSTOM[id] != nil and SKILL_CUSTOM[id][0] != nil ? SKILL_CUSTOM[id][0]*10 : MASH_TIME*10)
					else
						@skill_mash[id] = MASH_TIME*10
					end
					enemies = @enemies
				end
				
				
				target_enemies = []
				for e in enemies
					#Skip NIL values
					next if e == nil
					next if e.is_a?(Array)
					#Skip 이미 적이 죽은거면 넘어가
					next if e.dead?
					# Skip if the enemy is an ally and can't hurt allies.
					next if !CAN_HURT_ALLY and e.hate_group.include?(0)
					next if !e.hate_group.include?(0) # 내 적이 아니면 패스
					target_enemies.push(e)
				end
				
				#Get all enemies
				for e in target_enemies
					#Attack enemy
					hit_num.times{
						e.effect_skill(@actor, skill)
						hit_enemy(e, @actor, skill.animation2_id)
					}
					#Show Animetion on enemy
					
					#jump(e.event, $game_player, SKILL_CUSTOM[id][1]) if SKILL_CUSTOM[id] != nil and e.damage != "Miss" and e.damage != 0
					#Skip this enemy if its dead
					next if enemy_dead?(e, @actor)
					
					
					#If its alive, put it in battle
					e.in_battle = true
					#Make it attack the player
					e.attacking = $game_player
					#Setup movement
					setup_movement(e)
					
				end
				$rpg_skill.skill_cost_custom(@actor, skill.id) if target_enemies.size > 0
				return
				
			when 3..4, 7 #User
				if SKILL_CUSTOM[id] != nil
					@skill_mash[id] = (SKILL_CUSTOM[id] == nil ? MASH_TIME*10 : SKILL_CUSTOM[id] != nil and SKILL_CUSTOM[id][0] != nil ? SKILL_CUSTOM[id][0]*10 : MASH_TIME*10)
				else
					@skill_mash[id] = MASH_TIME*10
				end
				#Use the skill on the player
				@actor.effect_skill(@actor, skill)
				#Take off SP
				@actor.sp -= skill.sp_cost
				#Play animation
				$game_player.animation_id = skill.animation2_id
				return
			end
		end
		
		#--------------------------------------------------------------------------
		# * 플레이어의 범위 공격 스킬
		#--------------------------------------------------------------------------
		def player_explode(id)
			return if !RANGE_EXPLODE.has_key?(id)
			#Get Skill
			skill = $data_skills[id]
			#Return if the skill doesn't exist
			return if skill == nil
			#Return if the actor doesn't have the skill
			return if !@actor.skills.include?(skill.id)
			
			# 마력이 부족하면 무시
			if @actor.sp < skill.sp_cost
				$console.write_line("마력이 부족합니다.")
				return
			end
			
			# 엑터가 사용할 수 없는 상황이면 무시
			if !@actor.can_use_skill?(skill) and skill.id != 8 and skill.id != 120 #성황령, 부활은 죽을 때 사용하는 거니까 죽어서 사용할 수 있어야함
				$console.write_line("귀신은 할 수 없습니다.")
				return 
			end
			
			# 스킬 사용 불가 지역
			if $game_switches[352] or $game_switches[25]
				$console.write_line("스킬 사용 불가 지역입니다.")
				return
			end
			
			# 아직 스킬 딜레이가 남아있다면 무시
			skill_mash = SKILL_MASH_TIME[id]
			if skill_mash != nil and skill_mash[1]/60.0 > 0
				$console.write_line("딜레이가 남아있습니다. #{'%.1f' % (skill_mash[1]/60.0)}초")
				return
			end
			
			return if !$rpg_skill.check_need_skill_item(skill.id) # 스킬 사용 재료가 부족하면 취소
			
			w = RANGE_EXPLODE[skill.id]
			# Show Animation
			$game_player.animation_id = skill.animation1_id
			#Add mash time
			@skill_mash[id] = (w[4] == nil ? MASH_TIME*10 : w[4]*10)
			
			skill_console(id)
			$rpg_skill.skill_chat(skill) # 스킬 사용시 말하는 것
			
			#Animate
			if SKILL_CUSTOM.has_key?(id)
				l = SKILL_CUSTOM[id]
				animate($game_player, $game_player.character_name+l[2].to_s) if @player_ani
			else
				animate($game_player, $game_player.character_name+"_cast") if @player_ani
			end
			#Add to range
			@range.push(Game_Ranged_Explode.new($game_player, @actor, skill))
			Network::Main.socket.send("<show_range_skill>#{1},#{Network::Main.id},#{skill.id},#{1}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
			#Take off SP
			@actor.sp -= skill.sp_cost
			return
		end
		
		#--------------------------------------------------------------------------
		# * 적이 죽었니? (몹 또는 유저), e가 a에 의해 죽었음
		#--------------------------------------------------------------------------
		def enemy_dead?(e, a)
			# e가 유저라면 유저 죽을 때 함수 반환
			return player_dead?(e,a) if e.is_a?(Game_Actor)
			#Return false if enemy dead
			return false if !e.dead?
			enemy = e
			treasure(enemy) if a != nil and a.is_a?(Game_Actor)
			# 적 유닛이 적을 죽이면 평상시로 돌아옴
			if a != nil and !a.is_a?(Game_Actor)
				a.attacking = nil 
				#a.in_battle = false
				#restore_movement(a)
			end
			
			id = enemy.event_id
			#Remove from list 리스폰이 없으면 아예 지워버림
			@enemies.delete(id) if (@enemies[id] != nil and (@enemies[id].respawn == 0 or @enemies[id].respawn == nil))
			event = enemy.event
			#여기다가 이 이벤트를 없애는 명령하기
			Network::Main.socket.send("<monster>#{$game_map.map_id},#{event.id},#{0},#{event.x},#{event.y},#{event.direction},#{enemy.respawn}</monster>\n")
			Network::Main.socket.send("<enemy_dead>#{id},#{$game_map.map_id},#{$npt}</enemy_dead>\n")
			event.through = true
			
			case enemy.trigger[0]
			when 0
				event.fade = true if FADE_DEAD
				if !FADE_DEAD
					event.character_name = ""
					event.erase
				end
			when 1
				event.fade = true if FADE_DEAD
				print "EVENT " + event.id.to_s + "Trigger Not Set Right ~!" if enemy.trigger[1] == 0
				$game_switches[enemy.trigger[1]] = true
				#$game_map.need_refresh = true
			when 2
				event.fade = true if FADE_DEAD
				print "EVENT " + event.id.to_s + "Trigger Not Set Right ~!" if enemy.trigger[1] == 0
				$game_variables[enemy.trigger[1]] += 1
				#$game_map.need_refresh = true
			when 3 
				event.fade = true if FADE_DEAD
				value = "A" if enemy.trigger[1] == 1
				value = "B" if enemy.trigger[1] == 2
				value = "C" if enemy.trigger[1] == 3
				value = "D" if enemy.trigger[1] == 4
				print "EVENT " + event.id.to_s + "Trigger Not Set Right ~!" if value == 0
				key = [$game_map.map_id, event.id, value]
				$game_self_switches[key] = true
				#$game_map.need_refresh = true
			end
			#Return true if the e is dead
			return true
		end
		
		#--------------------------------------------------------------------------
		# * Player Dead(Player,Enemy) a가 e에 의해 죽음
		#--------------------------------------------------------------------------
		def player_dead?(a, e)
			return false if $game_party.actors[0].hp > 0
			
			# 플레이어가 죽으면 몹들 다가가는거 멈춤
			if e != nil and !e.is_a?(Game_NetPlayer)
				e.attacking = nil if e != nil and !e.is_a?(Game_Actor)
			end
			
			return true if $game_switches[296] # 죽음 표시 스위치
			#If the player is dead;
			Audio.se_play("Audio/SE/죽음", $game_variables[13])
			Network::Main.ani(Network::Main.id, 199)
			
			$console.write_line("죽었습니다.. 성황당에서 기원하십시오.")
			$cha_name = $game_party.actors[0].character_name
			$game_party.actors[0].equip(0, 0)
			$game_party.actors[0].equip(1, 0)
			$game_party.actors[0].equip(2, 0)
			$game_party.actors[0].equip(3, 0)
			$game_party.actors[0].equip(4, 0)
			$game_party.actors[0].set_graphic("죽음", 0, 0, 0)
			$game_player.refresh
			
			$game_switches[50] = false if $game_switches[50] != false # 유저 살음 스위치 오프
			$game_switches[296] = true if $game_switches[296] != true# 유저 죽음 스위치 온
			# 이때 모든 버프들을 지우자
			for skill_mash in SKILL_BUFF_TIME
				if skill_mash[1][1] > 0
					skill_mash[1][1] = 1 
				end
			end
			$game_party.actors[0].pdef = 0 # 물리방어
			$game_party.actors[0].mdef = 0 # 마법방어
			$scene = Scene_Map.new
			return true
		end
		#--------------------------------------------------------------------------
		# * 몬스터를 잡았을 경우 주는것
		#--------------------------------------------------------------------------
		def treasure(enemy)
			exp = 0
			gold = 0
			actor = $game_party.actors[0]
			unless enemy.hidden
				if ENEMY_EXP[enemy.id] != nil 
					exp = ENEMY_EXP[enemy.id][0]
					if ENEMY_EXP[enemy.id].size > 1
						exp = (((exp + actor.maxhp * ENEMY_EXP[enemy.id][1].to_f + actor.maxsp * ENEMY_EXP[enemy.id][2].to_f) / exp) * exp).to_i
					end
				else
					exp = enemy.exp
				end
				
				gold += enemy.gold
			end
			
			if actor.cant_get_exp? == false # 경험치를 얻을 수 있는 상황
				last_level = actor.level
				in_map_player = 1
				
				if $netparty.size >= 2   # 파티중일경우 경험치, 돈의 습득
					# 여기서 파티원이 맵에 있는지 확인			
					for player in Network::Main.mapplayers.values
						next if player == nil
						if $netparty.include?(player.name) and player.name != $game_party.actors[0].name
							in_map_player = in_map_player + 1 # 같은 맵에 파티원이 있으면 추가
						end
					end
				end
				
				nextExp = actor.level < 99 ? actor.exp_list[actor.level + 1] - actor.exp_list[actor.level] : actor.exp_list[100]
				limitExp = (nextExp / 100.0 * $exp_limit).to_i # 경험치 한계점
				gainExp = actor.level < 99 ? [exp, limitExp].min : exp
				gainExp *= $exp_event if $game_switches[1500] == true  # 경험치 이벤트!
				exp *= $exp_event if $game_switches[1500] == true  # 경험치 이벤트!
				
				if in_map_player >= 2
					Network::Main.socket.send("<nptgain>#{exp} #{gold} #{$npt} #{in_map_player} #{enemy.event.id}</nptgain>\n")
					gainExp = (gainExp * 1.5).to_i / in_map_player
					gold = (gold * 1.5).to_i / in_map_player
				end
				
				expPer = actor.level < 99 ? ((actor.exp - actor.exp_list[actor.level]) * 100.0 / nextExp) : (actor.exp * 100.0 / nextExp)
				$console.write_line("경험치:#{change_number_unit(gainExp)} 금전:#{change_number_unit(gold)} 획득. (#{'%.2f' % expPer}%)")
				actor.exp += gainExp
				$game_party.gain_gold(gold)
				drop_enemy(enemy) # ABS monster item drop 파일 참조
			end
		end
		
		# 간단하게 경험치 바로 얻을 수 있는 함수
		def simple_exp(id, val = 0)
			return if $data_enemies[id] == nil
			enemy = $data_enemies[id]
			actor = $game_party.actors[0]
			exp = val
			
			if ENEMY_EXP[id] != nil 
				exp = ENEMY_EXP[id][0]
				if ENEMY_EXP[id].size > 1 
					exp += (actor.maxhp * ENEMY_EXP[id][1] + actor.maxsp * ENEMY_EXP[id][2]).to_i
				end
			else
				exp = enemy.exp
			end
			# 경험치 이벤트!
			if $game_switches[1500] == true  
				exp *= $exp_event
			end
			actor.exp += exp
			$console.write_line("경험치:#{exp} 획득")
		end
		
		#--------------------------------------------------------------------------
		# * Hit Enemy(Enemy) or (Player) 몬스터가 공격할 경우, e가 a에게 공격당함
		#--------------------------------------------------------------------------
		def hit_enemy(e, a, animation=nil)
			return if animation == 0
			# 나한테 적이 아니면 공격 안하게 함
			if a.is_a?(ABS_Enemy) and e.is_a?(Game_Actor)
				return if !a.hate_group.include?(0)
			end
			if a.is_a?(ABS_Enemy) and e.is_a?(ABS_Enemy)
				return if !a.hate_group.include?(e.id)
			end
			
			if animation == nil
				e.event.animation_id = a.animation2_id
			else
				e.event.animation_id = animation
			end
			e.event.ani_array.push(e.event.animation_id)
			Network::Main.ani(Network::Main.id, e.event.animation_id)
		end
		#--------------------------------------------------------------------------
		# * Jump
		#--------------------------------------------------------------------------
		def jump(object,attacker,plus)
			return if plus == nil
			n_plus = plus - (plus * 2)
			d = attacker.direction
			# Calculate new pos
			new_x = (d == 6 ? plus : d == 4 ? n_plus : 0)
			new_y = (d == 2 ? plus : d == 8 ? n_plus : 0)
			# Jump
			object.jump_nt(new_x, new_y)
		end
		#--------------------------------------------------------------------------
		# * Enemy Pre-Attack(Enemy,Actions) - Checks action conditions to see if the 
		#   enemy can attack.
		#--------------------------------------------------------------------------
		def enemy_pre_attack(enemy, actions)
			return true if enemy.hp * 100.0 / enemy.maxhp > actions.condition_hp
			return true if $game_party.max_level < actions.condition_level
			switch_id = actions.condition_switch_id
			return true if actions.condition_switch_id > 0 and $game_switches[switch_id] == false
			n = rand(11) 
			return true if actions.rating < n
			return false
		end
		#--------------------------------------------------------------------------
		# * Can Enemy See(Enemy)
		#--------------------------------------------------------------------------
		def can_enemy_see(e)
			#Get all enemies of the enemy
			enemies = []
			if e.hate_group.include?(0) and in_range?(e.event, $game_player, e.see_range) or in_direction?(e.event, $game_player)
				if $game_party.actors[0].hp <= 0
					e.in_battle = false
					return false 
				end
				enemies.push($game_player) 
			end		
			
			if e.hate_group.size > 1 or (e.hate_group.size == 1 and !e.hate_group.include?(0))
				#Get the hate enemies
				for enemy in @enemies.values
					next if enemy == nil or enemy == e or !e.hate_group.include?(enemy.enemy_id) or
					!in_range?(e.event, enemy.event, e.see_range) or enemy.dead? #or !in_direction?(e.event, enemy.event)
					#Insert in to the list if the enemy is in hate group
					enemies.push(enemy)
				end
			end
			#Return false if the list is nil or empty
			if enemies == nil or enemies == []
				return false 
			end
			
			#Order the enemies
			if !e.closest_enemy
				#Order from hate points
				enemies.sort! {|a,b|
					e.hate_points[b.event_id] - e.hate_points[a.event_id] }
			else
				enemies.sort! {|a,b|
					get_range(e.event,a.event) - get_range(e.event,b.event) }
			end
			
			
			#Add to enemy attack list
			e.attacking = enemies[0]
			#Enemy is now in battle
			e.in_battle = true
			#Setup the movement
			setup_movement(e)
			
			#Return true
			return true
		end
		#--------------------------------------------------------------------------
		# * Setup the Movement Type to 0(Enemy)
		#--------------------------------------------------------------------------
		def setup_movement(e)
			#Set Speed
			e.event.move_speed = e.temp_speed
			#Set Frequency
			e.event.move_frequency = e.temp_frequency
			#Set Move Type
			e.temp_move_type = e.event.move_type
			e.event.move_type = 0 if e.behavior != 0
		end
		#--------------------------------------------------------------------------
		# * Restore the Movement Type(Enemy)
		#--------------------------------------------------------------------------
		def restore_movement(e)
			#Restore Speed
			e.temp_speed = e.event.move_speed
			#Restore Frequency
			e.temp_frequency = e.event.move_frequency
			#Restore Move Type
			e.event.move_type = e.temp_move_type
			e.temp_move_type = 0
		end
		#--------------------------------------------------------------------------
		# * Can Enemy Hear(Enemy)
		#--------------------------------------------------------------------------
		def can_enemy_hear(e)
			enemies = []
			#Get player
			d = 0
			d = DASH_SPEED if @dashing
			enemies.push($game_player) if e.hate_group.include?(0) and !@sneaking and 
			in_range?(e.event, $game_player, e.hear_range+d)
			if e.hate_group.size > 1 or (e.hate_group.size == 1 and !e.hate_group.include?(0))
				#Get the hate enemies
				for enemy in @enemies.values
					next if enemy == nil or enemy == e or !e.hate_group.include?(enemy.enemy_id) or
					!in_range?(e.event, enemy.event, e.hear_range+d) or enemy.dead?
					#Insert in to the list if the enemy is in hate group
					enemies.push(enemy)
				end
			end
			#Return False
			if enemies == nil or enemies == []
				return false 
			end
			
			#Order the enemies
			if !e.closest_enemy
				#Order from hate points
				enemies.sort! {|a,b|
					e.hate_points[b.event_id] - e.hate_points[a.event_id] }
			else
				enemies.sort! {|a,b|
					get_range(e.event,a.event) - get_range(e.event,b.event) }
			end
			
			#Add to enemy attack list
			e.attacking = enemies[0]
			#Enemy is now in battle
			e.in_battle = true
			#Setup the movement
			setup_movement(e)
			#Return true
			
			return true
		end
		
		#--------------------------------------------------------------------------
		# * Enemy Ally in_battle?(Enemy)
		#--------------------------------------------------------------------------
		def enemy_ally_in_battle?(enemy) # 동료가 전투중인가?
			#Start list
			allies = []
			#Get all allies
			for ally in @enemies.values
				#Skip NIL Value or value is in hate group
				next if ally == nil or enemy.hate_group.include?(ally.enemy_id)
				#Skip if the ally is not in_battle or the enemy can't see ally
				next if !ally.in_battle or !in_range?(enemy.event, ally.event, enemy.see_range)
				#Skip if the enemy can't hear ally
				next if !in_range?(enemy.event, ally.event, enemy.hear_range)
				#Skip if is player and can't be player
				next if ally.attacking == $game_player and !enemy.hate_group.include?(0)
				#Add to enemy attack list
				enemy.attacking = ally.attacking
				#Enemy is now in battle
				enemy.in_battle = true
				#Setup the movement
				setup_movement(enemy)
				#Return True
				return true
			end
			#Return False
			return false
		end
		
		#--------------------------------------------------------------------------
		# * Get Range(Element, Object) - Near Fantastica
		#--------------------------------------------------------------------------
		def get_range(element, object)
			x = (element.x - object.x) * (element.x - object.x)
			y = (element.y - object.y) * (element.y - object.y)
			r = x + y
			#r = Math.sqrt(r)
			return r.to_i
		end
		#--------------------------------------------------------------------------
		# * Checks the object range
		#--------------------------------------------------------------------------
		def in_screen?(object)
			screne_x = $game_map.display_x 
			screne_x -= 256
			screne_y = $game_map.display_y
			screne_y -= 256
			screne_width = $game_map.display_x 
			screne_width += 2816
			screne_height = $game_map.display_y
			screne_height += 2176
			return false if object.real_x <= screne_x
			return false if object.real_x >= screne_width
			return false if object.real_y <= screne_y
			return false if object.real_y >= screne_height
			return true
		end
		#--------------------------------------------------------------------------
		# * In Range?(Element, Object, Range) - Near Fantastica
		#--------------------------------------------------------------------------
		def in_range?(element, object, range)
			x = (element.x - object.x) * (element.x - object.x)
			y = (element.y - object.y) * (element.y - object.y)
			r = x + y
			return true if r <= (range * range)
			return false
		end
		#--------------------------------------------------------------------------
		# * Get ALL Range(Element, Range)
		#--------------------------------------------------------------------------
		def get_all_range(element, range)
			objects = []
			for e in @enemies.values
				objects.push(e) if in_range?(element, e.event, range)
			end
			return objects
		end
		
		#--------------------------------------------------------------------------
		# * 범위 안에 다른 유저를 포함한다. (Element, Range)
		#--------------------------------------------------------------------------
		def get_all_range_net(element, range)
			# 여기서 넷 플레이어인지 확인해야함
			objects = []
			for player in Network::Main.mapplayers.values
				next if player == nil
				objects.push(player) if in_range?(element, player, range)
			end
			return objects
		end
		
		#--------------------------------------------------------------------------
		# * In Direction?(Element, Object) - Near Fantastica
		#--------------------------------------------------------------------------
		def in_direction?(element, object)
			return true if element.direction == 2 and object.y >= element.y and object.x == element.x
			return true if element.direction == 4 and object.x <= element.x and object.y == element.y
			return true if element.direction == 6 and object.x >= element.x and object.y == element.y
			return true if element.direction == 8 and object.y <= element.y and object.x == element.x
			return false
		end
		
		#--------------------------------------------------------------------------
		# * Animate(object, name)
		#--------------------------------------------------------------------------
		def animate(object, name)
			object.set_animate(name)
		end
		#--------------------------------------------------------------------------
		# * End of class
		#--------------------------------------------------------------------------
	end
	
	#============================================================================
	# *  Range Base
	#============================================================================
	class Range_Base < Game_Character
		attr_accessor :range
		attr_accessor :draw
		attr_accessor :stop
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, attack)
			@step = 0
			@parent = parent
			@actor = actor
			@draw = true
			@stop  = false
			@range = 0
			@explosive = false
			@showing_ani = false
			super()
			@move_direction = @parent.direction
			@direction = @move_direction
			moveto(@parent.x, @parent.y)
		end
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			@character_name = @range_weapon[0]
			@move_speed = @range_weapon[1]
			@range = @range_weapon[4]
		end
		#--------------------------------------------------------------------------
		# * Force Movement
		#--------------------------------------------------------------------------
		def force_movement
			m = @move_direction
			@y += 1 if m == 1; @x -= 1 if m == 1
			@y += 1 if m == 2
			@y += 1 if m == 3; @x += 1 if m == 3
			@x -= 1 if m == 4
			@x += 1 if m == 6
			@y -= 1 if m == 7; @x -= 1 if m == 7
			@y -= 1 if m == 8
			@y -= 1 if m == 9; @x += 1 if m == 9
		end
		#--------------------------------------------------------------------------
		# * Update
		#-------------------------------------------------------------------------
		def update
			super
			return if @explosive
			#Return if moving
			return if moving?
			#Check if something is still here
			if @parent == nil or @actor == nil
				@stop = true
			end
			# Get new coordinates
			d = @move_direction
			new_x = @x
			new_x += -1 if d == 1 or d == 4 or d == 7
			new_x += 1 if d == 3 or d == 6 or d == 9
			
			new_y = @y
			new_y += 1 if d == 1 or d == 2 or d == 3
			new_y -= 1 if d == 7 or d == 8 or d == 9
			
			return @stop = true if @step > @range
			#Increase step
			@step += 1
			return force_movement if no_one?
			#return force_movement if $game_map.terrain_tag(new_x, new_y) == $ABS.PASS_TAG and no_one?
			m = @move_direction
			move_lower_left 	if m == 1
			move_down 				if m == 2
			move_lower_right 	if m == 3
			move_left 				if m == 4
			move_right 				if m == 6
			move_upper_left 	if m == 7
			move_up 					if m == 8
			move_upper_right 	if m == 9
			#Stop if it came to range
		end
		#--------------------------------------------------------------------------
		# * No One
		#-------------------------------------------------------------------------
		def no_one?
			#Get All Events
			objects = {}
			for event in $game_map.events.values
				next if event == nil
				objects[event.id] = event
			end
			objects[0] = $game_player
			# Get new coordinates
			d = @move_direction
			new_x = @x
			new_x += -1 if d == 1 or d == 4 or d == 7
			new_x += 1 if d == 3 or d == 6 or d == 9
			
			new_y = @y
			new_y += 1 if d == 1 or d == 2 or d == 3
			new_y -= 1 if d == 7 or d == 8 or d == 9
			#Get all pos
			for o in objects.values
				next if o == nil
				return false if o.x == new_x and o.y == new_y
			end
			
			# 여기서 넷 플레이어인지 확인해야함
			for player in Network::Main.mapplayers.values
				next if player == nil
				if player.x == new_x and player.y == new_y
					return false
				end
			end
			
			#Return False if no one was found
			return true
		end
	end
	#============================================================================
	# * Game Ranged Explode
	#============================================================================
	class Game_Ranged_Explode < Range_Base
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, skill, m_dir = -1, dummy = false)
			super(parent,actor,skill)
			@range_skill = $ABS.RANGE_EXPLODE[skill.id]
			@range = @range_skill[0]
			@opacity = 10 if @range == 1
			@move_speed = @range_skill[1]
			@character_name = @range_skill[2]
			@skill = skill
			@explosive = true
			@net_players = []
			if m_dir != -1
				@move_direction = m_dir
			end
			@dummy = dummy
			@hit_num = @range_skill[6] == nil ? 1 : [@range_skill[6], 1].max
		end
		#--------------------------------------------------------------------------
		# * Check Event Trigger Touch(x,y)
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			return
		end
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			super
			#Return if moving
			return if moving?
			#Check if something is still here
			if @parent == nil or @actor == nil
				@stop = true
			end
			# Get new coordinates
			d = @move_direction
			new_x = x + (d == 6 ? 1 : d == 4 ? -1 : 0)
			new_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
			
			return blow if @step > @range
			#Increase step
			@step += 1
			return force_movement if no_one?
			#return force_movement if $game_map.terrain_tag(new_x, new_y) == $ABS.PASS_TAG and no_one?
			m = @move_direction
			move_lower_left 	if m == 1
			move_down 				if m == 2
			move_lower_right 	if m == 3
			move_left 				if m == 4
			move_right 				if m == 6
			move_upper_left 	if m == 7
			move_up 					if m == 8
			move_upper_right 	if m == 9
			
		end
		#--------------------------------------------------------------------------
		# * In Range?(Element, Object, Range) - Near Fantastica
		#--------------------------------------------------------------------------
		def in_range?(element, object, range)
			x = (element.x - object.x) * (element.x - object.x)
			y = (element.y - object.y) * (element.y - object.y)
			r = x + y
			return true if r <= (range * range)
			return false
		end
		#--------------------------------------------------------------------------
		# * Get ALL Range(Element, Range)
		#--------------------------------------------------------------------------
		def get_all_range(element, range)
			objects = []
			for e in $ABS.enemies.values
				#Skip NIL values
				next if e == nil
				#Skip 이미 적이 죽은거면 넘어가
				next if e.dead?
				# Skip if the enemy is an ally and can't hurt allies.
				next if !CAN_HURT_ALLY and e.hate_group.include?(0)
				next if !e.hate_group.include?(0) and @parent.is_a?(Game_Player) # 나에게 적이 아닌 몬스터는 포함x
				if in_range?(element, e.event, range)
					objects.push(e) 
				end
			end
			
			# 여기서 넷 플레이어인지 확인해야함
			for player in Network::Main.mapplayers.values
				next if player == nil
				@net_players.push(player) if in_range?(element, player, range)
			end
			
			# 여기다가 개수 추가
			objects.push($game_player) if in_range?(element, $game_player, range)
			return objects
		end
		#--------------------------------------------------------------------------
		# * Blow
		#--------------------------------------------------------------------------
		def blow
			#Stop
			@stop = true
			return if @dummy
			#Play Animation
			#Show animation on event
			self.animation_id = @skill.animation2_id
			@showing_ani = true
			#Get Everyone in Range of the Explosive Skill
			objects = get_all_range(self, @range_skill[3])
			
			if objects.include?($game_player)
				hit_player 
				objects.delete($game_player)
			end
			
			#Hit Enemies
			for e in objects
				next if e == nil
				#Hit
				hit_event(e.event_id)
			end
			
			for p in @net_players
				next if p == nil
				hit_net_player(p)
			end
			
			if objects.size > 0 or @net_players.size > 0
				$rpg_skill.skill_cost_custom(@actor, @skill.id) # 스킬 코스트
			end
		end
		
		#--------------------------------------------------------------------------
		# * Hit net_Player
		#--------------------------------------------------------------------------
		def hit_net_player(actor)
			@stop = true
			#Show animation on event
			$ani_character[actor.netid.to_i].animation_id = @skill.animation2_id
			# 해당 대상 애니메이션 재생하도록 보냄
			Network::Main.ani(actor.netid, @skill.animation2_id)
			Network::Main.socket.send("<skill_effect>#{actor.name},#{@skill.id}</skill_effect>\n")	# if $game_switches[302] # pk on
		end 
		
		
		#--------------------------------------------------------------------------
		# * Hit Player
		#--------------------------------------------------------------------------
		def hit_player
			return if @dummy
			return if @parent.is_a?(Game_Player) and @actor == $game_party.actors[0]
			@stop = true
			#Get Actor
			actor = $game_party.actors[0]
			#Get Enemy
			enemy = @actor
			#Attack Actor
			@hit_num.times{
				actor.effect_skill(enemy, @skill) if enemy != nil 
			}
			
			$rpg_skill.skill_cost_custom(enemy, @skill.id) # 스킬 코스트 
			
			$game_player.animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
			Network::Main.ani(Network::Main.id, @skill.animation2_id)
			#Jump
			$ABS.jump($game_player,self,$ABS.RANGE_EXPLODE[@skill.id][5]) if actor.damage != "Miss" and actor.damage != 0
			#Check if enemy is dead
			$ABS.enemy_dead?(actor, enemy)
		end  
		#--------------------------------------------------------------------------
		# * Object Initialization 요기
		#--------------------------------------------------------------------------
		def hit_event(id)
			@stop = true
			#Get enemy
			actor = $ABS.enemies[id]
			#Return if actor has NIL value
			return if actor == nil or actor.hp == 0
			return if @actor == actor
			
			#If the parent is player
			if @parent.is_a?(Game_Player)
				#Get enemy
				enemy = $game_party.actors[0]
				#Attack It's enemy
				
				@hit_num.times{
					actor.event.animation_id = @skill.animation2_id
					actor.effect_skill(enemy, @skill)
					actor.event.ani_array.push(actor.event.animation_id)
					Network::Main.ani(actor.event.id, actor.event.animation_id, 1) #몬스터 대상의 애니매이션 공유
				}
				
				#$ABS.jump(e.event,self,$ABS.RANGE_EXPLODE[@skill.id][5]) if actor.damage != "Miss" and actor.damage != 0
				return if $ABS.enemy_dead?(actor, enemy)
				return if !actor.hate_group.include?(0)
				#Put enemy in battle
				actor.in_battle = true
				actor.attacking = $game_player
				$ABS.setup_movement(actor)
				return
			end
			
			#Get enemy
			enemy = $ABS.enemies[@parent.id]
			return if enemy == nil
			#Attack It's enemy
			@hit_num.times{
				actor.effect_skill(enemy, @skill)
			}
			#Show animation on event
			if actor.damage != "Miss" and actor.damage != 0
				actor.event.animation_id = @skill.animation2_id 
				Network::Main.ani(actor.event.id, @skill.animation2_id, 1) #몬스터 대상의 애니매이션 공유
			end
			
			#Jump
			e=actor
			$ABS.jump(e.event,self,$ABS.RANGE_EXPLODE[@skill.id][5]) if actor.damage != "Miss" and actor.damage != 0
			#return if enemy is dead
			return if $ABS.enemy_dead?(actor, enemy)
			return if !actor.hate_group.include?(enemy.enemy_id)
			actor.in_battle = true
			actor.attacking = enemy
			$ABS.setup_movement(actor)
		end
	end
	
	#============================================================================
	# * Game Ranged Skill
	#============================================================================
	class Game_Ranged_Skill < Range_Base
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, skill, m_dir = -1, dummy = false) # 만약 더미라면 그냥 스킬 효과 안나고 통과하도록 하게 해보자
			super(parent, actor, skill)
			@range_skill = $ABS.RANGE_SKILLS[skill.id]
			@range = @range_skill[0]
			@opacity = 20 if @range == 1
			@move_speed = @range_skill[1]
			@character_name = @range_skill[2]
			@skill = skill
			if m_dir != -1
				@move_direction = m_dir
			end
			@dummy = dummy
			@hit_num = @range_skill[5] == nil ? 1 : [@range_skill[5], 1].max
		end
		#--------------------------------------------------------------------------
		# * Check Event Trigger Touch(x,y)
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			return if @stop
			return if @dummy
			hit_player if x == $game_player.x and y == $game_player.y
			
			# 여기서 넷 플레이어인지 확인해야함
			for player in Network::Main.mapplayers.values
				next if player == nil
				if player.x == x and player.y == y
					hit_net_player(player)
				end
			end
			
			for event in $game_map.events.values
				if event.x == x and event.y == y
					if event.character_name == "" or ($ABS.enemies[event.id] != nil and $ABS.enemies[event.id].dead?) or event.erased
						force_movement
					else
						hit_event(event.id)
					end
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * Hit net_Player
		#--------------------------------------------------------------------------
		def hit_net_player(actor)
			@stop = true
			
			if @skill.id == 138
				$rpg_skill.비영승보(x, y, @move_direction)
			end
			
			# 해당 대상 애니메이션 재생하도록 보냄
			$ani_character[actor.netid.to_i].animation_id = @skill.animation2_id
			Network::Main.ani(actor.netid, @skill.animation2_id) #유저 애니매이션 공유
			Network::Main.socket.send("<skill_effect>#{actor.name},#{@skill.id}</skill_effect>\n")	# if $game_switches[302] # pk on
			$rpg_skill.skill_cost_custom(@actor, @skill.id) # 스킬 자원 소모
		end 
		
		
		#--------------------------------------------------------------------------
		# * Hit Player
		#--------------------------------------------------------------------------
		def hit_player
			@stop = true
			#Get Actor
			actor = $game_party.actors[0]
			#Get Enemy
			enemy = @actor
			return if enemy == nil
			#Attack Actor
			# 만약 내게 호의적인 적이라면 무시
			if enemy.is_a?(ABS_Enemy) and actor.is_a?(Game_Actor)
				return if !enemy.hate_group.include?(0)
			end
			
			hit_bool = false
			@hit_num.times{
				actor.effect_skill(enemy, @skill)
				hit_bool = true if actor.damage != "Miss" and actor.damage != 0
			}
			
			$rpg_skill.skill_cost_custom(enemy, @skill.id)
			
			#Show animation on player
			if hit_bool
				$game_player.animation_id = @skill.animation2_id 
				Network::Main.ani(Network::Main.id, $game_player.animation_id) #몬스터 대상의 애니매이션 공유
			end
			
			#Jump
			$ABS.jump($game_player, self, @range_skill[4]) if hit_bool and @range_skill[4] != 0
			#Check if enemy is dead
			$ABS.enemy_dead?(actor, enemy)
		end  
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def hit_event(id)
			@stop = true
			#Get enemy
			actor = $ABS.enemies[id]
			#Return if actor has NIL value
			return if actor == nil
			#If the parent is player
			if @parent.is_a?(Game_Player)
				#Get enemy
				enemy = $game_party.actors[0]
				# 만약 내게 호의적인 적이라면 무시
				if actor.is_a?(ABS_Enemy) and enemy.is_a?(Game_Actor)
					return if !actor.hate_group.include?(0)
				end
				#Show animation on event
				@enani = actor.event
				
				#Attack It's enemy
				@hit_num.times{
					@enani.animation_id = @skill.animation2_id
					actor.effect_skill(enemy, @skill)
					@enani.ani_array.push(@enani.animation_id)
					Network::Main.ani(@enani.id, @enani.animation_id, 1)
				}
				
				$rpg_skill.skill_cost_custom(enemy, @skill.id) # 스킬 코스트 
				
				if @skill.id == 138 # 무형검
					$rpg_skill.비영승보(x, y, @move_direction)
				end
				
				#Jump
				$ABS.jump(@enani, $game_player, @range_skill[4]) if actor.damage != "Miss" and actor.damage != 0 and @range_skill[4] != 0
				
				return if $ABS.enemy_dead?(actor, enemy)
				return if !actor.hate_group.include?(0)
				#Put enemy in battle
				actor.in_battle = true
				actor.attacking = $game_player
				$ABS.setup_movement(actor)				
				return
			end
			
			#Get enemy
			enemy = $ABS.enemies[@parent.id]
			return if enemy == nil
			# 적끼리 싸우는게 아니면 무시
			if enemy.is_a?(ABS_Enemy) and actor.is_a?(ABS_Enemy)
				return if !actor.hate_group.include?(enemy.id)
			end
			
			#Attack It's enemy
			@hit_num.times{
				actor.effect_skill(enemy, @skill)	
			}
			
			$rpg_skill.skill_cost_custom(enemy, @skill.id) # 스킬 코스트 
			
			#Show animation on event
			@enani = actor.event
			if actor.damage != "Miss" and actor.damage != 0
				actor.event.animation_id = @skill.animation2_id 
				Network::Main.ani(@enani.id, @skill.animation2_id, 1)
			end
			
			#Jump
			$ABS.jump($game_map.events[id], self, @range_skill[4]) if actor.damage != "Miss" and actor.damage != 0 and @range_skill[4] > 0
			#return if enemy is dead
			return if $ABS.enemy_dead?(actor, enemy)
			return if !actor.hate_group.include?(enemy.enemy_id)
			actor.in_battle = true
			actor.attacking = enemy
			$ABS.setup_movement(actor)
		end
	end
	#============================================================================
	# * Game Ranged Weapons
	#============================================================================
	class Game_Ranged_Weapon < Range_Base
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, attack)
			super(parent,actor,attack)
			@range_weapon = $ABS.RANGE_WEAPONS[attack]
			@character_name = @range_weapon[0]
			@move_speed = @range_weapon[1]
			@range = @range_weapon[4]
		end
		#--------------------------------------------------------------------------
		# * Check Event Trigger Touch(x,y)
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			return if @stop
			hit_player if x == $game_player.x and y == $game_player.y
			for event in $game_map.events.values
				next if event.x != x or event.y != y
				if event.character_name == "" or ($ABS.enemies[event.id] != nil and $ABS.enemies[event.id].dead?) or event.erased
					force_movement
				else
					hit_event(event.id)
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Hit Player
		#--------------------------------------------------------------------------
		def hit_player
			@stop = true
			#Get Actor
			actor = $game_party.actors[0]
			#Get Enemy
			enemy = @actor
			#Attack Actor 적이 플레이어를 공격함
			actor.attack_effect(enemy)
			# 여기다가 플레이어 데미지 보여주기 하면 될듯?
			damage(actor.damage, actor.critical) if actor.damage != 0
			
			#Show animation on player
			$game_player.animation_id = @range_weapon[2] if actor.damage != "Miss" and actor.damage != 0
			#jump
			#$ABS.jump($game_player, self, @range_weapon[6]) if actor.damage != "Miss" and actor.damage != 0
			#Check if enemy is dead
			$ABS.enemy_dead?(actor, enemy)
		end  
		#--------------------------------------------------------------------------
		# * Object Initialization   범위 무기 ( 표창 같은거)
		#--------------------------------------------------------------------------
		def hit_event(id)
			@stop = true
			#Get enemy
			actor = $ABS.enemies[id]
			#Return if actor has NIL value
			return if actor == nil or actor.dead?
			#If the parent is player
			if @parent.is_a?(Game_Player)
				#Get enemy
				enemy = $game_party.actors[0]
				#Attack It's enemy
				actor.attack_effect(enemy)
				#Show animation on event
				actor.event.animation_id = @range_weapon[2] if actor.damage != "Miss" and actor.damage != 0
				
				#jump
				#$ABS.jump(actor.event, self, @range_weapon[6]) if actor.damage != "Miss" and actor.damage != 0
				return if $ABS.enemy_dead?(actor, enemy)
				return if !actor.hate_group.include?(0)
				#Put enemy in battle
				actor.in_battle = true
				actor.attacking = $game_player
				$ABS.setup_movement(actor)
				return
			end
			#Get enemy
			enemy = $ABS.enemies[@parent.id]
			#Attack It's enemy
			actor.attack_effect(enemy)
			#Show animation on event
			actor.event.animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
			#$ABS.jump(actor.event, self, @range_weapon[6]) if actor.damage != "Miss" and actor.damage != 0
			#return if enemy is dead
			return if $ABS.enemy_dead?(actor, enemy)
			return if !actor.hate_group.include?(enemy.enemy_id)
			actor.in_battle = true
			actor.attacking = enemy
			$ABS.setup_movement(actor)
		end
	end
	#============================================================================
	# *  Game Event 
	#============================================================================
	class Game_Event < Game_Character
		attr_reader   :event
		attr_accessor :erased
		attr_reader   :page
		#--------------------------------------------------------------------------
		# * Alias
		#--------------------------------------------------------------------------
		alias mrmo_abs_game_event_refresh_set_page refresh_set_page
		#--------------------------------------------------------------------------
		# * Event Name
		#--------------------------------------------------------------------------
		def name
			return @event.name
		end
		#--------------------------------------------------------------------------
		# * Event ID
		#--------------------------------------------------------------------------
		def id
			return @id
		end
		#--------------------------------------------------------------------------
		# * Refreshes Page
		#--------------------------------------------------------------------------
		def refresh_set_page
			mrmo_abs_game_event_refresh_set_page # == refresh_set_page
			$ABS.refresh(self, @list, @character_name) # 한 맵에 있는 이벤트 리스트를 보내줌
			
		end
	end
	#============================================================================
	# * Scene Load
	#============================================================================
	class Scene_Load < Scene_File
		#--------------------------------------------------------------------------
		alias mrmo_abs_scene_load_read_data read_data
		#--------------------------------------------------------------------------
		def read_data(file)
			mrmo_abs_scene_load_read_data(file)
			$ABS = Marshal.load(file)  
			# Change Animation Size
			for an in $data_animations
				next if an == nil
				frames = an.frames
				for i in 0...frames.size
					for j in 0...frames[i].cell_max
						frames[i].cell_data[j, 1] /= $ABS.ANIMATION_DIVIDE
						frames[i].cell_data[j, 2] /= $ABS.ANIMATION_DIVIDE
						frames[i].cell_data[j, 3] /= $ABS.ANIMATION_DIVIDE
					end
				end
			end
		end
	end
	#============================================================================
	# * Scene Save
	#============================================================================
	class Scene_Save < Scene_File
		#--------------------------------------------------------------------------
		alias mrmo_abs_scene_save_write_data write_data
		#--------------------------------------------------------------------------
		def write_data(file)
			mrmo_abs_scene_save_write_data(file)
			Marshal.dump($ABS, file)
		end
	end
	#============================================================================
	# * Scene Title
	#============================================================================
	class Scene_Title
		#--------------------------------------------------------------------------
		alias mrmo_abs_scene_title_cng command_new_game
		#--------------------------------------------------------------------------
		# * Command: New Game
		#--------------------------------------------------------------------------
		def command_new_game
			$ABS = MrMo_ABS.new    
			# Change Animation Size
			for an in $data_animations
				next if an == nil
				frames = an.frames
				for i in 0...frames.size
					for j in 0...frames[i].cell_max
						frames[i].cell_data[j, 1] /= $ABS.ANIMATION_DIVIDE
						frames[i].cell_data[j, 2] /= $ABS.ANIMATION_DIVIDE
						frames[i].cell_data[j, 3] /= $ABS.ANIMATION_DIVIDE
					end
				end
			end
			mrmo_abs_scene_title_cng 
		end
	end
	#============================================================================
	# * Scene Map
	#============================================================================
	class Scene_Map
		#--------------------------------------------------------------------------
		alias mrmo_abs_scene_map_update update
		alias mrmo_abs_scene_map_transfer_player transfer_player
		#--------------------------------------------------------------------------
		def update
			$ABS.update
			mrmo_abs_scene_map_update
		end
		#--------------------------------------------------------------------------
		# * Player Place Move
		#--------------------------------------------------------------------------
		def transfer_player
			$ABS.enemies = {} if $game_map.map_id != $game_temp.player_new_map_id
			mrmo_abs_scene_map_transfer_player
		end
	end
	#============================================================================
	# * Game Player
	#============================================================================
	class Game_Player
		#--------------------------------------------------------------------------
		alias mrmo_abs_game_player_initialize initialize
		alias mrmo_abs_game_player_upm update_player_movement
		alias mrmo_sbabs_game_player_update update
		#--------------------------------------------------------------------------
		attr_accessor :event_id
		attr_accessor :event
		attr_accessor :actor
		attr_accessor :enemy_id
		attr_accessor :in_battle
		attr_accessor :movable
		def initialize
			super
			@event_id = 0
			@event = self
			@enemy_id = 0
			@actor = $game_party.actors[0]
			@in_battle = false
			@movable = true
			mrmo_abs_game_player_initialize
		end
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			# Record leader actor.
			@actor = $game_party.actors[0]
			mrmo_sbabs_game_player_update
		end
		#--------------------------------------------------------------------------
		# * Player Movement Update
		#--------------------------------------------------------------------------
		def update_player_movement
			return if !@movable
			mrmo_abs_game_player_upm
		end
	end
	#============================================================================
	# * RPG::Sprite
	#============================================================================
	module RPG
		class Sprite < ::Sprite
			attr_accessor :_damage_duration
			attr_accessor :_damage_duration_max
			attr_accessor :_max_height
			attr_accessor :_damage_string 
			
			def initialize(viewport = nil)
				super(viewport)
				@_whiten_duration = 0
				@_appear_duration = 0
				@_escape_duration = 0
				@_collapse_duration = 0
				@_collapse_erase_duration = 0
				@_damage_duration = 0
				@_damage_duration_max = 0
				@_damage_sprite = []
				
				@_animation_duration = 0
				@_blink = false
				@force_opacity = false
				@stop_animation = true
				@_max_height = 0
				@_damage_string = ""
			end
			
			def stop_animation?
				return @stop_animation 
			end
			
			#-------------------------------------------------------------------------
			# update
			#-------------------------------------------------------------------------
			def update
				super
				if @_whiten_duration > 0
					@_whiten_duration -= 1
					self.color.alpha = 128 - (16 - @_whiten_duration) * 10
				end
				if @_appear_duration > 0
					@_appear_duration -= 1
					self.opacity = (16 - @_appear_duration) * 16
				end
				if @_escape_duration > 0
					@_escape_duration -= 1
					self.opacity = 256 - (32 - @_escape_duration) * 10
				end
				if @_collapse_duration > 0
					@_collapse_duration -= 1
					self.opacity = 256 - (48 - @_collapse_duration) * 6
				end
				
				update_damage_view if @_damage_sprite.size > 0
				
				if @_animation != nil and (Graphics.frame_count % 2 == 0)
					@_animation_duration -= 1
					update_animation
				end
				if @_loop_animation != nil and (Graphics.frame_count % 2 == 0)
					update_loop_animation
					@_loop_animation_index += 1
					@_loop_animation_index %= @_loop_animation.frame_max
				end
				
				if @_blink
					@_blink_count = (@_blink_count + 1) % 32
					if @_blink_count < 16
						alpha = (16 - @_blink_count) * 6
					else
						alpha = (@_blink_count - 16) * 6
					end
					self.color.set(255, 255, 255, alpha)
				end
				@@_animations.clear
				
				if @_animation != nil and (Graphics.frame_count % 10 == 0)
					@_animation_duration += 1
				end
				
				#Update Duration
				if @_collapse_erase_duration > 0
					@_collapse_erase_duration -= 1
					@force_opacity = true
					# 불투명도 조절
					self.opacity = 256 - (36 - @_collapse_erase_duration) * 10
					@force_opacity = false
					if @_collapse_erase_duration == 0
						@collapse_character.character_name = ""
						self.opacity = 256
						self.color.set(0, 0, 0, 0) # 검은색으로 만듦
						self.blend_type = 0
						@collapse_character.erase # 이벤트 삭제
					end
				end
			end
			
			#--------------------------------------------------------------------------
			# * update damage view, 데미지 표시 효과 설정
			#--------------------------------------------------------------------------
			def update_damage_view
				count = 0
				if @_damage_sprite.size > 5
					dispose_damage(@_damage_sprite.first)
				end
				
				for sprite in @_damage_sprite
					if sprite._damage_duration > 0
						sprite._damage_duration -= 1
						if sprite._damage_duration == 0
							dispose_damage(sprite)
							next
						end
						
						tempY = self.y - 20
						time = sprite._damage_duration_max - sprite._damage_duration
						
						sprite.x = self.x - sprite.ox
						sprite.y = [tempY - time * 4, tempY - 10 * count - 60].max
						
						count += 1
					end
				end
			end
			
			#--------------------------------------------------------------------------
			# * 데미지 삭제
			#--------------------------------------------------------------------------
			def dispose_damage(sprite = nil)
				if sprite != nil
					@_damage_sprite.delete(sprite)
					sprite.visible = false
					sprite.bitmap.dispose
					sprite.dispose
					sprite = nil
				else
					if @_damage_sprite != nil
						for sprite in @_damage_sprite
							@_damage_sprite.delete(sprite)
							sprite.visible = false
							sprite.bitmap.dispose
							sprite.dispose
							sprite = nil
						end
					end
				end
			end
			
			#--------------------------------------------------------------------------
			# * Collapse and Erase
			#--------------------------------------------------------------------------
			def collapse_erase(character)
				self.blend_type = 1
				self.color.set(255, 64, 64, 255)
				self.opacity = 255
				@collapse_character = character
				@_collapse_erase_duration = 36
				@_collapse_duration = 0
				@_whiten_duration = 0
				@_appear_duration = 0
				@_escape_duration = 0
				@_loop_animation = nil
				dispose_loop_animation
			end
			#--------------------------------------------------------------------------
			# * Opacity
			#--------------------------------------------------------------------------
			def opacity=(o)
				return if @_collapse_erase_duration > 0 and !@force_opacity
				super(o)
			end
			#--------------------------------------------------------------------------
			# * Damage  데미지를 표시하는 부분
			#--------------------------------------------------------------------------
			def damage(value, critical)
				type = $game_variables[60] # 데미지 표시 타입
				#dispose_damage
				if value.is_a?(Numeric)
					damage_string = value.abs.to_s
				else
					damage_string = value.to_s
				end
				damage_string = change_number_unit(damage_string, type) if damage_string.to_i > 0
				
				bitmap = Bitmap.new(self.width, self.height)
				bitmap.font.name = $ABS.DAMAGE_FONT_NAME
				bitmap.font.size = critical == true ? 25 : $ABS.DAMAGE_FONT_SIZE 
				bitmap.font.color = $ABS.DAMAGE_FONT_COLOR
				# draw_text(x, y, width, height, string, align)
				
				y = self.height / 4 
				
				bitmap.draw_text(-1, y-1, 200, 36, damage_string, 0)
				bitmap.draw_text(+1, y-1, 200, 36, damage_string, 0)
				bitmap.draw_text(-1, y+1, 200, 36, damage_string, 0)
				bitmap.draw_text(+1, y+1, 200, 36, damage_string, 0)
				
				# 폰트 칼라 색
				if value.is_a?(Numeric) and value < 0
					bitmap.font.color.set(176, 255, 144)
				else
					bitmap.font.color.set(255, 255, 255) # 흰색
				end
				
				bitmap.font.color.set(255, 0, 51) if critical # 빨간색 
				bitmap.font.color.set(255, 255, 255) if !critical # 흰색	
				bitmap.font.color.set(102, 255, 102) if critical.to_s == "heal" # 연두색
				
				bitmap.draw_text(0, y, 200, 36, damage_string, 0)
				
				sprite = Sprite.new(self.viewport)
				sprite.bitmap = bitmap
				sprite.oy = self.oy
				sprite.ox = sprite.bitmap.text_size(damage_string).width / 4
				sprite.x = self.x - sprite.ox
				sprite._damage_string = damage_string
				sprite.y = self.y - self.oy
				sprite.z = 3000
				sprite._damage_duration = 50
				sprite._damage_duration_max = sprite._damage_duration
				
				@_damage_sprite.push(sprite)
			end
		end
	end
	#==============================================================================
	# ** Sprite_Character
	#------------------------------------------------------------------------------
	#  This sprite is used to display the character.It observes the Game_Character
	#  class and automatically changes sprite conditions.
	#==============================================================================
	class Sprite_Character < RPG::Sprite
		#--------------------------------------------------------------------------
		alias mrmo_abs_sc_int initialize
		alias mrmo_abs_sc_update update
		alias mrmo_abs_sc_dispose dispose
		#--------------------------------------------------------------------------
		# * Object Initialization
		#     viewport  : viewport
		#     character : character (Game_Character)
		#--------------------------------------------------------------------------
		def initialize(viewport, character = nil)
			@state_animation_id = 0
			@page = nil
			mrmo_abs_sc_int(viewport, character)
		end
		#--------------------------------------------------------------------------
		# * Dispose
		#--------------------------------------------------------------------------
		def dispose
			# End every animation and update
			if @_collapse_erase_duration > 0
				@collapse_character.character_name = ""
				self.opacity = @character.opacity
				self.blend_type = @character.blend_type
				self.bush_depth = @character.bush_depth
				self.color.set(0, 0, 0, 0)
				@collapse_character.erase
				@_collapse_erase_duration = 0
			end
			dispose_loop_animation
			super
		end
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			for sprite in @_damage_sprite
				if sprite != nil and !sprite.disposed? and sprite._damage_duration <= 0
					dispose_damage(sprite)
				end
			end
			mrmo_abs_sc_update
			
			#Skip if no demage or dead;
			if !@character.is_a?(Game_Player) and $ABS.enemies[@character.id] != nil
				#Show State Animation 상태 애니메이션
				id = @character.id
				if $ABS.enemies[id].damage == nil and $ABS.enemies[id].state_animation_id != @state_animation_id
					@state_animation_id = $ABS.enemies[id].state_animation_id
					loop_animation($data_animations[@state_animation_id])
				end
			elsif @character.is_a?(Game_Player)
				a = $game_party.actors[0]
				#Show State Animation
				if a.damage == nil and a.state_animation_id != @state_animation_id
					@state_animation_id = a.state_animation_id
					loop_animation($data_animations[@state_animation_id])
				end
			end
			
			#Check fade
			if @character.fade
				if @character.is_a?(Game_Event) and @character.page != @page
					@page = @character.page
				elsif @character.is_a?(Game_Event) or @character.is_a?(Game_Player)
					collapse_erase(@character)
				end
				@character.fade = false
			end
			
			if @character.is_a?(Game_Event) and @character.page != @page
				@page = @character.page
			end
			
			id = @character.id
			#if demage not displayed
			if $ABS.damage_display
				#Skip if no demage or dead;
				if !@character.is_a?(Game_Player) and $ABS.enemies[id] != nil
					dmg_array = $ABS.enemies[id].damage_array
					cri_array = $ABS.enemies[id].critical_array
					if dmg_array != nil and dmg_array.size > 0
						for i in 0...dmg_array.size
							dmg = dmg_array[i]
							cri = cri_array[i]
							next if dmg == nil
							damage(dmg, cri) 
							# 몬스터 데미지 표시(맵 id, 몹 id, 데미지, 크리티컬)
							Network::Main.socket.send("<mon_damage>#{$game_map.map_id},#{id},#{dmg},#{cri}</mon_damage>\n")	if $ABS.enemies[id].send_damage
						end
					elsif $ABS.enemies[id].damage != nil
						damage($ABS.enemies[id].damage, $ABS.enemies[id].critical) 
						# 몬스터 데미지 표시(맵 id, 몹 id, 데미지, 크리티컬)
						Network::Main.socket.send("<mon_damage>#{$game_map.map_id},#{id},#{$ABS.enemies[id].damage},#{$ABS.enemies[id].critical}</mon_damage>\n")	if $ABS.enemies[id].send_damage						
					end
					
					#Make Damage nil
					$ABS.enemies[id].damage = nil
					$ABS.enemies[id].damage_array.clear
					$ABS.enemies[id].critical_array.clear
					$ABS.enemies[id].send_damage = true
					
				elsif @character.is_a?(Game_Player)					
					a = $game_party.actors[0]
					
					dmg_array = a.damage_array
					cri_array = a.critical_array
					if dmg_array != nil and dmg_array.size > 0
						for i in 0...dmg_array.size
							dmg = dmg_array[i]
							cri = cri_array[i]
							next if dmg == nil
							damage(dmg, cri) 
							# 사람 데미지 표시(맵 id, 네트워크 id, 데미지, 크리티컬)
							Network::Main.socket.send("<player_damage>#{$game_map.map_id},#{Network::Main.id},#{dmg},#{cri}</player_damage>\n")	
						end
						#Display damage
					elsif a.damage != nil
						damage(a.damage, a.critical) 
						# 사람 데미지 표시(맵 id, 네트워크 id, 데미지, 크리티컬)
						Network::Main.socket.send("<player_damage>#{$game_map.map_id},#{Network::Main.id},#{a.damage},#{a.critical}</player_damage>\n")	
					end
					#Make Damage nil
					a.damage = nil
					a.damage_array.clear
					a.critical_array.clear
				end
			end
			
			if @character.ani_array != nil and @character.ani_array.size > 1
				for ani in @character.ani_array
					animation = $data_animations[ani]
					animation2(animation, true)
				end
			end
			@character.ani_array.clear
		end
	end
	#==============================================================================
	# ** Spriteset_Map
	#------------------------------------------------------------------------------
	#  This class brings together map screen sprites, tilemaps, etc.
	#  It's used within the Scene_Map class.
	#==============================================================================
	class Spriteset_Map
		#--------------------------------------------------------------------------
		alias mrmo_spriteset_map_init_characters init_characters
		alias mrmo_spriteset_map_update_character_sprites update_character_sprites
		alias mrmo_spriteset_map_dispose dispose
		#--------------------------------------------------------------------------
		# * Character Sprite Initialization
		#--------------------------------------------------------------------------
		def init_characters
			mrmo_spriteset_map_init_characters
			# Make character sprites
			@ranged_sprites = []
			for range in $ABS.range
				#Skip NIL Values
				next if range == nil and !range.draw
				sprite = Sprite_Character.new(@viewport1, range)
				@ranged_sprites.push(sprite)
			end
		end
		#--------------------------------------------------------------------------
		# * Dispose
		#--------------------------------------------------------------------------
		def dispose
			# Dispose ranged sprites
			for range in @ranged_sprites
				#Skip NIL Values
				next if range == nil
				range.dispose
			end
			mrmo_spriteset_map_dispose
		end
		#--------------------------------------------------------------------------
		# * Update Character Sprites
		#--------------------------------------------------------------------------
		def update_character_sprites
			mrmo_spriteset_map_update_character_sprites
			# Update ranged sprites
			for range in @ranged_sprites
				#Skip NIL Values
				next if range == nil
				range.update
				#If its stop
				if range.character.stop and range.stop_animation?
					@ranged_sprites.delete(range)
					range.dispose
					$ABS.range.delete(range.character)
				elsif range.character.stop 
					range.character.character_name = ""
				end
			end
			
			# Draw Sprite
			for range in $ABS.range
				#Skip NIL Values
				next if range == nil or !range.draw
				
				#If its draw
				sprite = Sprite_Character.new(@viewport1, range)
				@ranged_sprites.push(sprite)
				range.draw = false
			end
		end
	end
	#==============================================================================
	# ** Game_Battler (part 3)
	#------------------------------------------------------------------------------
	#  This class deals with battlers. It's used as a superclass for the Game_Actor
	#  and Game_Enemy classes.
	#==============================================================================
	class Game_Battler
		attr_accessor :state_time
		attr_accessor :damage_array # 표시할 데미지를 모아두는 배열
		attr_accessor :critical_array # 표시할 크리티컬을 모아두는 배열
		attr_accessor :ani_array # 표시할 애니메이션 아이디를 모아두는 배열
		#--------------------------------------------------------------------------
		alias mrmo_abs_gb_int initialize
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize
			mrmo_abs_gb_int
			@state_time = 0
			@damage_array = []
			@critical_array = []
			@ani_array = []
		end
		
		#--------------------------------------------------------------------------
		# * Change 물리방어력
		#--------------------------------------------------------------------------
		def pdef=(pdef)
			@pdef = pdef
		end
		#--------------------------------------------------------------------------
		# * Change 마법방어력
		#--------------------------------------------------------------------------
		def mdef=(mdef)
			@mdef = mdef
		end
		
		#--------------------------------------------------------------------------
		# * Determine Usable Skills
		#     skill_id : skill ID
		#--------------------------------------------------------------------------
		def can_use_skill?(skill)
			# 여기다가 스킬 딜레이가 남아있으면 무시하도록 만들어보자
			return false if @skill_mash != nil and @skill_mash[skill.id] != nil and @skill_mash[skill.id] > 0
			
			# If there's not enough SP, the skill cannot be used.
			return false if skill.sp_cost > self.sp
			
			# Unusable if incapacitated
			return false if dead?
			
			# If silent, only physical skills can be used
			return false if skill.atk_f == 0 and self.restriction == 1
			
			
			# Get usable time
			occasion = skill.occasion
			case occasion
			when 0..1
				return true
			when 2..3
				return false
			end
		end
		#--------------------------------------------------------------------------
		# * Applying Normal Attack Effects
		#     attacker : battler
		#--------------------------------------------------------------------------
		def attack_effect(attacker)
			# 나한테 적이아니면 공격 못함
			if self.is_a?(ABS_Enemy) and attacker.is_a?(Game_Actor)
				return if !self.hate_group.include?(0)
			end
			# Clear critical flag
			self.critical = false
			# First hit detection
			
			# If hit occurs
			hit_result = true
			# 1차로 명중률을 계산함
			if hit_result == true
				# Calculate basic damage
				
				if self.is_a?(Game_Actor)
					atk = [(attacker.atk + attacker.str / 100.0) - (self.base_pdef * 2 / 5), (attacker.atk / 20.0)].max
				else
					atk = [(attacker.atk + attacker.str / 100.0) - (self.pdef * 2 / 5), (attacker.atk / 20.0)].max
				end
				self.damage = (atk * (20 + attacker.str) / 20.0)
				
				#self.damage = [((self.damage) * (1.0 - ([self.base_pdef, limit_v].min) / limit_v)).to_i, (self.damage * 0.1).to_i].max
				# Element correction
				if !attacker.is_a?(Game_NetPlayer)
					self.damage *= elements_correct(attacker.element_set)  # 기본 반환값이 100임
					self.damage /= 100 
				end
				
				self.damage = self.damage.to_i
				self.damage = 1 if self.damage <= 0
				# If damage value is strictly positive
				if self.damage > 0
					# Critical correction
					# 여기다가 크리티컬 확률 높힐 수도 있음
					if rand(100) < 5.0 * attacker.dex / self.agi
						self.damage *= 2
						self.critical = true
					end
					# Guard correction
					if self.guarding?
						self.damage /= 2
					end
				end
				
				# Dispersion
				if self.damage.abs > 0
					amp = [self.damage.abs * 15 / 100, 1].max
					self.damage += rand(amp+1) + rand(amp+1) - amp
				end
				# Second hit detection
				# agi : 민첩 (회피율), dex : 손재주 (명중률)
				# eva : 절대 회피율..
				a_dex = attacker.dex - attacker.dex * (self.eva / 150.0)
				#eva = [(8 * self.agi / attacker.dex + self.eva), 100].min
				eva = [(8 * self.agi / a_dex), 100].min
				
				hit = self.damage < 0 ? 100 : [100 - eva, 5].max
				hit = self.cant_evade? ? 100 : hit # 피할 수 없는 경우?
				
				hit_result = (rand(100) < hit)
			end
			
			# If hit occurs
			if hit_result == true
				# State Removed by Shock
				remove_states_shock
				# Substract damage from HP
				
				if self.is_a?(Game_Actor) and attacker.is_a?(ABS_Enemy)
					if $game_player.direction == attacker.event.direction
						self.damage *= 2
					end
				elsif attacker.is_a?(Game_Actor) and self.is_a?(ABS_Enemy)
					if self.event.direction == $game_player.direction
						self.damage *= 2
					end
				end
				
				# 최종 데미지 계산
				self.damage = $rpg_skill.damage_calculation_attack(self.damage, self, attacker)
				self.damage += $ABS.weapon_skill(attacker.weapon_id, self) # 특정 무기를 착용하면 추가 격 데미지가 있음
				
				r = rand(100)
				if r <= (self.damage * 100 / self.maxhp) or r <= 40
					if !self.is_a?(Game_Actor)
						$ABS.enemies[self.event.id].aggro = true if $ABS.enemies[self.event.id] != nil
						Network::Main.socket.send("<aggro>#{$game_map.map_id},#{self.event.id}</aggro>\n")
					end
				end
				
				self.hp -= self.damage
				@damage_array.push(self.damage)
				@critical_array.push(self.critical)
				
				return $ABS.player_dead?(self, attacker) if self.is_a?(Game_Actor)
				
				# 맵 id, 몹id, 몹 hp, x, y, 방향, 딜레이 시간
				if !self.is_a?(Game_Actor)
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{self.hp},#{self.event.x},#{self.event.y},#{self.event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<hp>#{$game_map.map_id},#{self.event.id},#{self.hp}</hp>\n")
				end
				# State change
				@state_changed = false
				if !attacker.is_a?(Game_NetPlayer)
					states_plus(attacker.plus_state_set)
					states_minus(attacker.minus_state_set)
				end
				# When missing
			else
				
				# Set damage to "Miss"
				self.damage = "Miss!"
				# Clear critical flag
				self.critical = false
			end
			# End Method
			return true
		end
		
		#--------------------------------------------------------------------------
		# * Apply Skill Effects
		#     user  : the one using skills (battler)
		#     skill : skill
		#--------------------------------------------------------------------------
		def effect_skill(user, skill)
			# 나한테 적이 아니면 공격 안하게 함
			if self.is_a?(ABS_Enemy) and user.is_a?(Game_Actor)
				return if !self.hate_group.include?(0)
			end
			if self.is_a?(ABS_Enemy) and user.is_a?(ABS_Enemy)
				return if self.id != user.id and !self.hate_group.include?(user.id)
			end
			
			# Clear critical flag
			self.critical = false
			# If skill scope is for ally with 1 or more HP, and your own HP = 0,
			# or skill scope is for ally with 0, and your own HP = 1 or more
			if ((skill.scope == 3 or skill.scope == 4) and self.hp == 0) or
				((skill.scope == 5 or skill.scope == 6) and self.hp >= 1)
				# End Method
				return false
			end
			
			# Clear effective flag
			effective = false
			# Set effective flag if common ID is effective
			effective |= skill.common_event_id > 0
			# First hit detection
			hit = skill.hit
			if skill.atk_f > 0
				hit *= user.hit / 100 if !user.is_a?(Game_NetPlayer)
			end
			
			# 스킬 명중률
			hit_result = (rand(10) < hit)
			# Set effective flag if skill is uncertain
			effective |= hit < 100
			
			# If hit occurs
			if hit_result == true
				# Calculate power
				power = skill.power + user.atk / 2
				power = $rpg_skill.skill_power_custom(user, skill.id, power)				
				power = (power * (1.0 + user.atk / 100.0))
				if power > 0
					power -= self.pdef * [skill.pdef_f, 10].max / 200
					power -= self.mdef * skill.mdef_f / 100
					power = [power, 1].max
				end
				
				# Calculate rate
				rate = 20
				rate += (user.str * skill.str_f / 100.0)
				rate += (user.dex * skill.dex_f / 100.0)
				rate += (user.agi * skill.agi_f / 100.0)
				rate += (user.int * skill.int_f / 100.0)
				# Calculate basic damage
				self.damage = (power * rate / 20.0)
				# Element correction
				self.damage *= elements_correct(skill.element_set)
				self.damage /= 100
				self.damage = self.damage.to_i
				
				# If damage value is strictly positive
				if self.damage > 0
					# Guard correction
					if self.guarding?
						self.damage /= 2
					end
				end
				
				self.damage = $rpg_skill.damage_by_skill(self.damage, skill.id, self)
				
				# 방어력에 따른 데미지 감소
				if self.damage > 0
					if self.is_a?(Game_Actor)
						limit = 400.0
						self.damage = [((self.damage) * (1.0 - ([self.base_pdef + self.base_mdef * 2, limit].min) / limit)).to_i, (self.damage * 0.1).to_i].max
					else
						limit = 2000.0
						self.damage = [((self.damage) * (1.0 - ([self.pdef + self.mdef * 2, limit].min) / limit)).to_i, (self.damage * 0.1).to_i].max
					end
				end
				
				# Dispersion
				if skill.variance > 0 and self.damage.abs > 0
					amp = [self.damage.abs * skill.variance / 100, 1].max
					self.damage += rand(amp+1) + rand(amp+1) - amp
				end
				
				# 여기서 최종 데미지 계산하기(버프 같은거 걸렸을 경우)
				self.damage = $rpg_skill.damage_calculation_skill(self.damage, self, user)
				temp = $ABS.weapon_skill(user.weapon_id, self)
				if temp > 0 
					self.critical = true
					self.damage += temp
				end
				
				# Second hit detection
				eva = [(8 * self.agi / user.dex + self.eva), 100].min
				hit = self.damage < 0 ? 100 : [(100 - eva * skill.eva_f / 100), 25].max
				hit = self.cant_evade? ? 100 : hit
				hit_result = (rand(100) < hit)
				# Set effective flag if skill is uncertain
				effective |= hit < 100
			end
			
			# If hit occurs
			if hit_result == true
				# If physical attack has power other than 0
				if skill.power != 0 and skill.atk_f > 0
					# State Removed by Shock
					remove_states_shock
					# Set to effective flag
					effective = true
				end
				
				# Substract damage from HP
				last_hp = self.hp
				self.hp -= self.damage
				@damage_array.push(self.damage)
				@critical_array.push(self.critical)
				
				
				r = rand(100)
				if r <= [(self.damage * 100 / self.maxhp), 30].max
					if !self.is_a?(Game_Actor) and $ABS.enemies[self.event.id] != nil
						
						self.aggro = true
						Network::Main.socket.send("<aggro>#{$game_map.map_id},#{self.event.id}</aggro>\n")
					end
				end
				
				return $ABS.player_dead?(self, user) if self.is_a?(Game_Actor)
				# 맵 id, 몹id, 몹 hp, x, y, 방향, 딜레이 시간
				if !self.is_a?(Game_Actor) and $ABS.enemies[self.event.id] != nil
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{self.hp},#{self.event.x},#{self.event.y},#{self.event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<hp>#{$game_map.map_id},#{self.event.id},#{self.hp}</hp>\n")
				end
				effective |= self.hp != last_hp
				# State change
				@state_changed = false
				effective |= states_plus(skill.plus_state_set)
				effective |= states_minus(skill.minus_state_set)
				
				if skill.power == 0
					self.damage = 1
					unless @state_changed
						self.damage = "Miss"
					end
				end
			else
				self.damage = "Miss"
			end
			return effective
		end
	end
	#==============================================================================
	# ** Game_Character (part 1)
	#------------------------------------------------------------------------------
	#  This class deals with characters. It's used as a superclass for the
	#  Game_Player and Game_Event classes.
	#==============================================================================
	class Game_Character
		attr_accessor :move_type
		attr_accessor :move_speed
		attr_accessor :move_frequency
		attr_accessor :character_name
		attr_accessor :animating
		attr_accessor :frame
		attr_accessor :fade
		attr_accessor :through # 겹치기 가능 여부
		attr_accessor :ani_array # 표시할 애니메이션 아이디를 모아두는 배열
		
		alias mrmo_abs_game_character_ini initialize
		def initialize
			mrmo_abs_game_character_ini
			@ani_array = []
		end
		
		#--------------------------------------------------------------------------
		# * Jump
		#     x_plus : x-coordinate plus value
		#     y_plus : y-coordinate plus value
		#--------------------------------------------------------------------------
		def jump_nt(x_plus, y_plus)
			# Calculate new coordinates
			new_x = @x + x_plus
			new_y = @y + y_plus
			# If plus value is (0,0) or jump destination is passable
			if (x_plus == 0 and y_plus == 0) or passable?(new_x, new_y, 0)
				# Straighten position
				straighten
				# Update coordinates
				@x = new_x
				@y = new_y
				# Calculate distance
				distance = Math.sqrt(x_plus * x_plus + y_plus * y_plus).round
				# Set jump count
				@jump_peak = 10 + distance - @move_speed
				@jump_count = @jump_peak * 1
				# Clear stop count
				@stop_count = 0
			end
		end
		#--------------------------------------------------------------------------
		# * Set Animation
		#--------------------------------------------------------------------------
		def set_animate(name)
			return if @animating
			@frame = 4
			@old_char = @character_name
			@character_name = name
			@animating = true
			@anim_wait = 40
			@pattern = 0
			@direction_fix = true
		end
		#--------------------------------------------------------------------------
		alias mrmo_abs_game_character_update update
		#--------------------------------------------------------------------------
		# * Frame Update
		#--------------------------------------------------------------------------
		def update
			return animate_pose if @animating
			mrmo_abs_game_character_update
		end
		#--------------------------------------------------------------------------
		# * Frame Update Pose
		#--------------------------------------------------------------------------
		def animate_pose
			if @anim_wait >= 8
				@pattern = (@pattern + 1) % 4
				@frame -= 1
				@anim_wait = 0
			end
			@anim_wait += 1 if @anim_wait < 18 - @move_speed * 2
			if @frame == 0
				end_animate
				return
			end
			update_jump if jumping?
		end
		#--------------------------------------------------------------------------
		# * End Animate
		#--------------------------------------------------------------------------
		def end_animate
			@animating = false
			@character_name = @old_char
			@direction_fix = false
		end
		
		#--------------------------------------------------------------------------
		# * Move Down
		#     turn_enabled : a flag permits direction change on that spot
		#--------------------------------------------------------------------------
		def move_down(turn_enabled = true, is_ok = false) # is_ok : 이동 가능
			if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil
				return if !is_ok and !$ABS.enemies[self.event.id].aggro # 내 어그로가 아니고 외부요인도 없으면 움직이지 않음
			end
			# Turn down
			if turn_enabled
				if @direction != 2
					turn_down
				end
			end
			# If passable
			return if self.is_a?(Game_Player) and Key.press?(KEY_CTRL)
			if passable?(@x, @y, 2)
				# Turn down
				turn_down
				# Update coordinates
				@y += 1
				# Increase steps
				increase_steps
				# If impassable
				# 이때 계속 몹 정보 보내주면?
				
				if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{$ABS.enemies[self.event.id].hp},#{self.x},#{self.y},#{$ABS.enemies[self.event.id].event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<mon_move>#{$game_map.map_id},#{self.event.id},#{@direction},#{self.x},#{self.y}</mon_move>\n")
				end
			else
				# Determine if touch event is triggered
				check_event_trigger_touch(@x, @y+1)
			end
		end
		#--------------------------------------------------------------------------
		# * Move Left
		#     turn_enabled : a flag permits direction change on that spot
		#--------------------------------------------------------------------------
		def move_left(turn_enabled = true, is_ok = false) # is_ok는 외부요인으로 옮기는거		
			if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil
				return if !is_ok and !$ABS.enemies[self.event.id].aggro # 내 어그로가 아니고 외부요인도 없으면 움직이지 않음
			end
			
			# Turn left
			if turn_enabled
				if @direction != 4
					turn_left
				end
			end
			return if self.is_a?(Game_Player) and Key.press?(KEY_CTRL)
			# If passable
			if passable?(@x, @y, 4)
				# Turn left
				turn_left
				# Update coordinates
				@x -= 1
				# Increase steps
				increase_steps
				# If impassable
				# 이때 계속 몹 정보 보내주면?
				if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{$ABS.enemies[self.event.id].hp},#{self.x},#{self.y},#{$ABS.enemies[self.event.id].event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<mon_move>#{$game_map.map_id},#{self.event.id},#{@direction},#{self.x},#{self.y}</mon_move>\n")
				end
			else
				# Determine if touch event is triggered
				check_event_trigger_touch(@x-1, @y)
			end
		end
		#--------------------------------------------------------------------------
		# * Move Right
		#     turn_enabled : a flag permits direction change on that spot
		#--------------------------------------------------------------------------
		def move_right(turn_enabled = true, is_ok = false)
			if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil
				return if !is_ok and !$ABS.enemies[self.event.id].aggro # 내 어그로가 아니고 외부요인도 없으면 움직이지 않음
			end
			
			# Turn left
			if turn_enabled
				if @direction != 6
					turn_right
				end
			end
			
			return if self.is_a?(Game_Player) and Key.press?(KEY_CTRL)
			# If passable
			if passable?(@x, @y, 6)
				# Turn right
				turn_right
				
				# Update coordinates
				@x += 1
				# Increase steps
				increase_steps
				# If impassable
				# 이때 계속 몹 정보 보내주면?
				if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{$ABS.enemies[self.event.id].hp},#{self.x},#{self.y},#{$ABS.enemies[self.event.id].event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<mon_move>#{$game_map.map_id},#{self.event.id},#{@direction},#{self.x},#{self.y}</mon_move>\n")
				end
			else
				# Determine if touch event is triggered
				check_event_trigger_touch(@x+1, @y)
			end
		end
		#--------------------------------------------------------------------------
		# * Move up
		#     turn_enabled : a flag permits direction change on that spot
		#--------------------------------------------------------------------------
		def move_up(turn_enabled = true, is_ok = false)
			if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil
				return if !is_ok and !$ABS.enemies[self.event.id].aggro # 내 어그로가 아니고 외부요인도 없으면 움직이지 않음
			end
			
			# Turn up
			if turn_enabled
				if @direction != 8
					turn_up
				end
			end
			
			return if self.is_a?(Game_Player) and Key.press?(KEY_CTRL)
			# If passable
			if passable?(@x, @y, 8)
				# Turn up
				turn_up
				
				# Update coordinates
				@y -= 1
				# Increase steps
				increase_steps
				# If impassable
				# 이때 계속 몹 정보 보내주면?
				if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{$ABS.enemies[self.event.id].hp},#{self.x},#{self.y},#{$ABS.enemies[self.event.id].event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<mon_move>#{$game_map.map_id},#{self.event.id},#{@direction},#{self.x},#{self.y}</mon_move>\n")
				end
			else
				# Determine if touch event is triggered
				check_event_trigger_touch(@x, @y-1)
			end
		end
		
		#--------------------------------------------------------------------------
		# * 대각선 이동
		# * Move Lower Left
		#--------------------------------------------------------------------------
		def move_lower_left
			# If no direction fix
			unless @direction_fix
				# Face down is facing right or up
				@direction = (@direction == 6 ? 4 : @direction == 8 ? 2 : @direction)
			end
			# When a down to left or a left to down course is passable
			if (passable?(@x, @y, 2) and passable?(@x, @y + 1, 4)) or
				(passable?(@x, @y, 4) and passable?(@x - 1, @y, 2))
				# Update coordinates
				@x -= 1
				@y += 1
				# Increase steps
				increase_steps
			else
				check_event_trigger_touch(@x - 1, @y + 1)
			end
		end
		#--------------------------------------------------------------------------
		# * Move Lower Right
		#--------------------------------------------------------------------------
		def move_lower_right
			# If no direction fix
			unless @direction_fix
				# Face right if facing left, and face down if facing up
				@direction = (@direction == 4 ? 6 : @direction == 8 ? 2 : @direction)
			end
			# When a down to right or a right to down course is passable
			if (passable?(@x, @y, 2) and passable?(@x, @y + 1, 6)) or
				(passable?(@x, @y, 6) and passable?(@x + 1, @y, 2))
				# Update coordinates
				@x += 1
				@y += 1
				# Increase steps
				increase_steps
			else
				check_event_trigger_touch(@x + 1, @y + 1)
				
			end
		end
		#--------------------------------------------------------------------------
		# * Move Upper Left
		#--------------------------------------------------------------------------
		def move_upper_left
			# If no direction fix
			unless @direction_fix
				# Face left if facing right, and face up if facing down
				@direction = (@direction == 6 ? 4 : @direction == 2 ? 8 : @direction)
			end
			# When an up to left or a left to up course is passable
			if (passable?(@x, @y, 8) and passable?(@x, @y - 1, 4)) or
				(passable?(@x, @y, 4) and passable?(@x - 1, @y, 8))
				# Update coordinates
				@x -= 1
				@y -= 1
				# Increase steps
				increase_steps
			else
				check_event_trigger_touch(@x - 1, @y - 1)
			end
		end
		#--------------------------------------------------------------------------
		# * Move Upper Right
		#--------------------------------------------------------------------------
		def move_upper_right
			# If no direction fix
			unless @direction_fix
				# Face right if facing left, and face up if facing down
				@direction = (@direction == 4 ? 6 : @direction == 2 ? 8 : @direction)
			end
			# When an up to right or a right to up course is passable
			if (passable?(@x, @y, 8) and passable?(@x, @y - 1, 6)) or
				(passable?(@x, @y, 6) and passable?(@x + 1, @y, 8))
				# Update coordinates
				@x += 1
				@y -= 1
				# Increase steps
				increase_steps
			else
				check_event_trigger_touch(@x + 1, @y - 1)
			end
		end
		
		#--------------------------------------------------------------------------
		# * Move at Random
		#--------------------------------------------------------------------------
		def move_random()
			if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
				return true if !$is_map_first
			end
			case rand(4)
			when 0  # Move down
				move_down()
			when 1  # Move left
				move_left()
			when 2  # Move right
				move_right()
			when 3  # Move up
				move_up()
			end
		end
		
		#--------------------------------------------------------------------------
		# * Move toward B
		#--------------------------------------------------------------------------
		def move_to(b)
			return if @stop_count <= (15 - @move_frequency * 2) * (6 - @move_frequency)
			#~ @stop_count = 0
			# Get difference in player coordinates
			sx = @x - b.x
			sy = @y - b.y
			# If coordinates are equal
			if sx == 0 and sy == 0
				return
			end
			# Get absolute value of difference
			abs_sx = sx > 0 ? sx : -sx
			abs_sy = sy > 0 ? sy : -sy
			# Branch by random numbers 0-5
			case rand(6)
			when 0..4  # Approach player
				# If horizontal and vertical distances are equal
				if abs_sx == abs_sy
					# Increase one of them randomly by 1
					rand(2) == 0 ? abs_sx += 1 : abs_sy += 1
				end
				# If horizontal distance is longer
				if abs_sx > abs_sy
					# Move towards player, prioritize left and right directions
					if sx > 0
						move_left()
					else
						move_right()
					end
					
					if not moving? and sy != 0
						if sy > 0
							move_up()
						else
							move_down()
						end
					end
					# If vertical distance is longer
				else
					# Move towards player, prioritize up and down directions
					if sy > 0
						move_up()
					else
						move_down()
					end
					if not moving? and sx != 0						
						if sx > 0
							move_left()
						else
							move_right()
						end
					end
				end
			when 5  # random
				move_random
			end
			#~ turn_to(b)
		end
		#--------------------------------------------------------------------------
		# * Turn Towards B
		#--------------------------------------------------------------------------
		def turn_to(b)
			return if @stop_count <= (15 - @move_frequency * 2) * (6 - @move_frequency)
			# Get difference in player coordinates
			sx = @x - b.x
			sy = @y - b.y
			# If coordinates are equal
			if sx == 0 and sy == 0
				return
			end
			# If horizontal distance is longer
			if sx.abs > sy.abs
				# Turn to the right or left towards player
				sx > 0 ? turn_left : turn_right
				# If vertical distance is longer
			else
				# Turn up or down towards player
				sy > 0 ? turn_up : turn_down
			end
		end
	end
	#==============================================================================
	# ** Game_Party
	#------------------------------------------------------------------------------
	#  This class handles the party. It includes information on amount of gold 
	#  and items. Refer to "$game_party" for the instance of this class.
	#==============================================================================
	class Game_Party
		#--------------------------------------------------------------------------
		alias mrmo_abs_game_party_setup_starting_members setup_starting_members
		#--------------------------------------------------------------------------
		attr_accessor :items
		#--------------------------------------------------------------------------
		# * Initial Party Setup
		#--------------------------------------------------------------------------
		def setup_starting_members
			mrmo_abs_game_party_setup_starting_members
			$game_player.actor = $game_party.actors[0]
		end
	end
	#============================================================================
	# * ABS Enemy
	#============================================================================
	class ABS_Enemy < Game_Battler
		#--------------------------------------------------------------------------
		attr_accessor :event_id
		attr_accessor :enemy_id
		attr_accessor :behavior
		attr_accessor :see_range
		attr_accessor :hear_range
		attr_accessor :aggressiveness
		attr_accessor :trigger   
		attr_accessor :hate_points
		attr_accessor :hate_group
		attr_accessor :closest_enemy
		attr_accessor :in_battle
		attr_accessor :ranged
		attr_accessor :event
		attr_accessor :attacking
		attr_accessor :temp_move_type
		attr_accessor :temp_speed
		attr_accessor :temp_frequency
		attr_accessor :actor
		attr_accessor :respawn
		attr_accessor :aggro
		attr_accessor :send_damage
		attr_accessor :skill_mash # 적 스킬 딜레이 넣기
		
		attr_accessor :casting_mash # 주문외우는 딜레이
		attr_accessor :casting_action # 주문 외우는 스킬
		attr_accessor :casting_idx
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(enemy_id)
			super()
			$data_enemies[enemy_id].maxhp = ABS_ENEMY_HP[enemy_id][0] if ABS_ENEMY_HP[enemy_id] != nil 
			
			@event_id= 0
			@see_range = 0
			@hear_range = 0
			@aggressiveness = 1
			@trigger = []
			@enemy_id = enemy_id
			@in_battle = false
			@hp = maxhp
			@sp = maxsp
			@closest_enemy = false
			@hate_points = []
			@ranged = nil
			@hate_group = []
			@event = nil
			@attacking = nil
			@temp_move_type = 0 
			@temp_speed = 0
			@temp_frequency = 0 
			@actor = self
			@respawn = 0
			@aggro = $is_map_first
			@send_damage = true
			@skill_mash = {}
			# 캐스팅
			@casting_mash = 0
			@casting_action = nil
			@casting_idx = 0
		end
		#--------------------------------------------------------------------------
		# * Get Enemy ID
		#--------------------------------------------------------------------------
		def id
			return @enemy_id
		end
		#--------------------------------------------------------------------------
		# * Get Index
		#--------------------------------------------------------------------------
		def index
			return @member_index
		end
		#--------------------------------------------------------------------------
		# * Get Name
		#--------------------------------------------------------------------------
		def name
			return $data_enemies[@enemy_id].name
		end
		#--------------------------------------------------------------------------
		# * Get Basic Maximum HP
		#--------------------------------------------------------------------------
		def base_maxhp
			return $data_enemies[@enemy_id].maxhp
		end
		#--------------------------------------------------------------------------
		# * Get Basic Maximum SP
		#--------------------------------------------------------------------------
		def base_maxsp
			return $data_enemies[@enemy_id].maxsp
		end
		#--------------------------------------------------------------------------
		# * Get Basic Strength
		#--------------------------------------------------------------------------
		def base_str
			return $data_enemies[@enemy_id].str
		end
		#--------------------------------------------------------------------------
		# * Get Basic Dexterity
		#--------------------------------------------------------------------------
		def base_dex
			return $data_enemies[@enemy_id].dex
		end
		#--------------------------------------------------------------------------
		# * Get Basic Agility
		#--------------------------------------------------------------------------
		def base_agi
			return $data_enemies[@enemy_id].agi
		end
		#--------------------------------------------------------------------------
		# * Get Basic Intelligence
		#--------------------------------------------------------------------------
		def base_int
			return $data_enemies[@enemy_id].int
		end
		#--------------------------------------------------------------------------
		# * Get Basic Attack Power
		#--------------------------------------------------------------------------
		def base_atk
			return $data_enemies[@enemy_id].atk
		end
		#--------------------------------------------------------------------------
		# * Get Basic Physical Defense
		#--------------------------------------------------------------------------
		def base_pdef
			return $data_enemies[@enemy_id].pdef
		end
		#--------------------------------------------------------------------------
		# * Get Basic Magic Defense
		#--------------------------------------------------------------------------
		def base_mdef
			return $data_enemies[@enemy_id].mdef
		end
		#--------------------------------------------------------------------------
		# * Get Basic Evasion
		#--------------------------------------------------------------------------
		def base_eva
			return $data_enemies[@enemy_id].eva
		end
		#--------------------------------------------------------------------------
		# * Get Offensive Animation ID for Normal Attack
		#--------------------------------------------------------------------------
		def animation1_id
			return $data_enemies[@enemy_id].animation1_id
		end
		#--------------------------------------------------------------------------
		# * Get Target Animation ID for Normal Attack
		#--------------------------------------------------------------------------
		def animation2_id
			return $data_enemies[@enemy_id].animation2_id
		end
		#--------------------------------------------------------------------------
		# * Get Element Revision Value
		#     element_id : Element ID
		#--------------------------------------------------------------------------
		def element_rate(element_id)
			# Get a numerical value corresponding to element effectiveness
			table = [0,200,150,100,50,0,-100]
			result = table[$data_enemies[@enemy_id].element_ranks[element_id]]
			# If protected by state, this element is reduced by half
			for i in @states
				if $data_states[i].guard_element_set.include?(element_id)
					result /= 2
				end
			end
			# End Method
			return result
		end
		#--------------------------------------------------------------------------
		# * Get State Effectiveness
		#--------------------------------------------------------------------------
		def state_ranks
			return $data_enemies[@enemy_id].state_ranks
		end
		#--------------------------------------------------------------------------
		# * Determine State Guard
		#     state_id : state ID
		#--------------------------------------------------------------------------
		def state_guard?(state_id)
			return false
		end
		#--------------------------------------------------------------------------
		# * Get Normal Attack Element
		#--------------------------------------------------------------------------
		def element_set
			return []
		end
		#--------------------------------------------------------------------------
		# * Get Normal Attack State Change (+)
		#--------------------------------------------------------------------------
		def plus_state_set
			return []
		end
		#--------------------------------------------------------------------------
		# * Get Normal Attack State Change (-)
		#--------------------------------------------------------------------------
		def minus_state_set
			return []
		end
		#--------------------------------------------------------------------------
		# * Aquire Actions
		#--------------------------------------------------------------------------
		def actions
			return $data_enemies[@enemy_id].actions
		end
		#--------------------------------------------------------------------------
		# * Get EXP
		#--------------------------------------------------------------------------
		def exp
			return $data_enemies[@enemy_id].exp
		end
		#--------------------------------------------------------------------------
		# * Get Gold
		#--------------------------------------------------------------------------
		def gold
			return $data_enemies[@enemy_id].gold
		end
		#--------------------------------------------------------------------------
		# * Get Item ID
		#--------------------------------------------------------------------------
		def item_id
			return $data_enemies[@enemy_id].item_id
		end
		#--------------------------------------------------------------------------
		# * Get Weapon ID
		#--------------------------------------------------------------------------
		def weapon_id
			return $data_enemies[@enemy_id].weapon_id
		end
		#--------------------------------------------------------------------------
		# * Get Armor ID
		#--------------------------------------------------------------------------
		def armor_id
			return $data_enemies[@enemy_id].armor_id
		end
		#--------------------------------------------------------------------------
		# * Get Treasure Appearance Probability
		#--------------------------------------------------------------------------
		def treasure_prob
			return $data_enemies[@enemy_id].treasure_prob
		end
	end
	
	
end
class Interpreter
	#--------------------------------------------------------------------------
	# * Script
	#--------------------------------------------------------------------------
	def command_355
		# Set first line to script
		script = @list[@index].parameters[0] + "\n"
		# Loop
		loop do
			# If next event command is second line of script or after
			if @list[@index+1].code == 655
				# Add second line or after to script
				script += @list[@index+1].parameters[0] + "\n"
				# If event command is not second line or after
			else
				# Abort loop
				break
			end
			# Advance index
			@index += 1
		end
		# Evaluation
		result = eval(script)
		# Continue
		return true
	end
end
