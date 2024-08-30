#==============================================================================
# ■ Jindow_Server
#------------------------------------------------------------------------------
#   서버 선택 창
#------------------------------------------------------------------------------
class Jindow_Server < Jindow
	def initialize
		$game_variables[12] = 80
		$game_variables[13] = 80
		super(0, 0, 120, User_Edit::SERVERS.size * 30 + 35)
		self.name = "서버 선택"
		@head = true
		@mark = true
		
		self.refresh "Server"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@buttons = []
		@server_data = []
		i = 0
		User_Edit::SERVERS.each do |ip, port, name|
			#next if User_Edit::TEST && name != "테스트"
			next if !User_Edit::TEST && name == "테스트"
			
			button = J::Button.new(self).refresh(120, name)
			button.y = i * 30 + 12
			
			@buttons << button
			@server_data << [ip, port]
			i += 1
		end
		
		@a = J::Button.new(self).refresh(60, "종료")
		@a.x = self.width - 60
		@a.y = @buttons.last.y + @buttons.last.height + 14
		self.height = @a.y + @a.height + 10
		self.refresh "Server"
	end
	
	def update
		super
		
		@buttons.each_with_index do |button, i|
			next unless button.click
			
			Network::Main.initialize
			Network::Main.start_connection(@server_data[i][0], @server_data[i][1])
			Network::Main.amnet_auth
			
			$scene = Scene_Login.new
		end
		
		if @a.click  # 취소
			$game_system.se_play($data_system.decision_se)
			JS.game_end
		end
	end
end
