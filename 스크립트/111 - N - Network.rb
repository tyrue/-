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
					p "운영자모드 off"
					@group = "standard"
				else
					p "운영자모드 on"
					@group = "admin"
					p @group
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
			def self.ani(id, number, type = 0)
				return if @mapplayers.size == 0
				case type
				when 0
					@socket.send("<27>@ani_id = #{id}; @ani_number = #{number};</27>\n") # 유저 이펙트
				when 1
					@socket.send("<27>@ani_event = #{id}; @ani_number = #{number};</27>\n") # 이벤트 이펙트
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
				when /<sever_msg>(.*)<\/sever_msg>/
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
					
					#-----------하우징 시스템 -----------------
					
					
					
					#---------------엔피씨 배치 시스템----------------     
					# (no, mob_id, map_id, direction, x, y)  	
				when /<npc_batch>(.*)<\/npc_batch>/ 
					data = $1.split('.')
					for npc_data in data
						npc_data2 = npc_data.split(',')
						# 데이터 분해
						no = npc_data2[0].to_i
						mob_id = npc_data2[1].to_i
						map_id = $game_map.map_id
						direction = npc_data2[3].to_i
						x = npc_data2[4].to_i
						y = npc_data2[5].to_i
						
						if no != 0
							create_events(no, mob_id, map_id, direction, x, y)
						end
					end
					#return true
				when /<npc_regen>(.*)<\/npc_regen>/
					data = $1.split('.')
					for npc_data in data
						npc_data2 = npc_data.split(',')
						if npc_data2[0].to_i != 0
							if $mob_id[npc_data2[0].to_i] == $game_map.map_id
								$mob_id[npc_data2[0].to_i] = nil
								create_events(npc_data2[0].to_i, npc_data2[1].to_i, npc_data2[2].to_i, npc_data2[3].to_i, npc_data2[4].to_i , npc_data2[5].to_i)
							end
						end
					end
					return true
				when /<npc_move>(.*)<\/npc_move>/
					data = $1.split(',')
					if data[1].to_i == $game_map.map_id
						if data[5].to_s != $game_party.actors[0].name
							$game_map.events[data[0].to_i].direction = data[2].to_i
							$game_map.events[data[0].to_i].moveto(data[3].to_i, data[4].to_i)
						end
					end
					return true
					
				when /<npc_make>(.*)<\/npc_make>/
					data = $1.split('.')
					for npc_data in data
						npc_data2 = npc_data.split(',')
						if npc_data2[0].to_i != 0
							보관이벤트(npc_data2[1].to_i).moveto(npc_data2[2].to_i, npc_data2[3].to_i)
						end
					end
					
					
					
					#-------------------------------------------
					
					
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
					
				when /<req_monster>(.*)<\/req_monster>/ # 서버로부터 저장된 몬스터 정보를 받아옴
					# 맵 id, 몹id, 몹 hp, x, y, 방향, 딜레이 시간
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					return true if $game_map.map_id != data[0].to_i
					# 해당 맵에 있는 몹 id의 체력, x, y, 방향을 갱신
					if $ABS.enemies[data[1].to_i] != nil
						# 몹 죽었을때 리스폰 시간 적용
						if data[6].to_i != nil 
							if data[6].to_i > 0  
								$ABS.enemies[data[1].to_i].respawn = data[6].to_i
							else
								$ABS.enemies[data[1].to_i].event.erased = false
								event = $ABS.enemies[data[1].to_i].event
								event.refresh
								return
							end
						end
						
						# 몹 체력 적용
						if $ABS.enemies[data[1].to_i].hp != data[2].to_i
							$ABS.enemies[data[1].to_i].hp = data[2].to_i
							if $ABS.enemies[data[1].to_i].hp <= 0 # 체력이 0이면 죽은거지
								$ABS.enemies[data[1].to_i].event.erase
								return
							end
						end
						
						# 몹 방향과 좌표 적용
						x = $ABS.enemies[data[1].to_i].event.x
						y = $ABS.enemies[data[1].to_i].event.y
						if x != data[3].to_i and y != data[4].to_i
							$ABS.enemies[data[1].to_i].event.moveto(data[3].to_i, data[4].to_i)
							$ABS.enemies[data[1].to_i].event.direction = data[5].to_i
						end
						
						if $is_map_first
							$ABS.enemies[data[1].to_i].aggro = true
						else
							$ABS.enemies[data[1].to_i].aggro = false
						end
					end
					return true
					
				when /<hp>(.*)<\/hp>/ # 체력 공유
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					return true if $game_map.map_id != data[0].to_i
					# 해당 맵에 있는 몹 id의 체력, x, y, 방향을 갱신
					if $ABS.enemies[data[1].to_i] != nil
						# 몹 체력 적용
						if $ABS.enemies[data[1].to_i].hp != data[2].to_i
							$ABS.enemies[data[1].to_i].hp = data[2].to_i
						end
					end
					return true
					
				when /<aggro>(.*)<\/aggro>/ # 어그로 공유
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					return true if $game_map.map_id != data[0].to_i
					
					if $ABS.enemies[data[1].to_i] != nil
						# 어그로 해제
						$ABS.enemies[data[1].to_i].aggro = false
					end
					return true	
					
				when /<mon_move>(.*)<\/mon_move>/ # 몹 이동 공유
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					return true if $game_map.map_id != data[0].to_i
					# 해당 맵에 있는 몹 id의 x, y, 방향을 갱신
					if $ABS.enemies[data[1].to_i] != nil
						$ABS.enemies[data[1].to_i].aggro = false if $ABS.enemies[data[1].to_i].aggro and !$is_map_first
						x = data[3].to_i
						y = data[4].to_i
						
						if $ABS.enemies[data[1].to_i].event.x == x and $ABS.enemies[data[1].to_i].event.y == y
							return
						end
						
						# 몹 이동
						case data[2].to_i
						when 2
							$ABS.enemies[data[1].to_i].event.move_down(true, true)
						when 4
							$ABS.enemies[data[1].to_i].event.move_left(true, true)
						when 6
							$ABS.enemies[data[1].to_i].event.move_right(true, true)
						when 8
							$ABS.enemies[data[1].to_i].event.move_up(true, true)
						end
						if $ABS.enemies[data[1].to_i].event.x != x or $ABS.enemies[data[1].to_i].event.y != y
							$ABS.enemies[data[1].to_i].event.moveto(x,y)
						end
					end
					return true
					
					# 몬스터 데미지 표시(맵 id, 몹 id, 데미지, 크리티컬)
				when /<mon_damage>(.*)<\/mon_damage>/
					# 같은 맵이 아니면 무시
					return true if !$scene.is_a?(Scene_Map)
					data = $1.split(',')
					return true if $game_map.map_id != data[0].to_i
					return true if $ABS.enemies[data[1].to_i] == nil
					return true if $scene.spriteset == nil
					return true if $scene.spriteset.character_sprites[data[1].to_i] == nil
					
					if data[3].to_s == "true"
						$scene.spriteset.character_sprites[data[1].to_i].damage(data[2], true)
					elsif data[3].to_s == "false"
						$scene.spriteset.character_sprites[data[1].to_i].damage(data[2], false)
					else
						$scene.spriteset.character_sprites[data[1].to_i].damage(data[2], data[3])
					end
					return true
					
					# 플레이어 데미지 표시(맵 id, 네트워크 id, 데미지, 크리티컬)
				when /<player_damage>(.*)<\/player_damage>/
					return true if !$scene.is_a?(Scene_Map)
					# 같은 맵이 아니면 무시
					data = $1.split(',')
					return true if $game_map.map_id != data[0].to_i
					return true if @mapplayers[data[1].to_s] == nil
					return if $scene == nil or $scene.spriteset == nil or $scene.spriteset.network_sprites == nil
					
					if $scene.spriteset.network_sprites[data[1].to_i] != nil
						if data[3].to_s == "true"
							$scene.spriteset.network_sprites[data[1].to_i].damage(data[2], true)
						elsif data[3].to_s == "false"
							$scene.spriteset.network_sprites[data[1].to_i].damage(data[2], false)
						else
							$scene.spriteset.network_sprites[data[1].to_i].damage(data[2], data[3])
						end
					end
					return true
					
					# 같은 맵의 유저 또는 몬스터가 보내는 값
				when /<show_range_skill>(.*)<\/show_range_skill>/	
					return true if !$scene.is_a?(Scene_Map)
					data = $1.split(',')
					# 스킬을 사용하는 타입 (0은 몬스터, 1은 사람), 사용자 id, 스킬 id, 스킬 타입(0은 range, 1은 explode)
					type = data[0].to_i
					id = data[1].to_i
					skill = $data_skills[data[2].to_i]
					skill_type = data[3].to_i
					
					case type
					when 0
						e = $ABS.enemies[id]
						return if e == nil
						case skill_type
						when 0
							$ABS.range.push(Game_Ranged_Skill.new(e.event, e, skill))
						when 1
							$ABS.range.push(Game_Ranged_Explode.new(e.event, e, skill))
						end
						
					when 1
						return if @id == id
						netplayer = @mapplayers[id.to_s]						
						return if netplayer == nil
						case skill_type
						when 0
							$ABS.range.push(Game_Ranged_Skill.new(netplayer, netplayer, skill, true))
						when 1
							$ABS.range.push(Game_Ranged_Explode.new(netplayer, netplayer, skill, true))
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
					
					# Attacked!
				when /<attack_effect>(.*)<\/attack_effect>/
					return if !$game_switches[302] # pk off
					data = $1.split(",")
					return if data[0] != @id
					
					$game_party.actors[0].attack_effect(@players[data[1]]) if @players[data[1]] != nil
					
					# Attacked!
				when /<skill_effect>(.*)<\/skill_effect>/
					data = $1.split(",")
					return if data[0] != @id
					return if @players[data[1]] == nil
					
					actor = $game_party.actors[0]
					actor.effect_skill(@players[data[1]], $data_skills[data[2].to_i]) if $game_switches[302]
					range_skill = $ABS.RANGE_SKILLS[data[2].to_i]
					
					$ABS.jump($game_player, @players[data[1]], range_skill[4]) if actor.damage != "Miss" and actor.damage != 0 and range_skill != nil and range_skill[4] != 0
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
					
				when /<dataload>(.*)<\/dataload>/
					$global_x += 1
					#이름
					$name = $1.to_s if $global_x == 2
					#직업
					$game_party.actors[0].class_id = $1.to_i if $global_x == 3
					#레벨
					$game_party.actors[0].level = $1.to_i if $global_x == 4
					#경험치
					$game_party.actors[0].exp = $1.to_i if $global_x == 5
					#스텟
					$str = $1.to_i if $global_x == 6
					$dex = $1.to_i if $global_x == 7
					$agi = $1.to_i if $global_x == 8
					$int = $1.to_i if $global_x == 9
					#최대체력/마력
					$game_party.actors[0].maxhp = $1.to_i if $global_x == 10
					$game_party.actors[0].maxsp = $1.to_i if $global_x == 11
					#맵아이디 ,좌표, 방향
					$new_id = $1.to_i if $global_x == 12
					$new_x = $1.to_i if $global_x == 13
					$new_y = $1.to_i if $global_x == 14
					$new_d = $1.to_i if $global_x == 15
					$charp = $1.to_s if $global_x == 16
					
					#착용 장비
					$armedweapon = $1 if $global_x == 17
					$armedarmor1 = $1 if $global_x == 18
					$armedarmor2 = $1 if $global_x == 19
					$armedarmor3 = $1 if $global_x == 20
					$armedarmor4 = $1 if $global_x == 21
					
					# 아이템
					if $global_x == 22
						item = []
						item = $1.split('.')
						for data in item
							info = data.split(',')
							if info[0].to_i != nil and info[0].to_i != 0 and info[0].to_i != ""
								$game_party.gain_item(info[0].to_i, info[1].to_i)
							end
						end
					end
					
					#무기
					if $global_x == 23
						weapon = []
						weapon = $1.split('.')
						for data2 in weapon
							info1 = data2.split(',')
							if info1[0].to_i != nil and info1[0].to_i != 0 and info1[0].to_i != ""
								$game_party.gain_weapon(info1[0].to_i, info1[1].to_i)
							end
						end
					end    
					
					# 방어구
					if $global_x == 24
						armor = []
						armor = $1.split('.')
						for data3 in armor
							info2 = data3.split(',')
							if info2[0].to_i != nil and info2[0].to_i != 0 and info2[0].to_i != ""
								$game_party.gain_armor(info2[0].to_i, info2[1].to_i)
							end
						end
					end
					
					
					#스킬 리스트				
					if $global_x == 25						
						skill = []						
						skill = $1.split(',')					
						for skill_code in skill													
							if skill_code.to_i > 0				
								$game_party.actors[0].learn_skill(skill_code.to_i)				
							end							
						end						
					end
					
					# 금전
					$game_party.gain_gold($1.to_i) if $global_x == 26
					
					#현재 체력
					$game_party.actors[0].hp = $1.to_i if $global_x == 27
					
					#현재 마력
					$game_party.actors[0].sp = $1.to_i if $global_x == 28  
					
					# 스위치
					if $global_x == 29
						sw = []
						sw = $1.split ","
						for i in 0..sw.size
							if sw[i] == "1"
								$game_switches[i] = true
							elsif sw[i] == "0"
								$game_switches[i] = false
							end
						end
					end
					
					
					# 변수
					if $global_x == 30
						va = []
						va = $1.split ","
						for i in 0..va.size
							$game_variables[i] = va[i].to_i
						end
					end
					
					# 스킬 핫키
					if $global_x == 31
						hk = [] # 핫키 리스트 배열
						hk = $1.split ","
						i = 0
						for key in $ABS.skill_keys.keys
							$ABS.skill_keys[key] = hk[i].to_i
							i += 1
						end
					end
					
					# 아이템 핫키
					if $global_x == 32
						hk = [] # 핫키 리스트 배열
						hk = $1.split ","
						i = 0
						for key in $ABS.item_keys.keys
							$ABS.item_keys[key] = hk[i].to_i
							i += 1
						end
					end
					
					# pdef
					$game_party.actors[0].pdef = $1.to_i if $global_x == 33
					
					# mdef
					if $global_x == 34
						$game_party.actors[0].mdef = $1.to_i 
					end
					
					# 스킬 딜레이 갱신
					if $global_x == 35
						return if $1.to_s == "*null*"
						data = []
						data = $1.split "."
						for d in data
							break if d == "*null*"
							i = []
							i = d.split ","
							SKILL_MASH_TIME[i[0].to_i][1] = i[1].to_i if i[1] != nil and SKILL_MASH_TIME[i[0].to_i] != nil
						end
					end
					
					# 버프 지속시간 갱신
					if $global_x == 36
						return if $1.to_s == "*null*"
						data = []
						data = $1.split "."
						for d in data
							break if d == "*null*"
							i = []
							i = d.split ","
							SKILL_BUFF_TIME[i[0].to_i][1] = i[1].to_i if i[1] != nil and SKILL_BUFF_TIME[i[0].to_i] != nil
						end
					end
					if $global_x == 37
						$cha_name = $1.to_s
					end
					
				when /<dataLoadEnd>(.*)<\/dataLoadEnd>/	
					$cha_name = "바람머리" if $cha_name == nil or $cha_name == "*null*"
					
					# 데이터 로드 완료
					$game_party.actors[0].name = $name
					$game_map.setup($new_id) 
					$game_player.moveto($new_x, $new_y) 
					$game_player.direction = $new_d
					$game_party.actors[0].set_graphic($charp, 0, 0, 0) # 캐릭터 칩 설정
					
					$game_party.gain_weapon($armedweapon.to_i,1)
					$game_party.gain_armor($armedarmor1.to_i,1)
					$game_party.gain_armor($armedarmor2.to_i,1)
					$game_party.gain_armor($armedarmor3.to_i,1)
					$game_party.gain_armor($armedarmor4.to_i,1)
					
					$game_party.actors[0].equip(0, $armedweapon.to_i)
					$game_party.actors[0].equip(1, $armedarmor1.to_i)
					$game_party.actors[0].equip(2, $armedarmor2.to_i)
					$game_party.actors[0].equip(3, $armedarmor3.to_i)
					$game_party.actors[0].equip(4, $armedarmor4.to_i)
					
					$game_party.lose_weapon(1,1)
					$game_party.actors[0].str = $str
					$game_party.actors[0].dex = $dex
					$game_party.actors[0].agi = $agi
					$game_party.actors[0].int = $int
					$game_player.refresh
					
					
					if $game_party.actors[0].name == "/no"
						p "데이터 로드에 실패했습니다. 다시 실행해주세요."
						exit
					else
						$chat.write ("[알림]:'#{$game_party.actors[0].name}'님께서 접속 하셨습니다.", COLOR_WORLD)        
						Network::Main.socket.send("<chat1>[알림]:'#{$game_party.actors[0].name}'님께서 접속 하셨습니다.</chat1>\n")
						
						self.send_start
						$cbig = 0
						$nowtrade = 0
						$game_player.move_speed = 3
						
						$skill_Delay_Console = Skill_Delay_Console.new(520, 0, 140, 110, 6)
						$skill_Delay_Console.show
						
						$rpg_skill.job_select
						$game_map.autoplay
						$game_map.update 
						$scene = Scene_Map.new 
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
						val = data.split(',')
						if val[1].to_i == 1
							$game_switches[val[0].to_i] = true 
						else
							$game_switches[val[0].to_i] = false
						end
						
						$game_map.need_refresh = true
					end
					
					# id를 600번 변수에 저장 왜?
				when /<idsave>(.*)<\/idsave>/
					$game_variables[600] = $1.to_s
					
					# 변수 공유
				when /<variables>(.*)<\/variables>/
					variables_data = $1.split('.')
					for data in variables_data
						val = data.split(',')
						$game_variables[val[0].to_i] = val[1].to_i
						$game_map.need_refresh = true
					end
					
					# 경험치 이벤트 확인
				when /<exp_event>(.*)<\/exp_event>/
					n = $1.to_i
					if n > 0
						$chat.write ("<현재 경험치 #{n}배 이벤트가 진행중 입니다.>", COLOR_EVENT) 
						$game_switches[1500] = true
						$exp_event = n
					else
						$chat.write ("<현재 경험치 이벤트가 종료되었습니다.>", COLOR_EVENT) 
						$game_switches[1500] = false
						$exp_event = 0
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
					if $scene.is_a?(Scene_Map)
						$chat.write($1.to_s, COLOR_WORLD)
						$game_temp.chat_log.push($1.to_s)
						$game_temp.chat_refresh = true						
					end
					return true
					
					# 일반
				when /<chat1>(.*)<\/chat1>/
					if $scene.is_a?(Scene_Map)
						$chat.write($1.to_s, COLOR_NORMAL)
						$game_temp.chat_log.push($1.to_s)
						$game_temp.chat_refresh = true
					end	
					
				when /<map_chat>(.*)&(.*)&(.*)<\/map_chat>/
					if $scene.is_a?(Scene_Map)
						for player in @mapplayers.values
							next if player == nil
							if $1.to_s == player.name
								$chat_b.input(player.name + ": " + $2.to_s, $3.to_i, 4, player)
							end
						end
					end		
					
					# 현재 맵에 내가 기준인지 확인
				when /<map_player>(.*)<\/map_player>/
					if $1.to_i == 1
						$is_map_first = true
					else
						$is_map_first = false
					end
					
					for e in $ABS.enemies.values
						e.aggro = $is_map_first
					end
					return true
					
					# 우편 배송 (id, 아이템 id, 템 종류, 보낸이 id, 개수, 편지 내용)
				when /<post>(.*),(.*),(.*),(.*),(.*),(.*)<\/post>/
					if $scene.is_a?(Scene_Map)
						if $1.to_s == $game_party.actors[0].name
							case $3.to_i
							when 0#무기
								$game_party.gain_weapon($2.to_i, $5.to_i)
								$console.write_line("◎ 인벤토리에 우편물이 왔습니다.확인하여 주시길 봐랍니다.")
								$console.write_line("◎ 보낸이 : #{$4.to_s} 보낸 아이템 : #{$data_weapons[$2.to_i].name} x #{$5.to_i}")
								$console.write_line("◎ 내용 : #{$6.to_s}", Color.new(65,105, 0))
							when 1#방어구
								$game_party.gain_armor($2.to_i, $5.to_i)
								$console.write_line("◎ 인벤토리에 우편물이 왔습니다.확인하여 주시길 봐랍니다.")
								$console.write_line("◎ 보낸이 : #{$4.to_s} 보낸 아이템 : #{$data_armors[$2.to_i].name} x #{$5.to_i}")
								$console.write_line("◎ 내용 : #{$6.to_s}", Color.new(65,105, 0))
							when 2#기타
								$game_party.gain_item($2.to_i, $5.to_i)
								$console.write_line("◎ 인벤토리에 우편물이 왔습니다.확인하여 주시길 봐랍니다.")
								$console.write_line("◎ 보낸이 : #{$4.to_s} 보낸 아이템 : #{$data_items[$2.to_i].name} x #{$5.to_i}")
								$console.write_line("◎ 내용 : #{$6.to_s}", Color.new(65,105, 0))
							end
						end
					end
					return true
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
					
				when /<enemy_dead>(.*),(.*),(.*),(.*)<\/enemy_dead>/	
					id = $1.to_i # 적 id
					event_id = $2.to_i # 이벤트 id
					map_id = $3.to_i
					npt = $4.to_i
					
					if $game_map.map_id == map_id
						if $ABS.enemies[id] != nil and (npt.to_i != $npt.to_i or $netparty.size < 2)
							$game_map.events[event_id].fade = true
							$ABS.enemies[id].hp = 0
						elsif $ABS.enemies[id] != nil and npt.to_i == $npt.to_i # 같은 파티라면
							enemy = $ABS.enemies[id]
							event = enemy.event
							$game_map.events[event_id].fade = true
							$ABS.enemies[id].hp = 0
							
							case enemy.trigger[0]
							when 1 # 스위치
								$game_switches[enemy.trigger[1]] = true
							when 2 # 변수 조작
								if enemy.trigger[2] == 0
									$game_variables[enemy.trigger[1]] += 1
								else
									$game_variables[enemy.trigger[1]] = enemy.trigger[2]
								end
							when 3  # 셀프 스위치
								value = "A" if enemy.trigger[1] == 1
								value = "B" if enemy.trigger[1] == 2
								value = "C" if enemy.trigger[1] == 3
								value = "D" if enemy.trigger[1] == 4
								key = [$game_map.map_id, event.id, value]
								$game_self_switches[key] = true
							end						
							$game_map.refresh	
						end
					end
					
					
					# 템 드랍 
					#drop 번호, 아이템 타입1, 아이템 타입2, 아이템 id, 맵 아이디, x좌표, y좌표, 개수
				when /<Drop>(.*)<\/Drop>/
					data = $1.split(',')
					index = data[0].to_i
					map_id = data[4].to_i
					
					if map_id == $game_map.map_id
						$Drop[index] = Drop.new
						$Drop[index].id = data[3].to_i
						$Drop[index].type = data[2].to_i
						$Drop[index].type2 = data[1].to_i
						$Drop[index].amount = data[7].to_i #아이템 개수
						x = data[5].to_i
						y = data[6].to_i
						
						if $Drop[index].type2 == 1 # 일반 아이템
							name = ""
							if $Drop[index].type == 0
								image = $data_items[$Drop[index].id].icon_name
								name = $data_items[$Drop[index].id].name
							elsif $Drop[index].type == 1
								image = $data_weapons[$Drop[index].id].icon_name
								name = $data_weapons[$Drop[index].id].name
							elsif $Drop[index].type == 2
								image = $data_armors[$Drop[index].id].icon_name
								name = $data_armors[$Drop[index].id].name
							end
							create_drops2(index, 138, map_id, x, y, image, name, $Drop[index].amount)
						elsif $Drop[index].type2 == 0 # 돈
							create_moneys2(index, 138, map_id, x, y, $Drop[index].amount)
						end
					end
					
				when /<Drop_Get>(.*)<\/Drop_Get>/
					data = $1.split(',')
					id = data[0].to_i
					if data[1].to_i == $game_map.map_id
						if $Drop[id] != nil
							$Drop[id] = nil
							$game_map.events[id].erase
						end
					end
					
					# 파티퀘스트 입장 여부 확인 : 스위치 번호, 1/0
				when /<party_quest_check>(.*)<\/party_quest_check>/
					data = $1.split(',')
					id = data[0].to_i
					sw = data[1].to_i
					sw == 1 ? $game_switches[id] = true : $game_switches[id] = false
					
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
					
				when /<whispers>(.*),(.*),(.*)<\/whispers>/ 
					if $1.to_s == $game_party.actors[0].name
						$chat.write("(귓속말) #{$2.to_s} : #{$3.to_s}", COLOR_WHISPER)
					elsif $2.to_s == $game_party.actors[0].name
						$chat.write("(귓속말) #{$1.to_s} <<< #{$3.to_s}", COLOR_WHISPER)
					end
					
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
					
					
				when /<nptgain>(.*) (.*) (.*) (.*) (.*)<\/nptgain>/ # 경험치, 돈, 파티장, 맵의 파티원 수, 몬스터 아이디
					if $npt == $3.to_s
						return if $game_party.actors[0].hp <= 0 
						actor = $game_party.actors[0]
						exp = $1.to_i
						gold = $2.to_i
						in_map_player = $4.to_i
						
						if(exp > (actor.exp_list[actor.level + 1] - actor.exp_list[actor.level]) / $exp_limit and actor.level <= 99)
							exp = (actor.exp_list[actor.level + 1] - actor.exp_list[actor.level]) / $exp_limit
						end 
						
						exp = (exp * 1.5).to_i / in_map_player
						gold = (gold * 1.5).to_i / in_map_player
						
						actor.exp += exp
						$game_party.gain_gold(gold)
						$console.write_line("[파티]:경험치:#{exp} 금전:#{gold} (#{((actor.exp + exp - actor.exp_list[actor.level]) * 1.0 / (actor.exp_list[actor.level + 1] - actor.exp_list[actor.level]) * 100).to_i}%)")
					end
					
					return true
					#-----------------------------------------------------------------------      
				when /<partyhill>(.*) (.*) (.*) (.*) (.*)<\/partyhill>/  # 시전자이름, 마법번호, 파티크기, 맵번호, 체력/마력(0이면 버프라고 생각)
					if $npt == $3.to_s
						map_id = $4.to_i
						if $game_map.map_id == map_id
							if $netparty.size > 1 # 파티에 가입된 경우에만
								name = $1.to_s
								skill_id = $2.to_i
								heal_v = $5.to_i
								ani_id = $data_skills[skill_id].animation1_id # 스킬 사용 측 애니메이션 id
								if not $game_party.actors[0].hp == 0 # 회복 스킬
									$game_player.animation_id = ani_id
									$rpg_skill.buff(skill_id)
									$ABS.skill_console(skill_id) # 스킬 표시
									
									case skill_id
									when 92 # 공력주입
										$game_party.actors[0].sp += heal_v
									else
										$game_party.actors[0].hp += heal_v
										$game_party.actors[0].critical = "heal"
										$game_party.actors[0].damage = heal_v
									end								
									self.ani(@id, ani_id)
									$console.write_line("#{name}님의 #{$data_skills[skill_id].name}")	
								else
									case skill_id
									when 120 # 부활
										$game_player.animation_id = ani_id
										$game_temp.common_event_id = 24
										self.ani(@id, ani_id)	
										$console.write_line("#{name}님의 #{$data_skills[skill_id].name}")	
									end	
								end
							end
						end
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
					#@ani_event = #{e.event.id}; @ani_number = #{a}; @ani_map = #{$game_map.map_id} # 몹 이벤트
					#@ani_id = #{Network::Main.id}; @ani_number = #{e.event.animation_id}; @ani_map = #{$game_map.map_id} # 자신 이벤트
					eval($1)
					
					if @ani_event >= 0
						if $game_map.events[@ani_event] != nil
							$game_map.events[@ani_event].animation_id = @ani_number # 이벤트 애니 공유
						end
					end
					
					if @ani_id.to_i != @id.to_i
						if $ani_character[@ani_id.to_i] != nil # 다른 유저 애니 공유
							$ani_character[@ani_id.to_i].animation_id = @ani_number 
						end
					else
						$game_player.animation_id = @ani_number # 각각의 플레이어에게만 보이는 애니메이션 공유.
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