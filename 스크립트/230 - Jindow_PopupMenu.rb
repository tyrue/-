#==============================================================================
# * 팝업 메뉴
#------------------------------------------------------------------------------
#  - 유저를 클릭하면 해당 유저의 상세 정보를 표시합니다.
#==============================================================================
class Jindow_P_Status < Jindow
	def initialize(usrname, lev, hp, mhp, sp, msp, pci, netid)
		super(0, 0, 70, 110)
		self.name = usrname
		@usrname = usrname
		@pci = pci
		@lev = lev
		@head = true
		@mark = true
		@drag = true
		@close = true
		@hp = hp
		@mhp = mhp
		@sp = sp
		@msp = msp
		@netid = netid
		@netPlayer = Network::Main.players[@netid]
		self.refresh("P_Status")
		self.x = Mouse::x
		self.y = Mouse::y
		
		@a = J::Button.new(self).refresh(50, "파티 초대")
		@a.x = 10
		@a.y = 10
		
		@b = J::Button.new(self).refresh(50, "문파 초대")
		@b.x = 10
		@b.y = 35
		
		@c = J::Button.new(self).refresh(50, "교환 신청")
		@c.x = 10
		@c.y = 60
		
		@d = J::Button.new(self).refresh(50, "유저 정보")
		@d.x = 10
		@d.y = 85
	end
	
	def update
		super
		
		if @a.click # 파초
			if $netparty.size < $MAX_PARTY
				if $netparty.size == 0
					$npt = $game_party.actors[0].name
					$console.write_line("[파티]:파티가 생성되었습니다.")
					$netparty.push($game_party.actors[0].name)
				end
				
				party_mem = $netparty[0]
				for i in 1..$netparty.size - 1
					party_mem = party_mem.to_s + ",#{$netparty[i]}"
				end
				
				Network::Main.socket.send("<nptreq>#{@usrname} #{party_mem} #{$game_party.actors[0].name} #{$npt}</nptreq>\n")
				$console.write_line("[파티]: '#{@usrname}' 님을 파티에 초대했습니다.")
				if Hwnd.include?("NetParty")
					Hwnd.dispose("P_Status")
					Hwnd.dispose("NetParty")
					Jindow_NetParty.new
				end
			else
				$console.write_line("[파티]:파티는 최대 #{$MAX_PARTY}인까지 가능합니다.")
			end
		end
		
		if @b.click # 길초
			guild = @usrname
			if $guild_group == "문파장" or $guild_group == "부문파장"
				$console.write_line("#{@usrname}님에게 문파 초대를 하셨습니다.")
				Network::Main.socket.send "<Guild_Invite>#{guild},#{$guild},#{$guild_master}</Guild_Invite>\n"
				Hwnd.dispose("P_Status")
			else
				$console.write_line("문파장 혹은 부문파장만 쓸 수 있는 기능 입니다.")
			end
		end
		
		
		if @c.click # 교환
			if $nowtrade == 0
				$nowtrade = 1
				Network::Main.socket.send("<trade_invite>#{@usrname},#{$game_party.actors[0].name}</trade_invite>\n")
				$console.write_line("[교환]:'#{@usrname}'님에게 교환을 요청했습니다.")
				Hwnd.dispose("P_Status")
			else
				$console.write_line("[교환]:이미 요청중입니다.")
			end
		end
		
		
		if @d.click # 정보
			Jindow_NetPlayer_Info.new(@netPlayer.netid, @netPlayer.username)
			Hwnd.dispose("P_Status")
		end
	end
end
