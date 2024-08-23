# 스킬 클래스 구조 확인용
module RPG
	class Skill
		def initialize
			@id = 0
			@name = ""
			@icon_name = ""
			@description = ""
			@scope = 0
			@occasion = 1
			@animation1_id = 0
			@animation2_id = 0
			@menu_se = RPG::AudioFile.new("", 80)
			@common_event_id = 0
			
			@hp_cost = 0 # 체력 소모량
			@sp_cost = 0
			
			@power = 0
			@atk_f = 0
			@eva_f = 0
			@str_f = 0
			@dex_f = 0
			@agi_f = 0
			@int_f = 100
			@hit = 100
			@pdef_f = 0
			@mdef_f = 100
			@variance = 15
			@element_set = []
			@plus_state_set = []
			@minus_state_set = []
		end
		attr_accessor :id
		attr_accessor :name
		attr_accessor :icon_name
		attr_accessor :description
		attr_accessor :scope
		attr_accessor :occasion
		attr_accessor :animation1_id
		attr_accessor :animation2_id
		attr_accessor :menu_se
		attr_accessor :common_event_id
		attr_accessor :hp_cost
		attr_accessor :sp_cost
		attr_accessor :power
		attr_accessor :atk_f
		attr_accessor :eva_f
		attr_accessor :str_f
		attr_accessor :dex_f
		attr_accessor :agi_f
		attr_accessor :int_f
		attr_accessor :hit
		attr_accessor :pdef_f
		attr_accessor :mdef_f
		attr_accessor :variance
		attr_accessor :element_set
		attr_accessor :plus_state_set
		attr_accessor :minus_state_set
	end
end

