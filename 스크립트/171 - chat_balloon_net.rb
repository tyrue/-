class Chat_balloon_net 
	attr_accessor :chat_b
	
	def initialize()
		@viewport = Viewport.new(0, 0, 640, 480)
		@chat_b = {}
		@width = 150
		@height = 100
		@font_size = 20
		@font_name = "메이플스토리"
		@font_name_default = "맑은 고딕"
	end
	
	def refresh
		@chat_b = {}
	end
	
	def input(txt = "테스트", type = 1, sec = 4, ch = $game_player)
		return if txt == nil or txt == ""
		bitmap = Bitmap.new(@width, @height)
		
		@font_size = 18
		@font_name = Font.exist?("메이플스토리") ? "메이플스토리" : @font_name_default
		case type
		when 1 # 일반
			bitmap.font.color = COLOR_NORMAL
		when 2 # 파티
			bitmap.font.color = COLOR_PARTY
		when 3 # 스킬
			bitmap.font.color = COLOR_EVENT
			@font_size = 20
		when 4 # 귓속말
			bitmap.font.color = COLOR_WHISPER
		else # 기타
			bitmap.font.color = COLOR_NORMAL
		end
		
		bitmap.font.name = @font_name
		bitmap.font.size = @font_size
		w = 0
		h = 0
		@now_w = 0
		@now_h = @font_size
		
		for i in txt.scan(/./)
			rect = bitmap.text_size(i)
			if w + rect.width > @width
				h += rect.height
				w = 0
				bitmap.draw_frame_text(w, h, rect.width, rect.height, i)
				w += rect.width
			else
				bitmap.draw_frame_text(w, h, rect.width, rect.height, i)
				w += rect.width
				@now_w = w if @now_w <= w
			end
		end
		
		@now_h += h
		bitmap2 = Bitmap.new(@now_w, @now_h)
		bitmap2.fill_rect(0, 0, @now_w, @now_h, Color.new(0, 0, 0, 125)) # 꽉찬 네모
		
		src_rect = Rect.new(0, 0, bitmap2.width, bitmap2.height) 
		dest_rect = Rect.new(0, 0, bitmap2.width, bitmap2.height) 
		bitmap2.stretch_blt(dest_rect, bitmap, src_rect) 
		
		bitmap = bitmap2
		
		cx = @now_w / 2
		cy = @now_h + 60
		
		id = 0
		if ch != $game_player
			id = ""
			if ch.is_a?(Game_Event)
				id = ch.id.to_s
			else
				id = ch.name
			end		
		end 
		
		@chat_b[id] = Chat_data.new
		@chat_b[id].ch = ch
		@chat_b[id].sec = sec * 60
		@chat_b[id].ox = cx
		@chat_b[id].oy = cy
		@chat_b[id].txt = txt
		
		if $chat_s[id] != nil and !$chat_s[id].disposed?
			$chat_s[id].bitmap.clear
			$chat_s[id].dispose 
		end
		
		$chat_s[id] = Sprite.new
		$chat_s[id].bitmap = bitmap
		
		$chat_s[id].x = ch.screen_x - cx
		$chat_s[id].y = ch.screen_y - cy
		
		$chat_s[id].z = 3000
		$chat_s[id].visible = true
		$chat_s[id].opacity = 255
	end
	
	def update
		for cb in @chat_b
			id = cb[0]
			balloon = cb[1]
			
			if balloon.sec > 0
				balloon.sec -= 1
				char = balloon.ch
				
				cx = char.screen_x - balloon.ox
				cy = char.screen_y - balloon.oy
				
				$chat_s[id].x = cx 
				$chat_s[id].y = cy 
				
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