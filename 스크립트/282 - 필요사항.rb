

#Request Cancle by Mu
def 맵이동
	if $nowpartyreq == 1
		Network::Main.socket.send("<nptno>#{$nptor}</nptno>\n")
		$nowpartyreq = 0
	end
	if Hwnd.include?("Trade")
		Network::Main.socket.send "<trade_fail>#{$trade_player},#{$game_party.actors[0].name}</trade_fail>\n"
	end
end

def 로그아웃
	$game_system.se_play($data_system.decision_se)
	Audio.bgm_fade(800)
	Audio.bgs_fade(800)
	Audio.me_fade(800)
	if Network::Main.socket != nil
		자동저장 if $game_party.actors[0].name != "\no"
		$login_check = false
		Network::Main.socket.send "<trade_fail>#{$trade_player},#{$game_party.actors[0].name}</trade_fail>\n" #거래를 종료한다
		Network::Main.socket.send("<nptout>#{$game_party.actors[0].name} #{$npt}</nptout>\n") #파티를 탈퇴한다
		Network::Main.socket.send("<9>#{Network::Main.id}</9>\n")
		$ABS.close_buff if $ABS != nil
	end
	
	JS.dispose 
	$scene = Scene_Connect.new
end

def 게임종료
	Audio.bgm_fade(800)
	Audio.bgs_fade(800)
	Audio.me_fade(800)
	$game_system.se_play($data_system.decision_se)
	if Network::Main.socket != nil
		자동저장 if $game_party.actors[0].name != "\no"
		$login_check = false
		Network::Main.socket.send "<trade_fail>#{$trade_player},#{$game_party.actors[0].name}</trade_fail>\n" #거래를 종료한다
		Network::Main.socket.send("<nptout>#{$game_party.actors[0].name} #{$npt}</nptout>\n") #파티를 탈퇴한다
		Network::Main.socket.send("<9>#{Network::Main.id}</9>\n")
		$ABS.close_buff if $ABS != nil
	end
	
	JS.dispose 
	$scene = nil
end
