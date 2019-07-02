#==============================================================================
# ** Game_Actor
#------------------------------------------------------------------------------
#  This class handles the actor. It's used within the Game_Actors class
#  ($game_actors) and refers to the Game_Party class ($game_party).
#==============================================================================
class Game_Actor < Game_Battler
	#--------------------------------------------------------------------------
	# * Change Level
	#     level : new level
	#--------------------------------------------------------------------------
	def level=(level)
		# Check up and down limits
		level = [[level, $data_actors[@actor_id].final_level].min, 1].max
		# Change EXP
		self.exp = @exp_list[level]
		Network::Main.send_newstats if Network::Main.socket != nil
	end
	#--------------------------------------------------------------------------
	# * Refresh Stats
	#--------------------------------------------------------------------------
	def refresh_states(data)
		eval(data)
	end
end