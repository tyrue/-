
class Scene_Map
  
  alias scene_map_main main
  def main
    $map_chat_input = Jindow_Chat_Input.new
    $game_system.menu_disabled = true
    scene_map_main
    $cbig = 0
    JS.dispose
  end

  alias scene_map_update update
  def update
    scene_map_update
    JS.update
      
    
  if $game_party.actors[0].hp == 0
      Hwnd.dispose("Inventory")
      $game_party.actors[0].equip(0, 0)
      $game_party.actors[0].equip(1, 0)
      $game_party.actors[0].equip(2, 0)
      $game_party.actors[0].equip(3, 0)
      $game_party.actors[0].equip(4, 0)
     end
    
    
if not Hwnd.include?("NetPartyInv")
  if not $map_chat_input.active
    if $cbig == 0
      
      
    if $game_party.actors[0].class_name == "주술사"
      if $game_switches[16] == true
      $game_party.actors[0].str = 8
    else
      $game_party.actors[0].str = 5      
    end
  end
    
    if $game_party.actors[0].class_name == "도사"
      if $game_switches[16] == true
      $game_party.actors[0].str = 8
    else
      $game_party.actors[0].str = 5      
    end
  end
  
    
    if Key.trigger?(67) and not Hwnd.include?("System")
      Jindow_System.new
    end
    if Key.trigger?(67) 
      if not Hwnd.include?("System")
        Jindow_System.new
      else
        Hwnd.dispose("System")
      end
    end
    
    if Key.trigger?(30) 
      if not Hwnd.include?("Guild")
        Jindow_Guild.new
      else
        Hwnd.dispose("Guild")
      end
    end	

    if $game_party.actors[0].hp > 0  
      if Key.trigger?(32)
        if not Hwnd.include?("Inventory")
          Jindow_Inventory.new
        else
          Hwnd.dispose("Inventory")
        end
      end
    end	 
 
    if Key.trigger?(26) 
      if not Hwnd.include?("Status")
        Jindow_Status.new
      else
        Hwnd.dispose("Status")
      end
    end	

    if Key.trigger?(34)
      if not Hwnd.include?("Skill")
        Jindow_Skill.new
      else
        Hwnd.dispose("Skill")
      end
    end	

    if Key.trigger?(39)
      if not Hwnd.include?("NetParty")
        Jindow_NetParty.new
      else
        Hwnd.dispose("NetParty")
      end
    end	

    if Key.trigger?(35)
      if not Hwnd.include?("Jindow_NetPlayer")
        Jindow_NetPlayer.new
      else
        Hwnd.dispose("Jindow_NetPlayer")
      end
    end	
    
    if Key.trigger?(36)
       $scene = Scene_Menu.new(0)
     end 

    if Key.trigger?(11)  #아이템, 돈 줍기
      for event in $game_map.events.values
        if $game_player.x == event.x and $game_player.y == event.y
          item_index = event.id
          if $Drop[item_index] != nil
            if $Drop[item_index].type2 == 1
              if $Drop[item_index].type == 0
                $game_party.gain_item($Drop[item_index].id, 1)
              elsif $Drop[item_index].type == 1
                $game_party.gain_weapon($Drop[item_index].id, 1)
              elsif $Drop[item_index].type == 2
                $game_party.gain_armor($Drop[item_index].id, 1)
              end
              Network::Main.socket.send "<Drop_Get>#{event.id},#{$game_map.map_id}</Drop_Get>\n"
            elsif $Drop[item_index].type2 == 0
              $game_party.gain_gold($Drop[item_index].amount)
              Network::Main.socket.send "<Drop_Get>#{event.id},#{$game_map.map_id}</Drop_Get>\n"
            end
          else
            delete_events(event.id)
          end
        end
      end
    end

    
  end
end

  
end
end
end
