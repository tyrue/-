class Chat_balloon_net 
	def initialize()
		@type = 1
		@color = Color.new(255, 255, 255)
		@text = "테스트"
		@sec = 4 * 60
		
		@viewport = Viewport.new(0, 0, 640, 480)
		@chat_b = {}
		@ox = {}
		@oy = {}
	end
	
	def input(txt = @text, type = @type, sec = @sec, ch = $game_player)
		bitmap = Bitmap.new(500, 16)
		bitmap.font.name = "맑은 고딕"
		bitmap.font.size = 16
		case type
		when 1
			bitmap.font.color = Color.new()
		when 2
			
		else
			
		end
		rect = bitmap.text_size(txt)
		bitmap.fill_rect(0, 0, rect.width, rect.height, Color.new(0, 0, 0, 125)) # 꽉찬 네모
		bitmap.draw_text(0, 0, 500, 16, msg)
		
		if ch != $game_player
			@chat_b[ch.name] = Sprite.new(@viewport)
			
		else
			@chat_b[$game_party.actors[0].name] = Sprite.new(@viewport)
			
			
			$m_s.bitmap = bitmap
			$m_s.x = ($game_player.x - $game_map.display_x / 128) * 32 - (rect.width / 2)
			$m_s.y = ($game_player.y - $game_map.display_y / 128) * 32 - 55
			
			$m_s.z = 3000
			$m_s.visible = true
			@sec = sec * 60
			
			@ox = $game_player.x
			@oy = $game_player.y
		end 
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