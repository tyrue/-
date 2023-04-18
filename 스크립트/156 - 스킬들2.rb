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


class Rpg_skill
	alias rpg_skills_2_initialize initialize 
	def initialize
		rpg_skills_2_initialize
	end
	
	def refresh
		refresh_description
	end
	
	def refresh_description
		#$data_skills[5].description = $game_party.actors[0].maxsp.to_s
	end
end

class Rpg_Skill_Data
	attr_accessor :skill_type # 0이면 아무것도 아님, 1이면 원거리, 2이면 폭발
	attr_accessor :move_range # 이동 거리
	attr_accessor :character_name # 캐릭터이름
	attr_accessor :explode_range # 폭발 범위
	attr_accessor :hit_num # 타격 수
	attr_accessor :hit_back # 넉백거리
	attr_accessor :mash_time # 스킬 쿨타임
	attr_accessor :buff_time # 스킬 쿨타임
	attr_accessor :move_direction # 스킬 이동방향 배열
	attr_accessor :heal_val # 회복량  
	attr_accessor :is_party_skill # 파티원에게 적용되나?
	
	def initialize
		@skill_type = 0
		@move_range = 0
		@character_name = ""
		@explode_range = 0
		@hit_num = 0
		@hit_back = 0
		@mash_time = 0
		@buff_time = 0
		@move_direction = [] 
		@heal_val = 0
		@is_party_skill = false
	end
end
