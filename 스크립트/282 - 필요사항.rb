

#Request Cancle by Mu
def 맵이동
	if $nowpartyreq == 1
		$net_party_manager.refuse_party()
		$nowpartyreq = 0
	end
	if Hwnd.include?("Trade")
		Network::Main.socket.send "<trade_fail>#{$trade_player},#{$game_party.actors[0].name}</trade_fail>\n"
	end
end

def close_game
	$game_system.se_play($data_system.decision_se)
	Audio.bgm_fade(800)
	Audio.bgs_fade(800)
	Audio.me_fade(800)
	
	if Network::Main.socket != nil
		자동저장 if $game_party.actors[0].name != "\no"
		$login_check = false
		Network::Main.socket.send "<trade_fail>#{$trade_player},#{$game_party.actors[0].name}</trade_fail>\n" #거래를 종료한다
		$net_party_manager.end_party()
		Network::Main.socket.send("<9>#{Network::Main.id}</9>\n")
		#Network::Main.close_socket 
		$ABS.close_buff if $ABS != nil
	end
	
	JS.dispose 
end

def 로그아웃
	close_game
	$scene = Scene_Connect.new
end

def 게임종료
	close_game
	$scene = nil
end
