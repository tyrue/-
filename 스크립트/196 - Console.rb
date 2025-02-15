#==============================================================================
# ■ Console
#------------------------------------------------------------------------------
# 　콘솔 표시용의 스프라이트입니다.
#==============================================================================

class Console < Sprite
	#--------------------------------------------------------------------------
	# ● 오브젝트 초기화
	#     x        : 묘화처 X 좌표
	#     y        : 묘화처 Y 좌표
	#     width    : 묘화처의 폭
	#     height   : 묘화처의 높이
	#     max_line : 최대 줄 수
	#--------------------------------------------------------------------------
	attr_accessor :console_log
	attr_accessor :tog
	def initialize(x, y, width, height, max_line = 8)
		@console_viewport = Viewport.new(x, y, width, height)
		@console_viewport.z = 999
		super(@console_viewport)
		self.bitmap = Bitmap.new(width, height)
		self.z = 999
		@console_width = width
		@console_max_line = max_line
		@console_log = []
		
		
		@back_sprite = Sprite.new(@console_viewport)
		@tog = true
	end
	#--------------------------------------------------------------------------
	# ● 리프레쉬
	#--------------------------------------------------------------------------
	def refresh
		clear
		if @console_log.size <= 0
			@back_sprite.visible = false
			return 
		end
		@back_sprite.visible = true
		@back_sprite.bitmap = Bitmap.new(@console_viewport.rect.width, @console_viewport.rect.height)
		@back_sprite.bitmap.fill_rect(@back_sprite.bitmap.rect, Color.new(0, 0, 0, 100)) # 꽉찬 네모
		self.bitmap.font.color.set(255, 255, 255, 255)
		for i in 0...@console_log.size
			# x, y, width, height, string
			self.bitmap.draw_text(0, (@console_max_line - i - 1) * 16, @console_width, 32, @console_log[@console_log.size - i - 1])
		end
	end
	#--------------------------------------------------------------------------
	# ● 텍스트 출력
	#     text : 출력하는 문자열
	#--------------------------------------------------------------------------
	def write_line(text)
		@console_log.push(text)
		@console_log.delete_at(0) while @console_log.size > @console_max_line
		refresh
	end
	#--------------------------------------------------------------------------
	# ● 보인다
	#--------------------------------------------------------------------------
	def show
		self.opacity = 255
		@back_sprite.visible = true
	end
	
	def toggle
		if @tog 
			self.hide
			@tog = false
		elsif
			self.show
			@tog = true
		end
	end
	
	
	#--------------------------------------------------------------------------
	# ● 숨긴다
	#--------------------------------------------------------------------------
	def hide
		self.opacity = 0
		@back_sprite.visible = false
	end
	#--------------------------------------------------------------------------
	# ● 클리어
	#--------------------------------------------------------------------------
	def clear
		# 윈도우 내용을 클리어
		self.bitmap.clear
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
end