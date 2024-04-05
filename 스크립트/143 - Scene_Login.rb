class Scene_Login
	attr_reader :login_window
	attr_reader :register_window
	attr_reader :status_console
	def main
		@login_window = Jindow_Login.new
		Network::Main.retrieve_version
		Graphics.transition
		$game_system.bgm_play($data_system.title_bgm)
		@sprite = Sprite.new
		@sprite.bitmap = RPG::Cache.title($data_system.title_name)
		@sprite.opacity = 255
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
		@sprite.dispose
		JS.dispose
		$login_check = false
	end
	
	def update
		JS.update
	end
end
