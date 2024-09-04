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
	
	ADMIN_COMMANDS = {
		"운영자권한" => :give_admin_player, # 운영자권한 주기
		"운영자해제" => :remove_admin_player, # 운영자권한 해제
	}
	
	VICE_ADMIN_COMMANDS = 
	{
		"소환" => :summon_player,
		"출두" => :move_to_player,
		"이동" => :move_to_map,
		"강퇴" => :kick_player,
		"돈" => :grant_gold,
		"회복" => :recover_player,
		"집합" => :summon_all_players,
		"공지" => :send_announcement,
		"감옥" => :imprison_player,
		"석방" => :release_player,
		"이벤트고래" => :spawn_event_monster, # '이벤트고래'
		"몬스터소환" => :spawn_monster, # '몬스터소환'
		"경험치이벤트" => :exp_event_command,
		"드랍이벤트" => :drop_event_command,
		"길막생성" => :create_roadblock_command,
		"잠행" => :stealth_command,
		"테스트" => :process_test_command,
	}
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 500, 20)
		
		setup_chat_window
		setup_initial_state
		setup_buttons
	end
	
	def setup_chat_window
		self.refresh "Chat_Input"
		self.y = 460
		self.opacity = 255
	end
	
	def setup_initial_state
		@active = false
		@chat_type_idx = 0
		@sec = 0
		@ox = 0
		@oy = 0
		@actor = $game_party.actors[0]
		@player_name = @actor.name
		@map_infos = load_data("Data/MapInfos.rxdata")
		@chat_list = []
		@chat_idx = -1
		@chat_type = 
		[
			"전체",
			"귓속말",
			"파티",
			"길드",
		]
	end
	
	def setup_buttons
		@type = J::Type.new(self).refresh(64, 2, self.width - 70, 16)
		@type.set "(대화하려면 Enter 키를 누르세요)"
		@type.view
		
		@a = J::Button.new(self).refresh(40, current_chat_type)
		@a.x = 2
		@b = J::Button.new(self).refresh(20, "▶")
		@b.x = 42
	end
	
	def current_chat_type
		@chat_type[@chat_type_idx]
	end
	
	def is_command(text)
		return !!(text =~ /^\//)
	end
	
	def send_chat
		text = @type.result
		return process_command(text) if is_command(text) # 명령어 수행
		
		# 명령어가 아닌 그냥 일반 채팅일때
		return $console.write_line("말을 할 수 없습니다.") if $game_switches[8] # 채팅 금지 
		
		case current_chat_type
		when "귓속말" then process_whisper(text)
		when "전체" then process_global(text)
		when "파티" then process_party(text)
		when "길드" then process_guild(text)
		end
	end
	
	def process_command(text)
		# 명령어를 식별
		
		case text		
		when /^\/도움말/ then show_help
		when /^\/귓\s?(.*)/ then change_whisper_target($1)
		when /^\/교환\s?(.*)/ then process_trade($1)
		when /^\/세계후\s?(.*)/ then process_world_chat($1)
		when /^\/운영자모드\s+(.*)/ then process_admin_mode($1)
		when /^\/(\w+)\s?(.*)/
			command = $1
			params = $2.split(/\s+/)  # 공백으로 인자를 분리하여 배열로 만듦
			process_admin_command(command, *params)
			
		else show_default_help
		end
	end
	
	def show_help
		$chat.write("/귓 (귓속말 상대), /교환 (교환 상대)", COLOR_HELP)
		$chat.write("단축키 설명은 f1키를 누르세요!", COLOR_HELP)
	end
	
	def show_default_help
		$chat.write("알 수 없는 명령어입니다. '/도움말'을 입력하여 사용 가능한 명령어를 확인하세요.", COLOR_HELP)
	end
	
	def change_whisper_target(target)
		@whispers = target
		$console.write_line("(귓속말 상대 변경): #{target}")
	end
	
	def process_trade(target)
		$trade_manager.trade_invite(target)
	end
	
	def process_world_chat(message)
		return $chat.write ("세계후두루마리 아이템을 소지하셔야 합니다.", COLOR_BIGSAY) if $game_party.item_number(91) <= 0
		
		send_msg = "#{$game_party.actors[0].name},#{message}"
		Network::Main.send_with_tag("bigsay", send_msg)
		$game_party.lose_item(91, 1)
		$console.write_line("세계후두루마리 남은 보유량: #{$game_party.item_number(91)}", COLOR_BIGSAY)  
	end
	
	def process_admin_command(command, *params)
		if Network::Main.group == 'admin'
			return send(VICE_ADMIN_COMMANDS[command], params) if VICE_ADMIN_COMMANDS.key?(command)
			return send(ADMIN_COMMANDS[command], params) if ADMIN_COMMANDS.key?(command)
		end
		
		if Network::Main.group == 'vice_admin'
			return send(VICE_ADMIN_COMMANDS[command], params) if VICE_ADMIN_COMMANDS.key?(command)
		end
		
		show_default_help
	end
	
	def summon_player(params)
		target = params[0]
		return $console.write_line("닉네임 입력") unless target
		
		mapid = $game_map.map_id
		x = $game_player.x
		y = $game_player.y
		msg = "#{target},#{mapid},#{x},#{y}"
		Network::Main.send_with_tag("summon", msg)
	end
	
	def move_to_player(params)
		target = params[0]
		return $console.write_line("닉네임 입력") unless target
		
		player = Network::Main.players.values.find { |p| p.name == target }
		return unless player
		
		if player.map_id == $game_map.map_id
			$game_player.moveto(player.x, player.y)
		else
			$game_temp.player_transferring = true
			$game_temp.player_new_map_id = player.map_id
			$game_temp.player_new_x = player.x
			$game_temp.player_new_y = player.y
		end
	end
	
	def move_to_map(params)
		x, y, map_id = params[0], params[1], params[2]
		return $console.write_line("x y (map_id)입력") unless x && y
		
		x = x.to_i
		y = y.to_i
		new_map_id = map_id.to_i
		
		return $game_player.moveto(x, y) if map_id.nil?
		return $game_player.moveto(x, y) if new_map_id == $game_map.map_id
		
		$game_temp.player_transferring = true
		$game_temp.player_new_map_id = new_map_id
		$game_temp.player_new_x = x
		$game_temp.player_new_y = y
	end

	
	def kick_player(params)
		target, reason = params
		return $console.write_line("닉네임 이유 입력") unless target && reason
		
		msg = "#{target},#{reason}"
		Network::Main.send_with_tag("ki", msg)
		Network::Main.send_with_tag("chat", "[강퇴]: #{target}, 이유 : #{reason}")
	end
	
	def grant_gold(params)
		amount = params[0]
		$game_party.gain_gold(amount.to_i)
	end
	
	def recover_player(params)
		actor = $game_party.actors[0]
		actor.hp = actor.maxhp
		actor.sp = actor.maxsp
		$game_player.animation_id = 151
	end
	
	def summon_all_players(params)
		mapid = $game_map.map_id
		x = $game_player.x
		y = $game_player.y
		Network::Main.socket.send "<all_summon>#{mapid},#{x},#{y}</all_summon>\n"
	end
	
	def send_announcement(params)
		message = params[0]
		Network::Main.socket.send "<chat>(공지): #{message}</chat>\n"
	end
	
	def imprison_player(params)
		target = params[0]
		return $console.write_line("닉네임 입력") unless target 
		
		Network::Main.socket.send "<prison>#{target}</prison>\n"
	end
	
	def release_player(params)
		target = params[0]
		return $console.write_line("닉네임 입력") unless target 
		
		Network::Main.socket.send "<emancipation>#{target}</emancipation>\n"
	end
	
	def spawn_event_monster(params)
		n = params[0]
		n = (n.nil? || n.empty?) ? 10 : n.to_i
		return $console.write_line("오류 발생 (id 없음)") unless create_abs_monsters_admin(49, n, true)
		
		$console.write_line("고래를 #{n}마리 소환합니다.")
		mapname = ""
		if $game_map.map_id != nil
			mapname = @map_infos[$game_map.map_id].name.to_s if @map_infos[$game_map.map_id] != nil
		end
		Network::Main.socket.send "<chat>(이벤트)고래가 #{mapname}에 출몰하였습니다!!</chat>\n"
	end
	
	def spawn_monster(params)
		id, n = params
		return $console.write_line("id (개수) 입력") unless id
		
		id = id.to_i
		n = (n == nil || n == "") ? 1 : n.to_i
		return $console.write_line("해당되는 몬스터 없음") unless $data_enemies[id]
		
		create_abs_monsters_admin(id, n)
		name = $data_enemies[id].name
		$console.write_line("#{name}를 #{n}마리 소환합니다.") 
		
		mapname = ""
		if $game_map.map_id != nil
			mapname = @map_infos[$game_map.map_id].name.to_s if @map_infos[$game_map.map_id] != nil
		end
		Network::Main.socket.send "<chat>#{name}(이)가 #{mapname}에 출몰하였습니다!!</chat>\n"
	end
	
	def process_test_command(params)
		$game_temp.player_transferring = true # 이동 가능
		$game_temp.player_new_map_id = 306
		$game_temp.player_new_x = 21
		$game_temp.player_new_y = 22
	end
	
	def process_admin_mode(code)
		Network::Main.set_admin if code.to_s == "8624"
	end
		
	def give_admin_player(params) # 운영자권한 주기
		target = params[0]
		
		Network::Main.send_with_tag("give_admin", target)
	end
	
	def remove_admin_player(params) # 운영자권한 해제
		target = params[0]
		
		Network::Main.send_with_tag("remove_admin", target)
	end
	
	def exp_event_command(params)
		num = params[0]
		
		Network::Main.send_with_tag("exp_event_change", num)
	end
	
	def drop_event_command(params)
		num = params[0]
		
		Network::Main.send_with_tag("drop_event_change", num)
	end
	
	def create_roadblock_command(params)
		create_npc(34)
	end
	
	def stealth_command(params)
		state = params[0]
		
		unless state
			@actor.rpg_skill.buff_active(97) 
		else
			@actor.rpg_skill.buff_del(97)
		end
	end
	
	# ----------------아래는 일반 채팅--------------------------#
	
	def process_whisper(text)
		return $console.write_line("귓속말 할 상대가 없습니다.") if @whispers.nil?
		return $console.write_line("자기 자신에게는 귓속말을 할 수 없습니다.") if @whispers == @player_name
		
		$chat.write("(귓속말) #{@whispers} <<< #{text}", COLOR_WHISPER)
		Network::Main.socket.send "<whispers>#{@whispers},#{text}</whispers>\n"
	end
	
	def process_global(text)
		
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
		
		$chat_b.input("#{text}", 2, 4)
		Network::Main.send_with_tag("party_message", message)
		Network::Main.send_with_tag("map_chat", "#{@player_name}&#{text}&#{2}")
	end
	
	def process_guild(text)
		if $guild.nil?
			$console.write_line("가입된 길드가 없습니다.")
			return
		end
		
		name2 = $game_party.actors[0].class_name
		$chat_b.input("#{text}", 2, 4)
		Network::Main.socket.send "<guild_Message>#{@player_name},#{name2},#{text}</guild_Message>\n"
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
		@chat_idx = @chat_list.size
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