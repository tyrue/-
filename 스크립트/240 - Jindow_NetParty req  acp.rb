# 파티 초대를 받았을 때의 경우를 설정
def nptreq1(nptnpt)
	$nowpartyreq = 1
	data = nptnpt
	data1 = $game_party.actors[0].name
	$netparty[0] = data
	$netparty[1] = data1
	Network::Main.socket.send("<nptyes>#{nptnpt} #{$game_party.actors[0].name}</nptyes>\n")
	$console.write_line("[파티]:파티에 참가하셨습니다.")
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptyes1(npty)
	data = $game_party.actors[0].name
	data1 = npty
	$netparty[0] = data
	$netparty[1] = data1
	# data1에 이름만 넣는게 아니라 해당 유저의 정보를 넣는게 좋은데..
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptout1
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptreq2(nptnpt1, nptnpt2)
	$nowpartyreq = 1
	data = nptnpt1
	data1 = nptnpt2
	data2 = $game_party.actors[0].name
	$netparty[0] = data
	$netparty[1] = data1
	$netparty[2] = data2
	Network::Main.socket.send("<nptyes1>#{nptnpt1} #{nptnpt2} #{$game_party.actors[0].name}</nptyes1>\n")
	$console.write_line("[파티]:파티에 참가하셨습니다.")
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptyes2(npty1, npty2)
	data = $game_party.actors[0].name
	data1 = npty1
	data2 = npty2
	$netparty[0] = data
	$netparty[1] = data1
	$netparty[2] = data2
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptreq3(nptnpt3, nptnpt4, nptnpt5)
	$nowpartyreq = 1
	data = nptnpt3
	data1 = nptnpt4
	data2 = nptnpt5
	data3 = $game_party.actors[0].name
	$netparty[0] = data
	$netparty[1] = data1
	$netparty[2] = data2
	$netparty[3] = data3
	Network::Main.socket.send("<nptyes2>#{nptnpt3} #{nptnpt4} #{nptnpt5} #{$game_party.actors[0].name}</nptyes2>\n")
	$console.write_line("[파티]:파티에 참가하셨습니다.")
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptyes3(npty3, npty4, npty5)
	data = $game_party.actors[0].name
	data1 = npty3
	data2 = npty4
	data3 = npty5
	$netparty[0] = data
	$netparty[1] = data1
	$netparty[2] = data2
	$netparty[3] = data3
	Hwnd.dispose("NetParty")
	Jindow_NetParty.new
end

def nptnot
	$nowpartyreq = 1
	Network::Main.socket.send("<nptno>#{$nptor}</nptno>\n")
end