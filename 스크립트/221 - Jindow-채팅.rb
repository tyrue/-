#----------------------------------------------------------------------------------
# *진도우 채팅창
#----------------------------------------------------------------------------------
COLOR_HELP = Color.new(120, 187, 255)
COLOR_NORMAL = Color.new(255, 255, 255)
COLOR_WORLD = Color.new(255, 255, 102)
COLOR_EVENT = Color.new(255, 120, 0)
COLOR_BIGSAY = Color.new(65, 105, 255)
COLOR_WHISPER = Color.new(136, 255, 50)
COLOR_PARTY = Color.new(255, 151, 255)

class Jindow_Chat_Input < Jindow
	attr_reader :active
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 500, 20)
		self.refresh "Chat_Input"
		self.y = 460
		self.opacity = 255
		@active = false
		@chat_type = 
		[
			"전체",
			"귓속말",
			"파티",
			"길드",
		]
		@chat_type_idx = 0
		
		@type = J::Type.new(self).refresh(64, 2, self.width - 70, 16)
		@type.set "(대화하려면 Enter 키를 누르세요)"
		@type.view
		
		@a = J::Button.new(self).refresh(40, @chat_type[@chat_type_idx])
		@a.x = 2
		@b = J::Button.new(self).refresh(20, "▶")
		@b.x = 42
		
		@sec = 0
		@ox = 0
		@oy = 0
		
		@player_name = $game_party.actors[0].name
		
		#맵이름의 표시
		@map_infos = load_data("Data/MapInfos.rxdata")
		@chat_list = []
		@chat_idx = -1
		
	end
	
	def is_command(text)
		return !!(text =~ /^\//)
	end
	
	def send_chat
		text = @type.result
		return process_command(text) if is_command(text) # 명령어 수행
		
		# 명령어가 아닌 그냥 일반 채팅일때
		case @chat_type[@chat_type_idx]
		when "귓속말" then process_whisper(text)
		when "전체" then process_global(text)
		when "파티" then process_party(text)
		when "길드" then process_guild(text)
		end
	end
	
	def process_command(text)
		# 명령어를 식별
		case text		
		when /\/도움말/
			$chat.write ("/귓 (귓속말 상대), /교환 (교환 상대)", COLOR_HELP)    
			$chat.write ("단축키 설명은 f1키를 누르세요!", COLOR_HELP) 
			
		when /\/귓 (.*)/  # 귓속말 상대를 변경
			# 여기서 상대가 있는지 확인하는 로직 필요
			@whispers = $1.to_s
			$console.write_line("(귓속말 상대 변경):#{$1.to_s}")
			
		when /\/교환 (.*)/ #교환
			$trade_manager.trade_invite($1.to_s)
			
		when /\/세계후 (.*)/
			return $chat.write ("세계후두루마리 아이템을 소지하셔야 합니다.", COLOR_BIGSAY) if $game_party.item_number(91) <= 0
			
			간단메세지("[세계후] #{@player_name} : #{$1.to_s}")
			$chat.write("[세계후] #{@player_name} : #{$1.to_s}", COLOR_BIGSAY)
			Network::Main.socket.send("<bigsay>#{$game_party.actors[0].name},#{$1.to_s}</bigsay>\n")
			$game_party.lose_item(91, 1)
			$chat.write ("세계후두루마리 남은 보유량: #{$game_party.item_number(91)}", COLOR_BIGSAY)  
			
			# 운영자 전용 명령어 
		when /\/소환 (.*)/ #소환 명령어
			return if Network::Main.group != 'admin'
			mapid = $game_map.map_id
			x = $game_player.x
			y = $game_player.y
			Network::Main.socket.send "<summon>#{$1.to_s},#{mapid},#{x},#{y}</summon>\n"
			
		when /\/출두 (.*)/ #출두 명령어
			return if Network::Main.group != 'admin'
			for player in Network::Main.players.values
				next if player.name != $1.to_s 
				if player.map_id == $game_map.map_id
					$game_player.moveto(player.x, player.y)
				else
					$game_temp.player_transferring = true # 이동 가능
					$game_temp.player_new_map_id = player.map_id
					$game_temp.player_new_x = player.x
					$game_temp.player_new_y = player.y
				end
				break
			end	
			
		when /\/강퇴 (.*) (.*)/ #강퇴
			return if Network::Main.group != 'admin'
			Network::Main.socket.send "<ki>#{$1.to_s},#{$2.to_s},#{$game_party.actors[0].name}</ki>\n"
			
		when /\/골드 (.*)/ #골드 명령어
			return if Network::Main.group != 'admin'
			$game_party.gain_gold($1.to_i)
			
		when /\/회복/ #회복 명령어
			return if Network::Main.group != 'admin'
			$game_party.actors[0].hp += $game_party.actors[0].maxhp
			$game_party.actors[0].sp += $game_party.actors[0].maxsp
			$game_player.animation_id = 151
			
		when /\/집합/ #서버 안에 있는 유저들 전부 소환 명령어
			return if Network::Main.group != 'admin'
			mapid = $game_map.map_id
			x = $game_player.x
			y = $game_player.y
			Network::Main.socket.send "<all_summon>#{mapid},#{x},#{y}</all_summon>\n"
			
		when /\/공지 (.*)/
			return if Network::Main.group != 'admin'
			Network::Main.socket.send "<chat>(공지): #{$1.to_s}</chat>\n"
			
		when /\/감옥 (.*)/ # 감옥으로 보내는 명령어
			return if Network::Main.group != 'admin'
			Network::Main.socket.send "<prison>#{$1.to_s}</prison>\n"
			
		when /\/석방 (.*)/ # 감옥에 있는 유저 석방 명령어
			return if Network::Main.group != 'admin'
			Network::Main.socket.send "<emancipation>#{$1.to_s}</emancipation>\n"
			
		when /\/캐시 (.*) (.*)/ 
			return if Network::Main.group != 'admin'
			Network::Main.socket.send "<cashgive>#{$1.to_s},#{$2.to_s}</cashgive>\n"
			$console.write_line("#{$2.to_s}마일리지를 유저에게 지급하였습니다.")
			
		when /^\/이벤트\s?고래\s?(\d*)$/ 
			return if Network::Main.group != 'admin'
			
			n = ($1 == nil or $1 == "") ? 10 : $1.to_i
			return $console.write_line("오류 발생 (id 없음)") unless create_abs_monsters_admin(49, n)
			
			$console.write_line("고래를 #{n}마리 소환합니다.")
			mapname = ""
			if $game_map.map_id != nil
				mapname = @map_infos[$game_map.map_id].name.to_s if @map_infos[$game_map.map_id] != nil
			end
			Network::Main.socket.send "<chat>(이벤트)고래가 #{mapname}에 출몰하였습니다!!</chat>\n"
			
		when /^\/몬스터\s?소환\s?(\d*)\s?(\d*)$/ 
			return if Network::Main.group != 'admin'	
			return if ($1 == nil or $1 == "")
			
			id = $1.to_i
			n = ($2 == nil or $2 == "") ? 1 : $2.to_i
			return if $data_enemies[id] == nil
			
			name = $data_enemies[id].name
			mapname = ""
			if $game_map.map_id != nil
				mapname = @map_infos[$game_map.map_id].name.to_s if @map_infos[$game_map.map_id] != nil
			end
			
			return $console.write_line("오류 발생 (id 없음)") unless create_abs_monsters_admin(id, n)
			$console.write_line("#{name}를 #{n}마리 소환합니다.") 
			Network::Main.socket.send "<chat>#{name}(이)가 #{mapname}에 출몰하였습니다!!</chat>\n"
			
		when /\/테스트/
			return if Network::Main.group != 'admin'	
			
			$game_temp.player_transferring = true # 이동 가능
			$game_temp.player_new_map_id = 306
			$game_temp.player_new_x = 21
			$game_temp.player_new_y = 36
			
		when /^\/운영자모드 (.*)/
			Network::Main.set_admin if $1.to_i == 1367
			
		when /^\/(.*?)/	
			$chat.write ("/귓 (귓속말 상대), /교환 (교환 상대)", COLOR_HELP)    
		end
	end
	
	def process_whisper(text)
		return $console.write_line("귓속말 할 상대가 없습니다.") if @whispers.nil?
		return $console.write_line("자기 자신에게는 귓속말을 할 수 없습니다.") if @whispers == @player_name
		
		$chat.write("(귓속말) #{@whispers} <<< #{text}", COLOR_WHISPER)
		Network::Main.socket.send "<whispers>#{@whispers},#{text}</whispers>\n"
	end
	
	def process_global(text)
		$chat.write("(전체) #{@player_name} : #{text}", COLOR_NORMAL)
		$chat_b.input("#{text}", 1, 4)
		Network::Main.socket.send "<chat1>(전체) #{@player_name} : #{text}</chat1>\n"
		Network::Main.socket.send "<map_chat>#{@player_name}&#{text}&#{1}</map_chat>\n"
	end
	
	def process_party(text)
		if $net_party_manager.party_empty?
			return $console.write_line("가입된 파티가 없습니다.")
		end
		
		data = {
			"class" => $game_party.actors[0].class_name,
			"text" => text
		}
		message = data.map { |key, value| "#{key}:#{value}" }.join("|")
		Network::Main.send_with_tag("party_message", message)
		Network::Main.send_with_tag("map_chat", "#{@player_name}&#{text}&#{2}")
		$chat.write("(파티) #{@player_name} : #{text}", COLOR_PARTY)
		$chat_b.input("#{text}", 2, 4)
	end
	
	def process_guild(text)
		if $guild.nil?
			$console.write_line("가입된 길드가 없습니다.")
			return
		end
		
		name2 = $game_party.actors[0].class_name
		$chat.write("(길드) #{@player_name} : #{text}", COLOR_GUILD)
		$chat_b.input("#{text}", 2, 4)
		Network::Main.socket.send "<Guild_Message>#{@player_name},#{name2},#{text}</Guild_Message>\n"
		Network::Main.socket.send "<map_chat>#{@player_name}&#{text}&#{2}</map_chat>\n"
	end
	
	# update 시작
	def update
		super
		
		update_map_scroll if @sec > 0
		update_chat_mode_change if chat_mode_change_requested?
		process_chat_message_sending if chat_message_sending_requested?
		process_chat_cancellation if chat_cancellation_requested?
		process_chat_history_browsing if chat_history_browsing_requested?
	end
	
	def update_map_scroll
		@sec -= 1
		update_map_scroll_x 
		update_map_scroll_y 
		$m_s.visible = false if @sec == 0
	end
	
	def update_map_scroll_x
		if $game_player.x <= 10
			$m_s.x = $game_player.x * 32
		elsif $game_map.width - $game_player.x <= 10
			$m_s.x = ($game_player.x - 2) * 32
		end
		@ox = $game_player.x
	end
	
	def update_map_scroll_y
		if $game_player.y <= 10 || $game_map.height - $game_player.y <= 10
			$m_s.y = ($game_player.y - $game_map.display_y / 128) * 32 - 55
			@oy = $game_player.y
		end
	end
	
	def chat_mode_change_requested?
		return (@b.click || Key.trigger?(KEY_TAB)) && Hwnd.highlight? == self
	end
	
	def update_chat_mode_change
		@chat_type_idx = (@chat_type_idx + 1) % @chat_type.size
		@a.refresh(40, @chat_type[@chat_type_idx])
		chat_on
	end
	
	def chat_message_sending_requested?
		return Key.trigger?(KEY_ENTER) && (Hwnd.highlight? == self || !($inputKeySwitch || Hwnd.highlight?.to_s.include?("Jindow_N")))
	end
	
	def process_chat_message_sending
		if Hwnd.highlight? != self
			Hwnd.highlight = self
			return 
		end
		
		if !@active
			chat_on
		else
			if @type.result != ""
				send_chat 
				@chat_list.delete(@type.result)
				@chat_list.push(@type.result)
				@chat_idx = @chat_list.size
			end	
			chat_off	
		end
	end
	
	def chat_cancellation_requested?
		return Key.trigger?(KEY_ESC)
	end
	
	def process_chat_cancellation
		chat_off
		Hwnd.dis_highlight(self)
	end
	
	def chat_history_browsing_requested?
		return Key.trigger?(KEY_UP) || Key.trigger?(KEY_DOWN)
	end
	
	def process_chat_history_browsing
		return if @chat_list.nil? || @chat_list.empty?
		
		if Key.trigger?(KEY_UP)
			@chat_idx -= 1
			@chat_idx = [[0, @chat_idx].max, @chat_list.size - 1].min
			@type.set(@chat_list[@chat_idx])
		elsif Key.trigger?(KEY_DOWN)
			@chat_idx += 1
			@chat_idx = [[0, @chat_idx].max, @chat_list.size - 1].min
			@type.set(@chat_list[@chat_idx])
		end
	end
	
	def chat_on
		@type.set("")
		@type.view
		@type.bluck = true
		@active = true
		self.show
	end
	
	def chat_off
		@type.set("(대화하려면 Enter 키를 누르세요)")
		@type.view
		@type.bluck = false
		@active = false
		self.hide if $chat.mode == 2
	end
	
end


class Game_Event < Game_Character
	alias jindow_chat_over_trigger over_trigger?
	
	def over_trigger?
		return true if $map_chat_input.active # 채팅이 활성화 되면 결정키로 시작 못함
		jindow_chat_over_trigger
	end
end