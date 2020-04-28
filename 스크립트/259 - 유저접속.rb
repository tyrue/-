# 게임을 시작할 때가 아님, 로그인 부터임
def 유저접속
	if $nickname
		$game_party.actors[0].name = $nickname
	end
	Network::Main.update
	$ABS = MrMo_ABS.new
	$game_party.setup_starting_members
	$game_map.setup($data_system.start_map_id)
	$game_player.moveto($data_system.start_x, $data_system.start_y)
	$game_player.refresh
	$game_map.autoplay
	$game_map.update
	
	Network::Main.socket.send("<dtloadreq>'req'</dtloadreq>\n")
	Network::Main.socket.send("<exp_event></exp_event>\n")     
	$game_switches[401] = true # 경험치 이벤트는 켜 있는 상태
	$scene = Scene_Reinit.new
	
	$skill_Delay_Console = Skill_Delay_Console.new(520, 0, 140, 110, 6)
	$skill_Delay_Console.show
end