module Mouse
	module_function
	
	def x
		return @x
	end
	
	def y
		return @y
	end
	
	def ox
		return @ox
	end
	
	def oy
		return @oy
	end
	
	def x=(x)
		@x = x
	end
	
	def y=(y)
		@y = y
	end
	
	def ox=(x)
		@ox = x
	end
	
	def oy=(y)
		@oy = y
	end
	
	@x = 0
	@y = 0
	@ox = 0
	@oy = 0
	
	def update
		x, y = Input.mouse_pos
		(x == nil or y == nil) ? return : 0
		
		@ox = x; @oy = y
		if !Input.mouse_lbutton
			@x = x; @y = y	
		end
	end
	
	def arrive_rect?(x = 0, y = 0, width = 1, height = 1, size = 0)
		if x.rect?
			y = x.y
			width = x.width
			height = x.height
			x = x.x
		end
		return (@x > x - size and @x < x + width + size and @y > y - size and @y < y + height + size)
	end
	
	def arrive_sprite_rect?(sprite)
		x = sprite.viewport.x + sprite.x - sprite.viewport.ox
		y = sprite.viewport.y + sprite.y - sprite.viewport.oy
		return self.arrive_rect?(x, y, sprite.bitmap.width, sprite.bitmap.height)
	end
	
	def arrive_sprite?(sprite, size = 0)
		x = sprite.viewport.x + sprite.x - sprite.viewport.ox
		y = sprite.viewport.y + sprite.y - sprite.viewport.oy
		return self.arrive_rect?(x, y, sprite.bitmap.width, sprite.bitmap.height, size)
		
		self.arrive_rect?(x, y, sprite.bitmap.width, sprite.bitmap.height, size) ? 0 : return
		color = sprite.bitmap.get_pixel(@x - x, @y - y)
		return ((color.red != 0 and color.green != 0 and color.blue != 0 and color.alpha != 0) ? true : false)
	end
	def map_x
		return ((($game_map.display_x.to_f/4.0).floor + @x.to_f)/32.0).floor
	end
	
	def map_y
		return ((($game_map.display_y.to_f/4.0).floor + @y.to_f)/32.0).floor
	end
end