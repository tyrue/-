class Chat_balloon_net 
	attr_accessor :chat_b
	
	def initialize()
		@viewport = Viewport.new(0, 0, 640, 480)
		@chat_b = {}
		@width = 150
		@height = 100
		@font_size = 16
		@default_font_name = Font.exist?("메이플스토리") ? "메이플스토리" : "맑은 고딕"
	end
	
	def refresh
		@chat_b = {}
	end
	
	def input(text = "테스트", type = 1, sec = 4, ch = $game_player)
		return if text.nil? || text.empty?
		
		name_prefix = ""
		name_prefix = "#{$game_party.actors[0].name} : " if ch == $game_player && type != 3
		content = "#{name_prefix}#{text}"
		
		bitmap = create_bitmap(content, type)
		set_chat_balloon_data(id, ch, sec, bitmap)
	end
	
	def create_bitmap(content, type)
		bitmap = Bitmap.new(@width, @height)
		set_font_style(bitmap, type)
		draw_text_on_bitmap(bitmap, content) # 텍스트를 그리기
		bitmap = fill_rect_on_bitmap(bitmap)
		return bitmap
	end
	
	def set_font_style(bitmap, type)
		bitmap.font.name = @default_font_name
		bitmap.font.size = @font_size
		
		case type
		when 1  # 일반
			bitmap.font.color = COLOR_NORMAL
		when 2  # 파티
			bitmap.font.color = COLOR_PARTY
		when 3  # 스킬
			bitmap.font.color = COLOR_EVENT
			bitmap.font.size = 20
		when 4  # 귓속말
			bitmap.font.color = COLOR_WHISPER
		else   # 기타
			bitmap.font.color = COLOR_NORMAL
		end
	end
	
	def draw_text_on_bitmap(bitmap, content)
		w = 0
		h = 0
		@now_w = 0
		@now_h = bitmap.font.size
		
		for i in content.scan(/./)
			rect = bitmap.text_size(i)
			if w + rect.width > @width
				h += rect.height
				w = 0
			end
			
			bitmap.draw_frame_text(w, h, rect.width, rect.height, i)
			w += rect.width
			@now_w = w if @now_w <= w
		end
		@now_h += h
	end
	
	def fill_rect_on_bitmap(bitmap)
		bitmap2 = Bitmap.new(@now_w, @now_h)
		bitmap2.fill_rect(0, 0, @now_w, @now_h, Color.new(0, 0, 0, 125)) # 꽉찬 네모
		src_rect = Rect.new(0, 0, bitmap2.width, bitmap2.height) 
		dest_rect = Rect.new(0, 0, bitmap2.width, bitmap2.height) 
		bitmap2.stretch_blt(dest_rect, bitmap, src_rect) 
		return bitmap2
	end
	
	def set_chat_balloon_data(id, character, duration, bitmap)
		dispose_existing_sprite(id)
		
		chat_balloon = Chat_data.new
		chat_balloon.ch = character
		chat_balloon.sec = duration * 60
		chat_balloon.ox = @now_w / 2
		chat_balloon.oy = @now_h + 60
		
		sprite = Sprite.new
		sprite.bitmap = bitmap
		sprite.x = character.screen_x - chat_balloon.ox
		sprite.y = character.screen_y - chat_balloon.oy
		sprite.z = 3000
		sprite.visible = true
		sprite.opacity = 255
		
		@chat_b[id] = chat_balloon
		@chat_b[id].sprite = sprite
	end
	
	def dispose_existing_sprite(id)		
		return unless @chat_b[id]
		return unless @chat_b[id].sprite
		return if @chat_b[id].sprite.disposed?
		
		@chat_b[id].sprite.bitmap.clear
		@chat_b[id].sprite.dispose 
	end
	
	def update
		@chat_b.each do |id, balloon|
			next if balloon.sec <= 0
			
			char = balloon.ch
			sprite = balloon.sprite
			
			cx = char.screen_x - balloon.ox
			cy = char.screen_y - balloon.oy
			
			sprite.x = cx 
			sprite.y = cy 
			
			balloon.sec -= 1
			if balloon.sec <= 0
				sprite.visible = false
				sprite.dispose
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
	attr_accessor :sprite
end

$chat_b = Chat_balloon_net.new