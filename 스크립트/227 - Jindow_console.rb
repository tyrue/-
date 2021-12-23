class Jindow_Console < Jindow
	def initialize
		super(450, 255, 180, 85)
		@name = "콘솔 창"
		@bottom = false
		@opacity = 150
		
		self.refresh "Console"
		self.opacity = @opacity
		@tog = true
		@console_log = []
		@console_txt = []
		
		@old_size = 0
		@max_size = 60
		@font_size = 12
		@check = false
	end	
	
	def hide
		super
		@tog = false
		for con in @console_log
			con.visible = @tog
		end
	end
	
	def show(val = @opacity)
		super
		@tog = true
		for con in @console_log
			con.visible = @tog
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
			@console_log[0].dispose
			@console_log.shift 
			clear_and_write
		end
		@console_log[@console_log.size - 1].x = 0
		@console_log[@console_log.size - 1].y = (@console_log.size - 1) * @font_size
		@console_log[@console_log.size - 1].bitmap = Bitmap.new(self.width + 5, @font_size)
		@console_log[@console_log.size - 1].bitmap.font.size = @font_size
		#@console_log[@console_log.size - 1].bitmap.font.color = Color.new(0, 0, 0)
		@console_log[@console_log.size - 1].bitmap.draw_frame_text(0, 0, self.width + 5, @font_size, text, 0)
		@console_log[@console_log.size - 1].visible = @tog
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



