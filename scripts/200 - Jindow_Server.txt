#==============================================================================
# ■ Jindow_Server
#------------------------------------------------------------------------------
#   서버 선택 창
#------------------------------------------------------------------------------
class Jindow_Server < Jindow
  def initialize
    super(0, 0, 120, User_Edit::SERVERS.size * 30 + 35)
    self.name = "서버 선택"
    @head = true
    @mark = true
    @drag = true
    self.refresh "Server"
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
    @buttons = []
    for i in 0...User_Edit::SERVERS.size
      @buttons[i] = J::Button.new(self).refresh(120, User_Edit::SERVERS[i][2])
      @buttons[i].y = i * 30 + 12
    end
    @a = J::Button.new(self).refresh(60, "종료")
    @a.x = self.width - 60
    @a.y = @buttons.size * 30 + 14
  end
  
  def update
    super
    for i in 0...@buttons.size
      if @buttons[i].click
        Network::Main.initialize
        Network::Main.start_connection(User_Edit::SERVERS[i][0],User_Edit::SERVERS[i][1])
        Network::Main.retrieve_mod
        Network::Main.amnet_auth
        $scene = Scene_Login.new
      end
    end
    if @a.click  # 취소
      $game_system.se_play($data_system.decision_se)
      JS.game_end
    end
  end
end
