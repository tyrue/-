def 유저접속
	Network::Main.update
	#Network::Main.send_start
	$ABS = MrMo_ABS.new
	$game_party.setup_starting_members
	$game_map.setup($data_system.start_map_id)
	$game_player.moveto($data_system.start_x, $data_system.start_y)
	Network::Main.socket.send("<dtloadreq>'req'</dtloadreq>\n")
	#Network::Main.send_start
	$scene = Scene_Reinit.new
end