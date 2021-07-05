class Cursor < Sprite
	def initialize
		@viewport = Viewport.new(0, 0, 640, 480)
		@viewport.z = 99999
		super(@viewport)
		@route = "Graphics/Icons/"
		@x = Mouse.x
		@y = Mouse.y
		self.bitmap = Bitmap.new(@route + User_Edit::CURSOR_ICON)
		self.x = @x
		self.y = @y
		self.z = 999
	end
	
	def update
		super
		if @x != Mouse.x or @y != Mouse.y
			@x = Mouse.x
			@y = Mouse.y
			self.x = @x
			self.y = @y
		end
	end
end
