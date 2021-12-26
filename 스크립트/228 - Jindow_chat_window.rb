class Jindow_Chat_Window < Jindow
	
	def initialize
		super(0, 362, 500, 98)
		#@head = true
		@name = "대화창"
		@bottom = false
		@opacity = 150
		
		self.refresh "Chat_Window"
		self.opacity = @opacity
		
		@tog = true
		@chat_log = []
		
		@old_size = 0
		@max_size = 60
		@font_size = 14
		
		@check = false	
	end	
	
	def hide
		super
		@tog = false
		for log in @chat_log
			log.visible = @tog
		end
	end
	
	def show(val = @opacity)
		super
		@tog = true
		for log in @chat_log
			log.visible = @tog
		end
	end
	
	def toggle
		if @tog
			hide
		else
			show(@opacity)
		end
	end
	
	def scroll_end		
		cy = @scroll0down.y - @scroll0bar_down.y
		
		for i in [@scroll0bar_up, @scroll0bar_mid, @scroll0bar_down]
			i.y += cy
		end
		self.scroll_update
	end
	
	def re_write
		for i in 0...@chat_log.size
			return if @chat_log[i] == nil or @chat_log[i].bitmap == nil
			@chat_log[i].y = i * @font_size
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
		
		@chat_log[@chat_log.size - 1].x = 0
		@chat_log[@chat_log.size - 1].y = (@chat_log.size - 1) * @font_size
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



