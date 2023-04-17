#==============================================================================
# ** Game_Player
#------------------------------------------------------------------------------
#  This class handles the player. Its functions include event starting
#  determinants and map scrolling. Refer to "$game_player" for the one
#  instance of this class.
#==============================================================================
class Game_Player
	attr_reader :move_speed
	
	alias net_update update
	def update
		net_update
	end
end