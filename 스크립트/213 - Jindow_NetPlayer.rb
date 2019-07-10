class Jindow_NetPlayer < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 120, 150)
		self.name = "접속자 목록"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh "NetPlayer"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		@buttons = {}
		player = []
		i = 0
		for netplayer in Network::Main.players.values 
			if netplayer.netid == Network::Main.id
				@buttons[$game_party.actors[0].name] = J::Button.new(self).refresh(120, $game_party.actors[0].name)
				@buttons[$game_party.actors[0].name].y = i * 30 + 12
				i += 1
			else
				@buttons[netplayer.name] = J::Button.new(self).refresh(120, netplayer.name)
				@buttons[netplayer.name].y = i * 30 + 12
				i += 1
			end
		end
		@a = J::Button.new(self).refresh(60, "취소")
		@a.x = self.width - 60
		@a.y = @buttons.size * 30 + 14
	end
	
	def update
		super
		for netplayer in Network::Main.players.values 
			if @buttons[netplayer.name] != nil
				@buttons[netplayer.name].click ?
				
				Jindow_NetPlayer_Info.new(netplayer.netid, netplayer.name) : 0
			elsif @buttons[$game_party.actors[0].name] != nil
				@buttons[$game_party.actors[0].name].click ?
				
				Jindow_Status.new : 0
			end
		end
		if @a.click  # 취소
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
		end
	end
end
