def 파일확인
    Network::Main.update
    Audio.bgm_stop
    update
    Graphics.frame_count = 0
    $game_temp          = Game_Temp.new
    $jindow_temp          = Jindow_Temp.new
    $game_system        = Game_System.new
    $game_switches      = Game_Switches.new
    $game_variables     = Game_Variables.new
    $game_self_switches = Game_SelfSwitches.new
    $game_screen        = Game_Screen.new
    $game_actors        = Game_Actors.new
    $game_party         = Game_Party.new
    $game_troop         = Game_Troop.new
    $game_map           = Game_Map.new
    $game_player        = Game_Player.new
    $ABS = MrMo_ABS.new
    $game_party.setup_starting_members
    $game_map.setup($data_system.start_map_id)
    $game_player.moveto($data_system.start_x, $data_system.start_y)
    $game_player.refresh
    $game_map.autoplay
    $game_map.update
    Network::Main.send_start
    if $nickname
      $game_party.actors[0].name = $nickname
    end
      Network::Main.socket.send("<dtloadreq>'req'</dtloadreq>\n")
      Network::Main.socket.send("<skill_call>repacket</skill_call>\n")
      Network::Main.socket.send("<23_call>repacket</23_call>\n")
      Network::Main.socket.send("<guild_call>repacket</guild_call>\n")
      $scene = Scene_Reinit.new
end