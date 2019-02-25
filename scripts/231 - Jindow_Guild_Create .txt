#==============================================================================
# ■ Jindow_Guild_Create
#==============================================================================

class Jindow_Guild_Create < Jindow
  #--------------------------------------------------------------------------
  # ● 메인 처리
  #--------------------------------------------------------------------------
  
  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 150, 50)
    $nicknames = true
    $shopopen = true
    self.name = "문파 만들기"
    @head = true
    @drag = true
    self.refresh "GuildCreate"
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
    @username3_s = Sprite.new(self)
    @username3_s.y = 0
    @username3_s.bitmap = Bitmap.new(40, 32)
    @username3_s.bitmap.font.color.set(0, 0, 0, 255)
    @username3_s.bitmap.draw_text(0, 0, 40, 32, "문파명")
    @type_guild3 = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
    @a = J::Button.new(self).refresh(45, "만들기")
    @a.x = self.width - 92
    @a.y = 25
  end
  #--------------------------------------------------------------------------
  # ● 프레임 갱신
  #--------------------------------------------------------------------------
  def update
    super
    if @a.click
      $game_system.se_play($data_system.decision_se)
      @type_guild3.bluck = false
      guild = @type_guild3.result
      guild3 = guild.length
      Network::Main.socket.send "<Guild_Create>#{guild}</Guild_Create>\n"
      $cbig = 0
      Hwnd.dispose(self)
    end
  end
end
