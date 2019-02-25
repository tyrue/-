#==============================================================================
# ■ Jindow_Guild_Create
#------------------------------------------------------------------------------
# 　제작 : 흑부엉
#==============================================================================

class Jindow_bigsay < Jindow
  #--------------------------------------------------------------------------
  # ● 메인 처리
  #--------------------------------------------------------------------------
  
  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 300, 50)
    self.name = "확성기"
    @head = true
    @drag = true
    self.refresh "bigsay"
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
    @bigsay_s = Sprite.new(self)
    @bigsay_s.y = 0
    @bigsay_s.bitmap = Bitmap.new(40, 32)
    @bigsay_s.bitmap.font.color.set(0, 0, 0, 255)
    @bigsay_s.bitmap.draw_text(0, 0, 40, 32, "할말:")
    @type_bigsay2 = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
    @a = J::Button.new(self).refresh(45, "사용하기")
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
      bigsay3 = @type_bigsay2.result
      bigsay2 = bigsay3.length
      $game_party.lose_item(29, 1)
      name = $game_party.actors[0].name
      Network::Main.socket.send "<chat>[확성기] <#{name}>:#{bigsay3}</chat>\n"
      Network::Main.socket.send("<bigsay>#{name} #{bigsay3}</bigsay>\n")
      Hwnd.dispose(self)
      $cbig = 0
    end
  end
end
