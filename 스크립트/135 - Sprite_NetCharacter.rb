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
		super(viewport, character)
		
		# Creates Display Text Sprite
		self.visible = true #true
		self.opacity = 255
		update
	end
	
	# 재정의
	def update_damage_display
		return unless $ABS.damage_display
		
		display_net_player_damage 
		@_damage_idx = 0
	end
	
	def display_net_player_damage
		a = @character
		return unless a.damage || (a.damage_array && a.damage_array.size > 0)
		
		process_net_player_damage(a)
		clear_net_player_damage_arrays(a)
	end
	
	def process_net_player_damage(a)
		dmg_array = a.damage_array
		cri_array = a.critical_array
			
		sw = dmg_array.size > 1 ? true : false
		unless sw
			dmg_array << a.damage
			cri_array << a.critical
		end
		
		dmg_array.each_with_index do |dmg_val, i|
			next unless dmg_val
			
			damage(dmg_val, cri_array[i], sw)
		end
	end
	
	def clear_net_player_damage_arrays(a)
		a.damage = nil
		a.damage_array.clear
		a.critical_array.clear
	end
end
