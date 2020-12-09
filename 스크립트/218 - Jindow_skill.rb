#----------------------------------------------------------------------------------
# *진도우 스킬창
#----------------------------------------------------------------------------------
class Jindow_Skill < Jindow
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 100, 100)
		self.name = "⊙ 스킬"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh "Skill"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		@a = J::Button.new(self).refresh(100, "스킬창")
		@c = J::Button.new(self).refresh(100, "단축키")
		@b = J::Button.new(self).refresh(100, "취소")
		@a.y = 12
		@c.y = 42
		@b.y = 72
		
	end
	
	def update
		super
		if @a.click
			$game_system.se_play($data_system.decision_se)
			$scene = Scene_Skill.new
		elsif @b.click
			Hwnd.dispose(self)
		elsif @c.click
			Jindow_Keyset.new	
		end
	end
	
end