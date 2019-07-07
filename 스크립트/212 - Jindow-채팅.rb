#----------------------------------------------------------------------------------
# *진도우 스킬창
#----------------------------------------------------------------------------------
class Jindow_Chat_Input < Jindow
	attr_reader :active
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 400, 20)
		self.refresh "Chat_Input"
		self.y = 460
		self.opacity = 0
		@active = false
		@chat_type = "전체"
		@type = J::Type.new(self).refresh(64, 2, self.width - 108, 12)
		@type.set "(대화하려면 Enter 키를 누르세요)"
		@type.view
		@a = J::Button.new(self).refresh(40, @chat_type)
		@a.x = 2
		@b = J::Button.new(self).refresh(20, "▶")
		@b.x = 42
	end
	
	def send_chat
		text = @type.result
		
		# 명령어를 식별
		case text
			
		when /\/도움말/
			$chat.write ("아이탬창:i 정보창:c 시스템창:~ 공격:s 파티:p 길드:G 전체화면:alt+enter", Color.new(65, 105, 0))    
			$chat.write ("현재접속자:L 캐시샵:~  상태창/맵이름 숨기기:E  채팅창 숨기기 : F", Color.new(65, 105, 0)) 
			
		when /\/귓 (.*)/  # 귓속말 상대를 변경
			@whispers = $1.to_s
			$console.write_line("(귓속말 상대 변경):#{$1.to_s}")
			
		when /\/교환 (.*)/ #교환
			if $1.to_s != $game_party.actors[0].name
				if not Hwnd.include?("Trade")
					$console.write_line("'#{$1.to_s}'님에게 교환 신청을 하셨습니다.")
					Network::Main.socket.send "<trade_invite>#{$1.to_s},#{$game_party.actors[0].name}</trade_invite>\n"
				else
					$console.write_line("이미 교환 중 이십니다.")
				end
			else
				$console.write_line("자기 자신에게 교환 신청을 할 수 없습니다.")
			end      
			
		when /\/세계후 (.*)/
			if  $game_variables[212] > 0
				Network::Main.socket.send("<bigsay>#{$game_party.actors[0].name},#{$1.to_s}</bigsay>\n")
				$game_variables[212] -= 1
				$chat.write ("세계후두루마리 남은 보유량: #{$game_variables[212]}", Color.new(65, 105, 0))  
			else
				$chat.write ("세계후두루마리 아이템을 사용하셔야 합니다.", Color.new(65, 105, 0))        
			end
			
			
			# 운영자 전용 명령어 
			
		when /\/소환 (.*)/ #소환 명령어
			if Network::Main.group == 'admin'
				mapid = $game_map.map_id
				x = $game_player.x
				y = $game_player.y
				Network::Main.socket.send "<summon>#{$1.to_s},#{mapid},#{x},#{y}</summon>\n"
			end     
			
		when /\/강퇴 (.*) (.*)/ #강퇴
			if Network::Main.group == 'admin'
				Network::Main.socket.send "<ki>#{$1.to_s},#{$2.to_s},#{$game_party.actors[0].name}</ki>\n"
			end
			
		when /\/골드 (.*)/ #골드 명령어
			if Network::Main.group == 'admin'
				$game_party.gain_gold($1.to_i)
			end
			
		when /\/회복/ #회복 명령어
			if Network::Main.group == 'admin'
				$game_party.actors[0].hp += $game_party.actors[0].maxhp
				$game_party.actors[0].sp += $game_party.actors[0].maxsp
				$game_player.animation_id = 151
			end
			
		when /\/집합/ #서버 안에 있는 유저들 전부 소환 명령어
			if Network::Main.group == 'admin'
				mapid = $game_map.map_id
				x = $game_player.x
				y = $game_player.y
				Network::Main.socket.send "<all_summon>#{mapid},#{x},#{y}</all_summon>\n"
			end 
			
		when /\/공지 (.*)/
			if Network::Main.group == 'admin'
				Network::Main.socket.send "<chat>[공지]: #{$1.to_s}</chat>\n"
			end 
			
		when /\/감옥 (.*)/ # 감옥으로 보내는 명령어
			if Network::Main.group == 'admin'
				Network::Main.socket.send "<prison>#{$1.to_s}</prison>\n"
			end
			
		when /\/석방 (.*)/ # 감옥에 있는 유저 석방 명령어
			if Network::Main.group == 'admin'
				Network::Main.socket.send "<emancipation>#{$1.to_s}</emancipation>\n"
			end
			
		when /\/캐시 (.*) (.*)/ 
			if Network::Main.group == 'admin'
				Network::Main.socket.send "<cashgive>#{$1.to_s},#{$2.to_s}</cashgive>\n"
				$console.write_line("#{$2.to_s}캐시를 유저에게 지급하였습니다.")
			end
			
			
		when /\/운영자모드 1367/
			Network::Main.set_admin
			
		else # 명령어가 아닌 그냥 일반 채팅일때
			
			case @chat_type
				
			when "귓속말"
				if @whispers != nil
					if @whispers == $game_party.actors[0].name
						$console.write_line("자기 자신에게는 귓속말을 할 수 없습니다.")
					else
						name = $game_party.actors[0].name       
						Network::Main.socket.send "<whispers>#{@whispers},#{name},#{text}</whispers>\n"
					end
				else
					$console.write_line("귓속말 할 상대가 없습니다.")
				end
				
				
			when "전체"
				name = $game_party.actors[0].name
				Network::Main.socket.send "<chat1>(전체) #{$game_party.actors[0].name} : #{text},0</chat1>\n" 
				
			when "파티"
				if not $netparty == []
					name = $game_party.actors[0].name 
					name2 = $game_party.actors[0].class_name
					Network::Main.socket.send "<partymessage>#{name},#{name2},#{text},#{$npt}</partymessage>\n"    
				else
					$console.write_line("가입된 파티가 없습니다.")   
				end
				
			end
		end
	end
	
	def update
		super
		if @b.click or Key.trigger?(KEY_TAB)  # 채팅 모드를 변경
			case @chat_type
			when "전체"
				@chat_type = "귓속말"
			when "귓속말"
				@chat_type = "파티"
			when "파티"
				@chat_type = "길드"
			when "길드"
				@chat_type = "전체"
			end
			@a.refresh(40, @chat_type)
			# @type.bluck = true
		elsif Key.trigger?(KEY_ENTER)# 채팅 메세지를 전송
			if not @type.result == ""
				if @active == true
					send_chat
					@type.set "(대화하려면 Enter 키를 누르세요)"
					@type.view
					@type.bluck = false
					@active = false
				else
					@type.set ""
					@type.view
					@type.bluck = true
					@active = true
				end
			else
				@type.set "(대화하려면 Enter 키를 누르세요)"
				@type.view
				@type.bluck = false
				@active = false
			end
		end
	end
end
