
class Scene_Map
	
	alias scene_map_main main
	def main
		Hwnd.show
		$map_chat_input = Jindow_Chat_Input.new if $map_chat_input == nil  # 채팅입력창
		$chat = Jindow_Chat_Window.new if $chat == nil # 채팅창
		$console = Jindow_Console.new if $console == nil # 콘솔창
		$game_system.menu_disabled = true
		
		$chat.hide if !$game_switches[60]
		$console.hide if !$game_switches[61]
		scene_map_main
		
		$cbig = 0
		Hwnd.hide
	end
	
	alias scene_map_update update
	def update
		scene_map_update
		JS.update
		
		if $game_party.actors[0].hp == 0
			#Hwnd.dispose("Inventory") if Hwnd.include?("Inventory")
			$game_switches[50] = false if $game_switches[50] != false # 유저 살음 스위치 오프
			$game_switches[296] = true if $game_switches[296] != true # 유저 죽음 스위치 온
		end
		
		if not Hwnd.include?("NetPartyInv")
			if not $map_chat_input.active
				if $cbig == 0
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
						
					end	 
					
					if Key.trigger?(KEY_I) # i
						if not Hwnd.include?("Inventory")
							Jindow_Inventory.new
						else
							Hwnd.dispose("Inventory")
						end
						#~ if Key.press?(KEY_SHIFT)# 조합창
						#~ if not Hwnd.include?("craft")
						#~ Jindow_craft.new
						#~ else
						#~ Hwnd.dispose("craft")
						#~ end
						#~ else # 인벤토리
						#~ end
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
						#$jin_chat.toggle
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
					
					if Key.trigger?(KEY_V) # v
						$console.toggle
					end	
					
					if Key.trigger?(35) # l
						if not Hwnd.include?("NetPlayer")
							Jindow_NetPlayer.new
						else
							Hwnd.dispose("NetPlayer")
						end
					end	
					
					if Input.trigger?(Input::Fkeys[1]) # f1
						if not Hwnd.include?("help")
							Jindow_help.new
						else
							Hwnd.dispose("help")
						end
					end	
					
					if Key.trigger?(KEY_N)
						@spriteset.toggle_id
					end
				end
			end
		end
	end
end
