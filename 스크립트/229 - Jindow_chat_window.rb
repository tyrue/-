class Jindow_Chat_Window < Jindow
	attr_accessor :mode
	
	def initialize
		super(0, 362, 500, 98)
		#@head = true
		@name = "대화창"
		@bottom = false
		@opacity = 130
		
		@tog = true
		@chat_log = []
		
		@old_size = 0
		@max_size = 80
		@font_size = 13
		@margin = 5
		@view_line = 6
		
		@mode = 0 # 0 전체, 1 최소화, 2 off
		
		@check = false	
		self.height = (@font_size + @margin) * @view_line
		self.y = $map_chat_input.y - self.height
		self.refresh "Chat_Window"
		self.opacity = @opacity
	end	
	
	def scroll_op(opacity)
		@scroll0mid.opacity = opacity if @scroll0mid != nil
		@scroll0up.opacity = opacity if @scroll0up != nil
		@scroll0down.opacity = opacity if @scroll0down != nil
		
		@scroll0bar_mid.opacity = opacity if @scroll0bar_mid != nil
		@scroll0bar_up.opacity = opacity if @scroll0bar_up != nil
		@scroll0bar_down.opacity = opacity if @scroll0bar_down != nil
	end
	
	def hide
		self.y = $map_chat_input.y
		super
		@tog = false
		for log in @chat_log
			log.visible = false
			$map_chat_input.hide
		end
	end
	
	def hide2
		
		#super
		@tog = true
		self.height = (@font_size + @margin) * 2
		self.y = $map_chat_input.y - self.height
		self.refresh "Chat_Window"
		self.scroll
		self.scroll_end if @scroll0down != nil
		@check = true
		for log in @chat_log
			log.visible = true
		end
	end
	
	def show(val = @opacity)
		
		super
		@tog = true
		$map_chat_input.show
		self.height = (@font_size + @margin) * @view_line
		self.y = $map_chat_input.y - self.height
		self.refresh "Chat_Window"
		self.scroll
		
		@scroll0down == nil ? self.oy = 0 : self.scroll_end
		for log in @chat_log
			log.visible = @tog
		end
	end
	
	def toggle
		@mode = (@mode + 1) % 3
		case @mode
		when 0
			$game_switches[60] = true
			show(@opacity)
		when 1
			$game_switches[60] = true
			hide2
		when 2
			$game_switches[60] = false
			hide
		end
	end
	
	def scroll_end		
		return if @scroll0down == nil
		cy = @scroll0down.y - @scroll0bar_down.y
		
		for i in [@scroll0bar_up, @scroll0bar_mid, @scroll0bar_down]
			i.y += cy
		end
		self.scroll_update
	end
	
	def re_write
		for i in 0...@chat_log.size
			return if @chat_log[i] == nil or @chat_log[i].bitmap == nil
			@chat_log[i].y = i * (@font_size + 3)
		end
	end
	
	def write(text, color = COLOR_NORMAL)
		@chat_log.push(Sprite.new(self))
		if @chat_log.size == @max_size
			@chat_log[0].bitmap.clear
			@chat_log[0].dispose
			@chat_log.shift 
			re_write
		end
		
		@chat_log[@chat_log.size - 1].x = 5
		@chat_log[@chat_log.size - 1].y = (@chat_log.size - 1) * (@font_size + @margin)
		@chat_log[@chat_log.size - 1].bitmap = Bitmap.new(self.width, @font_size)
		@chat_log[@chat_log.size - 1].bitmap.font.size = @font_size
		@chat_log[@chat_log.size - 1].bitmap.font.color = color
		@chat_log[@chat_log.size - 1].bitmap.draw_frame_text(0, 0, self.width, @font_size, text, 0) 
		@chat_log[@chat_log.size - 1].visible = @tog
		@check = true
	end
	
	def update
		super
		if @check
			@check = false
			scroll_end if @height_scroll
		end
	end
end