class Rpg_Skill_Data
	attr_accessor :type 
	
	# 원거리 스펙
	attr_accessor :range_value # 이동 거리
	attr_accessor :move_speed # 이동 속도
	attr_accessor :character_name # 캐릭터이름
	attr_accessor :explode_range # 폭발 범위
	attr_accessor :hit_num # 타격 수
	attr_accessor :hit_back # 넉백거리
	attr_accessor :hit_skill_arr # 히트시 발생하는 스킬 배열
	attr_accessor :after_mash_time # 후 딜레이
	
	# 버프 스펙
	attr_accessor :is_party # 파티원에게 적용되나?
	attr_accessor :mash_time # 스킬 쿨타임
	attr_accessor :buff_time # 지속 시간
	attr_accessor :buff_data # 버프 데이터
	attr_accessor :is_move_stop # 움직이면 버프 끝?
	attr_accessor :is_active # 엑티브 스킬인가
	
	attr_accessor :attack_power_per # 평타 최종뎀 퍼센트
	attr_accessor :defense_per # 데미지 감소 퍼센트
	attr_accessor :skill_power_per # 스킬 최종뎀 퍼센트
	
	attr_accessor :attack_critical # 평타 크리티컬 확률
	attr_accessor :skill_critical # 스킬 크리티컬 확률
	
	attr_accessor :cycle_time # 주기적으로 실행하는 시간
	attr_accessor :cycle_action # 주기적으로 실행하는 행동
	attr_accessor :cycle_animation # 주기적으로 애니메이션
	
	# 스킬 스펙
	attr_accessor :power # 기본 파워
	attr_accessor :power_arr # 파워 비례 배열
	attr_accessor :cost_arr # 비용 비례 배열
	
	# 기타
	attr_accessor :show_effect # 범위 보이는 스위치
	attr_accessor :need_item # 스킬 사용하기 위한 재료
	attr_accessor :active_message # 스킬 사용시 대사
	attr_accessor :move_direction # 스킬 이동방향 배열
	
	attr_accessor :heal_type # 회복 타입 : 체력, 마력
	attr_accessor :heal_value # 회복량  
	attr_accessor :heal_value_per # 비례 회복량 : [타입(현재, 전체), 체력, 마력]  
	
	attr_accessor :not_damage # 피해량 있는가
	
	attr_accessor :id # 아이디
	attr_accessor :can_use_dead # 죽었을떄 사용 가능 여부
	
	attr_accessor :skill_data # rpg스킬 데이터
	
	def initialize(id)
		@id = id
		@skill_data = $data_skills[id]
		@power = @skill_data.power
		@is_party = false
		@can_use_dead = false
		@type = []
		set_skill_attributes
	end
	
	def set_skill_attributes
		set_range_attributes if range_skill_ids.include?(@id)
		set_explode_attributes if explode_skill_ids.include?(@id)
		set_heal_attributes if heal_skill_ids.include?(@id)
		set_active_attributes if active_skill_ids.include?(@id)
		set_buff_attributes	 if buff_skill_ids.include?(@id)
		set_debuff_attributes	 if debuff_skill_ids.include?(@id)
		
		set_default_attributes
	end
	
	def range_skill_ids
		[
			# 주술사
			1, 2, 3, 4,          # 뢰진주, 백열주, 화염주, 자무주
			10, 11, 12, 13,      # 뢰진주, 백열주, 화염주, 자무주
			16, 17, 18, 19,      # 뢰진주, 백열주, 화염주, 자무주
			22, 23, 24, 25,      # 뢰진주, 백열주, 화염주, 자무주
			30, 31, 32, 33,      # 뢰진주, 백열주, 화염주, 자무주
			37, 38, 39, 40,      # 뢰진주 5성, 백열주 5성, 화염주 5성, 자무주 5성
			14,                  # 뢰진주 첨
			
			44, 53, 57, 69,      # 헬파이어, 삼매진화, 삼매진화 2성, 삼매진화 3성
			49, 52, 56,					 # 성려멸주, 성려멸주 1성, 성려멸주 2성
			
			58,                  # 지폭지술
			68,                  # 폭류유성
			181, 								 # 마비
			184, 								 # 중독
			
			# 전사
			65,                  # 뢰마도
			67,                  # 건곤대나이
			73,                  # 광량돌격
			74, 75,              # 십리건곤, 뢰마도 2성
			77,                  # 유비후타
			78, 79, 80,          # 십리건곤 1성, 동귀어진, 십리건곤 2성
			85,                  # 필살검무
			
			101,                 # 백호참
			102,                 # 백리건곤 1성
			103,                 # 어검술
			104,                 # 포효검황
			105,                 # 혈겁만파
			106,                 # 초혼비무
			
			# 도사
			96,                  # 지진
			123,                 # 귀염추혼소
			124,                 # 지진'첨
			183,								 # 혼마술
			
			# 도적
			133,                 # 필살검무
			135,                 # 백호검무
			137,                 # 이기어검
			138,                 # 무형검
			139,                 # 분혼경천
			
			# 적
			45,                  # 산적 건곤
			59,                  # 주작의 노도성황
			61,                  # 백호의 건곤대나이
			151,                 # 청룡의 포효
			152,                 # 현무의 포효
			153,                 # 백호검무
			154,                 # 청룡마령참
			155,                 # 암흑진파
			156,                 # 흑룡광포
			158,                 # 지옥겁화
			159,                 # 혈겁만파
			160,                 # 분혼경천
			161,                  # 폭류유성
			
			# 기타
			6,                   # 도토리 던지기
		]
	end
	
	def explode_skill_ids
		[
			6,   # 도토리 던지기
			
			53,  # 삼매진화
			57,  # 삼매진화 2성
			69,  # 삼매진화 3성
			
			103, # 어검술
			
			96,  # 지진
			124, # 지진'첨
			
			135, # 백호검무
			137  # 이기어검
		]
	end
	
	def heal_skill_ids
		[
			5,   # 누리의기원
			21,  # 바다의기원
			27,  # 동해의기원
			29,  # 천공의기원
			36,  # 구름의기원
			41,  # 체마혈식
			43,  # 위태응기
			48,  # 태양의기원
			54,  # 태양의기원 2성
			55,  # 현인의기원
			
			81,  # 동해의희원
			83,  # 천공의희원
			86,  # 바다의희원
			87,  # 천공의희원
			89,  # 구름의희원
			92,  # 공력주입
			93,  # 태양의희원
			95,  # 생명의희원
			117, # 백호의희원
			118, # 신령의희원
			119, # 봉황의희원
			120, # 부활
			
			140, # 운기
			157,  # 적 회복 스킬
			
			184, # 중독
		]
	end
	
	
	def active_skill_ids
		[
			15, 73, 132, 162
		]
	end
	
	def buff_skill_ids
		[
			# 주술사
			20,  # 마법집중
			26,  # 누리의힘
			28,  # 야수
			35,  # 비호
			42,  # 주술마도
			
			# 도사
			46,  # 무장
			47,  # 보호
			50,  # 야수수금술
			51,  # 대지의힘
			88,  # 분량력법
			90,  # 분량방법
			91,  # 석화기탄
			94,  # 금강불체
			121, # 신령지익진
			122, # 파력무참진
			
			# 전사
			62,  # 수심각도
			63,  # 반영대도
			64,  # 십량분법
			66,  # 신수둔각도
			71,  # 혼신의힘
			72,  # 구량분법
			76,  # 팔량분법
			
			# 도적
			130, # 무영보법
			131, # 투명 1성
			134, # 분신
			136, # 운상미보
			140, # 운기
			141, # 투명 2성
			142, # 투명 3성
			143, # 기문방술
			144,  # 급소타격
			
			# 기타
			99,  # 속도시약
		]
	end
	
	def debuff_skill_ids
		[
			# 주술사
			181, # 마비
			182, # 저주
			184, # 중독
			# 전사
			
			# 도적
			
			# 도사
			183, # 혼마술
			# 기타
		]
	end
	
	def set_range_attributes
		@type << "range"
		set_range_default
	end
	
	def set_explode_attributes
		@type << "explode"
		@explode_range = 1 unless @explode_range
		@show_effect = true
	end
	
	def set_range_default
		@range_value = 12
		@move_speed = 10
		@character_name = "공격스킬2"
		@hit_num = 1
		@hit_back = 0
		@after_mash_time = 4
		@hit_skill_arr = []
		
		case @id
			# 주술사
		when 1, 10, 16, 22, 30 # 뢰진주
			@character_name = "(스킬)뢰진주"
		when 2, 11, 17, 23, 31 # 백열주
			@character_name = "(스킬)백열주"
		when 3, 12, 18, 24, 32 # 화염주
			@character_name = "(스킬)화염주"
		when 4, 13, 19, 25, 33 # 자무주
			@character_name = "(스킬)자무주"
		when 6 # 도토리 던지기
			@character_name = "도토리"
			@explode_range = 3
			@need_item = [[0, 3, 10]]
			
		when 14 # 뢰진주 첨
			@range_value = 1
			@character_name = "(스킬)뢰진주"
			@move_direction = [2, 4, 6, 8]
			
		when 37 # 뢰진주 5성
			@character_name = ["(스킬)뢰진주", 150]
		when 38 # 백열주 5성
			@character_name = ["(스킬)백열주", 180]
		when 39 # 화염주 5성
			@character_name = ["(스킬)화염주", 190]
		when 40 # 자무주 5성
			@character_name = ["(스킬)자무주", 90]
			
		when 44 # 헬파이어
			@character_name = "(스킬)헬파이어"
			@mash_time = 5
			@power_arr = [0, 0, 0.9, 10] 
			@cost_arr = [0, 0, 1.0]
		when 53 # 삼매진화
			@character_name = ["(스킬)헬파이어", 20]	
			@mash_time = 5
			@power_arr = [0, 0, 1.1, 10]
			@cost_arr = [0, 0, 1.0]
			@explode_range = 3
		when 57 # 삼매진화 2성
			@character_name = ["(스킬)헬파이어", 100]
			@mash_time = 4
			@power_arr = [0, 0, 1.2, 10]
			@cost_arr = [0, 0, 1.0]
			@explode_range = 3
		when 69 # 삼매진화 3성
			@character_name = ["(스킬)헬파이어", 190]
			@hit_num = 2
			@mash_time = 3.5
			@power_arr = [0, 0, 1.3, 10]
			@cost_arr = [0, 0, 1.0]
			@explode_range = 4
			
		when 49 # 성려멸주
			@range_value = 13
			@character_name = "(스킬)성려멸주"
			@power_arr = [1, 0, 0.03, 700] 
			@cost_arr = [1, 0, 1.0 / 20.0]
		when 52 # 성려멸주 1성
			@range_value = 13
			@character_name = ["(스킬)성려멸주", 30]
			@power_arr = [1, 0, 0.04, 1000] 
			@cost_arr = [1, 0, 1.0 / 20.0]
		when 56 # 성려멸주 2성
			@range_value = 13
			@character_name = ["(스킬)성려멸주", 180]
			@power_arr = [1, 0, 0.06, 1500] 
			@cost_arr = [1, 0, 1.0 / 20.0]
			
		when 58 # 지폭지술
			@hit_num = 3
			@mash_time = 150
			@power_arr = [0, 0, 0.75, 10]
			@cost_arr = [0, 0, 1.0]
		when 68 # 폭류유성
			@hit_num = 3
			@mash_time = 150
			@power_arr = [0, 0.5, 1.0, 10]
			@cost_arr = [0, 0.5, 1.0]
			
		when 181 # 마비
			@hit_skill_arr = [[181, 1]]
			
		when 184 # 중독
			@hit_skill_arr = [[184, 1]]
				
			
			# 전사 스킬
		when 65 # 뢰마도
			@range_value = 10
			@character_name = "(스킬)뢰진주"
			@mash_time = 2
		when 75 # 뢰마도 2성
			@range_value = 10
			@character_name = ["(스킬)뢰진주", 180]
			@mash_time = 1
			
		when 67 # 건곤대나이
			@range_value = 1
			@character_name = "(스킬)건곤2"
			@mash_time = 1
			@power_arr = [0, 0.9, 0, 70]
			@cost_arr = [0, 2.0 / 3.0, 0]
		when 73 # 광량돌격
			@range_value = 1
			@character_name = "(스킬)백호참"
			@mash_time = 5
			@power_arr = [0, 0.2, 0, 30]
			@cost_arr = [0, 0.3, 0.10]
		when 77 # 유비후타
			@range_value = 2
			@character_name = "(스킬)백열장"
			@hit_back = 7
			@mash_time = 1
			
		when 74 # 십리건곤
			@range_value = 1
			@character_name = "(스킬)검기"
			@power_arr = [1, 0.01, 0, 40]
			@cost_arr = [1, 1.0 / 20.0, 0]
		when 78 # 십리건곤 1성
			@range_value = 1
			@character_name = "(스킬)검기"
			@power_arr = [1, 0.02, 0.01, 60]
			@cost_arr = [1, 1.0 / 20.0, 0]
		when 80 # 십리건곤 2성
			@range_value = 2
			@character_name = "(스킬)검기2"
			@power_arr = [1, 0.04, 0.01, 80]
			@cost_arr = [1, 1.0 / 20.0, 0]
		when 102 # 백리건곤 1성
			@range_value = 3
			@character_name = "(스킬)검기3"
			@power_arr = [1, 0.06, 0.03, 100]
			@cost_arr = [1, 1.0 / 20.0, 0.01]
			
		when 79 # 동귀어진
			@range_value = 1
			@character_name = "(스킬)동귀어진"
			@hit_num = 10
			@mash_time = 180
			@power_arr = [0, 1.0, 0.01, 100]
			@cost_arr = [0, 1.0, 1.0]
		when 101 # 백호참
			@range_value = 1
			@hit_num = 2
			@mash_time = 0.5
			@power_arr = [0, 0.5, 0.1, 60]
			@cost_arr = [0, 0.5, 0.05]
			
		when 103 # 어검술
			@range_value = 1
			@character_name = ["(스킬)검기3", 150]
			@hit_num = 2
			@mash_time = 8
			@power_arr = [0, 0.3, 0.4, 60]
			@cost_arr = [0, 0.3, 0.4]
			@explode_range = 3
		when 104 # 포효검황
			@hit_num = 3
			@mash_time = 150
			@power_arr = [0, 0.3, 0.3, 20]
			@cost_arr = [0, 0.4, 0.3]
		when 105 # 혈겁만파
			@hit_num = 3
			@mash_time = 150
			@power_arr = [0, 0.7, 0.7, 100] 
			@cost_arr = [0, 0.5, 1.0]
		when 106 # 초혼비무
			@range_value = 4
			@character_name = "(스킬)쇄혼비무"
			@hit_num = 4
			@hit_back = -3
			@mash_time = 30
			@power_arr = [0, 0.1, 0.7, 100] 
			@cost_arr = [0, 0.3, 1.0]
			
			# 도사 스킬
		when 96 # 지진
			@range_value = 7
			@character_name = "(스킬)지진"
			@hit_num = 5
			@power_arr = [1, 0, 0.03, 20]
			@cost_arr = [1, 0, 1.0 / 10.0]
			@explode_range = 2
		when 123 # 귀염추혼소
			@move_speed = 5
			@hit_num = 3
			@mash_time = 120
			@power_arr = [0, 0.2, 0.2, 100] 
			@cost_arr = [0, 0.2, 1.0]
			@hit_skill_arr = [[183, 1]]
		when 124 # 지진'첨
			@range_value = 7
			@character_name = ["(스킬)지진", 150]
			@hit_num = 5
			@move_direction = [1, 2, 3, 4, 6, 7, 8, 9]
			@mash_time = 20
			@power_arr = [1, 0.01, 0.20, 150] 
			@cost_arr = [1, 0.01, 0.7]
			@explode_range = 2
		when 183 # 혼마술
			@hit_skill_arr = [[183, 1]]
			
			
			# 도적 스킬
		when 133 # 필살검무
			@range_value = 1
			@character_name = "(스킬)필살검무"
			@mash_time = 1
			@power_arr = [0, 1.2, 0.3, 20] 
			@cost_arr = [0, 0.3, 1.0]
		when 135 # 백호검무
			@range_value = 0
			@character_name = "(스킬)백호검무"
			@mash_time = 3
			@power_arr = [1, 0.10, 0.05, 70] 
			@cost_arr = [1, 0.1, 0.1]
			@explode_range = 2
		when 137 # 이기어검
			@range_value = 0
			@character_name = "(스킬)검기"
			@hit_num = 3
			@mash_time = 18
			@power_arr = [0, 0.2, 0.2, 20] 
			@cost_arr = [0, 0.3, 0.3]
			@explode_range = 4
		when 138 # 무형검
			@range_value = 15
			@character_name = ["(스킬)검", 250]
			@hit_num = 8
			@mash_time = 1.5
			@power_arr = [0, 0.07, 0.10, 50] 
			@cost_arr = [0, 0.1, 0.15]
			@hit_skill_arr = [[132, 0]]
			
		when 139 # 분혼경천
			@hit_num = 3
			@mash_time = 150
			@power_arr = [0, 0.7, 0.7, 100] 
			@cost_arr = [0, 0.5, 1.0]
			
			# 적 스킬
		when 45 # 산적 건곤
			@move_speed = 4.5
			@character_name = ["(스킬)검기", 50]
		when 59 # 주작의 노도성황
			@range_value = 5
		when 61 # 백호의 건곤대나이
			@range_value = 5
		when 85 # 필살검무
			@move_speed = 3.5
			@character_name = ["(스킬)필살검무", 150]
			@range_value = 4
			@mash_time = 1.5
		when 151 # 청룡의 포효
			@range_value = 10
			@character_name = ["(몬)(승급)청룡", 90]
			@hit_num = 1
			@hit_back = 12
			@move_direction = [1, 2, 3, 4, 6, 7, 8, 9]
			@mash_time = 10
			@power_arr = [2, 0.05, 0.05, 100]
		when 152 # 현무의 포효
			@range_value = 10
			@character_name = ["(몬)(승급)현무", 90]
			@hit_num = 1
			@hit_back = 12
			@move_direction = [1, 2, 3, 4, 6, 7, 8, 9]
			@mash_time = 10
			@power_arr = [2, 0.05, 0.05, 100]
		when 153 # 백호검무
			@range_value = 4
			@character_name = "(스킬)검기3"
			@hit_num = 2
			@hit_back = 2
			@move_direction = [2, 4, 6, 8]
			@mash_time = 3
		when 154 # 청룡마령참
			@move_speed = 3
			@range_value = 10
			@character_name = "(몬)(승급)용"
			@hit_num = 10
			@hit_back = 6
			@mash_time = 30
			@show_effect = true
			@power_arr = [2, 3.00, 3.00, 100]
		when 155 # 암흑진파
			@range_value = 6
			@hit_num = 2
			@hit_back = 1
			@mash_time = 10
			@show_effect = true
			@power_arr = [2, 0.5, 0.5, 100] 
		when 156 # 흑룡광포
			@range_value = 8
			@hit_num = 3
			@hit_back = 1
			@mash_time = 10
			@show_effect = true
			@power_arr = [2, 0.4, 0.3, 100] 
		when 158 # 지옥겁화
			@hit_num = 2
			@hit_back = 1
			@mash_time = 60
			@show_effect = true
			@power_arr = [2, 1.30, 0, 100] 
		when 159 # 혈겁만파
			@hit_num = 10
			@hit_back = 3
			@mash_time = 60
			@show_effect = true
			@power_arr = [2, 3.00, 3.00, 100] 
		when 160 # 분혼경천
			@hit_num = 10
			@hit_back = 3
			@mash_time = 60
			@show_effect = true
			@power_arr = [2, 3.00, 3.00, 100] 
		when 161 # 폭류유성
			@hit_num = 10
			@hit_back = 3
			@mash_time = 60
			@show_effect = true
			@power_arr = [2, 3.00, 3.00, 100] 
			
			
		end
	end
	
	def set_heal_attributes
		@type << "heal"
		@heal_type = "hp"
		@heal_value = 0
		
		case @id
		when 5 # 누리의기원
			@heal_value = 50
		when 21 # 바다의기원
			@heal_value = 100
		when 27 # 동해의기원
			@heal_value = 160
		when 29 # 천공의기원
			@heal_value = 300
		when 36 # 구름의기원
			@heal_value = 500
		when 41 # 체마혈식
			@heal_type = "sp"
			@heal_value_per = [1, 0.02, 0]
			@cost_arr = [1, 0.20, 0]
		when 43 # 위태응기
			@heal_value_per = [0, 0, 2.1]
			@cost_arr = [0, 0, 1.0]
		when 48 # 태양의기원
			@heal_value = 1000
		when 54 # 태양의기원 1성
			@heal_value = 2000
		when 55 # 현인의기원
			@heal_value = 5000
			
		when 81 # 동해의희원
			@heal_value = 170
			@is_party = true
		when 83 # 천공의희원
			@heal_value = 300
			@is_party = true
		when 86 # 바다의희원
			@heal_value = 75
			@is_party = true
		when 87 # 천공의희원
			@heal_value = 300
			@is_party = true
		when 89 # 구름의희원
			@heal_value = 500
			@is_party = true
		when 92 # 공력주입
			@heal_type = "sp"
			@heal_value_per = [0, 0, 1.5]
			@cost_arr = [0, 0, 0.99]
			@is_party = true
			
		when 93 # 태양의희원
			@heal_value = 1000
			@is_party = true
		when 95 # 생명의희원
			@heal_value = 3000
			@is_party = true
		when 117 # 백호의희원
			@heal_value_per = [0, 0, 4]
			@cost_arr = [0, 0, 1.0]
			@is_party = true
			@mash_time = 5
		when 118 # 신령의희원
			@heal_value = 7000
			@cost_arr = [1, 0, 0.02]
			@is_party = true
		when 119 # 봉황의희원
			@heal_value = 15000
			@cost_arr = [1, 0, 0.02]
			@is_party = true
		when 120 # 부활
			@heal_type = "com"
			@heal_value = 24
			@is_party = true
			@can_use_dead = true
			
		when 140 # 운기
			@heal_type = "sp"
			@heal_value_per = [1, 0, 0.12]
			@mash_time = 1
			
		when 157 # 적 회복 스킬
			@heal_value_per = [1, 0.3, 0]
			@mash_time = 10
			
		when 184 # 중독
			@heal_value_per = [1, -0.01, 0]
		end
	end
	
	def set_buff_attributes
		@type << "buff"
		@buff_time = 180
		@buff_data = []
		
		case @id
			# 주술사
		when 20 # 마법집중
			@skill_critical = [15]
		when 26 # 누리의힘
			@buff_data = [["str", 20]]
		when 28 # 야수
			@buff_time = 60
			@buff_data = [["com", 40]]
		when 35 # 비호
			@buff_time = 60
			@buff_data = [["com", 42]]
		when 42 # 주술마도
			@buff_data = [["per_int", 1.2]]
			@is_party = true
			@skill_power_per = 1.2
			
			# 도사
		when 50 # 야수수금술
			@buff_time = 60
			@buff_data = [["com", 40]]
			@is_party = true
		when 51 # 대지의힘
			@buff_data = [["str", 30]]
			@is_party = true
		when 88 # 분량력법
			@buff_time = 60
			@buff_data = [["per_str", 1.2]]
			@attack_power_per = 1.3
			@skill_power_per = 1.2
			@is_party = true
		when 90 # 분량방법
			@buff_time = 60
			@buff_data = [["per_agi", 1.2]]
			@defense_per = 0.2
			@is_party = true
		when 91 # 석화기탄
			@buff_time = 60
			@buff_data = [["com", 129]]
		when 46 # 무장
			@buff_data = [["mdef", 10], ["pdef", 10]]
			@is_party = true
		when 47 # 보호
			@defense_per = 0.3
			@is_party = true
		when 94 # 금강불체
			@buff_time = 5
			@mash_time = 10
			@defense_per = 0.99
		when 121 # 신령지익진
			@buff_time = 2
			@mash_time = 2
			@defense_per = 0.4
			@is_party = true
		when 122 # 파력무참진
			@buff_time = 2
			@mash_time = 2
			@is_party = true
			@attack_power_per = 1.5
			@skill_power_per = 1.5
			
			# 전사
		when 62 # 수심각도
			@buff_data = [["dex", 50]]
		when 63 # 반영대도
			@buff_data = [["agi", 50]]
		when 64 # 십량분법
			@buff_data = [["per_str", 1.1]]
			@attack_power_per = 1.1
		when 66 # 신수둔각도
			@buff_time = 60
			@mash_time = 180
			@buff_data = [["custom"]]
		when 71 # 혼신의힘
			@buff_time = 8
			@mash_time = 90
			@attack_power_per = 5
			@skill_power_per = 2.0
		when 72 # 구량분법
			@buff_data = [["per_str", 1.2]]
			@attack_power_per = 1.2
		when 76 # 팔량분법
			@buff_data = [["per_str", 1.3]]
			@attack_power_per = 1.4
			
			# 도적
		when 130 # 무영보법
			@buff_data = [["dex", 50], ["agi", 50]]
		when 131 # 투명 1성
			@buff_time = 10
			@buff_data = [["custom"]]
			@attack_power_per = 6
			@power_arr = [1, 0.01, 0, 0] 
			@cost_arr = [1, 0.01, 0]
		when 141 # 투명 2성
			@buff_time = 10
			@buff_data = [["custom"]]
			@attack_power_per = 7
			@power_arr = [1, 0.01, 0, 0] 
			@cost_arr = [1, 0.01, 0]
		when 142 # 투명 3성
			@buff_time = 20
			@buff_data = [["custom"]]
			@attack_power_per = 8
			@power_arr = [1, 0.02, 0.02, 0] 
			@cost_arr = [1, 0.01, 0]
			
		when 134 # 분신
			@buff_time = 60
			@mash_time = 90
			@buff_data = [["custom"]]
			@attack_power_per = 3
			@skill_power_per = 1.1
		when 136 # 운상미보
			@buff_data = [["speed", 0.5]]
			@is_party = true
		when 140 # 운기
			@buff_time = 10
			@buff_data = [["custom"]]
			
			@cycle_time = 1 # 주기적으로 실행하는 시간
			@cycle_action = ["heal"] # 주기적으로 실행하는 행동
			@is_move_stop = true
		when 143 # 기문방술
			@buff_time = 20
			@mash_time = 120
			@buff_data = [["custom"]]
		when 144 # 급소타격
			@attack_critical = [20]
			# 기타
		when 99 # 속도시약
			@buff_time = 360
			@buff_data = [["speed", 0.5]]
			
		end
	end
	
	def set_debuff_attributes
		@type << "debuff"
		@buff_time = 180
		@buff_data = []
		
		case @id
		when 181 # 마비
			@buff_time = 6
			@buff_data = [["speed", -6]]
			
			@cycle_time = 2 # 주기적으로 실행하는 시간
			@cycle_animation = 162
			@not_damage = true
		when 183 # 혼마술
			@buff_time = 6
			@buff_data = [["mdef", -30], ["pdef", -30]]
			
			@cycle_time = 2 # 주기적으로 실행하는 시간
			@cycle_animation = 169
			@not_damage = true
		when 184 # 중독
			@buff_time = 20
			
			@cycle_time = 3 # 주기적으로 실행하는 시간
			@cycle_action = ["heal_debuff"] # 주기적으로 실행하는 행동
			@cycle_animation = 161
			@not_damage = true
		end
	end
	
	def set_active_attributes
		@is_active = true
		@type << "active"
		
		case @id
		when 162 # 추격
			@mash_time = 10
		end
	end
	
	def set_default_attributes
		case @id
		when 8 # 성황령
			@can_use_dead = true
		end
	end
end


class Rpg_Skill_Initialize
	attr_accessor :data
	def initialize
		@data = {}
		
		$data_skills.each_with_index do |skill, i|
			next if skill == nil || skill.name == ""
			@data[i] = Rpg_Skill_Data.new(i)
		end
	end
end

