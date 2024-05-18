#==============================================================================
# ** Sprite_Character -  This sprite is used to display the character.  It 
#                        observes the Game_Character class and automatically 
#                        changes sprite conditions.
#------------------------------------------------------------------------------
# Author    Me™ and Mr.Mo
# Idea      Destined
#==============================================================================
class Sprite_NetCharacter < Sprite_Character #RPG::Sprite 
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
		#super(viewport)
		@character = character
		@netid = id
		@level = @character.level
		@hp = @character.hp
		@maxhp = @character.maxhp
		@name = @character.name
		@message1 = ""
		@test = false
		$ani_character[@netid.to_i] = @character
		super(viewport, character)
		
		# Creates Display Text Sprite
		self.visible = true #true
		self.opacity = 255
		update
	end
	
	#--------------------------------------------------------------------------
	def update
		super
		update_character_bitmap if character_graphics_changed?
		update_sprite_properties
	end
	
	#--------------------------------------------------------------------------
	# * Frame Update
	#--------------------------------------------------------------------------
	def update
		super
		update_moving if @tile_id == 0
		update_ani if $ani_character[@netid.to_i].animation_id != 0
		update_damage_display
	end
	
	#--------------------------------------------------------------------------
	# * Update Player movement
	#--------------------------------------------------------------------------
	def update_moving
		# Set rectangular transfer
		sx = @character.pattern * @cw
		sy = (@character.direction - 2) / 2 * @ch
		self.src_rect.set(sx, sy, @cw, @ch)
	end
	
	#--------------------------------------------------------------------------
	# * Updates Animation
	#--------------------------------------------------------------------------
	def update_ani
		animation = $data_animations[@character.animation_id]
		animation(animation, true)
		$ani_character[@netid].animation_id = 0
	end
	
	#--------------------------------------------------------------------------
	# * Updates Damage Display
	#--------------------------------------------------------------------------
	def update_damage_display
		dmg_array = @character.damage_array
		return unless dmg_array
		
		sw = dmg_array.size > 1 ? true : false
		dmg_array.each do |dmg|
			next unless dmg
			
			damage(dmg, @character.show_critical, sw)
		end
		clear_damage_data
	end
	
	#--------------------------------------------------------------------------
	# * Clears damage data
	#--------------------------------------------------------------------------
	def clear_damage_data
		@character.damage = nil
		@character.damage_array.clear
		@_damage_idx = 0
	end
end
