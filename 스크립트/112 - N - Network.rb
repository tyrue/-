#===============================================================================
# ** Network - Manages network data.
#-------------------------------------------------------------------------------
# Author    Me™ and Mr.Mo
# Version   1.0
# Date      11-04-06
#===============================================================================
SDK.log("Network", "Mr.Mo and Me™", "1.0", " 11-04-06")

p "TCPSocket script not found (class Network)" if not SDK.state('TCPSocket')
#-------------------------------------------------------------------------------
# Begin SDK Enabled Check
#-------------------------------------------------------------------------------
$is_map_first = false
if SDK.state('TCPSocket') == true and SDK.state('Network') #네트워크가 가능할 때 
	
	module Network
		
		class Main
			
			#--------------------------------------------------------------------------
			# * Attributes
			#-------------------------------------------------------------------------- 
			attr_accessor :socket
			attr_accessor :pm
			attr_accessor :group
			attr_accessor :players
			#--------------------------------------------------------------------------
			# * Initialiation
			#-------------------------------------------------------------------------- 
			def self.initialize
				@players    = {}
				@mapplayers = {}
				@netactors  = {}
				@pm = {}
				@pm_lines = []
				@user_test  = false
				@user_exist = false
				@socket     = nil
				@nooprec    = 0
				@id         = -1
				@name       = ""
				@group      = ""
				@status     = ""
				@oldx       = -1
				@oldy       = -1
				@oldd       = -1
				@oldp       = -1
				@oldid      = -1
				@value      = 0
				@login      = false
				@pchat_conf = false
				@send_conf  = false
				@trade_conf = false
				@servername = ""
				@pm_getting = false
				@self_key1 = nil
				@self_key2 = nil
				@self_key3 = nil
				@self_value = nil
				@trade_compelete = false
				@trading = false
				@trade_id = -1
				@ani_id = -1
				@ani_map = -1
				@ani_number = 0
				@ani_event = -1
			end
			#--------------------------------------------------------------------------
			# * Returns Servername
			#-------------------------------------------------------------------------- 
			def self.servername
				return @servername.to_s
			end
			#--------------------------------------------------------------------------
			# * Returns Socket
			#-------------------------------------------------------------------------- 
			def self.socket
				return @socket
			end
			#--------------------------------------------------------------------------
			# * Returns UserID
			#-------------------------------------------------------------------------- 
			def self.id
				return @id
			end
			#--------------------------------------------------------------------------
			# * Returns UserName
			#-------------------------------------------------------------------------- 
			def self.name
				return @name
			end  
			#--------------------------------------------------------------------------
			# * Returns current Status
			#-------------------------------------------------------------------------- 
			def self.status
				return "" if @status == nil or @status == []
				return @status
			end
			#--------------------------------------------------------------------------
			# * Returns Group
			#-------------------------------------------------------------------------- 
			def self.group
				if @group.downcase.include?("_adm")
					group = "vice_admin"
				elsif @group.downcase.include?("adm")
					group = "admin"
				elsif @group.downcase.include?("mod")
					group = "mod"
				else
					group = "standard"
				end
				return group
			end
			
			def self.set_admin(sw = false)
				if @group == "admin"
					$console.write_line("운영자모드 off")
					@group = "standard"
					$game_switches[54] = false
				else
					$console.write_line("운영자모드 on")
					@group = "admin"
					$game_switches[54] = true
				end
			end
			
			def self.set_vice_admin(sw = false)
				if sw
					$console.write_line("부운영자모드 on")
					@group = "vice_admin"
					$game_switches[55] = true
				else
					$console.write_line("부운영자모드 off")
					@group = "standard"
					$game_switches[55] = false
				end
			end
			
			def self.is_admin
				return @group == "vice_admin" || @group == "admin"
			end
			
			#--------------------------------------------------------------------------
			# * Returns Mapplayers
			#-------------------------------------------------------------------------- 
			def self.mapplayers
				return {} if @mapplayers == nil
				return @mapplayers
			end
			#--------------------------------------------------------------------------
			# * Returns NetActors
			#-------------------------------------------------------------------------- 
			def self.netactors
				return {} if @netactors == nil
				return @netactors
			end
			#--------------------------------------------------------------------------
			# * Returns Players
			#-------------------------------------------------------------------------- 
			def self.players
				return {} if @players == nil
				return @players
			end
			#--------------------------------------------------------------------------
			# * Destroys player
			#-------------------------------------------------------------------------- 
			def self.destroy(id)
				if @players[id.to_s] != nil
					#@socket.send("<chat>(알림): '#{@players[id.to_s].name}'님께서 게임을 종료하셨습니다.</chat>\n")
				end  
				@players[id.to_s] = nil rescue nil
				@mapplayers[id.to_s] = "" rescue nil
				for player in @mapplayers
					@mapplayers.delete(id.to_s) if player[0].to_i == id.to_i
				end
				for player in @players
					@players.delete(id.to_s) if player[0].to_i == id.to_i
				end
				if $scene.is_a?(Scene_Map)
					begin
						$scene.spriteset[id].dispose unless $scene.spriteset[id].disposed?
					rescue
						nil
					end
				end
			end
			#--------------------------------------------------------------------------
			# * Create A socket
			#-------------------------------------------------------------------------- 
			def self.start_connection(host, port)
				@socket = TCPSocket.new(host, port)
			end
			#--------------------------------------------------------------------------
			# * Asks for Id 아이디 요청
			#-------------------------------------------------------------------------- 
			def self.get_id
				@socket.send("<1>'req'</1>\n")
			end
			#--------------------------------------------------------------------------
			# * Asks for name 이름 요청
			#-------------------------------------------------------------------------- 
			def self.get_name
				@socket.send("<2>'req'</2>\n")
			end
			#--------------------------------------------------------------------------
			# * Asks for Group 그룹 요청
			#-------------------------------------------------------------------------- 
			def self.get_group
				#@socket.send("<3>'req'</3>\n")
				@socket.send("<check>#{self.name}</check>\n")
			end
			
			#--------------------------------------------------------------------------
			# * 회원가입 요청
			#-------------------------------------------------------------------------- 
			def self.send_regist(username, id, pass)
				@socket.send("<regist>#{username},#{id},#{pass}</regist>\n")
			end
			#--------------------------------------------------------------------------
			# * Send Gold
			#-------------------------------------------------------------------------- 
			def self.send_gold
				gold = $game_party.gold
			end
			
			#--------------------------------------------------------------------------
			# * Asks for Network Version Number 버전 요청
			#-------------------------------------------------------------------------- 
			def self.retrieve_version
				@socket.send("<versione>#{User_Edit::VERSION}</versione>\n")
			end
			#--------------------------------------------------------------------------
			# * Asks for Message of the day 날짜 요청
			#-------------------------------------------------------------------------- 
			def self.retrieve_mod
				@socket.send("<mod>'request'</mod>\n")
			end
			#--------------------------------------------------------------------------
			# * Asks for Message of the day 날짜 요청
			#-------------------------------------------------------------------------- 
			def self.send_with_tag(tag, msg = "")
				@socket.send("<#{tag}>#{msg}</#{tag}>\n")
			end
			
			#--------------------------------------------------------------------------
			# * Asks for Login (and confirmation)로그인 요청
			#-------------------------------------------------------------------------- 
			def self.send_login(user,pass)
				@socket.send("<login>#{user}|#{pass}</login>\n")
			end
			#--------------------------------------------------------------------------
			# * Send Errors
			#-------------------------------------------------------------------------- 
			def self.send_error(lines)
				if lines.is_a?(Array)
					for line in lines
						@socket.send("<err>#{line}</err>\n")
					end
				elsif lines.is_a?(String)
					@socket.send("<err>#{lines}</err>\n")
				end
			end  
			#--------------------------------------------------------------------------
			# * Authenfication 인증
			#-------------------------------------------------------------------------- 
			def self.amnet_auth
				@socket.send("<0>'e'</0>\n") # Send Authenfication
				@auth = false
				
				User_Edit::CONNFAILTRY.times do
					break if authenticate_or_timeout
				end
				
				$scene = Scene_Login.new if @auth
			end
			
			def self.authenticate_or_timeout
				2000.times do
					self.update
					return true if @auth # Break if authenticated
				end
				false
			end
			
			#--------------------------------------------------------------------------
			# * Return PMs
			#-------------------------------------------------------------------------
			def self.pm
				return @pm
			end
			#--------------------------------------------------------------------------
			# * Get PMs
			#-------------------------------------------------------------------------- 
			def self.get_pms
				@pm_getting = true
				@socket.send("<22a>'Get';</22a>\n")
			end
			#--------------------------------------------------------------------------
			# * Update PMs
			#-------------------------------------------------------------------------- 
			def self.update_pms(message)
				#Starts all the variables
				@pm = {}
				@current_Pm = nil
				@index = -1
				@message = false
				#Makes a loop to look thru the message
				for line in message
					#If the line is a new PM
					if line == "$NEWPM"
						@index+=1
						@pm[@index] = Game_PM.new(@index)
						@message = false
						#if the word has $to_from
					elsif line == "$to_from" and @message == false
						to_from = true
						#if the word has $subject
					elsif line == "$Subject" and @message == false
						subject = true
						#if the word has $message
					elsif line == "$Message" and @message == false
						@message = true
					elsif @message
						@pm[@index].message += line+"\n"
					elsif to_from
						@pm[@index].to_from = line
						to_from = false
					elsif subject
						@pm[@index].subject = line
						subject = false
					end
				end
				@pm_getting = false
			end
			#--------------------------------------------------------------------------
			# * Checks if the PM is still not get.
			#-------------------------------------------------------------------------- 
			def self.pm_getting
				return @pm_getting
			end
			#--------------------------------------------------------------------------
			# * Write PMs
			#-------------------------------------------------------------------------- 
			def self.write_pms(message)
				send = message
				@socket.send("<22d>#{send}</22d>\n")
			end
			#--------------------------------------------------------------------------
			# * Delete All PMs
			#-------------------------------------------------------------------------- 
			def self.delete_all_pms
				@socket.send("<22e>'delete'</22e>\n")
				@pm = {}
			end
			#--------------------------------------------------------------------------
			# * Delete pm(id)
			#-------------------------------------------------------------------------- 
			def self.delete_pm(id)
				@pm.delete(id)
			end
			#--------------------------------------------------------------------------
			# * Delete MapPlayers
			#-------------------------------------------------------------------------- 
			def self.mapplayers_delete
				@mapplayers = {}
			end
			
			#--------------------------------------------------------------------------
			# * 캐릭터 정보 수집 메서드
			#-------------------------------------------------------------------------- 
			def self.collect_character_info(actor)
				{
					"name" => "'#{actor.name}'",
					"class_name" => "'#{actor.class_name}'",
					"degree" => $job_degree,
					"hp" => actor.hp,
					"sp" => actor.sp,
					"maxhp" => actor.maxhp,
					"maxsp" => actor.maxsp,
					"str" => actor.str,
					"dex" => actor.dex,
					"agi" => actor.agi,
					"eva" => actor.eva,
					"pdef" => actor.base_pdef,
					"mdef" => actor.base_mdef,
					"level" => actor.level,
					"weapon_id" => actor.weapon_id,
					"armor1_id" => actor.armor1_id,
					"armor2_id" => actor.armor2_id,
					"armor3_id" => actor.armor3_id,
					"armor4_id" => actor.armor4_id,
				}
			end
			
			#--------------------------------------------------------------------------
			# * 공통 문자열 생성 메서드
			#-------------------------------------------------------------------------- 
			def self.build_send_message
				actor = $game_party.actors[0]
				# 캐릭터 정보 수집
				character_info = collect_character_info(actor)
				
				# 기본 문자열 파트 구성
				send_parts = []
				send_parts << "@username = '#{self.name}';"
				send_parts << "@character_name = '#{$game_player.character_name}';"
				send_parts << "@map_id = #{$game_map.map_id};"
				send_parts << "@x = #{$game_player.x}; @y = #{$game_player.y};"
				send_parts << "@direction = #{$game_player.direction};"
				send_parts << "@move_speed = #{$game_player.move_speed};"
				send_parts << "@guild = '#{$guild}';"
				send_parts << "@trans_v = #{$game_variables[10]};"
				
				# 캐릭터 상태 정보 추가
				character_info.each do |key, value|
					send_parts << "@#{key} = #{value};" if value != nil
				end
				
				# 투명 상태 처리
				send_parts << "@is_transparency = #{$state_trans ? 'true' : 'false'};"
				
				send_parts.join(" ")
			end
			
			#--------------------------------------------------------------------------
			# * Send Start
			#-------------------------------------------------------------------------- 
			def self.send_start
				message = build_send_message
				@socket.send("<5>#{message} start(#{self.id});</5>\n")
			end
			
			#--------------------------------------------------------------------------
			# * Send Start Request
			#-------------------------------------------------------------------------- 
			def self.send_start_request(id = 1)
				message = build_send_message
				@socket.send("<5>#{message}</5>\n")
			end
			
			#--------------------------------------------------------------------------
			# * Send Map Id data
			#-------------------------------------------------------------------------- 
			def self.send_map
				message = build_send_message
				@socket.send("<m5>#{message}</m5>\n")
			end
			
			def self.send_trans(sw)
				send = ""
				# Send 투명도 여부
				send += "@is_transparency = #{sw};"
				
				@socket.send("<5>#{send}</5>\n")
			end
			
			#--------------------------------------------------------------------------
			# * Send Move Update
			#-------------------------------------------------------------------------- 
			def self.send_move_change
				return if @oldx == $game_player.x && @oldy == $game_player.y && @oldd == $game_player.direction
				return if @mapplayers == {}
				
				send = ""
				send += "@x = #{$game_player.x};"
				send += "@y = #{$game_player.y};"
				send += "@tile_id = #{$game_player.tile_id};"
				send += "@direction = #{$game_player.direction};"  
				
				@oldx = $game_player.x
				@oldy = $game_player.y
				@oldd = $game_player.direction
				
				@socket.send("<m5>#{send}</m5>\n") if send != ""
			end
			
			#--------------------------------------------------------------------------
			# *게임을 종료 할경우
			#-------------------------------------------------------------------------- 
			def self.close_socket
				return if @socket == nil
				자동저장
				@socket.send("<9>#{self.id}</9>\n")
				@socket.close
				@socket = nil
			end
			#--------------------------------------------------------------------------
			# * Change Messgae of the Day
			#-------------------------------------------------------------------------- 
			def self.change_mod(newmsg)
				@socket.send("<11>#{newmsg}</11>\n")
			end
			
			#--------------------------------------------------------------------------
			# * Check if the user exists on the network..
			#--------------------------------------------------------------------------
			def self.user_exist?(username)
				# Enable the test
				@user_test  = true
				@user_exist = false
				# Send the data for the test
				self.send_login(username.to_s,"*test*")
				# Check for how to long to wait for data (Dependent on username size)
				if username.size <= 8
					# Wait 1.5 seconds if username is less then 8
					for frame in 0..(1.5*40)
						self.update
					end
				elsif username.size > 8 and username.size <= 15
					# Wait 2.3 seconds if username is less then 15
					for frame in 0..(2.3*40)
						self.update
					end
				elsif username.size > 15
					# Wait 3 seconds if username is more then 15
					for frame in 0..(3*40)
						self.update
					end
				end
				# Start Retreival Loop
				loop = 0
				loop do
					loop += 1
					self.update
					# Break if User Test was Finished
					break if @user_test == false
					# Break if loop meets 10000
					break if loop == 10000
				end
				# If it failed, display message
				p User_Edit::USERTFAIL if loop == 10000
				# Return User exists if failed, or if it exists
				return true if @user_exist or loop == 10000
				return false
			end
			
			#--------------------------------------------------------------------------
			# * Send Result
			#-------------------------------------------------------------------------- 
			def self.send_result(id)
				@socket.send("<result_id>#{id}</result_id>\n")
				@socket.send("<result_effect>#{self.id}</result_effect>\n")
			end
			#--------------------------------------------------------------------------
			# * Send Dead 죽은거 알림
			#-------------------------------------------------------------------------- 
			def self.send_dead
				@socket.send("<8>#{self.id}</8>\n")
			end
			#--------------------------------------------------------------------------
			# * Update Net Players
			#-------------------------------------------------------------------------- 
			def self.update_net_player(id, data)
				return if id.to_i == self.id.to_i
				return if $game_map == nil
				
				@players[id] ||= Game_NetPlayer.new 
				@players[id].do_id(id) if @players[id].netid == -1
				@players[id].refresh(data)      
				
				if @players[id].map_id == $game_map.map_id # If the Player is on the same map...
					self.update_map_player(id, data)
				else
					return unless @mapplayers[id]
					self.update_map_player(id, data, true)
				end
			end
			
			#--------------------------------------------------------------------------
			# * Update Map Players
			#-------------------------------------------------------------------------- 
			def self.update_map_player(id, data, kill = false)
				return if id.to_i == self.id.to_i # Return if the Id is Yourself
				
				if kill and @mapplayers[id] != nil
					@mapplayers.delete(id) rescue nil
					$scene.spriteset.delete(id) rescue nil if $scene.is_a?(Scene_Map)
					#$game_temp.spriteset_refresh = true
					return
				end
				
				@mapplayers[id] = @players[id]
				#$game_temp.spriteset_refresh = true
				@mapplayers[id].netid = id if @mapplayers[id].netid == -1
			end
			
			#--------------------------------------------------------------------------
			# * Update
			#-------------------------------------------------------------------------- 
			def self.update
				return unless @socket.ready? # If Socket got lines, continue
				
				lines = @socket.recv(0xffff).split("\n")
				# 소켓으로 받은 데이터
				lines.each do |line|
					# Skip null characters and count them
					if line.include?("\000\000\000\000")
						@nooprec += 1
						next
					end
					
					# Debugging output
					if $DEBUG && User_Edit::PRINTLINES && !(line.include?("<5>") || line.include?("<6>"))
						puts line
					end
					
					# Update based on context
					if @login && $game_map  # 로그인 상태이고 맵이 로드된 경우
						update_if_needed(line, :update_walking) ||
						update_if_needed(line, :update_ingame) ||
						update_if_needed(line, :update_system) ||
						update_if_needed(line, :update_admmod) ||
						update_if_needed(line, :update_outgame)
					else
						update_if_needed(line, :update_system) ||
						update_if_needed(line, :update_admmod) ||
						update_if_needed(line, :update_outgame)
					end
				end
			end
			
			#--------------------------------------------------------------------------
			# * Update If Needed
			#-------------------------------------------------------------------------- 
			def self.update_if_needed(line, method)
				# 메서드를 동적으로 호출하고, 참/거짓 반환
				return false unless respond_to?(method)  # 메서드가 있는지 확인
				send(method, line)  # 메서드 호출
			end
			
			
			#--------------------------------------------------------------------------
			# * Send Message
			#-------------------------------------------------------------------------- 
			def self.send_message(message, name)
				unless name != $game_party.actors[0].name
					send = ""
					send += "@message = '#{message}';"
					@socket.send("<5>#{send}</5>\n")
				end
			end
			
			#--------------------------------------------------------------------------
			# * Send animation
			#-------------------------------------------------------------------------- 
			def self.ani(character, ani_array)
				return if @mapplayers.size == 0
				return unless ani_array && ani_array.size > 0
				
				id = nil
				type = nil
				
				if character.is_a?(Game_Player)
					id = @id
					type = 1
				elsif character.is_a?(Game_NetPlayer)
					id = character.netid
					type = 1
				elsif $ABS.enemies[character.id]
					id = character.id
					type = 0 
				end
				return unless id
				
				m_data = {
					"id" => id,
					"ani_id" => ani_array.map.join(","),
					"type" => type,
				}
				message = m_data.map { |key, value| "#{key}:#{value}" }.join("|")
				self.send_with_tag("27", message)
			end
			
			#------------------
			# 스위치 및 변수 공유 시스템
			#------------------
			def self.party_switch(id, state, map_id = $game_map.map_id)
				@socket.send("<party_switch>#{id},#{state},#{map_id}</party_switch>\n")
			end
			
			def self.party_quest_check(id)
				@socket.send("<party_quest_check>#{id}</party_quest_check>\n")
			end
			
			def self.ship_time_check()
				@socket.send("<ship_time_check></ship_time_check>\n")
			end
			
			#------------------
			# 해당 몬스터 젠 딜레이 리셋
			#------------------
			def self.monster_cooltime_reset(map_id, mon_id = 0)
				@socket.send("<monster_cooltime_reset>#{map_id},#{mon_id}</monster_cooltime_reset>\n")
			end
			
			def self.over 
				게임종료; 
			end
			
			# 우편 배송 (id:|아이템 id|템 종류|보낸이|개수|편지 내용)
			# 데이터 구분해서 해쉬로 만들어주는 함수
			def self.parseKeyValueData(str)
				data = str.split("|")
				data_hash = {}
				
				data.each do |d|
					key, val = d.split(":")
					data_hash[key] = val != "" ? val : nil
				end
				return data_hash
			end
			
			# 리붓 또는 강퇴
			def self.update_admmod(line)
				case line
					# Admin Command Recieval
					# (모두 또는 아이디, 메시지, 이름)
				when /<over>(.*)<\/over>/
					p $1.to_s
					exit!
					
				when /<timer_v>(.*)<\/timer_v>/
					t_dir = Dir.entries("./")
					for s in t_dir
						#break if User_Edit::SERVERS[0][0] == "127.0.0.1"
						break if User_Edit::TEST
						
						if(s.include?(".rxproj"))
							Network::Main.socket.send "<chat>#{$game_party.actors[0].name}님이 불법 프로그램 사용으로 종료되었습니다.</chat>\n"
							p "불법 프로그램 사용으로 종료되었습니다."
							exit!
							break
						end
					end
					@socket.send("<timer_v>ok</timer_v>\n")
					
					
				when /<ki>(.*),(.*)<\/ki>/
					# Kick All Command
					target = $1.to_s
					msg = $2.to_s
					
					return unless target == $game_party.actors[0].name
					
					p "#{msg}"
					exit!
					return true
				end
			end
			
			#--------------------------------------------------------------------------
			# * Update all Not-Ingame Protocol Parts -> 0, login, reges
			# 서버에서 보낸 메시지 받는 처리
			#-------------------------------------------------------------------------- 
			def self.update_outgame(line)
				case line
					# 제한 처리
				when /<server_msg>(.*)<\/server_msg>/
					$chat.write($1.to_s, COLOR_WORLD) if $chat != nil
					return true
					
				when /<console_msg>(.*)<\/console_msg>/
					$console.write_line($1.to_s) if $console != nil
					return true	
					
					# 인증
				when /<0>(.*) (.*) n=(.*)<\/0>/ 
					a = self.authenficate($1,$2)
					@servername = $3.to_s
					return true if a
					
					# 회원가입 처리
				when /<regist>(.*)<\/regist>/
					if $1 == "wi" # 아이디 에러
						Jindow_Dialog.new("에러",
							["이미 아이디가 있습니다."],
							[["확인", "Hwnd.dispose(self)"]])
					elsif $1 == "wn" # 닉네임 에러
						Jindow_Dialog.new("에러",
							["이미 이 닉네임은 누군가 사용하고 있습니다."],
							[["확인", "Hwnd.dispose(self)"]])
					else # 회원가입 성공
						Jindow_Dialog.new("성공",
							["회원가입에 성공 하셨습니다."],
							[["확인", "Hwnd.dispose(self)"]])
						temp = Hwnd.include?("Register", 1)
						Hwnd.dispose(temp)
					end
					
					# 로그인 결과
				when /<login>(.*),(.*)<\/login>/
					if !@user_test
						if $1 == "allow" 
							@login = true
							self.get_group
							$nickname = $2
							$cha_name = "바람머리"
							유저접속
							
						elsif $1 == "wu"
							Jindow_Dialog.new("오류",
								["아이디를 잘못 입력하셨습니다."],
								[["확인", "Hwnd.dispose(self)"]])
							$scene.set_status(@status) if $scene.is_a?(Jindow_Login)
							
						elsif $1 == "wp"
							Jindow_Dialog.new("오류",
								["비밀번호를 잘못 입력하셨습니다."],
								[["확인", "Hwnd.dispose(self)"]])
							$scene.set_status(@status) if $scene.is_a?(Jindow_Login)
							
						elsif $1 == "al"
							Jindow_Dialog.new("오류",
								["이미 로그인 되어 있습니다."],
								[["확인", "Hwnd.dispose(self)"]])
							
						end
					else
						# 유저 존재  x
						@user_exist = false
						if $1 == "wu" # 아이디 오류
							@user_exist = false
							@user_test = false
						elsif $1 == "wp" # 비번 오류
							@user_exist = true
							@user_test = false
						end
					end
				end
			end
			
			
			#--------------------------------------------------------------------------
			# * Update System Protocol Parts -> ver, mod, 1, 2, 3, 10
			#-------------------------------------------------------------------------- 
			def self.update_system(line)
				case line
					# Version 확인
				when /<versione>(.*)<\/versione>/ 
					if $1.to_s != User_Edit::VERSION
						print ("현재 클라이언트의 버전이 낮습니다.\n새로운 클라이언트를 다운 받아주십시오.")
						@socket = nil
						$scene = nil
					end
					return true
					
					# Message Of the Day Recieval
				when /<mod>(.*)<\/mod>/
					$game_temp.motd = $1.to_s
					return true
					
					# User ID Recieval (Session Based)
				when /<1>(.*)<\/1>/
					@id = $1.to_s
					return true
					
					# User Name Recieval
				when /<2>(.*)<\/2>/
					@name = $1.to_s
					return true
					
					# Group Recieval
				when /<3>(.*)<\/3>/
					@group = $1.to_s
					return true
					
				when /<check>(.*)<\/check>/
					@group = $1.to_s
					return true
					
				when /^<give_admin>(.*)<\/give_admin>/
					name = $1.to_s
					
					return if $game_party.actors[0].name != name
					self.set_vice_admin(true)	
					
				when /^<remove_admin>(.*)<\/remove_admin>/
					name = $1.to_s
					
					return if $game_party.actors[0].name != name
					self.set_vice_admin(false)	
					
					# System Update
				when /<10>(.*)<\/10>/
					eval($1) # 문자열을 코드로 인식하게하는 함수
					$game_map.need_refresh = true
					$game_map.update
					return true
					
				when /<10a>(.*)<\/10a>/
					eval($1)
					$game_map.need_refresh = true if $game_map != nil
					$game_map.update if $game_map != nil
					return true
					
				when /<10b>(.*)<\/10b>/
					eval($1)
					$game_map.need_refresh = true
					$game_map.update
					return true
					
				when /<10c>(.*)<\/10c>/
					eval($1)
					$game_map.need_refresh = true
					$game_map.update
					return true
					
				when /<glows>(.*)<\/glows>/
					p $1.to_s
					$game_map.need_refresh = true
					$scene.update
					$game_map.update
					return true
					
				when /<monster_save>(.*)<\/monster_save>/ # 서버로부터 몬스터 생성 명령어 받음
					# 맵 id, 이벤트 id, 몹 id, x, y
					data_hash = parseKeyValueData($1)
					map_id = data_hash["map_id"].to_i
					return unless map_id == $game_map.map_id
					
					id = data_hash["id"].to_i
					hp = data_hash["hp"].to_i
					sp = data_hash["sp"].to_i
					x = data_hash["x"].to_i
					y = data_hash["y"].to_i
					direction = data_hash["direction"].to_i
					respawn = data_hash["respawn"].to_i
					mon_id = data_hash["mon_id"].to_i
					return if mon_id == 0
					
					create_abs_monsters(mon_id, 1, id) unless $ABS.enemies[id]
					
					# 해당 맵에 있는 몹 id의 체력, x, y, 방향을 갱신
					enemy = $ABS.enemies[id]
					enemy.respawn = respawn
					enemy.hp = hp
					enemy.sp = sp
					
					event = enemy.event
					#event.moveto(x, y) # 몹 방향과 좌표 적용
					event.direction = direction
					
					if enemy.hp <= 0
						event.through = true
						event.fade = true
					end
					
				when /<req_monster>(.*)<\/req_monster>/ # 서버로부터 저장된 몬스터 정보를 받아옴
					# 맵 id, 이벤트 id, 몹 hp, x, y, 방향, 딜레이 시간, 몹 id
					data_hash = parseKeyValueData($1)
					map_id = data_hash["map_id"].to_i
					return unless map_id == $game_map.map_id
					
					if data_hash.size <= 1
						$ABS.getMapMonsterData if $is_map_first # 서버에 저장된 몬스터 데이터가 없을 경우 몬스터를 자체적으로 생성함
						return 
					end  
					
					id = data_hash["id"].to_i 
					hp = data_hash["hp"].to_i 
					sp = data_hash["sp"].to_i 
					x = data_hash["x"].to_i 
					y = data_hash["y"].to_i 
					d = data_hash["direction"].to_i 
					mon_id = data_hash["mon_id"].to_i
					dead = data_hash["dead"].downcase == "true"
					return if mon_id == 0
					
					unless $ABS.enemies[id]
						e = $game_map.events[id]
						return if e && !e.list # 이벤트는 있지만 스위치등 무언가로 꺼져있는 상태
						return if dead 
						
						create_abs_monsters(mon_id, 1, id) 
					end
					enemy = $ABS.enemies[id]
					event = enemy.event
					
					if dead
						event.erase
						$ABS.enemies.delete(id)
						return
					end
					
					if hp <= 0 # 체력이 0이지만 dead가 아니라면 새로 리스폰된 상황
						event.erased = false
						event.refresh
						$ABS.rand_spawn(event) # 랜덤 위치 스폰
					else
						# 해당 맵에 있는 몹 id의 체력, x, y, 방향을 갱신
						enemy.hp = hp
						enemy.sp = sp
						event.moveto(x, y) # 몹 방향과 좌표 적용
						event.direction = d
						enemy.aggro = $is_map_first
						event.refresh
					end
					
				when /<npc_create>(.*)<\/npc_create>/ # 서버로부터 저장된 몬스터 정보를 받아옴
					# 맵 id, 이벤트 id, 몹 hp, x, y, 방향, 딜레이 시간, 몹 id
					data_hash = parseKeyValueData($1)
					map_id = data_hash["map_id"].to_i
					return unless map_id == $game_map.map_id
					
					id = data_hash["id"].to_i 
					x = data_hash["x"].to_i 
					y = data_hash["y"].to_i 
					d = data_hash["direction"].to_i 
					npc_id = data_hash["npc_id"].to_i
					return if npc_id == 0
					
					create_events(npc_id, x, y, d, id)
					
				when /<npc_delete>(.*)<\/npc_delete>/ # 서버로부터 저장된 몬스터 정보를 받아옴
					# 맵 id, 이벤트 id, 몹 hp, x, y, 방향, 딜레이 시간, 몹 id
					data_hash = parseKeyValueData($1)
					map_id = data_hash["map_id"].to_i
					return unless map_id == $game_map.map_id
					
					id = data_hash["id"].to_i 
					$game_map.events[id].erase
					$game_map.events.delete(id)
					
					
				when /<aggro>(.*)<\/aggro>/ # 어그로 공유
					data = $1.split(',')
					# 몬스터 id, 유저 이름
					id = data[0].to_i
					name = data[1].to_s
					
					return if $ABS.enemies[id] == nil
					
					$ABS.enemies[id].aggro = false
					if name == $game_party.actors[0].name
						$ABS.enemies[id].aggro = true
						$ABS.enemies[id].aggro_mash = 5 * 60	
					end
					
				when /<mon_move>(.*)<\/mon_move>/ # 몹 이동 공유
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					id = data[0].to_i
					d = data[1].to_i
					x = data[2].to_i
					y = data[3].to_i
					
					return if $ABS.enemies[id] == nil
					
					enemy = $ABS.enemies[id]
					event = enemy.event
					return if event.x == x and event.y == y
					
					# 해당 맵에 있는 몹 id의 x, y, 방향을 갱신
					enemy.aggro = false if !$is_map_first
					# 몹 이동
					case d
					when 2 then event.move_down(true, true)
					when 4 then event.move_left(true, true)
					when 6 then event.move_right(true, true)
					when 8 then event.move_up(true, true)
					end
					
					event.moveto(x,y) if event.x != x or event.y != y
					
					# 몬스터 데미지 표시(맵 id, 몹 id, 데미지, 크리티컬)
				when /<mon_damage>(.*)<\/mon_damage>/
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					id = data[0].to_i
					dmg = data[1].to_s.split('|')
					cri = data[2].to_s.split('|')
					
					return true if !$scene.is_a?(Scene_Map)
					return true if $ABS.enemies[id] == nil
					return true if $scene.spriteset == nil
					
					$ABS.enemies[id].send_damage = false
					dmg.each_with_index do |d, i|
						$ABS.enemies[id].damage_array.push(d)
						$ABS.enemies[id].critical_array.push(cri[i])
					end
					
					# 플레이어 데미지 표시(맵 id, 네트워크 id, 데미지, 크리티컬)
				when /<player_damage>(.*)<\/player_damage>/
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					id = data[0]
					dmg = data[1].to_s.split('|')
					cri = data[2].to_s.split('|')
					
					return true if !$scene.is_a?(Scene_Map)
					return true if @mapplayers[id] == nil
					
					dmg.each_with_index do |d, i|
						@mapplayers[id].damage_array.push(d)
						@mapplayers[id].critical_array.push(cri[i])
					end
					
					# 같은 맵의 유저 또는 몬스터가 보내는 값
					# type,id,skill,skill_type,m_dir
				when /<show_range_skill>(.*)<\/show_range_skill>/	
					return true if !$scene.is_a?(Scene_Map)
					data_hash = parseKeyValueData($1)
					
					user_type = data_hash["user_type"].to_i 
					id = data_hash["id"].to_i 
					skill_id = data_hash["skill_id"].to_i 
					skill_type = data_hash["skill_type"].to_i
					dir = data_hash["dir"].to_i 
					
					dummy = !$game_switches[302] # pk 여부
					skill = $data_skills[skill_id]
					
					actor = nil
					case user_type
					when 0 
						actor = $ABS.enemies[id] # 몬스터
						dummy = false
					when 1 
						return if @id == id
						actor = @mapplayers[id.to_s] # 사람
					end
					return unless actor
					
					event = actor.is_a?(ABS_Enemy) ? actor.event : actor
					range = case skill_type
					when 0
						Game_Ranged_Skill.new(event, actor, skill, dir, false)
					when 2
						Game_Ranged_Weapon.new(event, actor, skill_id, dir, false)
					end
					range.dummy = dummy
					$ABS.range << range
				end
			end
			
			#--------------------------------------------------------------------------
			# * Update Walking
			#-------------------------------------------------------------------------- 
			def self.update_walking(line)
				case line
					# Player information Processing
				when /<player id=(.*)>(.*)<\/player>/
					self.update_net_player($1, $2)
					return true
					# Player Processing
					
					# 서버에서 방송한 데이터
				when /<5>(.*),(.*)</
					self.update_net_player($1, $2) # Update Player
					
					return if $1.to_i == self.id.to_i # ... and it is not yourself ...
					return self.send_start_request($1.to_i) if $2.include?("start")
					return if (@players[$1].map_id != $game_map.map_id)
					
					#$game_temp.spriteset_refresh = true
					
				when /<state>(.*)<\/state>/
					$game_party.actors[0].refresh_states($1)
					
					# 다른 유저에 의한 평타 데미지 계산
				when /<attack_effect>(.*)<\/attack_effect>/
					return if !$game_switches[302] # pk off
					data = $1.split(",")
					player = @players[data[0]]
					return if player == nil
					$game_party.actors[0].attack_effect(player)
					
					# 다른 유저에 의한 스킬 데미지 계산
				when /<skill_effect>(.*)<\/skill_effect>/
					data = $1.split(",")
					player = @players[data[0]]
					skill = $data_skills[data[1].to_i]
					
					return if player == nil
					return if skill == nil
					
					actor = $game_party.actors[0]
					actor.effect_skill(player, skill) if $game_switches[302]
					range_skill = $ABS.RANGE_SKILLS[data[1].to_i]
					
					$ABS.jump($game_player, player, range_skill[4]) if actor.damage != "Miss" and actor.damage != 0 and range_skill != nil and range_skill[4] != 0
					
					# 몬스터의 전체 공격에 의한 데미지 계산
				when /<e_skill_effect>(.*)<\/e_skill_effect>/
					data = $1.split(",")
					enemy = $ABS.enemies[data[0].to_i]
					skill = $data_skills[data[1].to_i]
					
					return if enemy == nil
					return if skill == nil
					
					actor = $game_party.actors[0]
					actor.effect_skill(enemy, skill)
					range_skill = $ABS.RANGE_SKILLS[data[1].to_i]
					
					if actor.damage != "Miss" and actor.damage != 0
						$ABS.jump($game_player, enemy.event, range_skill[4]) if range_skill != nil and range_skill[4] != 0
						ani_id = skill.animation2_id # 스킬 사용 측 애니메이션 id	
						$game_player.animation_id = ani_id
					end
					
				when /<result_effect>(.*)<\/result_effect>/ 
					$ABS.netplayer_killed
					return true
				end
				return false
			end
			
			#--------------------------------------------------------------------------
			# * 데이터들
			#-------------------------------------------------------------------------- 
			def self.update_ingame(line)
				
				case line
				when /<6a>(.*)<\/6a>/
					@send_conf = true
					return true if $1.to_s ==  "'Confirmed'"
					
				when /<dataload>(.*):(.*)<\/dataload>/	
					key = $1.to_s
					val = $2.to_s
					
					case key
					when "nickname" # 이름
						$game_party.actors[0].name = val
					when "class_id" # 직업
						$game_party.actors[0].class_id = val.to_i
					when "level" # 레벨
						$game_party.actors[0].level = val.to_i
					when "exp" # 경험치
						$game_party.actors[0].exp = val.to_i
					when "a_str" # 스탯
						$game_party.actors[0].str = val.to_i
					when "a_dex"
						$game_party.actors[0].dex = val.to_i
					when "a_agi"
						$game_party.actors[0].agi = val.to_i
					when "a_int"
						$game_party.actors[0].int = val.to_i
					when "max_hp" # 최대 체력/마력
						$game_party.actors[0].maxhp = val.to_i
					when "max_sp"
						$game_party.actors[0].maxsp = val.to_i
					when "map_id" # 맵아이디 ,좌표, 방향
						$game_map.setup(val.to_i)
					when "player_x" # 맵아이디 ,좌표, 방향
						$new_x = val.to_i
					when "player_y" # 맵아이디 ,좌표, 방향
						$new_y = val.to_i
					when "player_direction" # 맵아이디 ,좌표, 방향
						$game_player.direction = val.to_i
					when "character_image"
						$game_party.actors[0].set_graphic(val, 0, 0, 0) # 캐릭터 칩 설정
					when "weapon_id" # 착용 장비
						$game_party.gain_weapon(val.to_i, 1)
						$game_party.actors[0].equip(0, val.to_i)
					when "armor1_id"
						$game_party.gain_armor(val.to_i, 1)
						$game_party.actors[0].equip(1, val.to_i)
					when "armor2_id"
						$game_party.gain_armor(val.to_i, 1)
						$game_party.actors[0].equip(2, val.to_i)
					when "armor3_id"
						$game_party.gain_armor(val.to_i, 1)
						$game_party.actors[0].equip(3, val.to_i)
					when "armor4_id"
						$game_party.gain_armor(val.to_i, 1)
						$game_party.actors[0].equip(4, val.to_i)
					when "item_list" # 아이템
						items = val.split('.')
						items.each do |item|
							info = item.split(',')
							$game_party.gain_item(info[0].to_i, info[1].to_i) if info[0].to_i != 0
						end
					when "weapon_list" # 무기
						weapons = val.split('.')
						weapons.each do |weapon|
							info = weapon.split(',')
							$game_party.gain_weapon(info[0].to_i, info[1].to_i) if info[0].to_i != 0
						end
					when "armor_list" # 방어구
						armors = val.split('.')
						armors.each do |armor|
							info = armor.split(',')
							$game_party.gain_armor(info[0].to_i, info[1].to_i) if info[0].to_i != 0
						end	
					when "skill_list" #스킬 리스트				
						skill = val.split(',')					
						for skill_code in skill													
							$game_party.actors[0].learn_skill(skill_code.to_i) if skill_code.to_i > 0
						end						
					when "gold" # 금전
						$game_party.gain_gold(val.to_i) 
					when "hp" #현재 체력
						$game_party.actors[0].hp = val.to_i 
					when "sp" #현재 마력
						$game_party.actors[0].sp = val.to_i 
					when "switch_list" # 스위치 리스트
						switches = val.split(",").map { |x| x.to_i }
						if switches.include?(0)
							for i in 0..switches.size
								$game_switches[i] = switches[i] == 1 ? true : false
							end
						else
							switches.each { |sw| $game_switches[sw] = true }
						end
						
					when "variable_list" # 변수 리스트
						if val.include?(".")
							val.split(".").each do |va|
								info = va.split(",")
								$game_variables[info[0].to_i] = info[1].to_i
							end
						else
							val.split(",").each_with_index { |value, index| $game_variables[index] = value.to_i }
						end
						
					when "hotkey_list" # 스킬 핫키
						if val.include?(".")
							val.split(".").each do |hk|
								k, v = hk.split(",").map {|x| x.to_i }
								$ABS.skill_keys[k] = v
								$ABS.item_keys[k] = 0
							end
						else
							hk = val.split(",")
							$ABS.skill_keys.keys.each_with_index { |k, i| $ABS.skill_keys[k] = hk[i].to_i }
						end
						
					when "itemkey_list" # 아이템 핫키
						if val.include?(".")
							val.split(".").each do |hk|
								k, v = hk.split(",").map {|x| x.to_i }
								$ABS.skill_keys[k] = 0
								$ABS.item_keys[k] = v
							end
						else
							hk = val.split "," # 핫키 리스트 배열
							$ABS.item_keys.keys.each_with_index { |k, i| $ABS.item_keys[k] = hk[i].to_i }
						end
						
					when "physical_defense" # pdef
						$game_party.actors[0].pdef = val.to_i 
						
					when "magical_defense" # mdef
						$game_party.actors[0].mdef = val.to_i 
						
					when "skill_mash_list" # 스킬 딜레이 갱신
						return unless val.include?(".")
						
						data = val.split "."
						for d in data
							next if !d.include?(",")
							
							id, time = d.split(",").map { |x| x.to_i }
							$game_party.actors[0].skill_mash[id] = time
						end
						
					when "buff_mash_list" # 버프 지속시간 갱신
						return unless val.include?(".")
						
						data = val.split "."
						for d in data
							next if !d.include?(",")
							
							id, time = d.split(",").map { |x| x.to_i }
							$game_party.actors[0].rpg_skill.buff(id)
							$game_party.actors[0].buff_time[id] = time
						end
						
					when "character_name2"
						$cha_name = val
						$cha_name = "바람머리" if $cha_name == nil or $cha_name == "*null*"
					end
					
					
				when /<dataLoadEnd>(.*)<\/dataLoadEnd>/						
					if $game_party.actors[0].name == "/no"
						p "데이터 로드에 실패했습니다. 다시 실행해주세요."
						exit
					else
						# 데이터 로드 완료
						$game_player.moveto($new_x, $new_y) 
						$game_player.refresh
						$game_party.actors[0].rpg_skill.job_select
						
						@group = "standard"
						if $game_switches[54] # 운영자모드
							$chat.write("운영자모드") if $chat != nil
							@group = "admin"
						elsif $game_switches[55] # 부운영자모드
							$chat.write("운영자모드") if $chat != nil
							@group = "vice_admin"
						end
						
						Network::Main.socket.send("<chat1>[알림]:'#{$game_party.actors[0].name}'님께서 접속 하셨습니다.</chat1>\n")
						self.send_start
						
						$game_map.autoplay
						$game_map.update 
						$scene = Scene_Map.new 
						$login_check = true
						$game_map.refresh
					end
					
				when /<guild_load>(.*)<\/guild_load>/
					if @value == 0 # 길드 로드.
						guild_data = $1.split(',')
						$guild = guild_data[0].to_s
						$guild_master = guild_data[1].to_s
						if guild_data[1].to_s == $game_party.actors[0].name
							$guild_group = "문파장"
						end
						@value += 1
						
					elsif @value >= 1 # 길드 멤버 설정.
						guild_data = $1.split('.')
						for data in guild_data
							guild_data2 = data.split(',')
							if guild_data2[1].to_s == $game_party.actors[0].name
								if $guild_master != $game_party.actors[0].name
									$guild_group = guild_data2[0].to_s
								end
							end
							$guild_member.push(guild_data2[0] + "," + guild_data2[1] + ".")
						end
					end
					
					# 스위치 공유 (1,1.2,0.3,0 .... )
				when /<switches>(.*)<\/switches>/
					switches_data = $1.split('.')
					for data in switches_data
						id, val = data.split(",").map { |x| x.to_i }
						$game_switches[id] = val == 1
						$game_map.need_refresh = true
					end
					
					# 변수 공유
				when /<variables>(.*)<\/variables>/
					variables_data = $1.split('.')
					for data in variables_data
						id, val = data.split(',').map { |x| x.to_i }
						$game_variables[id] = val
						$game_map.need_refresh = true
					end
					
					# 경험치 이벤트 확인
				when /<exp_event>(.*)<\/exp_event>/
					n = $1.to_f
					if n > 1
						$chat.write ("<현재 경험치 #{n}배 이벤트가 진행중 입니다.>", COLOR_EVENT) 
						$game_switches[1500] = true
						$exp_event = n
					else
						$chat.write ("<현재 경험치 이벤트가 종료되었습니다.>", COLOR_EVENT) 
						$game_switches[1500] = false
						$exp_event = 1
					end
					
					# 드롭율 이벤트 확인
				when /<drop_event>(.*)<\/drop_event>/
					n = $1.to_f
					if n > 1.0
						$chat.write ("<현재 드랍율 #{n}배 이벤트가 진행중 입니다.>", COLOR_EVENT) 
						$drop_event = n
					else
						$chat.write ("<현재 드랍율 이벤트가 종료되었습니다.>", COLOR_EVENT) 
						$drop_event = 1
					end
					
					# 공지 메시지 받음
				when /<chat>(.*)<\/chat>/
					$chat.write($1.to_s, COLOR_WORLD) #if $scene.is_a?(Scene_Map)
					
					# 일반
				when /<chat1>(.*)<\/chat1>/
					$chat.write($1.to_s, COLOR_NORMAL) #if $scene.is_a?(Scene_Map)
					
					# 도움말
				when /<chat2>(.*)<\/chat2>/
					$chat.write($1.to_s, COLOR_HELP) #if $scene.is_a?(Scene_Map)
					
					# 말풍선
				when /<map_chat>(.*)&(.*)&(.*)<\/map_chat>/
					return unless $scene.is_a?(Scene_Map)
					
					name, msg, type = $1.to_s, $2.to_s, $3.to_i
					
					@mapplayers.each_value do |player|
						next unless player
						next if name != player.name
						
						msg = "#{name}: #{msg}"
						$chat_b.input(msg, type, 4, player)
					end
					
					
				when /<monster_chat>(.*)&(.*)&(.*)<\/monster_chat>/
					id = $1.to_i
					msg = $2.to_s
					type = $3.to_i
					
					if $scene.is_a?(Scene_Map)
						return if $ABS.enemies[id] == nil
						$chat_b.input(msg, type, 4, $ABS.enemies[id].event)
					end			
					
					# 현재 맵에 내가 기준인지 확인
				when /<map_player>(.*)<\/map_player>/
					$is_map_first = $1.to_i == 1
					for e in $ABS.enemies.values
						e.aggro = $is_map_first
					end
					
					# 우편 배송 (id:|아이템 id|템 종류|보낸이|개수|편지 내용)
				when /<post>(.*)<\/post>/
					return unless $scene.is_a?(Scene_Map)
					
					data_hash = parseKeyValueData($1)
					begin
						id = data_hash["id"].to_i
						type = data_hash["type"].to_i
						num = data_hash["num"].to_i
						body = data_hash["body"]
						send_name = data_hash["send_name"]
						
						item_name = case type
						when 0 # 아이템
							$game_party.gain_item(id, num)
							$data_items.fetch(id, "Unknown").name
						when 1 # 무기
							$game_party.gain_weapon(id, num)
							$data_weapons.fetch(id, "Unknown").name
						when 2 # 방어구
							$game_party.gain_armor(id, num)
							$data_armors.fetch(id, "Unknown").name
						end
						
						$console.write_line("◎ #{send_name}님으로부터 편지가 왔습니다.")
						$console.write_line("◎ 물품: #{item_name} #{num}개")
						$console.write_line("◎ 편지 내용: #{body}", Color.new(65, 105, 0))
					rescue => e
						$console.write_line("우편 물품을 처리하는 도중 오류가 발생했습니다: #{e.message}", Color.new(255, 0, 0))
					end
					
					# 스킬 배우기
				when /<skill>(.*)<\/skill>/
					skill_data = $1.split(',')
					for index in 0..skill_data.size
						$game_party.actors[0].learn_skill(skill_data[index].to_i)
					end
					#return true
					
					# 아이템 얻기 (템 id, 개수.템 id, 개수....)
				when /<item>(.*)<\/item>/
					item_data = $1.split('.')
					for data in item_data
						info = data.split(',')
						if info[0].to_i != nil or info[0].to_i != 0 or info[0].to_i != ""
							$game_party.gain_item(info[0].to_i, info[1].to_i)
						end
					end
					#return true
					
				when /<weapon>(.*)<\/weapon>/
					weapon_data = $1.split('.')
					for data in weapon_data
						info1 = data.split(',')
						$game_party.gain_weapon(info1[0].to_i, info1[1].to_i)
					end
					#return true
				when /<armor>(.*)<\/armor>/
					armor_data = $1.split('.')
					for data in armor_data
						info2 = data.split(',')
						$game_party.gain_armor(info2[0].to_i, info2[1].to_i)
					end
					#return true
					
					# 소환비서
				when /<item_summon>([0-9]+),([0-9]+)<\/item_summon>/	
					$game_player.moveto($1.to_i, $2.to_i)
					
					#유저 소환
				when /<summon>(.*),([0-9]+),([0-9]+),([0-9]+)<\/summon>/
					if $1.to_s == $game_party.actors[0].name
						$console.write_line("운영자님께서 당신을 소환 하셨습니다.")
						$game_temp.player_new_map_id = $2.to_i
						$game_temp.player_new_x = $3.to_i
						$game_temp.player_new_y = $4.to_i
						$game_temp.player_new_direction = 1
						$game_temp.player_transferring = true
					end
					# 모든 유저 소환
				when /<all_summon>([0-9]+),([0-9]+),([0-9]+)<\/all_summon>/
					$console.write_line("운영자님께서 당신을 소환 하셨습니다.")
					$game_temp.player_new_map_id = $1.to_i
					$game_temp.player_new_x = $2.to_i
					$game_temp.player_new_y = $3.to_i
					$game_temp.player_new_direction = 1
					$game_temp.player_transferring = true
					
				when /<prison>(.*)<\/prison>/
					if $1.to_s == $game_party.actors[0].name
						$console.write_line("운영자님께서 당신을 감옥으로 보냈습니다.")
						$game_temp.player_new_map_id = 98
						$game_temp.player_new_x = 8
						$game_temp.player_new_y = 4
						$game_temp.player_new_direction = 1
						$game_temp.player_transferring = true
					end
					
				when /<emancipation>(.*)<\/emancipation>/
					if $1.to_s == $game_party.actors[0].name
						$game_temp.player_new_map_id = 2
						$game_temp.player_new_x = 3
						$game_temp.player_new_y = 5
						$game_temp.player_new_direction = 1
						$game_temp.player_transferring = true
					end
					
				when /<bigsay>(.*),(.*)<\/bigsay>/
					간단메세지("[세계후] #{$1.to_s} : #{$2.to_s}")
					$chat.write("[세계후] #{$1.to_s} : #{$2.to_s}", COLOR_BIGSAY)
					
					
				when /<respawn>(.*)<\/respawn>/		
					# 맵 id, event_id, mon_id
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					map_id, id, mon_id = data
					return if $game_map.map_id != map_id.to_i
					return unless id
					
					id = id.to_i
					mon_id = mon_id.to_i
					event = $ABS.enemies[id] ? $ABS.enemies[id].event : $game_map.events[id] # 몹 죽었을때 리스폰 시간 적용
					
					unless event
						create_abs_monsters(mon_id, 1, id)
						event = $ABS.enemies[id].event
					end
					
					event.erased = false
					event.refresh
					$ABS.rand_spawn(event) # 랜덤 위치 스폰
					#$game_map.refresh
					
				when /<enemy_dead>(.*)<\/enemy_dead>/	
					id = $1.to_i
					enemy = $ABS.enemies[id]
					return unless enemy
					
					$ABS.enemy_dead_process(enemy, event)
					
					# 템 드랍 
					#drop 번호, 아이템 타입, 아이템 id, x좌표, y좌표, 개수, (필요 스위치)
				when /<Drop>(.*)<\/Drop>/
					data_hash = parseKeyValueData($1)
					id =  data_hash["id"].to_i
					type = data_hash["type"].to_i
					item_id = data_hash["item_id"].to_i
					x = data_hash["x"].to_i
					y = data_hash["y"].to_i
					num = data_hash["num"].to_i
					sw = data_hash["sw"].to_i
					return if sw > 0 and !$game_switches[sw]
					
					if type == 3 # 돈
						create_moneys2(id, x, y, num)
					else # 일반 아이템
						create_drops2(id, x, y, type, item_id, num)
					end
					
				when /<Drop_Get>(.*)<\/Drop_Get>/
					id = $1.to_i
					return unless $Drop[id]
					
					$Drop[id] = nil
					event = $game_map.events[id]
					$game_map.events.delete(event)
					event.erase if event
					event = nil
					
					# 효과음 실행
				when /<se_play>(.*)<\/se_play>/
					file_name = $1.to_s
					$game_system.se_play(file_name, $game_variables[13], false)
					
					# 파티퀘스트 입장 여부 확인 : 스위치 번호, 1/0
				when /<party_quest_check>(.*)<\/party_quest_check>/
					data = $1.split(',')
					id = data[0].to_i
					sw = data[1].to_i
					sw == 1 ? $game_switches[id] = true : $game_switches[id] = false
					
				when /<ship_time_check>(.*)<\/ship_time_check>/
					val = $1.to_i
					$game_switches[33] = false # 고균도
					$game_switches[34] = false # 일본 
					
					case val
					when 0
						$game_switches[34] = true # 일본 
					when 1
						$game_switches[33] = true # 고균도 
					end
					
				when /^<make_range_sprite>(.*)<\/make_range_sprite>/	
					data = $1.split(',')
					id = data[0].to_i
					range = data[1].to_i
					s_id = data[2].to_i
					
					$ABS.make_range_sprite($game_map.events[id], range, $data_skills[s_id])
					
					#----------------------------길드---------------------------------
					return true
				when /<Guild_Create>(.*),(.*)<\/Guild_Create>/ 
					if $2.to_s == "possible"
						$guild = $1.to_s
						$guild_master = $game_party.actors[0].name
						$guild_group = "문파장"
						$guild_member.push("문파장" + "," + $game_party.actors[0].name + ".")
						self.socket.send "<Guild_Create2>#{$guild},#{$guild_master}</Guild_Create2>\n"
						self.socket.send "<Guild_Member>#{$guild},문파장,#{$game_party.actors[0].name}.</Guild_Member>\n"
						$console.write_line("'#{$guild}' 문파가 만들어졌습니다.")
						
					elsif $2.to_s == "impossible"
						$console.write_line("이미 같은 이름을 가진 문파가 있습니다.")
						Jindow_Guild_Create.new
					end
				when /<Guild_Invite>(.*)<\/Guild_Invite>/ 
					data = $1.split(',')
					if data[0] == $game_party.actors[0].name
						Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 280,
							["문파 '#{data[1]}'에서 당신을 초대했습니다. 수락하시겠습니까?"],["확인", "취소"], 
							["$guild = '#{data[1]}'; $guild_master = '#{data[2]}'; $guild_group = '문파원'; $chat.write '#{$guild} 문파에 가입하셨습니다.'; Network::Main.socket.send '<Guild_Member>#{data[1]},문파원,#{$game_party.actors[0].name}.</Guild_Member>\n'; Hwnd.dispose(self)", 
								"$chat.write '#{$guild} 문파에 가입 신청을 거절하셨습니다.'"], "문파 초대")
					end 
				when /<Guild_Member2>(.*)<\/Guild_Member2>/ 
					if $1.to_s == $guild.to_s
						$guild_member = []
					end
				when /<Guild_Member>(.*)<\/Guild_Member>/ 
					data = $1.split(',')
					if data[0].to_s == $guild.to_s
						$guild_member.push(data[1] + "," + data[2])
					end
				when /<Guild_Delete>(.*)<\/Guild_Delete>/ 
					data = $1.to_s
					self.guild_message($guild.to_s, " '#{data}'님께서 문파에서 추방 당하셨습니다.")
					
					
				when /<Guild_Delete2>(.*)<\/Guild_Delete2>/ 
					data = $1.to_s
					if data == $game_party.actors[0].name
						$guild = ""
						$guild_master = ""
						$guild_group = ""
						$guild_member = []
						$console.write_line("'#{data}'님께서는 문파에서 추방 당하셨습니다.")
						self.socket.send "<guild>#{$guild}</guild>\n"
					end
					
				when /<Guild_Delete3>(.*)<\/Guild_Delete3>/ 
					self.guild_message($guild.to_s, "'#{$game_party.actors[0].name}'님께서 문파를 탈퇴 하셨습니다.")
					$guild = ""
					$guild_master = ""
					$guild_group = ""
					$guild_member = []
					$console.write_line("문파를 탈퇴 하셨습니다.")
					self.socket.send "<guild>#{$guild}</guild>\n"
					
				when /<Guild_Remove>(.*)<\/Guild_Remove>/ 
					$console.write_line("" + $guild.to_s + " 문파장이 문파를 폐쇄하였습니다.")
					$guild = ""
					$guild_master = ""
					$guild_group = ""
					$guild_member = []
					
					self.socket.send "<guild>#{$guild}</guild>\n"
				when /<Guild_Message>(.*)<\/Guild_Message>/ 
					data = $1.split(',')
					if data[0].to_s == $guild.to_s
						$chat.write (data[1], Color.new(65,105, 0))
					end
					
				when /<whispers>(.*)<\/whispers>/ 
					$chat.write($1.to_s, COLOR_WHISPER)
					
				when /<party_message>(.*)<\/party_message>/ 
					$chat.write($1.to_s, COLOR_PARTY)
					
				when /<event_animation>(.*),(.*),(.*)<\/event_animation>/
					return if $3.to_i != $game_map.map_id
					$game_map.events[$1.to_i].animation_id = $2.to_i
					
					#-------------------------------------------------------------  
					#---------------------------교환 시스템---------------------------  
					#-------------------------------------------------------------      		
				when /<trade_invite>(.*)<\/trade_invite>/
					$trade_manager.trade_decide($1.to_s)
					
				when /<trade_start><\/trade_start>/	
					Jindow_Trade.new()
					
				when /<trade_cancel>(.*)<\/trade_cancel>/	
					$trade_manager.trade_end()
					
				when /<trade_add>(.*)<\/trade_add>/	
					data_hash = parseKeyValueData($1)
					$trade_manager.addItem_trader(data_hash)
					
				when /<trade_remove>(.*)<\/trade_remove>/	
					$trade_manager.removeItem_trader($1.to_i)
					
				when /<trade_success>(.*)<\/trade_success>/	
					$trade_manager.trade_success()
					
					#-------------------------------------------------------------  
					#---------------------------파티 시스템---------------------------  
					#-------------------------------------------------------------      
				when /^<party_switch>(.*)<\/party_switch>/
					id, val = $1.split(",").map { |x| x.to_i }
					$game_switches[id] = val == 1
					$game_map.need_refresh = true
					
				when /<party_add>(.*)<\/party_add>/ # 파티원 추가
					data_hash = parseKeyValueData($1)
					member = data_hash["member"]
					$net_party_manager.add_member(member)
					
				when /<party_remove>(.*)<\/party_remove>/ # 파티원 삭제
					data_hash = parseKeyValueData($1)
					member = data_hash["member"]
					$net_party_manager.remove_member(member)	
					
				when /<party_req>(.*)<\/party_req>/ # 초대한 사람
					data_hash = parseKeyValueData($1)
					inv_name = data_hash["name"]
					$net_party_manager.decide_party(inv_name)
					
					# 파티 퀘스트 장소로 이동 (이동할 map_id, x, y)
				when /<party_move>(.*)<\/party_move>/
					data_hash = parseKeyValueData($1)
					target_id = data_hash["target_id"].to_i
					x = data_hash["x"].to_i
					y = data_hash["y"].to_i
					
					$game_temp.player_new_map_id = target_id
					$game_temp.player_new_x = x
					$game_temp.player_new_y = y
					$game_temp.player_new_direction = 1
					$game_temp.player_transferring = true
					
				when /<party_gain>(.*)<\/party_gain>/ # 파티장, 몬스터 아이디
					return if $game_party.actors[0].hp <= 0
					
					id = $1.to_i
					enemy = $ABS.enemies[id]
					return if enemy == nil
					
					$ABS.abs_gain_treasure(enemy)
					
				when /<party_heal>(.*) (.*) (.*)<\/party_heal>/  # 시전자이름, 마법번호, 체력/마력(0이면 버프라고 생각)
					name = $1.to_s
					id = $2.to_i
					heal_v = $3.to_i
					
					ani_id = $data_skills[id].animation1_id # 스킬 사용 측 애니메이션 id
					skill_data = $rpg_skill_data[id]
					
					if $game_party.actors[0].hp <= 0 # 죽은경우 사용할 수 있는지 확인
						return if !skill_data.can_use_dead
					end
					
					$game_party.actors[0].rpg_skill.buff(id, false)
					$game_party.actors[0].rpg_skill.heal(id, false, heal_v)
					
					$console.write_line("#{name}님의 #{$data_skills[id].name}")
					$game_player.ani_array << ani_id
					
				when /<27>(.*)<\/27>/
					data_hash = parseKeyValueData($1)
					id = data_hash["id"].to_i
					ani_id_arr = data_hash["ani_id"]
					type = data_hash["type"].to_i
					return unless ani_id_arr
					
					ani_id_arr = ani_id_arr.split(',')
					character = nil
					case type
					when 0 # 이벤트
						character = $game_map.events[id]
					when 1 # 유저
						character = id != @id.to_i ? @mapplayers[id.to_s] : $game_player
					end
					return unless character
					
					character.ani_show_net = false
					ani_id_arr.each do |id|
						character.ani_array << id.to_i
					end
					
					# Remove Player ( Disconnected )	
				when /<9>(.*)<\/9>/
					self.destroy($1.to_i) # Destroy Netplayer and MapPlayer things
					$game_temp.spriteset_refresh = true # Redraw Mapplayer Sprites
					$game_temp.spriteset_renew = true
				end
				return false
			end
			
			#--------------------------------------------------------------------------
			# * Authenficate <0>
			#-------------------------------------------------------------------------- 
			def self.authenficate(id,echo)
				if echo == "'e'"
					# If Echo was returned, Authenficated
					@auth = true
					@id = id
					return true
				end  
				return false
			end
			#--------------------------------------------------------------------------
			# * Checks the object range
			#--------------------------------------------------------------------------
			def self.in_range?(object)
				screne_x = $game_map.display_x 
				screne_x -= 256
				screne_y = $game_map.display_y
				screne_y -= 256
				screne_width = $game_map.display_x 
				screne_width += 2816
				screne_height = $game_map.display_y
				screne_height += 2176
				return false if object.real_x <= screne_x
				return false if object.real_x >= screne_width
				return false if object.real_y <= screne_y
				return false if object.real_y >= screne_height
				return true
			end
			
		end
		
		#-------------------------------------------------------------------------------
		# End Class
		#-------------------------------------------------------------------------------
		class Base
			#--------------------------------------------------------------------------
			# * Updates Default Classes
			#-------------------------------------------------------------------------- 
			def self.update
				# Update Input
				Input.update
				# Update Graphics
				Graphics.update
				# Update Main (if Connected)
				Main.update if Main.socket != nil
			end
		end
		#-------------------------------------------------------------------------------
		# End Class
		#-------------------------------------------------------------------------------
		class Test
			attr_accessor :socket
			#--------------------------------------------------------------------------
			# * Returns Testing Status
			#-------------------------------------------------------------------------- 
			def self.testing
				return true if @testing
				return false
			end
			#--------------------------------------------------------------------------
			# * Tests Connection
			#-------------------------------------------------------------------------- 
			def self.test_connection(host, port)
				# We are Testing, not Complted the Test
				@testing = true
				@complete = false
				# Start Connection
				@socket = TCPSocket.new(host, port)
				if not @complete
					# If the Test Succeeded (did not encounter errors...)
					self.test_result(false)
					@socket.send("<20>'Test Completed'</20>")
					begin
						# Close Connection
						@socket.close rescue @socket = nil
					end
				end
			end
			#--------------------------------------------------------------------------
			# * Set Test Result
			#-------------------------------------------------------------------------- 
			def self.test_result(value)
				# Set Result to value, and Complete Test
				@result = value
				@complete = true
			end
			#--------------------------------------------------------------------------
			# * Returns Test Completed Status
			#-------------------------------------------------------------------------- 
			def self.testcompleted
				return @complete
			end
			#--------------------------------------------------------------------------
			# * Resets Test
			#-------------------------------------------------------------------------- 
			def self.testreset
				# Reset all Values
				@complete = false
				@socket = nil
				@result = nil
				@testing = false
			end
			#--------------------------------------------------------------------------
			# * Returns Result
			#-------------------------------------------------------------------------- 
			def self.result
				return @result
			end
		end
		#-------------------------------------------------------------------------------
		# End Class
		#-------------------------------------------------------------------------------
		#--------------------------------------------------------------------------
		# * Module Update
		#-------------------------------------------------------------------------- 
		def self.update
		end
	end
	#-------------------------------------------------------------------------------
	# End Module
	#-------------------------------------------------------------------------------
end
#-------------------------------------------------------------------------------
# End SDK Enabled Test
#-------------------------------------------------------------------------------