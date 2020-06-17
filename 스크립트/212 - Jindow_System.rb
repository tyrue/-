class Jindow_System < Jindow
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 100, 83)
		self.name = "⊙ 시스템"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh "System"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@menu_t = [
			"음량조절",
			"카페주소",
			"캐시샵",
			"로그아웃",
			"종료하기"
		]
		
		@menu = []
		for i in 0..@menu_t.size - 1
			@menu[i] = J::Button.new(self).refresh(100, @menu_t[i].to_s)
			@menu[i].y = 12 + i * 30
		end
		self.height = @menu[@menu.size - 1].y + 30 
		self.refresh "System"
	end	
	
	def update
		super
		if @menu[0].click
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			Jindow_volume.new
		elsif @menu[1].click
			$game_system.se_play($data_system.decision_se)
			$chat.write ("카페주소: http://cafe.naver.com/blackowlsbaram", Color.new(65, 105, 0))
			Hwnd.dispose(self)
		elsif @menu[2].click
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			Jindow_cashshop.new
		elsif @menu[3].click
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			JS.game_title
		elsif @menu[4].click
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			JS.game_end
		end
	end
end



