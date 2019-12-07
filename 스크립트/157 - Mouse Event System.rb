#==============================================================================
# ** Sprite_Cursor
#------------------------------------------------------------------------------
#  This sprite displays the cursor. It's used in the Spriteset_Map class.
#==============================================================================

class Sprite_Cursor < Sprite
  attr_accessor   :x
  attr_accessor   :y
  attr_accessor   :icon
  attr_accessor   :lock
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     viewport : viewport
  #     picture  : picture (Game_Picture)
  #--------------------------------------------------------------------------
  def initialize(viewport)
    super(viewport)
    update
    @icon = $game_system.cursor
    @old_icon = $game_system.cursor
    @lock = false
  end
  #--------------------------------------------------------------------------
  # * Dispose
  #--------------------------------------------------------------------------
  def dispose
    if self.bitmap != nil
      self.bitmap.dispose
    end
    super
  end
  #--------------------------------------------------------------------------
  # * Dispose
  #--------------------------------------------------------------------------
  def set_icon(new)
    if not @lock
      @icon = new
    end
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    # If picture file name is different from current one
    if self.bitmap == nil
      self.bitmap = RPG::Cache.picture($game_system.cursor)
    end
    
    if @icon != @old_icon
      if @icon == nil
        self.bitmap = RPG::Cache.picture($game_system.cursor)
        @old_icon = nil
      else
        self.bitmap = RPG::Cache.picture(@icon)
        @old_icon = @icon
      end
    end
    # If file name is empty
    # Set sprite to visible
    self.visible = true
    # Set transfer starting point
    # Set sprite coordinates
    pos = Mouse.pos
    if pos == nil
      if self.x == nil
        self.x = 0
      end
      if self.y == nil
        self.y = 0
      end
    else
      self.x = 0
      self.ox = pos[0] * -1 + (self.bitmap.width / 2)
      self.y = 0
      self.oy = pos[1] * -1 + (self.bitmap.height / 2)
    end
  end
end

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
    # Update the Keyboard Module
    Keyboard.update
    # Run old map update
    event_system_update
    #Update the mouse
    mouse_interface_update
    # Left Click Actions
    if Keyboard.pressed?(Keyboard::Mouse_Left) and @update_interface <= 0
      mouse_left_click
    elsif @update_interface > 0
      @update_interface -= 1
    end
  end
  #--------------------------------------------------------------------------
  # * Do actions that are related to the left click
  #--------------------------------------------------------------------------
  def mouse_left_click
    # If Mouse POS not nil
    pos = Mouse.pos
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
      # Get events that count as active (most front one)
			
      active_event = @spriteset.get_affected_event(@x_mouse, @y_mouse)
			
      if active_event > 0
        event = $game_map.events[active_event]
        range = get_object_range($game_player, event)
        run_it = part_of_event_system(event)
        # Check to see if it's a run event or not
        run_it = part_of_event_system(event)
				run_it = 20
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
  # * Update Mouse position and cursor
  #--------------------------------------------------------------------------
  def mouse_interface_update
    pos = Mouse.pos
    if pos != nil and (pos[0] != @x_mouse or pos[1] != @y_mouse)
      @x_mouse = pos[0]
      @y_mouse = pos[1]
      # Get the event that is under the mouse (most front one)
      hover = @spriteset.get_affected_event(@x_mouse, @y_mouse)
      if hover > 0
        event = $game_map.events[hover]
        # Run it if it is
        if event.list != nil
          for item in event.list
            if item.code == 108 and item.parameters[0].include?("CURSOR=")
              id = item.parameters[0].split('=')
              @spriteset.cursor.set_icon(id[1])
              set_icon = true
            end
          end
        end
      else
        x = pos[0] / 32
        y = pos[1] / 32
        if $game_map.display_x != 0
          x += ($game_map.display_x / 4) / 32
        end
        if $game_map.display_y != 0
          y += ($game_map.display_y / 4) / 32
        end
        set_icon = false
        for event in $game_map.events.values
          if event.x == x and event.y == y and event.character_name == ""
            if event.list != nil
              for item in event.list
                if item.code == 108 and item.parameters[0].include?("CURSOR=")
                  id = item.parameters[0].split('=')
                  @spriteset.cursor.set_icon(id[1])
                  set_icon = true
                end
              end
            end
          end
        end
        if not set_icon and @spriteset.cursor.icon != nil
          @spriteset.cursor.set_icon(nil)
        end
      end
    end
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
          end
        end
      end
    end
    return false
  end
end
#End Scene_Map

#==============================================================================
# ** Game_Player
#------------------------------------------------------------------------------
#  This class handles the player. Its functions include event starting
#  determinants and map scrolling. Refer to "$game_player" for the one
#  instance of this class.
#==============================================================================

class Game_Player < Game_Character
  #--------------------------------------------------------------------------
  # * Invariables
  #--------------------------------------------------------------------------
  #--------------------------------------------------------------------------
  # * Move toward Player
  #--------------------------------------------------------------------------
  def move_toward_point(x, y)
    # Get difference in player coordinates
    sx = @x - x
    sy = @y - y
    # If coordinates are equal
    if sx == 0 and sy == 0
      return
    end
    # Get absolute value of difference
    abs_sx = sx.abs
    abs_sy = sy.abs
    # If horizontal and vertical distances are equal
    if abs_sx == abs_sy
      # Increase one of them randomly by 1
      rand(2) == 0 ? abs_sx += 1 : abs_sy += 1
    end
    # If horizontal distance is longer
    if abs_sx > abs_sy
      # Move towards point, prioritize left and right directions
      sx > 0 ? move_left : move_right
      if not moving? and sy != 0
        sy > 0 ? move_up : move_down
      end
    # If vertical distance is longer
    else
      # Move towards point, prioritize up and down directions
      sy > 0 ? move_up : move_down
      if not moving? and sx != 0
        sx > 0 ? move_left : move_right
      end
    end
  end
  
end #End Game_Player

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
  # * Object Initialization
  #--------------------------------------------------------------------------
  alias :event_system_normal_init :initialize
  def initialize
    event_system_normal_init
    if $scene.is_a?(Scene_Map)
      @cursor = Sprite_Cursor.new(@viewport3)
    end
  end
  #--------------------------------------------------------------------------
  # * Dispose
  #--------------------------------------------------------------------------
  alias :event_system_normal_dispose :dispose
  def dispose
    if @cursor != nil
      @cursor.dispose
    end
    event_system_normal_dispose
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  alias :event_system_normal_update :update
  def update
    event_system_normal_update
    if @cursor != nil
      @cursor.update
    end
  end
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