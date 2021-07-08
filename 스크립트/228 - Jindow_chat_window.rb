class Jindow_Chat_Window < Jindow
	
	def initialize
		super(0, 380, 500, 70)
		@head = true
		@mark = true
		self.refresh "Chat"
		self.opacity = 255
		@tog = true
	end	
	
	def toggle
		if @tog
			@tog = false
			self.opacity = 0
		else
			@tog = true
			self.opacity = 255
		end
	end
	
	def update
		super
		
	end
end



