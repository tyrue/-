#==============================================================================
# * NetParty
#------------------------------------------------------------------------------
#  - 넷 파티
#==============================================================================
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
		
		@buttons = {}
		
		i = 0
		for netparty in $netparty
			@buttons[netparty[0]] = J::Button.new(self).refresh(120,
				netparty.to_s)
			# "( " + netparty[0].to_s + " ) " + netparty[1].to_s)
			@buttons[netparty[0]].y = i * 30 + 12
			
			i += 1
		end
		@a = J::Button.new(self).refresh(50, "탈퇴")
		@a.x = self.width - 50
		@a.y = 130
		@b = J::Button.new(self).refresh(50, "생성")
		@b.x = self.width - 120
		@b.y = 130
		@c = J::Button.new(self).refresh(50, "초대")
		@c.x = self.width - 50
		@c.y = 155
	end
	
	def update
		super
		if @a.click  # 탈퇴
			if not $netparty == []
				$game_system.se_play($data_system.decision_se)
				$npt = ""
				$netparty.clear
				$console.write_line("[파티]:파티에서 탈퇴하셨습니다.")
				Network::Main.socket.send("<nptout>#{$game_party.actors[0].name} #{$npt}</nptout>\n")
				Hwnd.dispose("NetParty")
				Jindow_NetParty.new
			else
				$console.write_line("[파티]:가입된 파티가 없습니다.")
			end
		end
		if @b.click  # 생성
			if $netparty == []
				$game_system.se_play($data_system.decision_se)
				$npt = $game_party.actors[0].name
				$console.write_line("[파티]:파티가 생성되었습니다.")
				$data = $game_party.actors[0].name
				$data = [$party_index = nil, $game_party.actors[0].name]
				$netparty.push($data)
				Hwnd.dispose("NetParty")
				$nowparty = 0 
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
