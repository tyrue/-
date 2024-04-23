class Jindow_Console < Jindow
	def initialize
		super(450, 255, 200, 85)
		@name = "콘솔 창"
		@bottom = false
		@opacity = 130
		
		@tog = true
		@console_log = []
		@console_txt = []
		
		@old_size = 0
		@max_size = 80
		@font_size = 12
		@margin = 4
		@check = false
		self.x = 640 - self.width - 10
		self.height = (@font_size + @margin) * 6 
		self.y = 328 - self.height
		
		self.refresh "Console"
		self.opacity = @opacity
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
			$game_switches[61] = false
			hide
		else
			$game_switches[61] = true
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
			next if @console_log[i] == nil
			next if @console_log[i].bitmap == nil
			next if @console_log[i].disposed?
			@console_log[i].y = i * (@font_size + @margin)
		end
	end
	
	def write_line(text, color = Color.new(255, 255, 255))
		@console_log.push(Sprite.new(self))
		if @console_log.size == @max_size
			@console_log[0].bitmap.clear
			@console_log[0].dispose
			@console_log[0] = nil
			@console_log.shift 
			clear_and_write
		end
		
		@console_log[@console_log.size - 1].x = 0
		@console_log[@console_log.size - 1].y = (@console_log.size - 1) * (@font_size + @margin)
		@console_log[@console_log.size - 1].bitmap = Bitmap.new(self.width + 5, @font_size)
		@console_log[@console_log.size - 1].bitmap.font.size = @font_size
		@console_log[@console_log.size - 1].bitmap.font.color.set(0, 0, 0)
		@console_log[@console_log.size - 1].bitmap.draw_text(1, 1, self.width + 5, @font_size, text, 0)
		@console_log[@console_log.size - 1].bitmap.font.color = color
		@console_log[@console_log.size - 1].bitmap.draw_text(0, 0, self.width + 5, @font_size, text, 0)
		#@console_log[@console_log.size - 1].bitmap.draw_frame_text(0, 0, self.width + 5, @font_size, text, 0)
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
	
	def dispose2
		for log in @console_log.size
			log.dispose
			log = nil
		end
		super
	end
end



