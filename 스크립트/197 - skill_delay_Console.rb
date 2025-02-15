#==============================================================================
# ■ Console
#------------------------------------------------------------------------------
# 　콘솔 표시용의 스프라이트입니다.
#==============================================================================

class Skill_Delay_Console < Sprite
	#--------------------------------------------------------------------------
	# ● 오브젝트 초기화
	#     x        : 묘화처 X 좌표
	#     y        : 묘화처 Y 좌표
	#     width    : 묘화처의 폭
	#     height   : 묘화처의 높이
	#     max_line : 최대 줄 수
	#--------------------------------------------------------------------------
	attr_accessor :console_log
	attr_accessor :console_log2
	attr_accessor :tog
	
	def initialize(x, y, width, height, max_line = 8)
		@console_viewport = Viewport.new(x, y, width, height)
		@console_viewport.z = 999
		super(@console_viewport)
		self.bitmap = Bitmap.new(width, height)
		
		self.z = 999
		@console_width = width
		@console_height = height
		@console_max_line = max_line
		
		@console_log = {}  # 딜레이 기간
		@console_log2 = {} # 버프 기간
		
		@font_size = 13
		@old_height = 0
		@tog = true # 토글 상태
		
		# 스킬 딜레이 갱신 id, 배열값
		for skill_mash in SKILL_MASH_TIME
			if skill_mash[1][1] > 0
				sprite = Sprite_Chat.new(@console_viewport)			
				@console_log[skill_mash[0]] = [sprite]
			end
		end
		
		# 버프 지속시간 갱신
		for buff_time in $game_party.actors[0].buff_time
			id = buff_time[0]
			time = buff_time[1]
			if time > 0
				sprite = Sprite_Chat.new(@console_viewport)
				@console_log2[id] = [sprite]
			end
		end
		
		@back_sprite = Sprite.new(@console_viewport)
		@back_sprite.visible = true
		self.refresh
	end
	
	#--------------------------------------------------------------------------
	# ● 리프레쉬
	#--------------------------------------------------------------------------
	def refresh
		# 스킬 딜레이 갱신 id, 배열값
		for skill_mash in SKILL_MASH_TIME
			id = skill_mash[0]
			if skill_mash[1][1] > 0 and @console_log[id] == nil
				sprite = Sprite_Chat.new(@console_viewport)			
				@console_log[id] = [sprite]
			elsif skill_mash[1][1] <= 0 and @console_log[id] != nil
				@console_log[id][0].dispose if !@console_log[id][0].disposed?
				@console_log.delete(id)
			end
		end
		
		# 버프 지속시간 갱신
		for buff_time in $game_party.actors[0].buff_time
			id = buff_time[0]
			time = buff_time[1]
			if time > 0 and @console_log2[id] == nil
				sprite = Sprite_Chat.new(@console_viewport)
				@console_log2[id] = [sprite]
			elsif time <= 0 and @console_log2[id] != nil
				@console_log2[id][0].dispose if !@console_log2[id][0].disposed?
				@console_log2.delete(id)
			end
		end
		
		if @console_log.size <= 0 and @console_log2.size <= 0
			@back_sprite.visible = false
			return 
		end
		
		@back_sprite.visible = true
		
		i = 0
		for log in @console_log2
			id = log[0]
			sprite = log[1][0]
			buff_time = $game_party.actors[0].buff_time[id]
			next if buff_time == nil
			
			sprite = Sprite.new(@console_viewport) if sprite == nil
			sprite.bitmap.clear if sprite.bitmap != nil
			sprite.bitmap = Bitmap.new(width, 32)
			sprite.bitmap.font.size = @font_size
			sprite.bitmap.font.color.set(0, 255, 0, 255)
			sprite.x = 0
			sprite.y = (i) * @font_size + 1
			sprite.bitmap.draw_text(0, 0, @console_width, 32, "#{$data_skills[id].name} : #{'%.1f' % (buff_time / 60.0)}초")
			sprite.opacity = 255
			i += 1
			
		end
		
		for log in @console_log
			id = log[0]
			sprite = log[1][0]
			next if SKILL_MASH_TIME[id] == nil
			
			sprite = Sprite.new(@console_viewport) if sprite == nil
			sprite.bitmap.clear if sprite.bitmap != nil
			sprite.bitmap = Bitmap.new(width, 32)
			sprite.bitmap.font.size = @font_size
			sprite.bitmap.font.color.set(255, 204, 0, 255)
			sprite.x = 0
			sprite.y = (i) * @font_size + 1
			sprite.bitmap.draw_text(0, 0, @console_width, 32, "#{$data_skills[id].name} : #{'%.1f' % (SKILL_MASH_TIME[id][1] / 60.0)}초") 	
			sprite.opacity = 255
			i += 1
		end
		
		@old_height = (@console_log.size + @console_log2.size) * (@font_size + 1) + 14
		if @old_height != @console_viewport.height
			@console_viewport.height = @old_height
			@back_sprite.bitmap.clear if @back_sprite.bitmap != nil
			@back_sprite.bitmap = Bitmap.new(@console_viewport.rect.width, @console_viewport.rect.height)
			@back_sprite.bitmap.fill_rect(@back_sprite.bitmap.rect, Color.new(0, 0, 0, 100)) # 꽉찬 네모
			@back_sprite.visible = true
		end
	end
	
	#--------------------------------------------------------------------------
	# ● 텍스트 출력
	#     text : 출력하는 문자열
	#--------------------------------------------------------------------------
	def write_line(id)
		@console_log[id][0].dispose if @console_log[id] != nil and !@console_log[id][0].disposed?
		@console_log2[id][0].dispose if @console_log2[id] != nil and !@console_log2[id][0].disposed?
		
		buff_time = $game_party.actors[0].buff_time[id]
		if buff_time != nil and buff_time > 0		
			sprite = Sprite.new(@console_viewport)
			@console_log2[id] = [sprite]			
		end
		
		if SKILL_MASH_TIME[id] != nil
			if SKILL_MASH_TIME[id][1] > 0
				sprite = Sprite.new(@console_viewport)
				@console_log[id] = [sprite]
			end
		end
	end
	#--------------------------------------------------------------------------
	# ● 보인다
	#--------------------------------------------------------------------------
	def show
		self.opacity = 255
	end
	
	def toggle
		if @back_sprite.visible 
			@back_sprite.visible = false
			@tog = false
			for sprite in @console_log
				sprite[1][0].visible = false
			end
			for sprite in @console_log2
				sprite[1][0].visible = false
			end
		elsif
			@back_sprite.visible = true
			@tog = true
			for sprite in @console_log
				sprite[1][0].visible = true
			end
			for sprite in @console_log2
				sprite[1][0].visible = true
			end
		end
	end
	
	#--------------------------------------------------------------------------
	# ● 숨긴다
	#--------------------------------------------------------------------------
	def hide
		self.opacity = 0
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