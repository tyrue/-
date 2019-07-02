#==============================================================================
# ■ Jindow_Member
#------------------------------------------------------------------------------
class Jindow_Guild_Member < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 120, 150)
		self.name = "문파원 목록"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh "GuildMember"
		self.x = 400
		self.y = 230
		@data = []
		@buttons = {}
		i = 0
		for data in $guild_member
			@buttons[data] = J::Button.new(self).refresh(120, data)
			@buttons[data].y = i * 30 + 12
			i += 1
		end
	end
	
	def update
		self.x != 400
		self.y != 230
		super
		for data in @data
			if @buttons[data.id].click #스킬을 눌렀을 경우
				if not Hwnd.include?("Skill Information")
					Jindow_Skill_Key.new(data)
				end
			end
		end
	end
end
