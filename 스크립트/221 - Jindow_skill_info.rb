#----------------------------------------------------------------------------------
# *진도우 스킬창
#----------------------------------------------------------------------------------
class Jindow_Skill_Info < Jindow
	
	def initialize(data)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 100, 100)
		@data = data
		self.name = "⊙ 스킬 정보 (#{@data.name})"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh "Skill_Info"
		
		@actor = $game_party.actors[0]
		
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		self.refresh("Skill_Info")
	end
	
	def update
		super
		
	end
	
end