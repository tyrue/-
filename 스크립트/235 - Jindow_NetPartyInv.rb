#==============================================================================
# * NetPartyInv
#------------------------------------------------------------------------------
#  - 넷 파티에 다른 유저를 초대합니다.
#==============================================================================
class Jindow_NetPartyInv < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 140, 50)
		self.name = "파티 초대"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh("NetPartyInv")
		self.x = 120
		self.y = 75
		
		@type = J::Type.new(self).refresh(10, 10, 120, 13)
		@buttons = {}
		@a = J::Button.new(self).refresh(50, "초대")
		@a.x = 10
		@a.y = 30
		@b = J::Button.new(self).refresh(50, "취소")
		@b.x = 80
		@b.y = 30
	end
	
	def update
		super
		if @a.click  # 확인
			$game_system.se_play($data_system.decision_se)
			if not @type.result == ""
				if $game_party.actors[0].name == @type.result
					$console.write_line("[파티]:자기 자신을 초대할 수 없습니다.")
				elsif $nowparty == 0 and not $game_party.actors[0].name == @type.result
					if $netparty.size == 1
						Network::Main.socket.send("<nptreq>#{@type.result} #{$netparty[0]} #{$game_party.actors[0].name} #{$npt}</nptreq>\n")
						$console.write_line("[파티]:'#{@type.result}'님을 파티로 초대했습니다.")
						Hwnd.dispose("NetPartyInv")
						Hwnd.dispose("NetParty")
						Jindow_NetParty.new
					elsif $netparty.size == 2
						Network::Main.socket.send("<nptreq2>#{@type.result} #{$netparty[0]} #{$netparty[1]} #{$game_party.actors[0].name} #{$npt}</nptreq2>\n")
						$console.write_line("[파티]:'#{@type.result}'님을 파티로 초대했습니다.")
						Hwnd.dispose("NetPartyInv")
						Hwnd.dispose("NetParty")
						Jindow_NetParty.new
					elsif $netparty.size == 3
						Network::Main.socket.send("<nptreq3>#{@type.result} #{$netparty[0]} #{$netparty[1]} #{$netparty[2]} #{$game_party.actors[0].name} #{$npt}</nptreq3>\n")
						$console.write_line("[파티]:'#{@type.result}'님을 파티로 초대했습니다.")
						Hwnd.dispose("NetPartyInv")
						Hwnd.dispose("NetParty")
						Jindow_NetParty.new
					else
						$console.write_line("[파티]:파티는 최대 4인까지 가능합니다.")
					end
				else
					$console.write_line("[파티]:초대할 유저의 이름을 입력하세요.")
				end
			end
			if @b.click
				Hwnd.dispose("NetPartyInv")
			end
		end
	end
end
