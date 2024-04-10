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
				$ani_character = {}
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
				if @group.downcase.include?("adm")
					group = "admin"
				elsif @group.downcase.include?("mod")
					group = "mod"
				else
					group = "standard"
				end
				return group
			end
			
			def self.set_admin
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
			# * Asks for Login (and confirmation)로그인 요청
			#-------------------------------------------------------------------------- 
			def self.send_login(user,pass)
				@socket.send("<login #{user}>#{pass}</login>\n")
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
				# Send Authenfication
				@socket.send("<0>'e'</0>\n")
				@auth = false
				# Set Try to 0, then start Loop
				try = 0
				loop do
					# Add 1 to Try
					try += 1
					loop = 0
					# Start Loop for Retrieval
					loop do
						loop += 1
						self.update
						# Break if Authenficated
						break if @auth
						# Break if loop reaches 20000
						break if loop == 20000
					end
					# If the loop was breaked because it reached 10000, display message
					p "#{User_Edit::NOTAUTH}, Try #{try} of #{User_Edit::CONNFAILTRY}" if loop == 20000
					# Stop everything if try mets the maximum try's
					break if try == User_Edit::CONNFAILTRY
					# Break loop if Authenficated
					break if @auth
				end
				# Go to Scene Login if Authenficated
				$scene = Scene_Login.new if @auth
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
			# * Send start
			#-------------------------------------------------------------------------- 
			def self.send_start
				send = ""
				# Send Username And character's Graphic Name
				send += "@username = '#{self.name}'; @character_name = '#{$game_player.character_name}'; "
				# Sends Map ID, X and Y positions
				send += "@map_id = #{$game_map.map_id}; @x = #{$game_player.x}; @y = #{$game_player.y}; "
				# Sends Name
				send += "@name = '#{$game_party.actors[0].name}'; " if User_Edit::Bandwith >= 1
				# Sends Direction
				send += "@direction = #{$game_player.direction}; " if User_Edit::Bandwith >= 2
				# Sends Move Speed
				send += "@move_speed = #{$game_player.move_speed};" if User_Edit::Bandwith >= 3 
				send += "@weapon_id = #{$game_party.actors[0].weapon_id};"
				send += "@armor1_id = #{$game_party.actors[0].armor1_id};"
				send += "@armor2_id = #{$game_party.actors[0].armor2_id};"
				send += "@armor3_id = #{$game_party.actors[0].armor3_id};"
				send += "@armor4_id = #{$game_party.actors[0].armor4_id};"
				send += "@guild = '#{$guild}';"
				
				if $state_trans # 투명
					send += "@is_transparency = true;"
				else
					send += "@is_transparency = false;"
				end
				send += "start(#{self.id});"
				@socket.send("<5>#{send}</5>\n")
				self.send_start_newstats
			end
			
			#--------------------------------------------------------------------------
			# * Send Requested Data
			#-------------------------------------------------------------------------- 
			def self.send_start_request(id)
				send = ""
				# Send Username And character's Graphic Name
				send += "@username = '#{self.name}'; @character_name = '#{$game_player.character_name}'; "
				# Sends Map ID, X and Y positions
				send += "@map_id = #{$game_map.map_id}; @x = #{$game_player.x}; @y = #{$game_player.y}; "
				# Sends Name
				send += "@name = '#{$game_party.actors[0].name}'; " if User_Edit::Bandwith >= 1
				# Sends Direction
				send += "@direction = #{$game_player.direction}; " if User_Edit::Bandwith >= 2
				# Sends Move Speed
				send += "@move_speed = #{$game_player.move_speed};" if User_Edit::Bandwith >= 3 
				send += "@weapon_id = #{$game_party.actors[0].weapon_id};"
				send += "@armor1_id = #{$game_party.actors[0].armor1_id};"
				send += "@armor2_id = #{$game_party.actors[0].armor2_id};"
				send += "@armor3_id = #{$game_party.actors[0].armor3_id};"
				send += "@armor4_id = #{$game_party.actors[0].armor4_id};"
				send += "@guild = '#{$guild}';"
				
				if $state_trans # 투명
					send += "@is_transparency = true;"
				else
					send += "@is_transparency = false;"
				end
				@socket.send("<5>#{send}</5>\n")
				self.send_start_newstats
			end
			
			#--------------------------------------------------------------------------
			# * Send Map Id data
			#-------------------------------------------------------------------------- 
			def self.send_map
				send = ""
				# Sends Map ID, X and Y positions
				send += "@username = '#{self.name}';"
				send += "@character_name = '#{$game_player.character_name}';"
				send += "@map_id = #{$game_map.map_id}; @x = #{$game_player.x}; @y = #{$game_player.y}; "
				# Sends Direction
				send += "@direction = #{$game_player.direction};" if User_Edit::Bandwith >= 2
				send += "@move_speed = #{$game_player.move_speed};" if User_Edit::Bandwith >= 3 
				send += "@weapon_id = #{$game_party.actors[0].weapon_id};"
				send += "@armor1_id = #{$game_party.actors[0].armor1_id};"
				send += "@armor2_id = #{$game_party.actors[0].armor2_id};"
				send += "@armor3_id = #{$game_party.actors[0].armor3_id};"
				send += "@armor4_id = #{$game_party.actors[0].armor4_id};"
				send += "@level = #{$game_party.actors[0].level};"
				send += "@bar_showing = false;" 
				
				if $state_trans # 투명
					send += "@is_transparency = true;"
				else
					send += "@is_transparency = false;"
				end
				@socket.send("<m5>#{send}</m5>\n")
				
				self.send_newstats
			end
			
			def self.send_trans(sw)
				send = ""
				# Send 투명도 여부
				send += "@is_transparency = #{sw};"
				
				@socket.send("<5>#{send}</5>\n")
			end
			
			
			#--------------------------------------------------------------------------
			# * 방향 보냄
			#-------------------------------------------------------------------------- 
			def self.send_direction
				return if @oldd == $game_player.direction
				return if @mapplayers.size == 0
				send = ""
				# Increase Steps if the oldx or the oldy do not match the new ones
				if User_Edit::Bandwith >= 1
					send += "ic;"  if @oldx != $game_player.x or @oldy != $game_player.y
				end
				if @oldd != $game_player.direction 
					send += "@direction = #{$game_player.direction};"  
					@oldd = $game_player.direction
				end
				# Send everything that needs to be sended
				@socket.send("<m5>#{send}</m5>\n")
			end
			#--------------------------------------------------------------------------
			# * Send Move Update
			#-------------------------------------------------------------------------- 
			def self.send_move_change
				
				return if @oldx == $game_player.x and @oldy == $game_player.y
				return if @mapplayers == {}
				send = ""
				# Increase Steps if the oldx or the oldy do not match the new ones
				if User_Edit::Bandwith >= 1
					send += "ic;"  if @oldx != $game_player.x or @oldy != $game_player.y
				end
				# New x if x does not mathc the old one
				if @oldx != $game_player.x
					send += "@x = #{$game_player.x}; @tile_id = #{$game_player.tile_id};"
					@oldx = $game_player.x
				end
				# New y if y does not match the old one
				if @oldy != $game_player.y
					send += "@y = #{$game_player.y}; @tile_id = #{$game_player.tile_id};"
					@oldy = $game_player.y
				end
				# Send the Direction if it is different then before
				if User_Edit::Bandwith >= 2
					if @oldd != $game_player.direction 
						send += "@direction = #{$game_player.direction};"  
						@oldd = $game_player.direction
					end
				end
				# Send everything that needs to be sended
				@socket.send("<m5>#{send}</m5>\n") if send != ""
			end
			
			#--------------------------------------------------------------------------
			# * Send start Stats
			#-------------------------------------------------------------------------- 
			def self.send_start_newstats
				a = $game_party.actors[0]
				hp = a.hp
				sp = a.sp
				agi = a.agi
				eva = a.eva
				pdef = a.base_pdef
				mdef = a.base_mdef
				level = a.level
				maxhp = a.maxhp
				maxsp = a.maxsp
				pci = a.class_name
				
				stats = "@str = #{a.str}; @dex = #{a.dex}; @pci = '#{pci}'; @hp = #{hp}; @sp = #{sp}; @agi = #{agi}; @eva = #{eva}; @pdef = #{pdef}; @mdef = #{mdef}; @level = #{level}; @maxhp = #{maxhp}; @maxsp = #{maxsp};"
				stats += "@character_name = '#{$game_player.character_name}';"
				stats += "@trans_v = #{$game_variables[10]};"
				if $state_trans # 투명
					stats += "@is_transparency = true;"
				else
					stats += "@is_transparency = false;"
				end
				
				@socket.send("<5>#{stats}</5>\n")
			end
			
			#--------------------------------------------------------------------------
			# * Send Stats
			#-------------------------------------------------------------------------- 
			def self.send_newstats
				return if @mapplayers == {}
				
				a = $game_party.actors[0]
				hp = a.hp
				sp = a.sp
				agi = a.agi
				eva = a.eva
				pdef = a.base_pdef
				mdef = a.base_mdef
				level = a.level
				maxhp = a.maxhp
				maxsp = a.maxsp
				pci = a.class_name
				
				stats = "@str = #{a.str}; @dex = #{a.dex}; @pci = '#{pci}'; @hp = #{hp}; @sp = #{sp}; @agi = #{agi}; @eva = #{eva}; @pdef = #{pdef}; @mdef = #{mdef}; @level = #{level}; @maxhp = #{maxhp}; @maxsp = #{maxsp};"
				stats += "@character_name = '#{$game_player.character_name}';"
				stats += "@trans_v = #{$game_variables[10]};"
				if $state_trans # 투명
					stats += "@is_transparency = true;"
				else
					stats += "@is_transparency = false;"
				end
				
				@socket.send("<m5>#{stats}</m5>\n")
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
				# Return if the Id is Yourself
				return if id.to_i == self.id.to_i
				# Return if you are not yet on a Map
				return if $game_map == nil
				
				# Turn Id in Hash into Netplayer (if not yet)
				@players[id] ||= Game_NetPlayer.new 
				# Set the Global NetId if it is not Set yet
				@players[id].do_id(id) if @players[id].netid == -1
				# Refresh -> Change data to new data
				@players[id].refresh(data)      
				
				# If the Player is on the same map...
				if @players[id].map_id == $game_map.map_id
					# Update Map Players
					self.update_map_player(id, data)
				else
					if @mapplayers[id] != nil
						# Remove from Map Players
						self.update_map_player(id, data, true)
					end
				end
			end
			
			#--------------------------------------------------------------------------
			# * Update Map Players
			#-------------------------------------------------------------------------- 
			def self.update_map_player(id, data, kill=false)
				# Return if the Id is Yourself
				return if id.to_i == self.id.to_i
				# If Kill (remove) is true...
				if kill and @mapplayers[id] != nil
					# Delete Map Player
					@mapplayers.delete(id) rescue nil
					if $scene.is_a?(Scene_Map)
						$scene.spriteset.delete(id) rescue nil
					end
					$game_temp.spriteset_refresh = true
					return
				end
				
				if @players[id] != nil
					if @mapplayers[id] == nil
						@mapplayers[id] = @players[id] 
						$game_temp.spriteset_refresh = true 
					end
				else
					if @mapplayers[id] == nil
						@mapplayers[id] = Game_NetPlayer.new
						$game_temp.spriteset_refresh = true
					end
				end
				# Set the Global NetId if it is not Set yet
				if @mapplayers[id].netid == -1
					@mapplayers[id].netid = id 
				end
				# Refresh -> Change data to new data
				@mapplayers[id].refresh(data)
				#Send the player's new stats
			end
			#--------------------------------------------------------------------------
			# * Update Net Actors
			#-------------------------------------------------------------------------- 
			def self.update_net_actor(id,data,actor_id)
				return
				return if id.to_i == self.id.to_i
				# Turn Id in Hash into Netplayer (if not yet)
				@netactors[id] ||= Game_NetActor.new(actor_id)
				# Set the Global NetId if it is not Set yet
				@netactors[id].netid = id if @netactors[id].netid == -1
				# Refresh -> Change data to new data
				@netactors[id].refresh(data)
			end
			#--------------------------------------------------------------------------
			# * Update
			#-------------------------------------------------------------------------- 
			def self.update
				# If Socket got lines, continue
				return unless @socket.ready?
				# 소켓으로 받은 데이터
				for line in @socket.recv(0xffff).split("\n")
					@nooprec += 1 if line.include?("\000\000\000\000") 
					return if line.include?("\000\000\000\000")
					p "#{line}" unless line.include?("<5>") or line.include?("<6>")or not $DEBUG or not User_Edit::PRINTLINES
					# Set Used line to false
					updatebool = false
					#Update Walking
					updatebool = self.update_walking(line) if @login and $game_map != nil
					# Update Ingame Protocol, if LogedIn and Map loaded
					updatebool = self.update_ingame(line)  if updatebool == false and @login and $game_map != nil
					# Update System Protocol, if command is not Ingame
					updatebool = self.update_system(line)  if updatebool == false 
					# Update Admin/Mod Protocol, if command is not System
					updatebool = self.update_admmod(line)  if updatebool == false
					# Update Outgame Protocol, if command is not Admin/Mod
					updatebool = self.update_outgame(line) if updatebool == false
				end
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
			def self.ani(id, number, type = 0, count = 1)
				return if @mapplayers.size == 0
				case type
				when 0
					@socket.send("<27>@ani_id = #{id}; @ani_number = #{number}; count = #{count}</27>\n") # 유저 이펙트
				when 1
					@socket.send("<27>@ani_event = #{id}; @ani_number = #{number}; count = #{count}</27>\n") # 이벤트 이펙트
				end
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
			
			
			#--------------------------------------------------------------------------
			# * 길드 시스템
			#-------------------------------------------------------------------------- 
			def self.guild_message(guild_name, message)
				@socket.send("<Guild_Message>#{guild_name},#{message}</Guild_Message>\n")
			end
			def self.guild_system(guild_name, invite_name)
				@socket.send("<Guild_system>#{guild_name},#{invite_name}</Guild_system>\n")
			end
			#--------------------------------------------------------------------------
			# * 파티 시스템
			#-------------------------------------------------------------------------- 
			def self.party_system(party_name, message, party, invite_name)
				@socket.send("<party_system>#{party_name},#{message},#{party},#{invite_name}</party_system>\n")
			end
			#--------------------------------------------------------------------------
			# * 파티 추방 시스템
			#-------------------------------------------------------------------------- 
			def self.party_delete(party_name, name, message)
				@socket.send("<party_system2>#{party_name},#{name},#{message}</party_system2>\n")
			end
			#--------------------------------------------------------------------------
			# * 교환 시스템
			#-------------------------------------------------------------------------- 
			def self.trade_system(trade_invite, player)
				@socket.send("<trade_system>#{trade_invite},#{player}</trade_system>\n")
			end
			
			#--------------------------------------------------------------------------
			# * Update Admin and Mod Command Recievals -> 18
			#  운영자 명령어
			#-------------------------------------------------------------------------- 
			
			def self.over
				Audio.bgm_fade(800); 
				Audio.bgs_fade(800); 
				Audio.me_fade(800); 
				게임종료; 
				self.close_socket; 
				$scene = nil
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
					self.over
					
				when /<timer_v>(.*)<\/timer_v>/
					t_dir = Dir.entries("./")
					for s in t_dir
						break if User_Edit::SERVERS[0][0] == "127.0.0.1"
						break if User_Edit::TEST
						if(s.include?(".rxproj"))
							Network::Main.socket.send "<chat>#{$game_party.actors[0].name}님이 불법 프로그램 사용으로 종료되었습니다.</chat>\n"
							p "버전이 다릅니다."
							exit!
							break
						end
					end
					@socket.send("<timer_v>ok</timer_v>\n")
					
					
				when /<ki>(.*),(.*),(.*)<\/ki>/
					# Kick All Command
					if $1.to_s == "모두"
						if $3.to_s != $game_party.actors[0].name
							p "운영자의 명령어로 인해 모든 플레이어가 서버에서 강퇴당하였습니다."
							p $2.to_s
							self.over
							
						end
						return true
						# Kick Command
					elsif $1.to_s == $game_party.actors[0].name
						p $2.to_s
						self.over
						
						return true
					end
					return false
				end
				return false
			end
			
			#--------------------------------------------------------------------------
			# * Update all Not-Ingame Protocol Parts -> 0, login, reges
			# 서버에서 보낸 메시지 받는 처리
			#-------------------------------------------------------------------------- 
			def self.update_outgame(line)
				
				case line
					# 제한 처리
				when /<server_msg>(.*)<\/server_msg>/
					p $1
					return true
					
					# 인증
				when /<0 (.*)>(.*) n=(.*)<\/0>/ 
					a = self.authenficate($1,$2)
					@servername = $3.to_s
					return true if a
					
					# 회원가입 처리
				when /<regist>(.*)<\/regist>/
					if $1 == "wi" # 아이디 에러
						Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
							["이미 아이디가 있습니다."],
							["확인"], ["Hwnd.dispose(self)"], "에러")
					elsif $1 == "wn" # 닉네임 에러
						Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
							["이미 이 닉네임은 누군가 사용하고 있습니다."],
							["확인"], ["Hwnd.dispose(self)"], "에러")
					else # 회원가입 성공
						Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
							["회원가입에 성공 하셨습니다."],
							["확인"], ["Hwnd.dispose(self)"], "성공")
						
					end
					return true
					
					# 로그인 결과
				when /<login>(.*),(.*)<\/login>/
					if not @user_test
						if $1 == "allow" and not @user_test
							@login = true
							Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
								["로그인에 성공 하셨습니다."],
								["확인"], ["Hwnd.dispose(self)"], "성공")
							self.get_name
							loop = 0
							loop do
								self.update
								loop += 1
								break if loop == 10000
								break if self.name != "" and self.name != nil and self.id != -1
							end
							self.get_group
							$nickname = $2
							$cha_name = "바람머리"
							유저접속
							
							return true
						elsif $1 == "wu" and not @user_test
							Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
								["아이디를 잘못 입력하셨습니다."],
								["확인"], ["Hwnd.dispose(self)"], "오류")
							$scene.set_status(@status) if $scene.is_a?(Jindow_Login)
							return true
						elsif $1 == "wp" and not @user_test
							Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
								["비밀번호를 잘못 입력하셨습니다."],
								["확인"], ["Hwnd.dispose(self)"], "오류")
							$scene.set_status(@status) if $scene.is_a?(Jindow_Login)
						elsif $1 == "al" and not @user_test == true
							Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
								["이미 로그인 되어 있습니다."],
								["확인"], ["Hwnd.dispose(self)"], "오류")
							return true
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
						return true
					end
					return false
				end
				return false
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
					
					id = data_hash["id"].to_i 
					hp = data_hash["hp"].to_i 
					sp = data_hash["sp"].to_i 
					x = data_hash["x"].to_i 
					y = data_hash["y"].to_i 
					d = data_hash["direction"].to_i 
					res = data_hash["respawn"].to_i
					mon_id = data_hash["mon_id"].to_i 
					
					if $ABS.enemies[id] == nil and mon_id != 0
						create_events(16, x, y, d, id, mon_id)
					end
					
					# 해당 맵에 있는 몹 id의 체력, x, y, 방향을 갱신
					return if $ABS.enemies[id] == nil
					enemy = $ABS.enemies[id]
					enemy.respawn = res
					enemy.hp = hp
					enemy.sp = sp
					
				when /<req_monster>(.*)<\/req_monster>/ # 서버로부터 저장된 몬스터 정보를 받아옴
					# 맵 id, 이벤트 id, 몹 hp, x, y, 방향, 딜레이 시간, 몹 id
					data_hash = parseKeyValueData($1)
					
					if data_hash.size <= 1 # 서버에 저장된 몬스터 데이터가 없을 경우 몬스터를 자체적으로 생성함
						$ABS.getMapMonsterData if $is_map_first # 몬스터 데이터 생성
						return
					end
					
					id = data_hash["id"].to_i 
					hp = data_hash["hp"].to_i 
					sp = data_hash["sp"].to_i 
					x = data_hash["x"].to_i 
					y = data_hash["y"].to_i 
					d = data_hash["direction"].to_i 
					res = data_hash["respawn"].to_i
					mon_id = data_hash["mon_id"].to_i 
					
					if $ABS.enemies[id] == nil and mon_id != nil and mon_id != 0
						create_events(16, x, y, d, id, mon_id)
					end
					
					# 해당 맵에 있는 몹 id의 체력, x, y, 방향을 갱신
					return if $ABS.enemies[id] == nil
					enemy = $ABS.enemies[id]
					event = enemy.event
					
					# 몹 죽었을때 리스폰 시간 적용
					if res != nil 
						if res > 0  
							enemy.respawn = res
						else # 몹 리스폰 시간 됐음
							# hp가 0이었던 경우에만 다시 리스폰
							if hp <= 0
								event.erased = false
								$ABS.rand_spawn(event) # 랜덤 위치 스폰
								event.refresh
								return
							end
						end
					end
					
					enemy.hp = hp
					if enemy.hp <= 0 # 체력이 0이면 죽은거지
						event.erase
						return
					end
					enemy.sp = sp
					
					# 몹 방향과 좌표 적용
					event.moveto(x, y)
					event.direction = d
					
					enemy.aggro = $is_map_first ? true : false
						
				when /<aggro>(.*)<\/aggro>/ # 어그로 공유
					data = $1.split(',')
					# 몬스터 id, 유저 이름
					id = data[0].to_i
					name = data[1].to_s
					
					return if $ABS.enemies[id] == nil
					
					if name == $game_party.actors[0].name
						$ABS.enemies[id].aggro = true
						$ABS.enemies[id].aggro_mash = 5 * 60
					else
						$ABS.enemies[id].aggro = false
					end
					
					
				when /<mon_move>(.*)<\/mon_move>/ # 몹 이동 공유
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					id = data[0].to_i
					d = data[1].to_i
					x = data[2].to_i
					y = data[3].to_i
					
					return if $ABS.enemies[id] == nil
					
					# 해당 맵에 있는 몹 id의 x, y, 방향을 갱신
					$ABS.enemies[id].aggro = false if !$is_map_first
					
					return if $ABS.enemies[id].event.x == x and $ABS.enemies[id].event.y == y
					
					# 몹 이동
					case d
					when 2
						$ABS.enemies[id].event.move_down(true, true)
					when 4
						$ABS.enemies[id].event.move_left(true, true)
					when 6
						$ABS.enemies[id].event.move_right(true, true)
					when 8
						$ABS.enemies[id].event.move_up(true, true)
					end
					if $ABS.enemies[id].event.x != x or $ABS.enemies[id].event.y != y
						$ABS.enemies[id].event.moveto(x,y)
					end
					
					
					# 몬스터 데미지 표시(맵 id, 몹 id, 데미지, 크리티컬)
				when /<mon_damage>(.*)<\/mon_damage>/
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					id = data[0].to_i
					dmg = data[1]
					cri = data[2].to_s
					return true if !$scene.is_a?(Scene_Map)
					return true if $ABS.enemies[id] == nil
					return true if $scene.spriteset == nil
					$ABS.enemies[id].send_damage = false
					
					dmg_arr = dmg.split('|')
					for d in dmg_arr
						$ABS.enemies[id].damage_array.push(d.to_i)
					end
					
					if cri == "true"
						$ABS.enemies[id].critical = true
					elsif cri == "false"
						$ABS.enemies[id].critical = false
					else
						$ABS.enemies[id].critical = cri
					end
					return true
					
					# 플레이어 데미지 표시(맵 id, 네트워크 id, 데미지, 크리티컬)
				when /<player_damage>(.*)<\/player_damage>/
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					id = data[0]
					dmg = data[1]
					cri = data[2].to_s
					
					return true if !$scene.is_a?(Scene_Map)
					return true if @mapplayers[id] == nil
					
					dmg_arr = dmg.split('|')
					for d in dmg_arr
						@mapplayers[id].damage_array.push(d.to_i)
					end
					
					if cri == "true"
						@mapplayers[id].show_critical = true
					elsif cri == "false"
						@mapplayers[id].show_critical = false
					else
						@mapplayers[id].show_critical = cri
					end
					
					return true
					
					# 같은 맵의 유저 또는 몬스터가 보내는 값
					# type,id,skill,skill_type,m_dir
				when /<show_range_skill>(.*)<\/show_range_skill>/	
					return true if !$scene.is_a?(Scene_Map)
					data = $1.split(',')
					# 스킬을 사용하는 타입 (0은 몬스터, 1은 사람), 사용자 id, 스킬 id, 스킬 타입(0은 range, 1은 explode), 스킬 이동 방향
					type = data[0].to_i
					id = data[1].to_i
					skill = $data_skills[data[2].to_i]
					skill_type = data[3].to_i
					m_dir = data[4].to_i
					hit_sw = !$game_switches[302] # pk 여부
					
					case type
					when 0 # 몬스터
						e = $ABS.enemies[id]
						return if e == nil
						case skill_type
						when 0
							$ABS.range.push(Game_Ranged_Skill.new(e.event, e, skill, m_dir))
						when 1
							$ABS.range.push(Game_Ranged_Explode.new(e.event, e, skill, m_dir))
						end
						
					when 1 # 사람
						return if @id == id
						netplayer = @mapplayers[id.to_s]						
						return if netplayer == nil
						case skill_type
						when 0
							$ABS.range.push(Game_Ranged_Skill.new(netplayer, netplayer, skill, m_dir, hit_sw))
						when 1
							$ABS.range.push(Game_Ranged_Explode.new(netplayer, netplayer, skill, m_dir, hit_sw))
						when 2 # 원거리 무기
							$ABS.range.push(Game_Ranged_Weapon.new(netplayer, netplayer, data[2].to_i, m_dir, hit_sw))
						end
					end
					
				end
				
				return false
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
				when /<5 (.*)>(.*)</
					# Update Player
					self.update_net_player($1, $2)
					# If it is first time connected...
					return true if !$2.include?("start")
					# ... and it is not yourself ...
					return true if $1.to_i == self.id.to_i
					# ... and it is on the same map...
					return true if @players[$1].map_id != $game_map.map_id and !$2.include?("start")
					# ...  Return the Requested Information
					self.send_start_request($1.to_i) 
					
					$game_temp.spriteset_refresh = true
					return true
					# Map PLayer Processing
					
					
				when /<netact (.*)>data=(.*) id=(.*)<\/netact>/
					# Return if it is yourself
					return true if $1.to_i == self.id.to_i
					# Update Map Player
					self.update_net_actor($1, $2, $3)
					return true
					
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
						self.ani(@id, ani_id)
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
								info = hk.split(",")
								$ABS.skill_keys[info[0].to_i] = info[1].to_i
							end
						else
							hk = val.split(",")
							$ABS.skill_keys.keys.each_with_index { |k, i| $ABS.skill_keys[k] = hk[i].to_i }
						end
						
						
					when "itemkey_list" # 아이템 핫키
						if val.include?(".")
							val.split(".").each do |hk|
								info = hk.split(",")
								$ABS.item_keys[info[0].to_i] = info[1].to_i
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
						return if !val.include?(".")
						data = val.split "."
						
						for d in data
							next if !d.include?(",")
							id, time = d.split(",").map { |x| x.to_i }
							
							next if SKILL_MASH_TIME[id] == nil							
							SKILL_MASH_TIME[id][1] = time 
							$skill_Delay_Console.write_line(id)
						end
						
					when "buff_mash_list" # 버프 지속시간 갱신
						return if !val.include?(".")
						data = val.split "."
						
						for d in data
							next if !d.include?(",")
							id, time = d.split(",").map { |x| x.to_i }
							
							$game_party.actors[0].buff_time[id] = time
							$skill_Delay_Console.write_line(id)
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
						
						$rpg_skill.base_str = $game_variables[52]
						$rpg_skill.base_agi = $game_variables[53]
						$rpg_skill.base_int = $game_variables[54]
						$rpg_skill.base_dex = $game_variables[55]
						
						@group = "standard"
						if $game_switches[54] # 운영자모드
							p "운영자모드"
							@group = "admin"
						end
						
						$chat.write ("[알림]:'#{$game_party.actors[0].name}'님께서 접속 하셨습니다.", COLOR_WORLD)        
						Network::Main.socket.send("<chat1>[알림]:'#{$game_party.actors[0].name}'님께서 접속 하셨습니다.</chat1>\n")
						self.send_start
						
						$rpg_skill.job_select
						
						$game_map.autoplay
						$game_map.update 
						$scene = Scene_Map.new 
						$login_check = true
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
					
					# id를 600번 변수에 저장 왜?
				when /<idsave>(.*)<\/idsave>/
					$game_variables[600] = $1.to_s
					
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
					n = $1.to_i
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
					$chat.write($1.to_s, COLOR_WORLD) if $scene.is_a?(Scene_Map)
					
					# 일반
				when /<chat1>(.*)<\/chat1>/
					$chat.write($1.to_s, COLOR_NORMAL) if $scene.is_a?(Scene_Map)
					
					# 도움말
				when /<chat2>(.*)<\/chat2>/
					$chat.write($1.to_s, COLOR_HELP) if $scene.is_a?(Scene_Map)
					
					# 말풍선
				when /<map_chat>(.*)&(.*)&(.*)<\/map_chat>/
					return unless $scene.is_a?(Scene_Map)
					
					name, msg, type = $1.to_s, $2.to_s, $3.to_i
					
					@mapplayers.each_value do |player|
						next unless player
						next if name != player.name
						
						msg = "#{name}: #{msg}"
						
						case type
						when 1, 3 # 전체, 스킬
							$chat_b.input(msg, type, 4, player)
						when 2 # 파티
							$chat_b.input(msg, type, 4, player) if $netparty.include?(player.name) 
						end
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
						when 0 # 무기
							$game_party.gain_weapon(id, num)
							$data_weapons.fetch(id, "Unknown").name
						when 1 # 방어구
							$game_party.gain_armor(id, num)
							$data_armors.fetch(id, "Unknown").name
						when 2 # 기타
							$game_party.gain_item(id, num)
							$data_items.fetch(id, "Unknown").name
						end
						
						$console.write_line("◎ 인벤토리에 우편물이 왔습니다. 확인하여 주시길 봐랍니다.")
						$console.write_line("◎ 보낸이 : #{send_name} 보낸 아이템 : #{item_name}#{num}개")
						$console.write_line("◎ 내용 : #{body}", Color.new(65, 105, 0))
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
					Network::Main.socket.send "<chat>'#{$1.to_s}'님께서 감옥으로 갔습니다.</chat>\n"
					if $1.to_s == $game_party.actors[0].name
						$console.write_line("운영자님께서 당신을 감옥으로 보냈습니다.")
						$game_temp.player_new_map_id = 98
						$game_temp.player_new_x = 8
						$game_temp.player_new_y = 4
						$game_temp.player_new_direction = 1
						$game_temp.player_transferring = true
					end
					
				when /<emancipation>(.*)<\/emancipation>/
					Network::Main.socket.send "<chat>'#{$1.to_s}'님께서 감옥에서 석방 되셨습니다.</chat>\n"
					if $1.to_s == $game_party.actors[0].name
						$game_temp.player_new_map_id = 2
						$game_temp.player_new_x = 3
						$game_temp.player_new_y = 5
						$game_temp.player_new_direction = 1
						$game_temp.player_transferring = true
					end
					
				when /<cashgive>(.*),(.*)<\/cashgive>/
					if $1.to_s == $game_party.actors[0].name
						$game_variables[213] += $2.to_i
						$console.write_line("#{$2.to_i}Cash 가 충전되었습니다.")
					end
					
				when /<bigsay>(.*),(.*)<\/bigsay>/
					간단메세지("[세계후] #{$1.to_s} : #{$2.to_s}")
					$chat.write("[세계후] #{$1.to_s} : #{$2.to_s}", COLOR_BIGSAY)
					
					
				when /<respawn>(.*)<\/respawn>/		
					# 맵 id, 몹id, x, y, 방향
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					return true if $game_map.map_id != data[0].to_i
					# 해당 맵에 있는 몹 id의 체력, x, y, 방향을 갱신
					if $ABS.enemies[data[1].to_i] != nil
						# p "#{$ABS.enemies[data[1].to_i]}, #{data[1].to_i}"
						# 몹 죽었을때 리스폰 시간 적용
						event = $ABS.enemies[data[1].to_i].event
						if event != nil
							event.erased = false
							event.moveto(data[2].to_i, data[3].to_i)
							event.direction = data[4].to_i
							$ABS.rand_spawn(event) # 랜덤 위치 스폰
							event.refresh
							$game_map.refresh
						end
					end
					
				when /<enemy_dead>(.*)<\/enemy_dead>/	
					data = $1.split(',')
					id = data[0].to_i
					map_id = data[1].to_i
					npt = data[2]
					
					return if $game_map.map_id != map_id
					return if $ABS.enemies[id] == nil
					return if $ABS.enemies[id].event == nil
					
					enemy = $ABS.enemies[id]
					enemy.hp = 0
					
					event = enemy.event
					event.fade = true
					
					return if npt != $npt # 같은 파티가 아니라면
					
					$game_variables[enemy.id + $mon_val_start] += 1
					case enemy.trigger[0]
					when 1 # 스위치
						$game_switches[enemy.trigger[1]] = true
					when 2 # 변수 조작
						$game_variables[enemy.trigger[1]] += 1
					when 3  # 셀프 스위치
						value = "A" if enemy.trigger[1] == 1
						value = "B" if enemy.trigger[1] == 2
						value = "C" if enemy.trigger[1] == 3
						value = "D" if enemy.trigger[1] == 4
						key = [$game_map.map_id, event.id, value]
						$game_self_switches[key] = true
					end						
					$game_map.refresh	
					
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
					data = $1.split(',')
					id = data[0].to_i
					if data[1].to_i == $game_map.map_id
						if $Drop[id] != nil
							$Drop[id] = nil
							event = $game_map.events[id]
							event.erase
							event = nil
							$game_map.events.delete(event)
						end
					end
					
					# 효과음 실행
				when /<se_play>(.*)<\/se_play>/
					file_name = $1.to_s
					Audio.se_play(file_name, $game_variables[13])
					
					
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
						$game_switches[33] = true # 일본 
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
					$chat.write("(귓속말) #{$1.to_s}", COLOR_WHISPER)
					
				when /<partymessage>(.*),(.*),(.*),(.*)<\/partymessage>/ 
					if $npt == $4.to_s
						$chat.write("(파티말) #{$1.to_s}(#{$2.to_s}) : #{$3.to_s}", COLOR_PARTY)
					end
					
				when /<event_animation>(.*),(.*),(.*)<\/event_animation>/
					if $3.to_i == $game_map.map_id
						$game_map.events[$1.to_i].animation_id = $2.to_i
					end
					return true
					
					
					#-------------------------------------------------------------  
					#---------------------------교환 시스템---------------------------  
					#-------------------------------------------------------------      		
					
				when /<trade_invite>(.*),(.*)<\/trade_invite>/
					if $1.to_s == $game_party.actors[0].name
						Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 82 / 2, 350,
							["'#{$2.to_s}'님께서 교환 신청을 하셨습니다.수락 하시겠습니까?"], ["예", "아니오"],
							["$trade_player = '#{$2.to_s}'; Network::Main.trade_system('#{$1.to_s}', '#{$2.to_s}'); Jindow_Trade.new; $chat.write '#{$2.to_s}님의 교환 신청을 수락 하셨습니다.'; Hwnd.dispose(self)" ,
								"Network::Main.socket.send \"<trade_fail>#{$2.to_s}</trade_fail>\n\"; $chat.write '#{$2.to_s}님의 교환 신청을 거절 하셨습니다.'; Hwnd.dispose(self)"], "교환 신청")
					end
					return true
				when /<trade_system>(.*),(.*)<\/trade_system>/
					if $2.to_s == $game_party.actors[0].name
						$trade_player = $1.to_s
						Jindow_Trade.new
					elsif $1.to_s == $game_party.actors[0].name
						Jindow_Trade.new
					end
					return true
				when /<trade_item>(.*),(.*),(.*),(.*),(.*)<\/trade_item>/ # 교환자, 아이템 id, 개수, 타입, 번호
					if $1.to_s == $game_party.actors[0].name
						id = $2.to_i
						amount = $3.to_i
						type = $4.to_i
						num = $5.to_i
						
						$item_number2[num] = Jindow_Trade_Data.new
						$item_number2[num].id = id
						$item_number2[num].type = type
						$item_number2[num].amount = amount
					end
					return true
				when /<trade_money>(.*),(.*)<\/trade_money>/
					if $1.to_s == $game_party.actors[0].name
						$trade_player_money = $2.to_i
					end
					return true
				when /<trade_okay>(.*)<\/trade_okay>/
					if $1.to_s == $game_party.actors[0].name
						$trade2_ok = 1
						$console.write_line("상대방이 교환 준비 완료 상태입니다.")
					end
				when /<trade_fail>(.*)<\/trade_fail>/
					if $1.to_s == $game_party.actors[0].name
						Jindow_Trade.trade_fail
					end
					return true  
					
					
					#-------------------------------------------------------------  
					#---------------------------파티 시스템---------------------------  
					#-------------------------------------------------------------      
				when /<nptreq>(.*) (.*) (.*) (.*)<\/nptreq>/ # 내 이름, 파티원 목록, 초대한 사람, 파티장
					$n_data = $2
					$n_name = $3
					
					if $game_party.actors[0].name == $1.to_s
						if $netparty.size == 0
							Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 82 / 2, 130,
								["파티 요청 : #{$3.to_s}"], ["예", "아니오"],
								["nptreq($n_name, $n_data); Hwnd.dispose(self)",
									"nptnot($n_name); Hwnd.dispose(self)"], "파티 초대")
						else
							Network::Main.socket.send("<nptno>#{$n_name}</nptno>\n")
						end
					end
					return true
					
				when /<nptno>(.*)<\/nptno>/
					if $game_party.actors[0].name == $1.to_s
						$console.write_line("[파티]:상대방이 파티에 참가할 수 없습니다.")
					end
					return true
					
				when /<nptyes>(.*) (.*)<\/nptyes>/
					if $npt == $1.to_s
						nptyes($2.to_s)
						$console.write_line("[파티]:'#{$2.to_s}'님과 파티가 되었습니다.")
					end
					return true
					
				when /<nptout>(.*) (.*)<\/nptout>/
					return if $npt != $2.to_s
					out_mem = $1.to_s
					
					for netparty in $netparty
						if netparty == out_mem
							if $npt == netparty
								$npt = ""
								$netparty.clear
								nptout
								$console.write_line("[파티]:파티장이 탈퇴하여 파티가 해체되었습니다.")
							else
								$netparty.delete(out_mem)
								nptout
								$console.write_line("[파티]:'#{out_mem}' 님이 파티를 나가셨습니다.")
							end
						end
					end
					return true
					
					# 파티 퀘스트 장소로 이동 (npt, 현재 map_id, 이동할 map_id, x, y)
				when /<npt_move>(.*) (.*) (.*) (.*) (.*)<\/npt_move>/
					return if $npt != $1.to_s
					return if $game_map.map_id != $2.to_i
					$game_temp.player_new_map_id = $3.to_i
					$game_temp.player_new_x = $4.to_i
					$game_temp.player_new_y = $5.to_i
					$game_temp.player_new_direction = 1
					$game_temp.player_transferring = true
					
				when /<nptgain>(.*) (.*)<\/nptgain>/ # 파티장, 몬스터 아이디
					return if $npt != $1.to_s
					return if $game_party.actors[0].hp <= 0
					id = $2.to_i
					enemy = $ABS.enemies[id]
					return if enemy == nil
					$ABS.abs_gain_treasure(enemy, 1)
					
				when /<partyhill>(.*) (.*) (.*) (.*) (.*)<\/partyhill>/  # 시전자이름, 마법번호, 파티크기, 맵번호, 체력/마력(0이면 버프라고 생각)
					map_id = $4.to_i
					return if $npt != $3.to_s
					return if $game_map.map_id != map_id
					return if $netparty.size <= 1 # 파티에 가입한 경우에만
					
					name = $1.to_s
					skill_id = $2.to_i
					heal_v = $5.to_i
					ani_id = $data_skills[skill_id].animation1_id # 스킬 사용 측 애니메이션 id
					
					sw = false
					if not $game_party.actors[0].hp == 0 # 회복 스킬
						sw = true
						$rpg_skill.buff(skill_id, false)
						case skill_id
						when 92 # 공력주입
							$game_party.actors[0].sp += heal_v
						else
							$game_party.actors[0].hp += heal_v
						end								
					else
						case skill_id
						when 120 # 부활
							$game_temp.common_event_id = 24
							sw = true
						end	
					end
					
					if sw
						$game_player.animation_id = ani_id
						self.ani(@id, ani_id)
						$game_party.actors[0].critical = "heal"
						$game_party.actors[0].damage = heal_v
						$console.write_line("#{name}님의 #{$data_skills[skill_id].name}")
					end
					
					return true
					
					#-----------------------------------------------------------------    
					
					#맵아이디, 이벤트 아이디, x좌표, y좌표               
					
				when /<drop_create>(.*)<\/drop_create>/
					data = $1.split(",")
					if data[0].to_i == $game_map.map_id
						보관이벤트(data[1].to_i).moveto(data[2].to_i, data[3].to_i)
					end
					
					
				when /<drop_del>(.*)<\/drop_del>/    #맵아이디, 이벤트 아이디
					data = $1.split(",")
					if data[0].to_i == $game_map.map_id
						for e in $game_map.events.values
							if e.x == data[2].to_i and e.y == data[3].to_i
								e.erase
							end
						end
					end
					
					#-----------------------------------------------------------------      
					return true  
				when /<System_Message>(.*)<\/System_Message>/
					$console.writeline("#{$1.to_s}",Color.new(155, 20, 150))
					
					return true       
					# Chat Recieval
					
					
				when /<27>(.*)<\/27>/
					#@ani_id = #{id}; @ani_number = #{number}; count = #{count} # 유저 이펙트				
					#@ani_event = #{id}; @ani_number = #{number}; count = #{count} # 이벤트 이펙트
					count = 1
					eval($1)
					
					if @ani_event >= 0
						if $game_map.events[@ani_event] != nil
							count.times do
								$game_map.events[@ani_event].ani_array.push(@ani_number)  # 이벤트 애니 공유
							end
						end
					end
					
					if @ani_id.to_i != @id.to_i
						if $ani_character[@ani_id.to_i] != nil # 다른 유저 애니 공유
							$ani_character[@ani_id.to_i].animation_id = @ani_number
						end
					else
						count.times do
							$game_player.ani_array.push(@ani_number) # 각각의 플레이어에게만 보이는 애니메이션 공유.
						end
					end
					
					@ani_id = -1; @ani_number = -1; @ani_event = -1
					#Network::Main.send_newstats
					return true
					
					# Remove Player ( Disconnected )
				when /<9>(.*)<\/9>/
					# Destroy Netplayer and MapPlayer things
					self.destroy($1.to_i)
					# Redraw Mapplayer Sprites
					$game_temp.spriteset_refresh = true
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