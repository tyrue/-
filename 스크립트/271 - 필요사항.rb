

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

def 게임종료
	#Network::Main.socket.send("<chat>(알림):'#{$game_party.actors[0].name}'님께서 게임을 종료하셨습니다.</chat>\n")
	if Network::Main.socket != nil
		자동저장 if $game_party.actors[0].name != "\no"
		$ABS.close_buff if $ABS != nil
		#거래를 종료한다
		Network::Main.socket.send "<trade_fail>#{$trade_player},#{$game_party.actors[0].name}</trade_fail>\n"
		
		#파티를 탈퇴한다
		Network::Main.socket.send("<nptout>#{$game_party.actors[0].name} #{$npt}</nptout>\n")
		
		Network::Main.socket.send("<9>#{Network::Main.id}</9>\n")
		$global_x = 0
	end
end
