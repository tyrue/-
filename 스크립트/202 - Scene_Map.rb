
class Scene_Map
	
	alias scene_map_main main
	def main
		initialize_windows
		setup_windows_visibility
		dispose_shop_windows
		scene_map_main
	end
	
	def initialize_windows
		$map_chat_input ||= Jindow_Chat_Input.new
		$chat ||= Jindow_Chat_Window.new
		$console ||= Jindow_Console.new
		initialize_inventory_window unless Hwnd.include?("Inventory")
	end
	
	def initialize_inventory_window
		$j_inven = Jindow_Inventory.new
		$j_inven.toggle
	end
	
	def setup_windows_visibility
		$game_system.menu_disabled = true
		$chat.hide unless $game_switches[60]
		$console.hide unless $game_switches[61]
		$j_inven.hide if $j_inven && !$j_inven.temp_sw
	end
	
	def dispose_shop_windows
		["Shop_Window", "Shop_Sell_Window", "Shop_Menu_Window"].each do |window|
			Hwnd.dispose(window) if Hwnd.include?(window)
		end
	end
	
	alias scene_map_update update
	def update
		scene_map_update
		JS.update
		update_game_switches
		update_key_presses
	end
	
	def update_game_switches
		$game_switches[50] = $game_party.actors[0].hp > 0
		$game_switches[296] = $game_party.actors[0].hp <= 0
	end
	
	def update_key_presses
		return unless check_key_active_ready
		
		handle_toggle_windows
		handle_other_key_presses
		handle_admin_key_presses
	end
	
	def check_key_active_ready
		#return false if $map_chat_input.active
		return false if $inputKeySwitch
		
		return true
	end
	
	def handle_admin_key_presses
		return unless Network::Main.group == 'admin'
		
		toggle_window("Post", KEY_T) 
	end
	
	def handle_toggle_windows
		toggle_window("System", 67) # `
		#toggle_window("Guild", KEY_G) # g
		toggle_window("Status", KEY_C) # c
		toggle_window("Skill", KEY_K) # k
		toggle_window("NetParty", KEY_P) # p
		toggle_window("Keyset", KEY_J) # j
		toggle_window("NetPlayer", KEY_L) # l
		toggle_window("Quest", KEY_Q) # q
		
		toggle_help_window
		toggle_inventory_window
		toggle_chat_window
		toggle_skill_delay_console
		toggle_console_window
		toggle_spriteset_id
	end
	
	def toggle_help_window
		return unless Input.trigger?(Input::Fkeys[1]) # f1
		
		Hwnd.include?("help") ? Hwnd.dispose("help") : Jindow_help.new
	end
	
	def toggle_inventory_window
		return unless Key.trigger?(KEY_I) # i
		
		Hwnd.include?("Inventory") ? $j_inven.toggle : $j_inven = Jindow_Inventory.new
	end
	
	def toggle_chat_window
		$chat.toggle if Key.trigger?(KEY_F) # f
	end
	
	def toggle_skill_delay_console
		if Key.trigger?(KEY_R) # r
			$skill_Delay_Console ||= Skill_Delay_Console.new(520, 0, 140, 110, 6)
			$skill_Delay_Console.toggle
		end
	end
	
	def toggle_console_window
		$console.toggle if Key.trigger?(KEY_V) # v
	end
	
	def toggle_spriteset_id
		@spriteset.toggle_id if Key.trigger?(KEY_N)
	end
	
	def handle_other_key_presses
		$game_temp.common_event_id = 9 if Key.trigger?(65) # ; 감정표현
	end
	
	def toggle_window(window_name, key_code)
		return unless Key.trigger?(key_code)
		
		Hwnd.include?(window_name) ? Hwnd.dispose(window_name) : Object.const_get("Jindow_#{window_name}").new
	end
end
