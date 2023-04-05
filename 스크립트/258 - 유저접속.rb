# 게임을 시작할 때가 아님, 로그인 부터임
def 유저접속
	if $nickname
		$game_party.actors[0].name = $nickname
	end
	Network::Main.update
	$ABS = MrMo_ABS.new
	$rpg_skill = Rpg_skill.new # 스킬 사용에 대한 클래스
	$game_party.setup_starting_members
	$game_map.setup($data_system.start_map_id)
	$game_player.moveto($data_system.start_x, $data_system.start_y)
	$game_player.refresh
	$game_map.autoplay
	$game_map.update
	
	Network::Main.socket.send("<dtloadreq>'req'</dtloadreq>\n")
	Network::Main.socket.send("<exp_event></exp_event>\n")
	Network::Main.socket.send("<drop_event></drop_event>\n")     
	
	$game_variables[11] = 1
	$game_variables[12] = 60
	$game_variables[13] = 60
	
	$game_switches[401] = true # 경험치 이벤트는 켜 있는 상태
	$game_switches[60] = true
	$game_switches[61] = true
	$game_switches[62] = true
	
	$cbig = 0
	$nowtrade = 0
	$game_player.move_speed = $rpg_skill.player_base_move_speed
	$scene = Scene_Reinit.new
	$Abs_item_data = Item_data.new
	
	$console = nil
	$chat = nil
	$map_chat_input = nil
	$j_inven = nil
	
	# 장비 아이템 체력, 마력 옵션 
	Set_Weapon_plus.new 
	Set_Armor_plus.new
	
end