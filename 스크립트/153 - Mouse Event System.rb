#==============================================================================
# ** Scene_ActionMap
#------------------------------------------------------------------------------
#  This class performs map screen processing and allows the use of the 
# mouse to make activations of events.
#==============================================================================
class Scene_Map
	#--------------------------------------------------------------------------
	# * Main Processing
	#--------------------------------------------------------------------------
	alias :event_system_main :main
	def main
		@update_interface = -1
		event_system_main
	end
	#--------------------------------------------------------------------------
	# * Frame Update
	#--------------------------------------------------------------------------
	alias :event_system_update :update
	def update
		# Run old map update
		event_system_update
		# Left Click Actions
		
		if Key.trigger?(KEY_MOUSE_LEFT) and @update_interface <= 0
			mouse_left_click
		elsif @update_interface > 0
			@update_interface -= 1
		end
	end
	#--------------------------------------------------------------------------
	# * Do actions that are related to the left click
	#--------------------------------------------------------------------------
	def mouse_left_click
		return if Hwnd.mouse_in_window
		# If Mouse POS not nil
		pos = Input.mouse_pos
		if pos != nil and not $game_temp.message_window_showing
			x = pos[0]
			y = pos[1]
			
			# Set the X and Y to the correct X/Y coordinates
			x2 = x / 32
			y2 = y / 32
			if $game_map.display_x != 0
				x2 += ($game_map.display_x / 4) / 32
			end
			if $game_map.display_y != 0
				y2 += ($game_map.display_y / 4) / 32
			end
			event_run = false
			
			# 이벤트 실행
			active_event = @spriteset.get_affected_event(x, y)
			
			if active_event > 0
				event = $game_map.events[active_event]
				range = get_object_range($game_player, event)
				# Check to see if it's a run event or not
				run_it = part_of_event_system(event)
				
				# Run it if it is
				if run_it != false and event.trigger == 0
					range = get_object_range($game_player, event)
					if run_it >= range
						event.refresh
						event.start
						$game_map.need_refresh
						@update_interface = 10
						event_run = true
					end
				end #End the run check
			else
				eventlist = $game_map.events.values
				for event in eventlist
					if x2 == event.x and y2 == event.y and event.character_name == ""
						# Check to see if it's a run event or not
						run_it = part_of_event_system(event)
						# Run it if it is
						if run_it != false and event.trigger == 0
							range = get_object_range($game_player, event)
							if run_it >= range
								event.refresh
								event.start
								$game_map.need_refresh
								@update_interface = 10
								event_run = true
							end
						end #End the run check
					end # End the X/Y check
				end
			end #End if/else
		end # End POS != nil statement
	end
	
	
	#--------------------------------------------------------------------------
	# * Get Range from Point1 to Point2
	#--------------------------------------------------------------------------
	def get_object_range(point1, point2)
		range_x = (point1.x.abs) - (point2.x.abs)
		range_y = (point1.y.abs) - (point2.y.abs)
		range_x = range_x.abs
		range_y = range_y.abs
		range_x = range_x * range_x
		range_y = range_y * range_y
		range = Math.sqrt(range_x + range_y)
		range = range.round
		return range
	end
	#--------------------------------------------------------------------------
	# * Part of Combat System
	#--------------------------------------------------------------------------
	def part_of_event_system(event)
		if event.is_a?(Game_Event)
			if event.list != nil
				for item in event.list
					if item.code == 108 and item.parameters[0].include?("RUN=")
						id = item.parameters[0].split('=')
						return (id[1].to_i)
					else
						return 40
					end
				end
			end
		end
		return false
	end
end
#End Scene_Map


#==============================================================================
# ** Spriteset_Map
#------------------------------------------------------------------------------
#  This class brings together map screen sprites, tilemaps, etc.
#  It's used within the Scene_Map class.
#==============================================================================

class Spriteset_Map
	attr_accessor   :cursor
	attr_reader     :character_sprites
	
	#--------------------------------------------------------------------------
	# * Get Event under a Click Point
	#--------------------------------------------------------------------------
	def get_affected_event(true_x, true_y)
		data = []
		for sprite in @character_sprites
			x = true_x - sprite.x
			y = true_y - sprite.y
			if sprite.tile_id == 0
				if x.abs < (sprite.cw / 2) and y.abs < sprite.ch and y < 0
					bx = (sprite.cw / 2) + x
					by = sprite.ch + y
					sx = sprite.character.pattern * sprite.cw
					sy = (sprite.character.direction - 2) / 2 * sprite.ch
					if sprite.bitmap.get_pixel((bx+sx),(by+sy)).alpha > 0.0
						data.push(sprite.character)
					end
				end
			else
				if x.abs < 16 and y.abs < 32 and y < 0
					data.push(sprite.character)
				end
			end
		end
		if data.size > 1
			event = data[0]
			for i in 0...data.size
				if data[i].y > event.y
					event = data[i]
				end
			end
			return event.id
		elsif data.size > 0
			return data[0].id
		else
			return -1
		end
	end
	
	# End the Spriteset_Map
end

#==============================================================================
# ** Sprite_Character
#------------------------------------------------------------------------------
#  This sprite is used to display the character.It observes the Game_Character
#  class and automatically changes sprite conditions.
#==============================================================================

class Sprite_Character < RPG::Sprite
	attr_reader   :cw
	attr_reader   :ch
	attr_reader   :tile_id
end

#==============================================================================
# ** Game_System
#------------------------------------------------------------------------------
#  This class handles data surrounding the system. Backround music, etc.
#  is managed here as well. Refer to "$game_system" for the instance of 
#  this class.
#==============================================================================

class Game_System
	attr_accessor     :cursor
	attr_accessor     :move_toward_mouse
	#--------------------------------------------------------------------------
	# * Object Initialization
	#--------------------------------------------------------------------------
	alias :event_system_normal_init :initialize
	def initialize
		event_system_normal_init
		@move_toward_mouse = true
		@cursor = ""
	end
end