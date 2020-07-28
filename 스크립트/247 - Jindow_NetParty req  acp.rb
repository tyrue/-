# 파티 초대를 받았을 때의 경우를 설정
def nptreq(name, party_mem)
	$npt = name
	party_mem = party_mem.split(",")
	for mem in party_mem
		$netparty.push(mem)
	end
	$netparty.push($game_party.actors[0].name)
	
	Network::Main.socket.send("<nptyes>#{$npt} #{$game_party.actors[0].name}</nptyes>\n")
	$console.write_line("[파티]:파티에 참가하셨습니다.")
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptyes(name)
	$netparty.push(name)
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptout
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptnot(name)
	Network::Main.socket.send("<nptno>#{name}</nptno>\n")
end