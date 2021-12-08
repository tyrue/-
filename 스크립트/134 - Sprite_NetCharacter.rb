#==============================================================================
# ** Sprite_Character -  This sprite is used to display the character.  It 
#                        observes the Game_Character class and automatically 
#                        changes sprite conditions.
#------------------------------------------------------------------------------
# Author    Me™ and Mr.Mo
# Idea      Destined
#==============================================================================
class Sprite_NetCharacter < RPG::Sprite
	#--------------------------------------------------------------------------
	# * Public Instance Variables
	#--------------------------------------------------------------------------
	attr_accessor :character                # character
	attr_accessor :netid
	attr_accessor :level
	attr_accessor :hp
	attr_accessor :maxhp
	attr_accessor :name
	#--------------------------------------------------------------------------
	# * Object Initialization
	#     viewport  : viewport
	#     character : character (Game_Character)
	#--------------------------------------------------------------------------
	def initialize(viewport, id, character = nil)
		super(viewport)
		@character = character
		@netid = id
		@level = level
		@hp = hp
		@maxhp = maxhp
		@message1 = ""
		@name = name
		$ani_character[@netid.to_i] = @character
		@test = false
		
		# Creates Display Bitmap
		bitmap = Bitmap.new(160, 100)
		# Draws Text Shadow
		bitmap.font.draw_shadow = false if bitmap.font.respond_to?(:draw_shadow)
		bitmap.font.color = Color.new(0, 0, 0)
		bitmap.font.size = 13
		bitmap.draw_text(1, 1, 160, 24, "Lv: " + @character.level.to_s, 1)
		
		# Changes Font Color
		bitmap.font.color = Color.new(255, 255, 255)
		# Draws Text
		bitmap.font.size = 13
		bitmap.draw_text(0, 0, 160, 24, "Lv: " + @character.level.to_s, 1)
		
		bitmap.font.draw_shadow = false if bitmap.font.respond_to?(:draw_shadow)
		bitmap.font.color = Color.new(-204, 0, 204)
		bitmap.font.size = 13
		bitmap.draw_text(0, 0, 160, 150,@character.guild.to_s, 1)
		
		# Changes Font Color
		bitmap.font.color = Color.new(255, 255, 255)
		# Draws Text
		bitmap.font.name = "굴림"
		bitmap.font.size = 12
		bitmap.draw_frame_text(0, 0, 160, 47, @character.name.to_s, 1)
		
		# Creates Display Text Sprite
		self.visible = true #true
		
		@_text_display = Sprite.new(self.viewport)
		@_text_display.bitmap = bitmap
		@_text_display.ox = 80
		@_text_display.oy = 24
		@_text_display.x = self.x
		@_text_display.y = self.y - self.oy / 2 - 24
		@_text_display.z = 30000
		@_text_display.visible = self.visible
		self.opacity = 255
		update
	end
	#--------------------------------------------------------------------------
	# * Disposes Text
	#--------------------------------------------------------------------------
	def dispose
		@_text_display.dispose
		super
	end
	#--------------------------------------------------------------------------
	# * Frame Update
	#--------------------------------------------------------------------------
	def update
		super
		# If tile ID, file name, or hue are different from current ones
		if @tile_id != @character.tile_id or
			@character_name != @character.character_name or
			@character_hue != @character.character_hue or
			@character.equip_change
			#Updates tile info
			update_tile
			@character.equip_change = false
		end
		# update_tile
		# Set visible situation
		ok = $netparty.include? @character.name.to_s
		if @character.is_transparency
			if ok
				self.visible = true
				@_text_display.visible = true
			else
				self.visible = false
				@_text_display.visible = false
			end
		else
			self.visible = true
			@_text_display.visible = true
		end
		
		# If graphic is character
		animate_player if @tile_id == 0
		# Set sprite coordinates
		self.x = @character.screen_x
		self.y = @character.screen_y
		self.z = @character.screen_z(@ch)
		# Set opacity level, blend method, and bush depth
		self.opacity = @character.opacity
		self.blend_type = @character.blend_type
		self.bush_depth = @character.bush_depth
		# Animation
		update_ani if $ani_character[@netid.to_i].animation_id != 0
		
		if @character.damage_show != nil
			damage(@character.damage_show, @character.show_critical)
			@character.show_demage(nil, false)
		end
		
		# Name Sprite
		@_text_display.x = self.x
		@_text_display.y = self.y - self.oy / 2 - 24
	end
	#--------------------------------------------------------------------------
	# * Update Tile
	#--------------------------------------------------------------------------
	def update_tile
		# Remember tile ID, file name, and hue
		@tile_id = @character.tile_id
		@character_name = @character.character_name
		@character_hue = @character.character_hue
		# If tile ID value is valid
		if @tile_id >= 384
			self.bitmap = RPG::Cache.tile($game_map.tileset_name,
				@tile_id, @character.character_hue)
			self.src_rect.set(0, 0, 32, 32)
			self.ox = 16
			self.oy = 32
			# If tile ID value is invalid
		else
			self.bitmap = RPG::Cache.character(@character.character_name,
				@character.character_hue)
			@cw = bitmap.width / 4
			@ch = bitmap.height / 4
			self.ox = @cw / 2
			self.oy = @ch
		end
	end
	#--------------------------------------------------------------------------
	# * Update Player movement
	#--------------------------------------------------------------------------
	def animate_player
		# Set rectangular transfer
		sx = @character.pattern * @cw
		sy = (@character.direction - 2) / 2 * @ch
		self.src_rect.set(sx, sy, @cw, @ch)
	end
	#--------------------------------------------------------------------------
	# * Update Animation
	#--------------------------------------------------------------------------
	def update_ani
		animation = $data_animations[@character.animation_id]
		animation(animation, true)
		$ani_character[@netid].animation_id = 0
	end
end
