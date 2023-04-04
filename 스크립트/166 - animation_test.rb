# 애니메이션 코드 커스텀
# 애니메이션 여러개 겹치게 나오게 하기
# 애니메이션 효과음 설정

module RPG
	class AniData
		attr_accessor :hit
		attr_accessor :duration
		attr_accessor :sprites
		attr_accessor :animation
		attr_accessor :pause_duration
		def initialize(ani = nil, hit = nil)
			@animation = ani
			@hit = hit
			@duration = nil
			@sprites = nil
			@pause_duration = nil
		end
	end
	
	class Sprite < ::Sprite
		alias mrmo_abs_sprite_ini initialize
		alias mrmo_abs_sprite_update update
		
		# ------------------
		# 애니메이션 겹치기 코드 시작
		# ------------------
		def initialize(viewport = nil)
			mrmo_abs_sprite_ini(viewport)
			# 애니메이션 겹치기용 배열들
			@_animation_overlap = []
			
		end
		
		def update
			mrmo_abs_sprite_update
			if @_animation_overlap != nil and @_animation_overlap.size > 0
				for ani in @_animation_overlap
					if ani.pause_duration > 0
						ani.pause_duration -= 1
						next
					end
					
					ani.duration -= 1 if (Graphics.frame_count % 2 == 0)
					update_animation2(ani)
					ani.duration += 1 if (Graphics.frame_count % 10 == 0) 
				end
			end
		end
		
		def animation2(animation, hit)
			return if animation == nil
			ani = AniData.new(animation, hit)
			ani.duration = animation.frame_max
			ani.pause_duration = @_animation_overlap.size * 3
			
			animation_name = animation.animation_name
			animation_hue = animation.animation_hue
			bitmap = RPG::Cache.animation(animation_name, animation_hue)
			if @@_reference_count.include?(bitmap)
				@@_reference_count[bitmap] += 1
			else
				@@_reference_count[bitmap] = 1
			end
			
			max_sprite = get_max_sprites(animation)
			ani.sprites = []
			if animation.position != 3 or not @@_animations.include?(animation)
				max_sprite.times {
					sprite = ::Sprite.new(self.viewport)
					sprite.bitmap = bitmap
					sprite.visible = false
					ani.sprites.push(sprite)
				}
				unless @@_animations.include?(animation)
					@@_animations.push(animation)
				end
			end
						
			@_animation_overlap.push(ani)
			update_animation2(ani)
		end
		
		def update_animation2(ani)
			if ani.duration > 0
				frame_index = ani.animation.frame_max - ani.duration
				cell_data = ani.animation.frames[frame_index].cell_data
				position = ani.animation.position
				animation_set_sprites(ani.sprites, cell_data, position)
				
				for timing in ani.animation.timings
					if timing.frame == frame_index
						animation_process_timing(timing, ani.hit)
					end
				end
			else
				dispose_animation2(ani)
			end
		end
		
		def dispose_animation2(ani)
			if ani.sprites != nil
				sprite = ani.sprites[0]
				if sprite != nil
					@@_reference_count[sprite.bitmap] -= 1
					if @@_reference_count[sprite.bitmap] == 0
						sprite.bitmap.dispose
					end
				end
				for sprite in ani.sprites
					sprite.dispose
				end
				ani.sprites = nil
				ani.animation = nil
				@_animation_overlap.delete(ani)
			end
		end
		
		# ------------------
		# 애니메이션 겹치기 코드 끝
		# ------------------
		
		def animation(animation, hit)
			dispose_animation
			@_animation = animation
			return if @_animation == nil
			@_animation_hit = hit
			@_animation_duration = @_animation.frame_max
			animation_name = @_animation.animation_name
			animation_hue = @_animation.animation_hue
			bitmap = RPG::Cache.animation(animation_name, animation_hue)
			if @@_reference_count.include?(bitmap)
				@@_reference_count[bitmap] += 1
			else
				@@_reference_count[bitmap] = 1
			end
			
			max_sprite = get_max_sprites(@_animation)
			@_animation_sprites = []
			if @_animation.position != 3 or not @@_animations.include?(animation)
				max_sprite.times {
					sprite = ::Sprite.new(self.viewport)
					sprite.bitmap = bitmap
					sprite.visible = false
					@_animation_sprites.push(sprite)
				}
				unless @@_animations.include?(animation)
					@@_animations.push(animation)
				end
			end
			update_animation
		end
		
		def loop_animation(animation)
			return if animation == @_loop_animation
			dispose_loop_animation
			@_loop_animation = animation
			return if @_loop_animation == nil
			@_loop_animation_index = 0
			animation_name = @_loop_animation.animation_name
			animation_hue = @_loop_animation.animation_hue
			bitmap = RPG::Cache.animation(animation_name, animation_hue)
			if @@_reference_count.include?(bitmap)
				@@_reference_count[bitmap] += 1
			else
				@@_reference_count[bitmap] = 1
			end
			max_sprite = get_max_sprites(@_loop_animation)
			@_loop_animation_sprites = []
			max_sprite.times {
				sprite = ::Sprite.new(self.viewport)
				sprite.bitmap = bitmap
				sprite.visible = false
				@_loop_animation_sprites.push(sprite)
			}
			update_loop_animation
		end
		
		def get_max_sprites(animation)
			max = 0
			animation.frames.each {|frame|
				max = frame.cell_max if max<frame.cell_max
			}
			return max
		end
		
		def dispose_animation
			if @_animation_sprites != nil
				sprite = @_animation_sprites[0]
				if sprite != nil
					@@_reference_count[sprite.bitmap] -= 1
					if @@_reference_count[sprite.bitmap] == 0
						sprite.bitmap.dispose
					end
				end
				for sprite in @_animation_sprites
					sprite.dispose
				end
				@_animation_sprites = nil
				@_animation = nil
			end
		end
		
		def dispose_loop_animation
			if @_loop_animation_sprites != nil
				sprite = @_loop_animation_sprites[0]
				if sprite != nil
					@@_reference_count[sprite.bitmap] -= 1
					if @@_reference_count[sprite.bitmap] == 0
						sprite.bitmap.dispose
					end
				end
				for sprite in @_loop_animation_sprites
					sprite.dispose
				end
				@_loop_animation_sprites = nil
				@_loop_animation = nil
			end
		end
		
		def update_animation
			if @_animation_duration > 0
				frame_index = @_animation.frame_max - @_animation_duration
				cell_data = @_animation.frames[frame_index].cell_data
				position = @_animation.position
				animation_set_sprites(@_animation_sprites, cell_data, position)
				
				for timing in @_animation.timings
					if timing.frame == frame_index
						animation_process_timing(timing, @_animation_hit)
					end
				end
			else
				dispose_animation
			end
		end
		
		def update_loop_animation
			frame_index = @_loop_animation_index
			cell_data = @_loop_animation.frames[frame_index].cell_data
			position = @_loop_animation.position
			animation_set_sprites(@_loop_animation_sprites, cell_data, position)
			
			for timing in @_loop_animation.timings
				if timing.frame == frame_index
					animation_process_timing(timing, true)
				end
			end
		end
		
		def animation_set_sprites(sprites, cell_data, position)
			sprites.size.times{ |i|
				sprite = sprites[i]
				pattern = cell_data[i, 0]
				if sprite == nil or pattern == nil or pattern == -1
					sprite.visible = false if sprite != nil
					next
				end
				sprite.visible = true
				sprite.src_rect.set(pattern % 5 * 192, pattern / 5 * 192, 192, 192)
				if position == 3
					if self.viewport != nil
						sprite.x = self.viewport.rect.width / 2
						sprite.y = self.viewport.rect.height - 160
					else
						sprite.x = 320
						sprite.y = 240
					end
				else
					sprite.x = self.x - self.ox + self.src_rect.width / 2
					sprite.y = self.y - self.oy + self.src_rect.height / 2
					sprite.y -= self.src_rect.height / 4 if position == 0
					sprite.y += self.src_rect.height / 4 if position == 2
				end
				sprite.x += cell_data[i, 1]
				sprite.y += cell_data[i, 2]
				sprite.z = 2000
				sprite.ox = 96
				sprite.oy = 96
				sprite.zoom_x = cell_data[i, 3] / 100.0
				sprite.zoom_y = cell_data[i, 3] / 100.0
				sprite.angle = cell_data[i, 4]
				sprite.mirror = (cell_data[i, 5] == 1)
				sprite.opacity = 255#cell_data[i, 6] * self.opacity / 255.0
				sprite.blend_type = cell_data[i, 7]
			}
		end
		
		def animation_process_timing(timing, hit)
			if (timing.condition == 0) or
				(timing.condition == 1 and hit == true) or
				(timing.condition == 2 and hit == false)
				if timing.se.name != ""
					se = timing.se
					Audio.se_play("Audio/SE/" + se.name, $game_variables[13], se.pitch)
				end
				case timing.flash_scope
				when 1
					self.flash(timing.flash_color, timing.flash_duration * 2)
				when 2
					if self.viewport != nil
						self.viewport.flash(timing.flash_color, timing.flash_duration * 2)
					end
				when 3
					self.flash(nil, timing.flash_duration * 2)
				end
			end
		end
		
		def x=(x)
			sx = x - self.x
			if sx != 0
				if @_animation_sprites != nil
					@_animation_sprites.size.times {|i|
						@_animation_sprites[i].x += sx
					}
				end
				if @_loop_animation_sprites != nil
					@_loop_animation_sprites.size.times {|i|
						@_loop_animation_sprites[i].x += sx
					}
				end
			end
			super
		end
		
		def y=(y)
			sy = y - self.y
			if sy != 0
				if @_animation_sprites != nil
					@_animation_sprites.size.times {|i|
						@_animation_sprites[i].y += sy
					}
				end
				if @_loop_animation_sprites != nil
					@_loop_animation_sprites.size.times {|i|
						@_loop_animation_sprites[i].y += sy
					}
				end
			end
			super
		end
		
	end
end