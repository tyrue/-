#==============================================================================
# * 팝업 메뉴
#------------------------------------------------------------------------------
# - 유저를 클릭하면 해당 유저의 상세 정보를 표시합니다.
#==============================================================================
class Jindow_P_Status < Jindow
  def initialize(usrname, netid)
    super(0, 0, 70, 110)
    setup_properties(usrname, netid)
    setup_buttons
  end

  def setup_properties(usrname, netid)
    self.name = usrname
    @usrname = usrname
    @netid = netid
    @netPlayer = Network::Main.players[@netid]
    @head = @drag = @close = @mark = true
    self.refresh("P_Status")
    self.x = Mouse.x
    self.y = Mouse.y
  end

  def setup_buttons
    @buttons = {
      :party_invite => J::Button.new(self).refresh(50, "파티 초대"),
      :guild_invite => J::Button.new(self).refresh(50, "문파 초대"),
      :trade_request => J::Button.new(self).refresh(50, "교환 신청"),
      :user_info => J::Button.new(self).refresh(50, "유저 정보")
    }

    @buttons.each_with_index do |(key, button), index|
      button.x = 10
      button.y = 10 + (index * 25)
    end
  end

  def update
    super
    handle_party_invite if @buttons[:party_invite].click
    handle_guild_invite if @buttons[:guild_invite].click
    handle_trade_request if @buttons[:trade_request].click
    handle_user_info if @buttons[:user_info].click
  end

  def handle_party_invite
		$net_party_manager.invite_party(@usrname)
		Hwnd.dispose(self)
  end
  
  def handle_guild_invite
    if %w[문파장 부문파장].include?($guild_group)
      Network::Main.socket.send(
        "<Guild_Invite>#{@usrname},#{$guild},#{$guild_master}</Guild_Invite>\\n"
      )
      $console.write_line("[문파]: '#{@usrname}'님에게 문파 초대를 하셨습니다.")
    else
      $console.write_line("문파장 혹은 부문파장만 쓸 수 있는 기능입니다.")
    end
    Hwnd.dispose(self)
  end

  def handle_trade_request
		$trade_manager.trade_invite(@usrname)
    Hwnd.dispose(self)
  end

  def handle_user_info
    Jindow_NetPlayer_Info.new(@netPlayer.netid, @netPlayer.name)
    Hwnd.dispose(self)
  end
end
