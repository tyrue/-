#==============================================================================
# ** Game_Map
#------------------------------------------------------------------------------
#  This class handles the map. It includes scrolling and passable determining
#  functions. Refer to "$game_map" for the instance of this class.
#==============================================================================
class Game_Map
  #--------------------------------------------------------------------------
  # * Determine if Passable
  #     x          : x-coordinate
  #     y          : y-coordinate
  #     d          : direction (0,2,4,6,8,10)
  #                  *  0,10 = determine if all directions are impassable
  #     self_event : Self (If event is determined passable)
  #--------------------------------------------------------------------------
  def passable?(x, y, d, self_event = nil)
    # If coordinates given are outside of the map
    unless valid?(x, y)
      # impassable
      return false
    end
    # Change direction (0,2,4,6,8,10) to obstacle bit (0,1,2,4,8,0)
    bit = (1 << (d / 2 - 1)) & 0x0f
    # Loop in all events
    for event in events.values
      # If tiles other than self are consistent with coordinates
      if event.tile_id >= 0 and event != self_event and
         event.x == x and event.y == y and not event.through
        # If obstacle bit is set
        if @passages[event.tile_id] & bit != 0
          # impassable
          return false
        # If obstacle bit is set in all directions
        elsif @passages[event.tile_id] & 0x0f == 0x0f
          # impassable
          return false
        # If priorities other than that are 0
        elsif @priorities[event.tile_id] == 0
          # passable
          return true
        end
      end
    end
    # Loop in all events
    for player in Network::Main.mapplayers.values
      next if player == nil
      next if player.map_id != $game_map.map_id
      # If tiles other than self are consistent with coordinates
      if player.tile_id >= 0 and player != self_event and
         player.x == x and player.y == y and not player.through
        # If obstacle bit is set
        if @passages[player.tile_id] & bit != 0
          # impassable
          return false
        # If obstacle bit is set in all directions
        elsif @passages[player.tile_id] & 0x0f == 0x0f
          # impassable
          return false
        # If priorities other than that are 0
        elsif @priorities[player.tile_id] == 0
          # passable
          return true
        end
      end
    end
    # Loop searches in order from top of layer
    for i in [2, 1, 0]
      # Get tile ID
      tile_id = data[x, y, i]
      # Tile ID acquistion failure
      if tile_id == nil
        # impassable
        return false
      # If obstacle bit is set
      elsif @passages[tile_id] & bit != 0
        # impassable
        return false
      # If obstacle bit is set in all directions
      elsif @passages[tile_id] & 0x0f == 0x0f
        # impassable
        return false
      # If priorities other than that are 0
      elsif @priorities[tile_id] == 0
        # passable
        return true
      end
    end
    # passable
    return true
  end
  
end