class Rpg_skill
	def 투명
		$game_variables[9] = 1
	end
	
	def 비영승보
		x = $game_player.x
		y = $game_player.y
		d = $game_player.direction
		if 비영_passable2?(x, y, d) 
			if 비영_passable?(x, y, d)
				new_x = x + (d == 6 ? 2 : d == 4 ? -2 : 0)
				new_y = y + (d == 2 ? 2 : d == 8 ? -2 : 0)
				
				$game_player.moveto(new_x, new_y) 
				$game_player.direction = 10 - d
				$ABS.player_melee(true)
			else
				r = rand(100)
				new_x = x 
				new_y = y 
				case d
				when 4
					if r <= 50
						d = 8
						new_x -= 1
						new_y += 1
					else
						d = 2
						new_x -= 1
						new_y -= 1
					end
				when 6
					if r <= 50
						d = 8
						new_x += 1
						new_y += 1
					else
						d = 2
						new_x += 1
						new_y -= 1
					end
				when 2
					if r <= 50
						d = 4
						new_x += 1
						new_y += 1
					else
						d = 6
						new_x -= 1
						new_y += 1
					end
				when 8
					if r <= 50
						d = 4
						new_x += 1
						new_y -= 1
					else
						d = 6
						new_x -= 1
						new_y -= 1
					end
				end
				$game_player.moveto(new_x, new_y) 
				$game_player.direction = d
				$ABS.player_melee(true)
			end
		end
	end
	
	def 비영_passable?(x, y, d)
		# Get new coordinates
		new_x = x + (d == 6 ? 2 : d == 4 ? -2 : 0)
		new_y = y + (d == 2 ? 2 : d == 8 ? -2 : 0)
		# If coordinates are outside of map; impassable
		return false unless $game_map.valid?(new_x, new_y)
		# If through is ON; passable
		return true if @through
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
	
	def 비영_passable2?(x, y, d)
		# Get new coordinates
		new_x = x + (d == 6 ? 1 : d == 4 ? -1 : 0)
		new_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
		
		# Loop all events
		for event in $game_map.events.values
			# If event coordinates are consistent with move destination
			if event.x == new_x and event.y == new_y
				# If through is OFF
				return false if event.through
				return true
			end
		end
		# Loop all players
		for player in Network::Main.mapplayers.values
			# If player coordinates are consistent with move destination
			next if player == nil
			if player.x == new_x and player.y == new_y
				# If through is OFF
				return false if player.through
				return true
			end
		end
		
		return false
	end
end	
$rpg_skill = Rpg_skill.new