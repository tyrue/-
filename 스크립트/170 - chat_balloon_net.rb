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
		return if txt == nil or txt == ""
		bitmap = Bitmap.new(500, 16)
		bitmap.font.name = "맑은 고딕"
		bitmap.font.size = 16
		case type
		when 1 # 일반
			bitmap.font.color = COLOR_NORMAL
		when 2 # 파티
			bitmap.font.color = COLOR_PARTY
		when 3 # 스킬
			bitmap.font.color = COLOR_EVENT
		else # 기타
			
		end
		rect = bitmap.text_size(txt)
		bitmap.fill_rect(0, 0, rect.width, rect.height, Color.new(0, 0, 0, 125)) # 꽉찬 네모
		bitmap.draw_frame_text(0, 0, 500, 16, txt)
		
		cx = ch.screen_x - (rect.width / 2)
		cy = ch.screen_y - 55
		
		if ch != $game_player
			id = ""
			if ch.is_a?(Game_Event)
				id = ch.id.to_s
			else
				id = ch.name
			end
			
			@chat_b[id] = Chat_data.new
			@chat_b[id].ch = ch
			@chat_b[id].sec = sec * 60
			@chat_b[id].ox = cx
			@chat_b[id].oy = cy
			@chat_b[id].txt = txt
			
			$chat_s[id].dispose if $chat_s[ch.name] != nil and not $chat_s[ch.name].disposed?
			
			$chat_s[id] = Sprite.new
			$chat_s[id].bitmap = bitmap
			$chat_s[id].x = cx
			$chat_s[id].y = cy
			
			$chat_s[id].z = 3000
			$chat_s[id].visible = true
			$chat_s[id].opacity = 255
			
		else
			@chat_b[0] = Chat_data.new
			@chat_b[0].ch = ch
			@chat_b[0].sec = sec * 60
			@chat_b[0].ox = cx
			@chat_b[0].oy = cy
			@chat_b[0].txt = txt
			
			$chat_s[0].dispose if $chat_s[0] != nil and not $chat_s[0].disposed?
			
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
			id = cb[0]
			balloon = cb[1]
			
			if balloon.sec > 0
				balloon.sec -= 1
				char = balloon.ch
				rect = $chat_s[id].bitmap.text_size(balloon.txt)
				
				cx = char.screen_x - (rect.width / 2)
				cy = char.screen_y - 55
				
				if balloon.ox != cx
					$chat_s[id].x = cx
					balloon.ox = cx
				end
				
				if balloon.oy != cy
					$chat_s[id].y = cy
					balloon.oy = cy
				end
				
				if balloon.sec <= 0
					$chat_s[id].visible = false
					$chat_s[id].dispose
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