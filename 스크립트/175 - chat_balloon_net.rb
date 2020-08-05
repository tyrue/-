class Chat_balloon_net 
	attr_accessor :chat_b
	
	def initialize()
		@viewport = Viewport.new(0, 0, 640, 480)
		@chat_b = {}
	end
	
	def refresh
		@chat_b = {}
	end
	
	def input(txt = "테스트", type = 1, sec = 4, ch = $game_player)
		bitmap = Bitmap.new(500, 16)
		bitmap.font.name = "맑은 고딕"
		bitmap.font.size = 16
		case type
		when 1 # 일반
			bitmap.font.color = Color.new(255, 255, 255)
		when 2 # 파티
			
		else # 기타
			
		end
		rect = bitmap.text_size(txt)
		bitmap.fill_rect(0, 0, rect.width, rect.height, Color.new(0, 0, 0, 125)) # 꽉찬 네모
		bitmap.draw_text(0, 0, 500, 16, txt)
		
		cx = ch.screen_x - (rect.width / 2)
		cy = ch.screen_y - 55
		
		if ch != $game_player
			@chat_b[ch.name] = Chat_data.new
			@chat_b[ch.name].ch = ch
			@chat_b[ch.name].sec = sec * 60
			@chat_b[ch.name].ox = cx
			@chat_b[ch.name].oy = cy
			@chat_b[ch.name].txt = txt
			
			$chat_s[ch.name] = Sprite.new
			$chat_s[ch.name].bitmap = bitmap
			$chat_s[ch.name].x = cx
			$chat_s[ch.name].y = cy
			
			$chat_s[ch.name].z = 3000
			$chat_s[ch.name].visible = true
			$chat_s[ch.name].opacity = 255
			
		else
			@chat_b[0] = Chat_data.new
			@chat_b[0].ch = ch
			@chat_b[0].sec = sec * 60
			@chat_b[0].ox = cx
			@chat_b[0].oy = cy
			@chat_b[0].txt = txt
			
			$chat_s[0] = Sprite.new
			$chat_s[0].bitmap = bitmap
			$chat_s[0].x = cx
			$chat_s[0].y = cy
			
			$chat_s[0].z = 3000
			$chat_s[0].visible = true
			$chat_s[0].opacity = 255
		end 
	end
	
	def update
		for cb in @chat_b
			if @chat_b[cb[0]].sec > 0
				@chat_b[cb[0]].sec -= 1
				char = @chat_b[cb[0]].ch
				rect = $chat_s[cb[0]].bitmap.text_size(@chat_b[cb[0]].txt)
				
				cx = char.screen_x - (rect.width / 2)
				cy = char.screen_y - 55
				
				if @chat_b[cb[0]].ox != cx
					$chat_s[cb[0]].x = cx
					@chat_b[cb[0]].ox = cx
				end
				
				if @chat_b[cb[0]].oy != cy
					$chat_s[cb[0]].y = cy
					@chat_b[cb[0]].oy = cy
				end
				
				if @chat_b[cb[0]].sec <= 0
					$chat_s[cb[0]].visible = false
					$chat_s[cb[0]].dispose
				end
			end
		end
	end
end

class Chat_data
	attr_accessor :sec
	attr_accessor :ox
	attr_accessor :oy
	attr_accessor :ch
	attr_accessor :txt
end

$chat_b = Chat_balloon_net.new
$chat_s = {}