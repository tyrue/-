#==============================================================================
# ■ Sprite_Chat
#------------------------------------------------------------------------------
# 　채팅 표시용의 스프라이트입니다.
#==============================================================================

class Sprite_Console< Sprite
	#--------------------------------------------------------------------------
	# ● 오브젝트 초기화
	#     viewport : 뷰포트
	#--------------------------------------------------------------------------
	def initialize(viewport)
		super(viewport)
		self.bitmap = Bitmap.new(640, 16)
		self.bitmap.font.name = "맑은 고딕"
		self.bitmap.font.size = 12
		self.x = 0
		self.y = viewport.rect.height - self.bitmap.height
		self.z = 1
		@text = ''
		@color = Color.new(0, 0, 0, 0)
		@back_color = Color.new(0, 0, 0, 0)
		update
	end
	#--------------------------------------------------------------------------
	# ● 해방
	#--------------------------------------------------------------------------
	def dispose
		if self.bitmap != nil
			self.bitmap.dispose
		end
		super
	end
	def text=(text)
		@text = text
	end
	def color=(color)
		@color = color
	end
	def back_color=(back_color)
		@back_color = back_color
	end
	#--------------------------------------------------------------------------
	# ● 프레임 갱신
	#--------------------------------------------------------------------------
	def update
		super
		if @original_text != @text or @original_color != @color or
			@original_back_color != @back_color
			@original_text = @text
			@original_color = @color
			@original_back_color = @back_color
			self.bitmap.fill_rect(self.bitmap.rect, @back_color)
			self.bitmap.font.color = @color
			self.bitmap.draw_text(1, 0, self.bitmap.width, self.bitmap.height, @text)
			self.bitmap.draw_text(-1, 0, self.bitmap.width, self.bitmap.height, @text)
			self.bitmap.draw_text(0, 1, self.bitmap.width, self.bitmap.height, @text)
			self.bitmap.draw_text(0, -1, self.bitmap.width, self.bitmap.height, @text)
			self.bitmap.draw_text(1, 1, self.bitmap.width, self.bitmap.height, @text)
			self.bitmap.draw_text(1, -1, self.bitmap.width, self.bitmap.height, @text)
			self.bitmap.draw_text(-1, -1, self.bitmap.width, self.bitmap.height, @text)
			self.bitmap.draw_text(-1, 1, self.bitmap.width, self.bitmap.height, @text)
			self.bitmap.font.color.set(255, 255, 255)
			self.bitmap.draw_text(0, 0, self.bitmap.width, self.bitmap.height, @text)
		end
	end
end
