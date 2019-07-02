#==============================================================================
# ■ Jindow_NetPlayer
#------------------------------------------------------------------------------
class Jindow_NetPlayer < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 120, 150)
		self.name = "접속자 목록"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh "NetPlayer"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		@buttons = {}
		i = 0
		for p in Network::Main.mapplayers.values
			@buttons[p.id] = J::Button.new(self).refresh(120, p.name)
			@buttons[p.id].y = i * 30 + 12
			i += 1
		end
		@a = J::Button.new(self).refresh(60, "취소")
		@a.x = self.width - 60
		@a.y = @buttons.size * 30 + 14
	end
	
	def update
		super
		if @a.click  # 취소
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
		end
	end
end
