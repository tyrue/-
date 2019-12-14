
class Scene_Map
	
	alias scene_map_main main
	def main
		$map_chat_input = Jindow_Chat_Input.new # 채팅입력창
		$game_system.menu_disabled = true
		scene_map_main
		$cbig = 0
		JS.dispose
	end
	
	alias scene_map_update update
	def update
		scene_map_update
		JS.update
			
		# 콘솔 초기화
		if Graphics.frame_count % (Graphics.frame_rate * 5) == 0 and $console.console_log.size > 0
			$console.console_log.delete_at(0)
			$console.refresh
		end
		
		if $game_party.actors[0].hp == 0
			$game_switches[50] = false # 유저 살음 스위치 오프
			$game_switches[296] = true # 유저 죽음 스위치 온
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
					#~ if $game_party.actors[0].class_name == "주술사"
						#~ if $game_switches[16] == true
							#~ $game_party.actors[0].str = 8
						#~ else
							#~ $game_party.actors[0].str = 5      
						#~ end
					#~ end
					
					#~ if $game_party.actors[0].class_name == "도사"
						#~ if $game_switches[16] == true
							#~ $game_party.actors[0].str = 8
						#~ else
							#~ $game_party.actors[0].str = 5      
						#~ end
					#~ end
					
					if Key.trigger?(67) # `
						if not Hwnd.include?("System")
							Jindow_System.new
						else
							Hwnd.dispose("System")
						end
					end
					
					if Key.trigger?(30) # g
						if not Hwnd.include?("Guild")
							Jindow_Guild.new
						else
							Hwnd.dispose("Guild")
						end
					end	
					
					if $game_party.actors[0].hp > 0  
						if Key.trigger?(32) # i
							if not Hwnd.include?("Inventory")
								Jindow_Inventory.new
							else
								Hwnd.dispose("Inventory")
							end
						end
					end	 
					
					if Key.trigger?(26) # c
						if not Hwnd.include?("Status")
							Jindow_Status.new
						else
							Hwnd.dispose("Status")
						end
					end	
					
					if Key.trigger?(KEY_F) # f
						$chat.toggle # 채팅창 닫고 키기
					end	
					
					if Key.trigger?(KEY_R) # r
						if($skill_Delay_Console == nil)
							$skill_Delay_Console = Skill_Delay_Console.new(520, 0, 140, 110, 6)
						end
						$skill_Delay_Console.toggle
					end	
					
					if Key.trigger?(34) # k
						if not Hwnd.include?("Skill")
							Jindow_Skill.new
						else
							Hwnd.dispose("Skill")
						end
					end	
					
					if Key.trigger?(39) # p
						if not Hwnd.include?("NetParty")
							Jindow_NetParty.new
						else
							Hwnd.dispose("NetParty")
						end
					end	
					
					if Key.trigger?(KEY_J) # j
						if not Hwnd.include?("Keyset")
							Jindow_Keyset.new
						else
							Hwnd.dispose("Keyset")
						end
					end	
					
					#~ if Key.trigger?(KEY_T) and Network::Main.group == 'admin' # t
						#~ if not Hwnd.include?("Post")
							#~ Jindow_Post.new
						#~ else
							#~ Hwnd.dispose("Post")
						#~ end
					#~ end
					
					if Key.trigger?(65) # ; 감정표현
						$game_temp.common_event_id = 9
					end	
					
					
					if Key.trigger?(35) # l
						if not Hwnd.include?("NetPlayer")
							Jindow_NetPlayer.new
						else
							Hwnd.dispose("NetPlayer")
						end
					end	
					
					if Key.trigger?(36) # m
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
