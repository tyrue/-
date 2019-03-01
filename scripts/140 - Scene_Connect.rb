class Scene_Connect
	attr_reader :login_window
	attr_reader :register_window
	attr_reader :status_console
	
	def main
		$trade_item = []
		$item_number = []
		$party_name = ""
		$party_reader = ""
		$switches = []
		$variables = []
		$variables1 = []
		$switches1 = []
		$guild = ""
		$guild_master = ""
		$guild_group = ""
		$guild_member = []
		$trade_player_money = 0
		$mob_id = []
		$saybul = ""
		$Drop = []
		$netparty = []
		$data_actors        = load_data("Data/Actors.rxdata")
		$data_classes       = load_data("Data/Classes.rxdata")
		$data_skills        = load_data("Data/Skills.rxdata")
		$data_items         = load_data("Data/Items.rxdata")
		$data_weapons       = load_data("Data/Weapons.rxdata")
		$data_armors        = load_data("Data/Armors.rxdata")
		$data_enemies       = load_data("Data/Enemies.rxdata")
		$data_troops        = load_data("Data/Troops.rxdata")
		$data_states        = load_data("Data/States.rxdata")
		$data_animations    = load_data("Data/Animations.rxdata")
		$data_tilesets      = load_data("Data/Tilesets.rxdata")
		$data_common_events = load_data("Data/CommonEvents.rxdata")
		$data_system        = load_data("Data/System.rxdata")
		$game_system = Game_System.new
		$game_temp          = Game_Temp.new
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
		$game_party.setup_starting_members
		$game_system          = Game_System.new
		Network::Main.initialize
		
		@login_window = Jindow_Server.new
		Graphics.transition
		#Network::Main.retrieve_version
		$game_system.bgm_play($data_system.title_bgm)
		loop do
			Graphics.update
			Input.update
			update
			Network::Base.update
			if $scene != self
				break
			end
		end
		Graphics.freeze
		JS.dispose
	end
	
	def update
		JS.update
	end
end
