#==============================================================================
# * NetPartyInv
#------------------------------------------------------------------------------
# - 파티에 다른 유저를 초대합니다.
#==============================================================================
class Jindow_NetPartyInv < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 140, 50)
		self.name = "파티 초대"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh("NetPartyInv")
		self.x = 120
		self.y = 75
		
		@type = J::Type.new(self).refresh(10, 10, 120, 13)
		
		@a = J::Button.new(self).refresh(50, "초대")
		@a.x = 10
		@a.y = 30
		
		@b = J::Button.new(self).refresh(50, "취소")
		@b.x = 80
		@b.y = 30
	end
	
	def update
		super
		
		if @a.click
			$game_system.se_play($data_system.decision_se)
			inv_name = @type.result
			$net_party_manager.invite_party(inv_name)
		end
		
		if @b.click
			Hwnd.dispose("NetPartyInv")
		end
	end
end
