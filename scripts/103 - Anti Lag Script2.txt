#==============================================================================
# ** Anti Event Lag Script
#==============================================================================
# Near Fantastica and Mr.Mo
# Version 3
# 29.11.05
#==============================================================================
# The Anti Event Lag Script reduces the Lag in RMXP cause by events dramatically
# It dose this by limiting process updating and graphic updating for events
# outside the view of the screen. Events that are parallel process or auto-start
# are not effected by this script.
#==============================================================================

#------------------------------------------------------------------------------
# * SDK Log Script
#------------------------------------------------------------------------------
SDK.log("Anti Lag Script", "Near Fantastica", 3, "29.11.05")

#------------------------------------------------------------------------------
# * Begin SDK Enable Test
#------------------------------------------------------------------------------
if SDK.state("Anti Lag Script") == true
  #============================================================================
  # ** Game_Map
  #============================================================================
  class Game_Map
    #--------------------------------------------------------------------------
    # * Checks the object range
    #--------------------------------------------------------------------------
    def in_range?(object)
      screne_x = $game_map.display_x 
      screne_x -= 256
      screne_y = $game_map.display_y
      screne_y -= 256
      screne_width = $game_map.display_x 
      screne_width += 2816
      screne_height = $game_map.display_y
      screne_height += 2176
      return false if object.real_x <= screne_x
      return false if object.real_x >= screne_width
      return false if object.real_y <= screne_y
      return false if object.real_y >= screne_height
      return true
    end
    #--------------------------------------------------------------------------
    # * Updates Events
    #--------------------------------------------------------------------------
    def update_events
      for event in @events.values
        if in_range?(event) or event.trigger == 3 or event.trigger == 4
          event.update if event.name != "noupdate"
        end
      end
    end
  end
  #============================================================================
  # ** Spriteset_Map
  #============================================================================
  class Spriteset_Map
    #--------------------------------------------------------------------------
    # * Checks the object range
    #--------------------------------------------------------------------------
    def in_range?(object)
      screne_x = $game_map.display_x 
      screne_x -= 256
      screne_y = $game_map.display_y
      screne_y -= 256
      screne_width = $game_map.display_x 
      screne_width += 2816
      screne_height = $game_map.display_y
      screne_height += 2176
      return false if object.real_x <= screne_x
      return false if object.real_x >= screne_width
      return false if object.real_y <= screne_y
      return false if object.real_y >= screne_height
      return true
    end
    #--------------------------------------------------------------------------
    # * Update Sprites
    #--------------------------------------------------------------------------
    def update_character_sprites
      #Make a loop to get the sprites
      for sprite in @character_sprites
        #check if its an event
        if sprite.character.is_a?(Game_Event)
          #Check if in range
          if in_range?(sprite.character) or sprite.character.trigger == 3 or sprite.character.trigger == 4
            #Update event
            sprite.update
          end
        else
          #Update Sprite if not an event.
          sprite.update
        end
      end
      #Make a loop to get the sprites
      for nsprite in @network_sprites.values
        #Check if in range, update
        nsprite.update if in_range?(nsprite.character)
      end
    end
  end
#------------------------------------------------------------------------------
# * End SDK Enable Test
#------------------------------------------------------------------------------
end