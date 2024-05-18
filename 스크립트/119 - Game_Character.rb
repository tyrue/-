#==============================================================================
# ** Game_Character (part 1)
#------------------------------------------------------------------------------
#  This class deals with characters. It's used as a superclass for the
#  Game_Player and Game_Event classes.
#==============================================================================
class Game_Character
	def es_set_graphic(character_name, opacity, character_hue)
		@character_name = character_name
		@opacity = opacity
		@character_hue = character_hue
	end
end


class Game_Character
	attr_reader   :original_pattern
	attr_reader   :move_route
	attr_reader   :damage_show
	attr_accessor :show_critical
	attr_accessor :direction
	alias mr_mo_pvp_gc_initialize initialize
	#--------------------------------------------------------------------------
	# * Object Initialization
	#--------------------------------------------------------------------------
	def initialize
		mr_mo_pvp_gc_initialize
	end
	#--------------------------------------------------------------------------
	# * Determine if Passable
	#     x : x-coordinate
	#     y : y-coordinate
	#     d : direction (0,2,4,6,8)
	#         * 0 = Determines if all directions are impassable (for jumping)
	#--------------------------------------------------------------------------
	def mouse_passable?(x, y, new_x, new_y, d = $game_player.direction)
		# If coordinates are outside of map; impassable
		return false unless $game_map.valid?(new_x, new_y)
		# If through is ON; passable
		return true if @through
		# If unable to leave first move tile in designated direction; impassable
		return false unless $game_map.passable?(x, y, d, self)
		# If unable to enter move tile in designated direction; impassable
		return false unless $game_map.passable?(new_x, new_y, 10 - d)
		# Loop all events
		for event in $game_map.events.values
			# If event coordinates are consistent with move destination
			if event.x == new_x and event.y == new_y
				# If through is OFF
				unless event.through
					# If self is event; impassable
					return false if self != $game_player
					# With self as the player and partner graphic as character; impassable
					return false if event.character_name != ""
				end
			end
		end
		# Loop all players
		for player in Network::Main.mapplayers.values
			# If player coordinates are consistent with move destination
			if player.x == new_x and player.y == new_y
				# If through is OFF
				unless player.through
					# If self is playeri; impassable
					return false  if self != $game_player
					# With self as the player and partner graphic as character; impassable
					return false if player.character_name != ""
				end
			end
		end
		# If player coordinates are consistent with move destination
		if $game_player.x == new_x and $game_player.y == new_y
			# If through is OFF
			unless $game_player.through
				# If your own graphic is the character; impassable
				return false if @character_name != ""
			end
		end
		# passable
		return true
	end
	#--------------------------------------------------------------------------
	# * Determine if Passable
	#     x : x-coordinate
	#     y : y-coordinate
	#     d : direction (0,2,4,6,8)
	#         * 0 = Determines if all directions are impassable (for jumping)
	#--------------------------------------------------------------------------
	def passable?(x, y, d)
		# Get new coordinates
		new_x = x + (d == 6 ? 1 : d == 4 ? -1 : 0)
		new_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
		# If coordinates are outside of map; impassable
		return false unless $game_map.valid?(new_x, new_y)
		# If through is ON; passable
		return true if @through
		# If unable to leave first move tile in designated direction; impassable
		return false unless $game_map.passable?(x, y, d, self)
		# If unable to enter move tile in designated directionimpassable
		return false unless $game_map.passable?(new_x, new_y, 10 - d)
		# Loop all events
		for event in $game_map.events.values
			# If event coordinates are consistent with move destination
			if event.x == new_x and event.y == new_y
				# If through is OFF
				unless event.through
					# If self is event; impassable
					return false if self != $game_player
					# With self as the player and partner graphic as character; impassable
					return false if event.character_name != ""
				end
			end
		end
		# Loop all players
		for player in Network::Main.mapplayers.values
			# If player coordinates are consistent with move destination
			next if player == nil
			if player.x == new_x and player.y == new_y
				# If through is OFF
				unless player.through
					# If self is player; impassable
					return false if self != $game_player
					# With self as the player and partner graphic as character; impassable
					return false if player.character_name != ""
				end
			end
		end
		# If player coordinates are consistent with move destination
		if $game_player.x == new_x and $game_player.y == new_y
			# If through is OFF
			unless $game_player.through
				# If your own graphic is the character; impassable
				return false if @character_name != ""
			end
		end
		# passable
		return true
	end
end