#Request Cancle by Mu
def 맵이동
	$net_party_manager.refuse_party()
	$trade_manager.trade_refuse()
end

def 로그아웃
	close_game
	$scene = Scene_Connect.new
end

def 게임종료
	close_game
	$scene = nil
end

def close_game
	$game_system.se_play($data_system.decision_se)
	Audio.bgm_fade(800)
	Audio.bgs_fade(800)
	Audio.me_fade(800)
	
	close_network
	
	$ABS.close_buff if $ABS != nil
	JS.dispose 
end

def close_network
	if Network::Main.socket != nil
		자동저장 
		$login_check = false
		$trade_manager.trade_refuse() if $trade_manager
		$net_party_manager.end_party() if $net_party_manager
		Network::Main.send_with_tag("9", "#{Network::Main.id}")
	end
end
