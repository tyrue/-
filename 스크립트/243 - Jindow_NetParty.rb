#==============================================================================
# * PartyManager
#------------------------------------------------------------------------------
#  - 파티 관리 클래스
#==============================================================================

class PartyManager
	attr_accessor :party_members
	attr_accessor :leader
	attr_accessor :max_size
	attr_accessor :inv_name
	
	def initialize
		@party_members = []
		@leader = nil
		@max_size = 5
	end
	
	def is_party_member?(member)
		return @party_members.include?(member)
	end
	
	def party_empty?
		return @party_members.empty?
	end
	
	def create_party()
		Network::Main.send_with_tag("party_create")
	end
	
	def add_member(member)
		@party_members << member 
		Jindow_NetParty.new() if !Hwnd.include?("NetParty")
	end
	
	def remove_member(member)
		@party_members.delete(member)
		Jindow_NetParty.new() if !Hwnd.include?("NetParty")
	end
	
	# 파티를 끝낸다
	def end_party()
		Network::Main.send_with_tag("party_end")
		@party_members.clear()
		@leader = nil
	end
		
	def invite_party(target_name)
		data = {
			"target" => target_name
		}
		
		message = data.map { |key, value| "#{key}:#{value}" }.join("|")
		Network::Main.send_with_tag("party_invite", message)
	end
	
	def decide_party(inv_name)
		@inv_name = inv_name
		
		accept_script = <<-SCRIPT
		$net_party_manager.accept_party();
		Hwnd.dispose(self)
		SCRIPT
		
		decline_script = <<-SCRIPT
		$net_party_manager.refuse_party(); 
		Hwnd.dispose(self)
		SCRIPT
		
		Jindow_Dialog.new(
			"파티 초대",
			["파티 요청 : #{inv_name}"], 
			[
				["예", accept_script], 
				["아니오", decline_script]
			]
		)
	end
	
	# 파티에 초대 수락
	def accept_party()
		Network::Main.send_with_tag("party_accept")
	end
	
	# 파티 거절	
	def refuse_party()
		Network::Main.send_with_tag("party_refuse")
	end
	
	# 파티원 이동
	# 파티 퀘스트 장소로 이동 (이동할 map_id, x, y)
	def move_party(target_id, x, y)
		data = {
			"target_id" => target_id,
			"x" => x,
			"y" => y
		}
		
		message = data.map { |key, value| "#{key}:#{value}" }.join("|")
		Network::Main.send_with_tag("party_move", message)
	end
end

#==============================================================================
# * JindowNetParty
#------------------------------------------------------------------------------
#  - 넷 파티 GUI 클래스
#==============================================================================

class Jindow_NetParty < Jindow
	def initialize()
		super(0, 0, 120, 175)
		self.name = "파티원 목록"
		configure_window
		@party_manager = $net_party_manager
		@party_list = Marshal.load(Marshal.dump(@party_manager.party_members))
		
		create_buttons
		set_button_positions
		refresh_window
	end
	
	def configure_window
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.x = 75
		self.y = 75
	end
	
	def create_buttons
		@buttons = []
		@party_manager.party_members.each_with_index do |member, i|
			button = J::Button.new(self).refresh(120, member.to_s)
			button.y = i * 30 + 12
			@buttons << button
		end
		
		@create_button = J::Button.new(self).refresh(50, "생성") unless @create_button
		@invite_button = J::Button.new(self).refresh(50, "초대") unless @invite_button
		@leave_button = J::Button.new(self).refresh(50, "탈퇴") unless @leave_button 
	end
	
	def set_button_positions
		@create_button.x = self.width - 120
		@create_button.y = @buttons.last ? @buttons.last.y : 0
		@create_button.y = [120, @create_button.y].max
		
		@invite_button.x = self.width - 50
		@invite_button.y = @create_button.y
		
		@leave_button.x = @invite_button.x
		@leave_button.y = @invite_button.y + @invite_button.height
		
		self.height = @leave_button.y + @leave_button.height + 10
	end
	
	def refresh_window
		self.refresh("NetParty")
	end
	
	def update
		super
		handle_create_button if @create_button.click
		handle_invite_button if @invite_button.click
		handle_leave_button if @leave_button.click
		update_member_list
	end
	
	def handle_create_button
		$game_system.se_play($data_system.decision_se)
		@party_manager.create_party()
	end
	
	def handle_invite_button
		Jindow_NetPartyInv.new
	end
	
	def handle_leave_button
		$game_system.se_play($data_system.decision_se)
		@party_manager.end_party()
	end
	
	def update_member_list	
		return if @party_list == @party_manager.party_members
		
		@buttons.each do |b|
			b.dispose
		end
		
		create_buttons
		set_button_positions
		refresh_window
		@party_list = Marshal.load(Marshal.dump(@party_manager.party_members))
	end
end
