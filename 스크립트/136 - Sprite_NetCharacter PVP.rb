#==============================================================================
# ** Sprite_Character
#------------------------------------------------------------------------------
#  This sprite is used to display the character.It observes the Game_Character
#  class and automatically changes sprite conditions.
#==============================================================================

class Sprite_Character < RPG::Sprite
	alias mrmo_pvp_sc_update update
	#--------------------------------------------------------------------------
	# * Frame Update
	#--------------------------------------------------------------------------
	def update
		mrmo_pvp_sc_update
		# Damage Show
		if @character.damage_show != nil
			damage(@character.damage_show, @character.show_critical)
			@character.show_demage(nil, false)
		end
	end
end
