class Chat_balloon 
	def initialize()
		@type = 1
		@color = Color.new(255, 255, 255)
		@text = ""
		@sec = 4 * 60
		
		@chat_b = {}
		@ox = {}
		@oy = {}
	end
	
	def input(ch = $game_player, txt = @text, type = @type, sec = @sec)
		@chat_b[ch] = ch 
	end
	
	def update
		super
		if @sec > 0
			@sec -= 1
			if @ox != @char.x
				if @char.x <= 10
					self.x = (@char.x) * 32
					@ox = @char.x
				elsif $game_map.width - @char.x <= 10
					self.x = (@char.x - 2) * 32
					@ox = @char.x
				end
			end
			
			if @oy != @char.y
				if @char.y <= 10
					self.y = (@char.y - $game_map.display_y / 128) * 32 - 55
					@oy = @char.y
				elsif $game_map.height - @char.y <= 10
					self.y = (@char.y - $game_map.display_y / 128) * 32 - 55
					@oy = @char.y
				end
			end
			
			if @sec == 0
				self.visible = false
				self.dispose
			end
		end
	end
end