# 게임을 시작할 때가 아님, 로그인 부터임
def 유저접속
	if $nickname
		$game_party.actors[0].name = $nickname
	end
	Network::Main.update
	$ABS = MrMo_ABS.new unless $ABS
	$rpg_skill = Rpg_skill.new unless $rpg_skill # 스킬 사용에 대한 클래스
	$game_party.setup_starting_members
	
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
	$Abs_item_data = Item_data.new unless $Abs_item_data
	
	$console = nil
	$chat = nil
	$map_chat_input = nil
	$j_inven = nil
	$net_party_manager = PartyManager.new
	$trade_manager = TradeManager.new
	
	# 장비 아이템 체력, 마력 옵션 
	Set_Weapon_plus.new 
	Set_Armor_plus.new
	
	$skill_Delay_Console = Skill_Delay_Console.new(520, 0, 140, 110, 6)
	$skill_Delay_Console.show
	
	$game_map.setup($data_system.start_map_id)
	$game_player.moveto($data_system.start_x, $data_system.start_y)
	$game_player.refresh
	$game_map.autoplay
	$game_map.update
end