
#==============================================================================
# ¦ 스위치/변수/셀프 스위치 서버 저장 
#------------------------------------------------------------------------------
#  제작자:흑부엉
#==============================================================================

class Interpreter
  
  #--------------------------------------------------------------------------
  # ? Switches
  #--------------------------------------------------------------------------
  def command_121
    # ???????????
    for i in @parameters[0] .. @parameters[1]
      # ???????
      $game_switches[i] = (@parameters[2] == 0)
      Network::Main.socket.send("<10b>$game_switches[#{i}] = #{@parameters[2] == 0}</10b>\n") if i >= 1500
    end
    # ??????????
    $game_map.need_refresh = true
    # ??
    return true
  end
  
  #--------------------------------------------------------------------------
  # ? Variables
  #--------------------------------------------------------------------------
  def command_122
    @invio = false
    # ?????
    value = 0
    # ????????
    case @parameters[3]
    when 0  # ??
      value = @parameters[4]
    when 1  # ??
      value = $game_variables[@parameters[4]]
    when 2  # ??
      value = @parameters[4] + rand(@parameters[5] - @parameters[4] + 1)
    when 3  # ????
      value = $game_party.item_number(@parameters[4])
    when 4  # ????
      actor = $game_actors[@parameters[4]]
      if actor != nil
        case @parameters[5]
        when 0  # ???
          value = actor.level
        when 1  # EXP
          value = actor.exp
        when 2  # HP
          value = actor.hp
        when 3  # SP
          value = actor.sp
        when 4  # MaxHP
          value = actor.maxhp
        when 5  # MaxSP
          value = actor.maxsp
        when 6  # ??
          value = actor.str
        when 7  # ???
          value = actor.dex
        when 8  # ???
          value = actor.agi
        when 9  # ??
          value = actor.int
        when 10  # ???
          value = actor.atk
        when 11  # ????
          value = actor.pdef
        when 12  # ????
          value = actor.mdef
        when 13  # ????
          value = actor.eva
        end
      end
    when 5  # ????
      enemy = $game_troop.enemies[@parameters[4]]
      if enemy != nil
        case @parameters[5]
        when 0  # HP
          value = enemy.hp
        when 1  # SP
          value = enemy.sp
        when 2  # MaxHP
          value = enemy.maxhp
        when 3  # MaxSP
          value = enemy.maxsp
        when 4  # ??
          value = enemy.str
        when 5  # ???
          value = enemy.dex
        when 6  # ???
          value = enemy.agi
        when 7  # ??
          value = enemy.int
        when 8  # ???
          value = enemy.atk
        when 9  # ????
          value = enemy.pdef
        when 10  # ????
          value = enemy.mdef
        when 11  # ????
          value = enemy.eva
        end
      end
    when 6  # ??????
      character = get_character(@parameters[4])
      if character != nil
        case @parameters[5]
        when 0  # X ??
          value = character.x
        when 1  # Y ??
          value = character.y
        when 2  # ??
          value = character.direction
        when 3  # ?? X ??
          value = character.screen_x
        when 4  # ?? Y ??
          value = character.screen_y
        when 5  # ????
          value = character.terrain_tag
        end
      end
    when 7  # ???
      case @parameters[4]
      when 0  # ??? ID
        value = $game_map.map_id
      when 1  # ??????
        value = $game_party.actors.size
      when 2  # ????
        value = $game_party.gold
      when 3  # ??
        value = $game_party.steps
      when 4  # ?????
        value = Graphics.frame_count / Graphics.frame_rate
      when 5  # ????
        value = $game_system.timer / Graphics.frame_rate
      when 6  # ?????
        value = $game_system.save_count
      end
    end
    # ???????????
    for i in @parameters[0] .. @parameters[1]
      # ?????
      case @parameters[2]
      when 0  # ??
        $game_variables[i] = value
      when 1  # ??
        $game_variables[i] += value
      when 2  # ??
        $game_variables[i] -= value
      when 3  # ??
        $game_variables[i] *= value
      when 4  # ??
        if value != 0
          $game_variables[i] /= value
        end
      when 5  # ??
        if value != 0
          $game_variables[i] %= value
        end
      end
      # ??????
      if $game_variables[i] > 99999999
        $game_variables[i] = 99999999
      end
      # ??????
      if $game_variables[i] < -99999999
        $game_variables[i] = -99999999
      end

      Network::Main.socket.send("<10b>$game_variables[#{i}]  = #{$game_variables[i]}</10b>\n") if i >= 1500 and @invio==false
      @invio = true
    end
    # ??????????
    $game_map.need_refresh = true
    # ??
    return true
    @invio = false
  end  

  
  #--------------------------------------------------------------------------
  # ? Self-Switches
  #--------------------------------------------------------------------------  
  def command_123
    # ???? ID ??????
    if @event_id > 0
      # ?????????????
      key = [$game_map.map_id, @event_id, @parameters[0]]
      # ??????????
      $game_self_switches[key] = (@parameters[1] == 0)
      Network::Main.socket.send("<23>$game_self_switches[[#{$game_map.map_id}, #{@event_id}, '#{@parameters[0]}']] = #{(@parameters[1] == 0)}</23>\n") if User_Edit::GLOBAL_SELF.include?(key[2])
    end
    # ??????????
    $game_map.need_refresh = true
    # ??
    return true
  end
  
end
