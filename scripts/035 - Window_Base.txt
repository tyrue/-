#==============================================================================
# ■ Window_Base
#------------------------------------------------------------------------------
# 　게임중의 모든 윈도우의 슈퍼 클래스입니다.
#==============================================================================

class Window_Base < Window
  #--------------------------------------------------------------------------
  # ● 오브젝트 초기화
  #     x      : 윈도우의 X 좌표
  #     y      : 윈도우의 Y 좌표
  #     width  : 윈도우의 폭
  #     height : 윈도우의 높이
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height)
    super()
    @windowskin_name = $game_system.windowskin_name
    self.windowskin = RPG::Cache.windowskin(@windowskin_name)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.z = 100
    Font.default_size = 17
    Font.default_name = ["맑은 고딕","맑은 고딕"]
  end
  #--------------------------------------------------------------------------
  # ● 해방
  #--------------------------------------------------------------------------
  def dispose
    # 윈도우 내용의 비트 맵이 설정되어 있으면 해방
    if self.contents != nil
      self.contents.dispose
    end
    super
  end
  #--------------------------------------------------------------------------
  # ● 문자색취득
  #     n : 문자색번호 (0~7)
  #--------------------------------------------------------------------------
  def text_color(n)
    case n
    when 0
      return Color.new(255, 255, 255, 255)
    when 1
      return Color.new(128, 128, 255, 255)
    when 2
      return Color.new(255, 128, 128, 255)
    when 3
      return Color.new(128, 255, 128, 255)
    when 4
      return Color.new(128, 255, 255, 255)
    when 5
      return Color.new(255, 128, 255, 255)
    when 6
      return Color.new(255, 255, 128, 255)
    when 7
      return Color.new(192, 192, 192, 255)
    else
      normal_color
    end
  end
  #--------------------------------------------------------------------------
  # ● 통상 문자색 취득
  #--------------------------------------------------------------------------
  def normal_color
    return Color.new(220, 220, 220, 255)
  end
  #--------------------------------------------------------------------------
  # ● 무효 문자색 취득
  #--------------------------------------------------------------------------
  def disabled_color
    return Color.new(255, 255, 255, 128)
  end
  #--------------------------------------------------------------------------
  # ● 시스템 문자색 취득
  #--------------------------------------------------------------------------
  def system_color
    return Color.new(192, 224, 255, 255)
  end
  #--------------------------------------------------------------------------
  # ● 핀치 문자색 취득
  #--------------------------------------------------------------------------
  def crisis_color
    return Color.new(255, 255, 64, 255)
  end
  #--------------------------------------------------------------------------
  # ● 전투 불능 문자색 취득
  #--------------------------------------------------------------------------
  def knockout_color
    return Color.new(255, 64, 0)
  end
  #--------------------------------------------------------------------------
  # ● 프레임 갱신
  #--------------------------------------------------------------------------
  def update
    super
    # 윈도우 스킨이 변경되었을 경우, 재설정
    if $game_system.windowskin_name != @windowskin_name
      @windowskin_name = $game_system.windowskin_name
      self.windowskin = RPG::Cache.windowskin(@windowskin_name)
    end
  end
  #--------------------------------------------------------------------------
  # ● 그래픽의 묘화
  #     actor : 액터
  #     x     : 묘화처 X 좌표
  #     y     : 묘화처 Y 좌표
  #--------------------------------------------------------------------------
  def draw_actor_graphic(actor, x, y)
    bitmap = RPG::Cache.character(actor.character_name, actor.character_hue)
    cw = bitmap.width / 4
    ch = bitmap.height / 4
    src_rect = Rect.new(0, 0, cw, ch)
    self.contents.blt(x - cw / 2, y - ch, bitmap, src_rect)
  end
  #--------------------------------------------------------------------------
  # ● 이름의 묘화
  #     actor : 액터
  #     x     : 묘화처 X 좌표
  #     y     : 묘화처 Y 좌표
  #--------------------------------------------------------------------------
  def draw_actor_name(actor, x, y)
    self.contents.font.color = normal_color
    self.contents.draw_text(x, y, 120, 32, actor.name)
  end
  #--------------------------------------------------------------------------
  # ● 클래스의 묘화
  #     actor : 액터
  #     x     : 묘화처 X 좌표
  #     y     : 묘화처 Y 좌표
  #--------------------------------------------------------------------------
  def draw_actor_class(actor, x, y)
    self.contents.font.color = normal_color
    self.contents.draw_text(x, y, 236, 32, actor.class_name)
  end
  #--------------------------------------------------------------------------
  # ● 레벨의 묘화
  #     actor : 액터
  #     x     : 묘화처 X 좌표
  #     y     : 묘화처 Y 좌표
  #--------------------------------------------------------------------------
  def draw_actor_level(actor, x, y)
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 32, 32, "Lv")
    self.contents.font.color = normal_color
    self.contents.draw_text(x + 32, y, 24, 32, actor.level.to_s, 2)
  end
  #--------------------------------------------------------------------------
  # ● 묘화용의 스테이트 문자열 작성
  #     actor       : 액터
  #     width       : 묘화처의 폭
  #     need_normal : [정상] 이 필요할지 (true / false)
  #--------------------------------------------------------------------------
  def make_battler_state_text(battler, width, need_normal)
    # 괄호의 폭을 취득
    brackets_width = self.contents.text_size("[]").width
    # 스테이트명의 문자열을 작성
    text = ""
    for i in battler.states
      if $data_states[i].rating >= 1
        if text == ""
          text = $data_states[i].name
        else
          new_text = text + "/" + $data_states[i].name
          text_width = self.contents.text_size(new_text).width
          if text_width > width - brackets_width
            break
          end
          text = new_text
        end
      end
    end
    # 스테이트명의 문자열이 하늘의 경우는 "[정상]" 으로 한다
    if text == ""
      if need_normal
        text = "[정상]"
      end
    else
      # 괄호를 붙인다
      text = "[" + text + "]"
    end
    # 완성한 문자열을 돌려준다
    return text
  end
  #--------------------------------------------------------------------------
  # ● 스테이트의 묘화
  #     actor : 액터
  #     x     : 묘화처 X 좌표
  #     y     : 묘화처 Y 좌표
  #     width : 묘화처의 폭
  #--------------------------------------------------------------------------
  def draw_actor_state(actor, x, y, width = 120)
    text = make_battler_state_text(actor, width, true)
    self.contents.font.color = actor.hp == 0 ? knockout_color : normal_color
    self.contents.draw_text(x, y, width, 32, text)
  end
  #--------------------------------------------------------------------------
  # ● EXP 의 묘화
  #     actor : 액터
  #     x     : 묘화처 X 좌표
  #     y     : 묘화처 Y 좌표
  #--------------------------------------------------------------------------
  def draw_actor_exp(actor, x, y)
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 24, 32, "E")
    self.contents.font.color = normal_color
    self.contents.draw_text(x + 24, y, 84, 32, actor.exp_s, 2)
    self.contents.draw_text(x + 108, y, 12, 32, "/", 1)
    self.contents.draw_text(x + 120, y, 84, 32, actor.next_exp_s)
  end
  #--------------------------------------------------------------------------
  # ● HP 의 묘화
  #     actor : 액터
  #     x     : 묘화처 X 좌표
  #     y     : 묘화처 Y 좌표
  #     width : 묘화처의 폭
  #--------------------------------------------------------------------------
  def draw_actor_hp(actor, x, y, width = 144)
    # 문자열 "HP" 를 묘화
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 32, 32, $data_system.words.hp)
    # MaxHP 를 묘화 하는 스페이스가 있을까 계산
    if width - 32 >= 108
      hp_x = x + width - 108
      flag = true
    elsif width - 32 >= 48
      hp_x = x + width - 48
      flag = false
    end
    # HP 를 묘화
    self.contents.font.color = actor.hp == 0 ? knockout_color :
      actor.hp <= actor.maxhp / 4 ? crisis_color : normal_color
    self.contents.draw_text(hp_x, y, 48, 32, actor.hp.to_s, 2)
    # MaxHP 를 묘화
    if flag
      self.contents.font.color = normal_color
      self.contents.draw_text(hp_x + 48, y, 12, 32, "/", 1)
      self.contents.draw_text(hp_x + 60, y, 48, 32, actor.maxhp.to_s)
    end
  end
  #--------------------------------------------------------------------------
  # ● SP 의 묘화
  #     actor : 액터
  #     x     : 묘화처 X 좌표
  #     y     : 묘화처 Y 좌표
  #     width : 묘화처의 폭
  #--------------------------------------------------------------------------
  def draw_actor_sp(actor, x, y, width = 144)
    # 문자열 "SP" 를 묘화
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 32, 32, $data_system.words.sp)
    # MaxSP 를 묘화 하는 스페이스가 있을까 계산
    if width - 32 >= 108
      sp_x = x + width - 108
      flag = true
    elsif width - 32 >= 48
      sp_x = x + width - 48
      flag = false
    end
    # SP 를 묘화
    self.contents.font.color = actor.sp == 0 ? knockout_color :
      actor.sp <= actor.maxsp / 4 ? crisis_color : normal_color
    self.contents.draw_text(sp_x, y, 48, 32, actor.sp.to_s, 2)
    # MaxSP 를 묘화
    if flag
      self.contents.font.color = normal_color
      self.contents.draw_text(sp_x + 48, y, 12, 32, "/", 1)
      self.contents.draw_text(sp_x + 60, y, 48, 32, actor.maxsp.to_s)
    end
  end
  #--------------------------------------------------------------------------
  # ● 파라미터의 묘화
  #     actor : 액터
  #     x     : 묘화처 X 좌표
  #     y     : 묘화처 Y 좌표
  #     type  : 파라미터의 종류 (0~6)
  #--------------------------------------------------------------------------
  def draw_actor_parameter(actor, x, y, type)
    case type
    when 0
      parameter_name = $data_system.words.atk
      parameter_value = actor.atk
    when 1
      parameter_name = $data_system.words.pdef
      parameter_value = actor.pdef
    when 2
      parameter_name = $data_system.words.mdef
      parameter_value = actor.mdef
    when 3
      parameter_name = $data_system.words.str
      parameter_value = actor.str
    when 4
      parameter_name = $data_system.words.dex
      parameter_value = actor.dex
    when 5
      parameter_name = $data_system.words.agi
      parameter_value = actor.agi
    when 6
      parameter_name = $data_system.words.int
      parameter_value = actor.int
    end
    self.contents.font.color = system_color
    self.contents.draw_text(x, y, 120, 32, parameter_name)
    self.contents.font.color = normal_color
    self.contents.draw_text(x + 120, y, 36, 32, parameter_value.to_s, 2)
  end
  #--------------------------------------------------------------------------
  # ● 아이템명의 묘화
  #     item : 아이템
  #     x    : 묘화처 X 좌표
  #     y    : 묘화처 Y 좌표
  #--------------------------------------------------------------------------
  def draw_item_name(item, x, y)
    if item == nil
      return
    end
    bitmap = RPG::Cache.icon(item.icon_name)
    self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24))
    self.contents.font.color = normal_color
    self.contents.draw_text(x + 28, y, 212, 32, item.name)
  end
end
