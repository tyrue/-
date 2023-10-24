class Viewport
	def x
		return rect.x
	end
	
	def y
		return rect.y
	end
	
	def width
		begin
			return rect.width
		rescue
			
		end	
	end
	
	def height
		return rect.height
	end
	
	def x=(x)
		rect.x = x
	end
	
	def y=(y)
		rect.y = y
	end
	
	def width=(width)
		rect.width = width
	end
	
	def height=(height)
		rect.height = height
	end
end
