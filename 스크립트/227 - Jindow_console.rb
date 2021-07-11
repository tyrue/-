class Jindow_Console < Jindow
	
	def initialize
		super(400, 200, 230, 130)
		@head = true
		@name = "콘솔 창"
		
		@opacity = 100
		
		self.refresh "Console"
		self.opacity = @opacity
		@tog = true
		@console_log = []
		@console_txt = []
		
		@old_size = 0
		@max_size = 40
		@font_size = 14
		@check = false
	end	
	
	def toggle
		if @tog
			@tog = false
			hide
			for con in @console_log
				con.opacity = 0
			end
		else
			@tog = true
			show(@opacity)
			for con in @console_log
				con.opacity = 255
			end
		end
	end
	
	def scroll_end
		cy = @scroll0down.y - @scroll0bar_down.y
		
		for i in [@scroll0bar_up, @scroll0bar_mid, @scroll0bar_down]
			i.y += cy
		end
		self.scroll_update
	end
	
	def clear_and_write
		for i in 0...@console_log.size
			return if @console_log[i] == nil or @console_log[i].bitmap == nil
			@console_log[i].y = i * @font_size
		end
	end
	
	def write_line(text)
		@console_log.push(Sprite.new(self))
		if @console_log.size == @max_size
			@console_log[0].bitmap.clear
			@console_log.shift 
			@console_txt.shift
			clear_and_write
		end
		@console_txt.push(text)
		@console_log[@console_log.size - 1].x = 0
		@console_log[@console_log.size - 1].y = (@console_log.size - 1) * @font_size
		@console_log[@console_log.size - 1].bitmap = Bitmap.new(self.width, @font_size)
		@console_log[@console_log.size - 1].bitmap.font.size = @font_size
		@console_log[@console_log.size - 1].bitmap.draw_text(0, 0, self.width, @font_size, text, 0)
		
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



