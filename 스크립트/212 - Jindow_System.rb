class Jindow_System < Jindow
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 100, 183)
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
		
		
		@a = J::Button.new(self).refresh(100, "계속하기")
		@b = J::Button.new(self).refresh(100, "현재서버")
		@c = J::Button.new(self).refresh(100, "카페주소")
		@d = J::Button.new(self).refresh(100, "캐시샵")
		@e = J::Button.new(self).refresh(100, "로그아웃")
		@f = J::Button.new(self).refresh(100, "종료하기")
		
		
		@a.y = 12
		@b.y = 42
		@c.y = 72
		@d.y = 102
		@e.y = 132
		@f.y = 162
	end
	
	def update
		super
		if @a.click
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
		elsif @b.click and not Hwnd.include?("현재서버")
			$console.write_line("현재서버: 흑부엉서버")
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
		elsif @c.click and not Hwnd.include?("카페주소")
			$game_system.se_play($data_system.decision_se)
			
			$chat.write ("카페주소: http://cafe.naver.com/blackowlsbaram", Color.new(65, 105, 0))
			
			Hwnd.dispose(self)
		elsif @d.click
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			Jindow_cashshop.new
		elsif @f.click
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			JS.game_end
		elsif @e.click
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			JS.game_title
		
		end
	end
	
end



