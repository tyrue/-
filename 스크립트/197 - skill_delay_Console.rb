class Skill_Delay_Console < Sprite
	attr_accessor :skill_mash_log
	attr_accessor :buff_time_log
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
		
		@skill_mash_log = {}
		@buff_time_log = {}
		
		@mash_color = Color.new(255, 204, 0)
		@buff_color = Color.new(0, 255, 0)
		
		@log_arr = [
			[@buff_time_log, @buff_color],
			[@skill_mash_log, @mash_color],
		]
		
		@font_size = 13
		@old_height = 0
		@tog = true
		
		@actor = $game_party.actors[0]
		initialize_skill_mash
		initialize_buff_time
		
		@back_sprite = Sprite.new(@console_viewport)
		@back_sprite.visible = true
		
		@sec = Graphics.frame_rate
		self.refresh
	end
	
	def initialize_skill_mash
		@actor.skill_mash.each do |skill_mash|
			id, time = skill_mash
			next if time <= 0
			
			sprite = Sprite_Chat.new(@console_viewport)
			@skill_mash_log[id] = sprite
		end
	end
	
	def initialize_buff_time
		@actor.buff_time.each do |buff_time|
			id, time = buff_time
			next if time <= 0
			
			sprite = Sprite_Chat.new(@console_viewport)
			@buff_time_log[id] = sprite
		end
	end
	
	def update
		if (Graphics.frame_count % (@sec / 5) == 0)
			self.refresh 
		end
	end
	
	def refresh
		return unless @tog
			
		update_log(@skill_mash_log, @actor.skill_mash)
		update_log(@buff_time_log, @actor.buff_time)
		return if check_log_empty
			
		update_sprite_logs(@buff_time_log, @actor.buff_time, @buff_color, 0)
		update_sprite_logs(@skill_mash_log, @actor.skill_mash, @mash_color, @buff_time_log.size + 1)
		update_back_sprite_height
	end
	
	def check_log_empty
		@log_arr.each do |log, color|
			next unless log
			return false unless log.empty?
		end
		
		@back_sprite.visible = false
		return true
	end
	
	def update_log(log, source)
		source.each do |id, time|
			if time > 0 && log[id].nil?
				sprite = Sprite_Chat.new(@console_viewport)
				log[id] = sprite
			elsif time <= 0 && log[id]
				log[id].dispose unless log[id].disposed?
				log.delete(id)
			end
		end
	end
	
	def update_sprite_logs(log, source, color, i)
		log.each do |id, sprite|
			time = source[id]
			next unless time
			
			sprite = Sprite.new(@console_viewport) if sprite.nil?
			sprite.bitmap.clear if sprite.bitmap
			sprite.bitmap = Bitmap.new(@console_width, @font_size + 2)
			sprite.bitmap.font.size = @font_size
			sprite.bitmap.font.color = color
			sprite.bitmap.draw_text(0, 0, @console_width, @font_size + 2, "#{$data_skills[id].name} : #{'%.1f' % (time / 60.0)}초")
			sprite.opacity = 255
		end
		
		set_sprite_position(log, i)
	end
	
	def set_sprite_position(log, i)
		log.each do |id, sprite|
			sprite.x = 0
			sprite.y = @font_size * i + 5
			i += 1
		end
	end
	
	def update_back_sprite_height
		size = 1
		@log_arr.each do |log, color|
			size += log.size if log
		end
		
		@old_height = size * (@font_size + 3)
		if @old_height != @console_viewport.height
			@console_viewport.height = @old_height
			@back_sprite.bitmap.clear if @back_sprite.bitmap
			@back_sprite.bitmap = Bitmap.new(@console_viewport.rect.width, @console_viewport.rect.height)
			@back_sprite.bitmap.fill_rect(@back_sprite.bitmap.rect, Color.new(0, 0, 0, 100))
		end
		@back_sprite.visible = true
	end
	
	def show
		self.opacity = 255
	end
	
	def toggle
		@back_sprite.visible = !@back_sprite.visible
		@tog = !@tog
		
		@log_arr.each do |log, color|
			log.each {|id, sprite| sprite.visible = @back_sprite.visible }   
		end
	end
	
	def hide
		self.opacity = 0
	end
	
	def clear
		self.bitmap.clear
	end
	
	def dispose
		@log_arr.each do |log, color|
			log.each {|id, sprite| sprite.dispose unless sprite.disposed?}   
		end
		
		self.bitmap.dispose if self.bitmap
		super
	end
end
