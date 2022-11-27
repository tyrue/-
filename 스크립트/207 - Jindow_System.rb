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
		
		
		@menu_t = [
			"음량조절",
			"데미지 표시 설정",
			"카페주소",
			"로그아웃",
			"종료하기"
		]
		
		@menu = []
		for i in 0..@menu_t.size - 1
			@menu[i] = J::Button.new(self).refresh(100, @menu_t[i].to_s)
			@menu[i].y = 12 + i * 30
		end
		self.height = @menu[@menu.size - 1].y + 30 
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		self.refresh "System"
	end	
	
	def update
		super
		for menu in @menu
			if menu.click
				$game_system.se_play($data_system.decision_se)
				case menu.command
				when "데미지 표시 설정"
					Jindow_Damage_Set.new
					Hwnd.dispose(self)
				when "음량조절"
					Jindow_volume.new
					Hwnd.dispose(self)
				when "카페주소"
					$chat.write ("카페주소: http://cafe.naver.com/blackowlsbaram", COLOR_HELP)
				when "로그아웃"
					JS.game_title
					Hwnd.dispose(self)
				when "종료하기"
					JS.game_end
					Hwnd.dispose(self)
				end
			end
		end
	end
end



