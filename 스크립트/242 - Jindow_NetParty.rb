#==============================================================================
# * NetParty
#------------------------------------------------------------------------------
#  - 넷 파티
#==============================================================================
$MAX_PARTY = 5

class Jindow_NetParty < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 120, 175)
		self.name = "파티원 목록"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh("NetParty")
		self.x = 75
		self.y = 75
		
		@buttons = []
		
		i = 0
		for netparty in $netparty
			@buttons[i] = J::Button.new(self).refresh(120, netparty.to_s)
			@buttons[i].y = i * 30 + 12
			i += 1
		end
		
		@a = J::Button.new(self).refresh(50, "탈퇴")
		@a.x = self.width - 50
		@a.y = @buttons.last != nil ? @buttons.last.y : 0
		@a.y = [self.height - 30, @a.y].max
		
		@b = J::Button.new(self).refresh(50, "생성")
		@b.x = self.width - 120
		@b.y = @a.y
		
		@c = J::Button.new(self).refresh(50, "초대")
		@c.x = @b.x
		@c.y = @b.y + @b.height
		self.height = @c.y + @c.height + 10
		self.refresh("NetParty")
	end
	
	def update
		super
		if @a.click  # 탈퇴
			if not $netparty == []
				$game_system.se_play($data_system.decision_se)
				$console.write_line("[파티]:파티에서 탈퇴하셨습니다.")
				Network::Main.socket.send("<nptout>#{$game_party.actors[0].name} #{$npt}</nptout>\n")
				$netparty.clear
				$npt = "" # 파티장 이름
				Hwnd.dispose("NetParty")
				Jindow_NetParty.new
			else
				$console.write_line("[파티]:가입된 파티가 없습니다.")
			end
		end
		if @b.click  # 생성
			if $netparty.size == 0
				$game_system.se_play($data_system.decision_se)
				$npt = $game_party.actors[0].name
				$console.write_line("[파티]:파티가 생성되었습니다.")
				$netparty.push($game_party.actors[0].name)
				Hwnd.dispose("NetParty")
				Jindow_NetParty.new
			else
				$console.write_line("[파티]:이미 가입한 파티가 존재합니다.")
			end
		end
		if @c.click
			Jindow_NetPartyInv.new
		end
	end
end
