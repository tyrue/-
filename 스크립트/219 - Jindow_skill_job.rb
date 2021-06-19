#----------------------------------------------------------------------------------
# 직업 길드에서 사용하는 스킬 목록 창, 타입에 따라 배울 수 있는 스킬 목록, 지울 수 있는 목록을 확인 가능
#----------------------------------------------------------------------------------
class Jindow_skill_job < Jindow
	
	def initialize(type = 0)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 300, 100)
		self.name = "⊙ 스킬목록"
		@head = true
		@mark = true
		@drag = true
		@close = true
			
		self.refresh "Skill_job"
	end
	
	def update
		super
	end
	
end