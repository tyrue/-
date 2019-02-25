#==============================================================================
# ** Enemy Bars
#------------------------------------------------------------------------------
# Mr.Mo "Muhammet Sivri"
# Version 1
# 10.16.06
#==============================================================================
#-------------------------------------------------------------------------------
# Begin SDK Enabled Check
#-------------------------------------------------------------------------------
if SDK.state("Mr.Mo's ABS")
class Enemy_Bars < Sprite
  #--------------------------------------------------------------------------
  # * Constants Bar Types and Hues for parameters and parameter names
  #--------------------------------------------------------------------------
  HP_BAR = "014-Reds01"
  # leave this alone if you don't know what you are doing
  OUTLINE = 1
  BORDER = 1
  HP_WIDTH = 30         # WIDTH of the HP Bar
  HP_HEIGHT = 5         # Height of the HP Bar
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(enemy, v)
    super(v)
    @enemy = enemy
    @old_hp = 0
    @old_x = 0
    @old_y = 0
    self.bitmap = Bitmap.new(HP_WIDTH, HP_HEIGHT)
    update    
  end
  #--------------------------------------------------------------------------
  # * Refresh
  #--------------------------------------------------------------------------
  def refresh
    #First move it
    @old_x = @enemy.event.screen_x-10
    @old_y = @enemy.event.screen_y
    self.x = @old_x
    self.y = @old_y
    #HP Bar Check
    return if @old_hp == @enemy.hp
    self.bitmap.clear
    @old_hp = @enemy.hp
    #Show the bar
    draw_gradient_bar(0,0,@enemy.hp,@enemy.maxhp,HP_BAR,HP_WIDTH,HP_HEIGHT)
  end  
  #--------------------------------------------------------------------------
  # * Something Changed?
  #--------------------------------------------------------------------------
  def something_changed?
    return dispose if @enemy.dead? or $ABS.enemies[@enemy.event_id] == nil
    return true if @old_hp != @enemy.hp
    return true if @old_x != @enemy.event.screen_x-10
    return true if @old_y != @enemy.event.screen_y
    return false
  end
  #--------------------------------------------------------------------------
  # * Update
  #--------------------------------------------------------------------------
  def update
    refresh if something_changed?
  end
  #--------------------------------------------------------------------------
  # * Draw Gradient Bar 
  #--------------------------------------------------------------------------
  def draw_gradient_bar(x, y, min, max, file, width = nil, height = nil, hue = 0, back = "Back", back2 = "Back2")
    bar = RPG::Cache.gradient(file, hue)
    back = RPG::Cache.gradient(back)
    back2 = RPG::Cache.gradient(back2)
    cx = BORDER
    cy = BORDER
    dx = OUTLINE
    dy = OUTLINE
    zoom_x = width != nil ? width : back.width
    zoom_y = height != nil ? height : back.height
    percent = min / max.to_f if max != 0
    percent = 0 if max == 0
    back_dest_rect = Rect.new(x,y,zoom_x,zoom_y)
    back2_dest_rect = Rect.new(x+dx,y+dy,zoom_x -dx*2,zoom_y-dy*2)
    bar_dest_rect = Rect.new(x+cx,y+cy,zoom_x * percent-cx*2,zoom_y-cy*2)
    back_source_rect = Rect.new(0,0,back.width,back.height)
    back2_source_rect = Rect.new(0,0,back2.width,back2.height)
    bar_source_rect = Rect.new(0,0,bar.width* percent,bar.height)
    self.bitmap.stretch_blt(back_dest_rect, back, back_source_rect)
    self.bitmap.stretch_blt(back2_dest_rect, back2, back2_source_rect)
    self.bitmap.stretch_blt(bar_dest_rect, bar, bar_source_rect)
  end  
end
#============================================================================
# * Scene Map
#============================================================================
class Scene_Map
  #--------------------------------------------------------------------------
  alias mrmo_hpeny_scene_map_update update
  alias mrmo_hpeny_scene_map_main_draw main_draw
  #--------------------------------------------------------------------------
  # * Main Draw
  #--------------------------------------------------------------------------
  def main_draw
    @enemys_hp = {}
    #Get Enemies
    for e in $ABS.enemies.values
      e.bar_showing = false
    end
    mrmo_hpeny_scene_map_main_draw
  end
  #--------------------------------------------------------------------------
  # * Update
  #--------------------------------------------------------------------------
  def update
    #Get Enemies
    for e in $ABS.enemies.values
      next if e == nil
      #if in screen
      if $ABS.in_range?($game_player, e.event, 5)
        next if e.bar_showing
        @enemys_hp[e.event.id] = Enemy_Bars.new(e,@spriteset.viewport3)
        e.bar_showing = true
      elsif e.bar_showing and @enemys_hp[e.event.id] != nil
        @enemys_hp[e.event.id].dispose if !@enemys_hp[e.event.id].disposed?
        @enemys_hp[e.event.id] = nil
        e.bar_showing = false
      end
    end
    #Update HP BARS
    for bars in @enemys_hp.values
      next if bars == nil or bars.disposed?
      bars.update
    end
    mrmo_hpeny_scene_map_update
  end
end
#============================================================================
# * ABS Enemy
#============================================================================
class ABS_Enemy < Game_Battler
  #--------------------------------------------------------------------------
  attr_accessor :bar_showing
  #--------------------------------------------------------------------------
  alias mrmo_hpeny_abs_enemy_initialize initialize
  #--------------------------------------------------------------------------
  # * Object Initialization
  #--------------------------------------------------------------------------
  def initialize(enemy_id)
    mrmo_hpeny_abs_enemy_initialize(enemy_id)
    @bar_showing = false
  end
end
#==============================================================================
# ** Spriteset_Map
#------------------------------------------------------------------------------
#  This class brings together map screen sprites, tilemaps, etc.
#  It's used within the Scene_Map class.
#==============================================================================
class Spriteset_Map
  attr_accessor :viewport3
end
end