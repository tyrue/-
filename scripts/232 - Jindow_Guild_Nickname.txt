#==============================================================================
# ■ Jindow_Guild_Nickname
#------------------------------------------------------------------------------
# 　문파 계급 하사
#==============================================================================

class Jindow_Guild_Nickname < Jindow
  #--------------------------------------------------------------------------
  # ● 메인 처리
  #--------------------------------------------------------------------------
  
  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 150, 100)
    $nicknames = true
    $shopopen = true
    self.name = "문파원 칭호 하사"
    @head = true
    @drag = true
    self.refresh "Guild_Group"
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
    @username1_s = Sprite.new(self)
    @username1_s.y = 0
    @username1_s.bitmap = Bitmap.new(40, 32)
    @username1_s.bitmap.font.color.set(0, 0, 0, 255)
    @username1_s.bitmap.draw_text(0, 0, 40, 32, "이름")
    @type_guild1 = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
    @username2_s = Sprite.new(self)
    @username2_s.y = 30
    @username2_s.bitmap = Bitmap.new(40, 32)
    @username2_s.bitmap.font.color.set(0, 0, 0, 255)
    @username2_s.bitmap.draw_text(0, 0, 40, 32, "칭호")
    @type_guild2 = J::Type.new(self).refresh(40, 37, self.width - 40, 16)
    @a = J::Button.new(self).refresh(45, "하사")
    @a.x = self.width - 92
    @a.y = 65
    @b = J::Button.new(self).refresh(45, "취소")
    @b.x = self.width - 45
    @b.y = 65
  end
  #--------------------------------------------------------------------------
  # ● 프레임 갱신
  #--------------------------------------------------------------------------
  def update
    super
    if @a.click
      $game_system.se_play($data_system.decision_se)
      @type_guild1.bluck = false
      @type_guild2.bluck = false
      guild = @type_guild1.result
      guild2 = @type_guild2.result
      if guild2 == "문파장"
         $console.write_line("문파장은 한 명 밖에 할 수 없습니다.")
      else
        if guild.to_s != $game_party.actors[0].name
       $console.write_line("#{guild}님의 칭호를 변경시키고 있습니다.")
          Network::Main.socket.send "<Guild_Nick>#{$guild.to_s},#{guild.to_s},#{guild2}</Guild_Nick>\n"
        end
      end
    elsif @b.click
      Hwnd.dispose(self)
    end
  end
end
