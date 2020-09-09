# 신수 스킬 아이디
SINSU_SKILL_ID = 
[
	1, # 신수마법
	10, # 신수 1성
	16, # 신수 2성
	22, # 신수 3성
	30, # 신수 4성
	37 # 신수 5성
]

# 업그레이드 하는 스킬들
UPGRADE_SKILL_ID = {}
UPGRADE_SKILL_ID[1] =	[1, 2, 3, 4, 10, 11, 12, 13, 16, 17, 18, 19, 22, 23, 24, 25, 30, 31, 32, 33, 37, 38, 39, 40] # 신수 마법
UPGRADE_SKILL_ID[2]	= [64, 72, 76] # 십량분법류
UPGRADE_SKILL_ID[3]	= [65, 75] # 뢰마도
UPGRADE_SKILL_ID[4]	= [74, 78, 80] # 십리건곤
UPGRADE_SKILL_ID[5] = [131, 141, 142] # 투명

# 0~15 : 도토리, 토끼고기, 사슴고기, 녹용
# 15~25 : 쥐고기, 박쥐고기, 뱀고기
# 25~35 : 웅담, 호랑이고기
# 35~45 : 여우고기, 산돼지, 숲돼지고기
# 45~55 : 짙은호랑이고기, 돼지의뿔
# 55~85 : 호박, 진호박
# 85~99 : 진호박, 불의혼, 불의결정

REQ_SKILL_DATA = {}
# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
# 전사
REQ_SKILL_DATA[1] = 
[
	[10, 30, 10, 5, 3, 74], 		# 누리의기원
	[13, 10, 10, 26, 5, 6], 		# 누리의힘
	[18, 20, 20, 62, 9, 10], 		# 수심각도
	[20, 20, 20, 74, 9, 10], 		# 십리건곤
	[25, 15, 15, 63, 10, 104], 	# 반영대도
	[32, 15, 15, 64, 11, 12], 	# 십량분법
	[38, 10, 10, 65, 12, 50], 	# 뢰마도
	[42, 10, 10, 21, 19, 20], 	# 바다의기원
	[46, 20, 15, 66, 19, 20], 	# 신수둔각도
	
	[50, 2, 10, 1, 28, 22], 		# 신수마법
	[55, 20, 1, 67, 22, 59], 	# 건곤대나이
	[62, 10, 10, 71, 29, 30], 	# 혼신의힘
	
	[67, 5, 5, 27, 29, 30], 		# 동해의기원
	[71, 20, 20, 72, 29, 30], 	# 구량분법
	[74, 10, 30, 43, 29, 30], 	# 광량돌격
	[81, 5, 5, 10, 29, 30], 		# 신수 1성
	[84, 15, 15, 78, 29, 30],		# 십리건곤 1성
	[86, 10, 30, 75, 29, 30],		# 뢰마도 1성
	[90, 10, 3, 77, 30, 31], 		# 유비후타
	[94, 10, 3, 76, 30, 31], 		# 팔분량법
	[97, 3, 1, 80, 31, 37],			# 십리건곤 2성
	[99, 30, 3, 79, 30, 37],		# 동귀어진
	[99, 30, 3, 140, 30, 37]		# 운기
]

# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
# 주술사
REQ_SKILL_DATA[2] = 
[
	[8, 30, 10, 5, 3, 74], # 누리의기원
	[10, 20, 20, 1, 5, 6], # 신수마법
	[12, 10, 10, 46, 9, 10], # 무장
	[15, 20, 20, 10, 9, 10], # 신수 1성
	[22, 15, 15, 15, 10, 104], # 공력증강
	[25, 10, 15, 16, 104, 11], # 신수 2성
	[28, 10, 10, 47, 11, 12], # 보호
	[32, 10, 10, 21, 11, 50], # 바다의기원
	[37, 20, 5, 22, 50, 19], # 신수 3성
	[42, 5, 5, 26, 19, 20], # 누리의힘
	[45, 10, 10, 27, 19, 20], # 동해의기원
	[52, 10, 10, 28, 20, 22], # 야수
	[56, 10, 3, 29, 22, 28], # 천공의기원
	[62, 10, 5, 30, 29, 30], # 신수 4성
	[65, 5, 5, 34, 29, 30], # 귀환
	[70, 5, 5, 35, 29, 30], # 비호
	[78, 15, 15, 36, 29, 30], # 구름의기원
	[84, 10, 30, 37, 29, 30], # 신수 5성
	[90, 10, 3, 41, 30, 31], # 체마혈식
	[94, 10, 3, 42, 30, 31], # 주술마도
	[97, 3, 1, 43, 31, 37], # 위태응기
	[99, 30, 3, 44, 30, 37] # 헬파이어
]

# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
# 도사
REQ_SKILL_DATA[3] = 
[
	[8, 30, 10, 5, 3, 74], 			# 누리의기원
	[10, 10, 10, 1, 5, 6], 			# 신수마법
	[12, 10, 10, 46, 9, 10], 		# 무장
	[18, 20, 20, 15, 9, 10], 		# 공력증강
	[22, 15, 15, 86, 10, 104], 	# 바다의희원
	[27, 15, 15, 10, 11, 12], 	# 신수 1성
	[32, 10, 10, 47, 12, 50], 	# 보호
	[36, 10, 10, 81, 19, 20], 	# 동해의희원
	[42, 20, 15, 90, 19, 20], 	# 분량방법
	
	[48, 2, 10, 50, 28, 22], 		# 야수수금술
	[54, 20, 1, 83, 22, 59], 		# 천공의희원
	[61, 10, 10, 88, 29, 30], 	# 분량력법
	[67, 15, 15, 89, 29, 30], 		# 구름의희원
	[71, 10, 10, 91, 29, 30], 	# 석화기탄
	[74, 10, 30, 92, 29, 30], 	# 공력주입
	[80, 25, 15, 96, 29, 30], 		# 지진
	[84, 15, 15, 93, 29, 30],		# 태양의희원
	[92, 30, 3, 95, 30, 31],		# 생명의희원
	[96, 3, 3, 94, 31, 37], 		# 금강불체
	[99, 10, 3, 120, 31, 37] 		# 부활
]

# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
# 도적
REQ_SKILL_DATA[4] = 
[
	[8, 30, 10, 5, 3, 74], 			# 누리의기원
	[13, 15, 15, 26, 5, 6], 		# 누리의힘
	[18, 15, 15, 1, 9, 10], 		# 신수마법
	[22, 10, 20, 27, 10, 104], 	# 동해의기원
	[26, 10, 10, 10, 11, 12], 	# 신수마법 1성
	[30, 15, 15, 130, 11, 12],  # 무영보법
	[32, 10, 20, 131, 12, 50], 	# 투명
	[37, 20, 10, 132, 50, 19], 	# 비영승보
	[43, 10, 10, 16, 19, 20], 	# 신수마법 2성
	[50, 15, 15, 29, 19, 20], 	# 천공의기원
	[56, 5, 15, 133, 28, 22], 	# 필살검무
	[64, 10, 15, 64, 22, 29], 	# 십량분법
	[70, 5, 5, 34, 29, 30], 		# 귀환
	[75, 15, 20, 141, 29, 30], 	# 투명 1성
	[80, 10, 10, 28, 29, 30], 	# 야수
	[88, 20, 3, 142, 30, 31], 	# 투명 2성
	[92, 5, 3, 140, 31, 37], 	# 운기
	[99, 5, 3, 134, 31, 37],	# 분신
]

class Rpg_skill
	def update_buff
		if SKILL_BUFF_TIME[140][1] > 0 # 운기 중
			if !$game_player.moving?
				if (Graphics.frame_count % (Graphics.frame_rate) == 0)
					$game_party.actors[0].sp += $game_party.actors[0].maxsp / 10
					$game_player.animation_id = 4
					Network::Main.ani(Network::Main.id, $game_player.animation_id) #애니메이션 공유
				end
			else
				SKILL_BUFF_TIME[140][1] = 1
			end
		end
		
		if SKILL_BUFF_TIME[131][1] > 0 # 투명 중
			SKILL_BUFF_TIME[131][1] = 1 if !$state_trans
		end
		if SKILL_BUFF_TIME[141][1] > 0 # 투명 중
			SKILL_BUFF_TIME[141][1] = 1 if !$state_trans
		end
		if SKILL_BUFF_TIME[142][1] > 0 # 투명 중
			SKILL_BUFF_TIME[142][1] = 1 if !$state_trans
		end
	end
	
	def party_heal(skill_id, heal_v = 1)
		if skill_id == 50 # 야수수금술
			$game_temp.common_event_id = 40
		elsif skill_id == 88 # 분량력법
			$game_party.actors[0].str += 15
		elsif skill_id == 90 # 분량방법
			$game_party.actors[0].agi += 50
		elsif skill_id == 92 # 공력주입
			heal_v = $game_party.actors[0].sp
			$game_party.actors[0].sp = 0
			
		elsif skill_id == 117 # 백호의희원
			heal_v = $game_party.actors[0].sp * 2
			$game_party.actors[0].sp = 0
			
		elsif skill_id == 120 # 부활
			$game_temp.common_event_id = 24
		else
			heal_v = ((heal_v) * (1 + ($game_party.actors[0].int / 1000.0) + ($game_party.actors[0].maxsp / 300000.0))).to_i
		end
		
		ani_id = $data_skills[skill_id].animation1_id # 스킬 사용 측 애니메이션 id
		
		if $netparty.size > 1
			name = $game_party.actors[0].name
			Network::Main.socket.send("<partyhill>#{name} #{skill_id.to_i} #{$npt} #{$game_map.map_id} #{heal_v}</partyhill>\n")
		else
			$game_player.animation_id = ani_id
			Network::Main.ani(Network::Main.id, ani_id)
		end
		$game_party.actors[0].damage = heal_v.to_s
		$game_party.actors[0].critical = "heal"
		$game_party.actors[0].hp += heal_v
	end
	
	def heal(id)
		is_heal = false
		heal_v = 0
		case id
		when 5 # 누리의기원
			heal_v = 75
			is_heal = true
		when 21 # 바다의기원
			heal_v = 100
			is_heal = true
		when 27 # 동해의기원
			heal_v = 170
			is_heal = true
		when 29 # 천공의기원
			heal_v = 300
			is_heal = true
		when 36 # 구름의기원
			heal_v = 500
			is_heal = true
		when 48 # 태양의기원
			heal_v = 1000
			is_heal = true
		when 54 # 태양의기원 1성
			heal_v = 2000
			is_heal = true
		when 55 # 현인의기원
			heal_v = 5000
			is_heal = true
		end
		
		if is_heal
			$game_party.actors[0].critical = "heal"
			$game_party.actors[0].damage = heal_v.to_s
			$game_party.actors[0].hp += heal_v
		end
	end
	
	def buff(id)
		case id 
			# 주술사
		when 26 # 누리의힘
			$game_party.actors[0].str += 20
			
		when 28 # 야수
			$game_temp.common_event_id = 40
			
		when 35 # 비호
			$game_temp.common_event_id = 42
			
		when 42 # 주술마도
			@a = $game_party.actors[0].int / 10
			$game_party.actors[0].int += @a
			
		when 46 # 무장
			$game_party.actors[0].mdef += 7
			$game_party.actors[0].pdef += 7
		when 47 # 보호
			$game_party.actors[0].mdef += 10
			$game_party.actors[0].pdef += 10
			
			# 전사
		when 62  # 수심각도
			$game_party.actors[0].dex += 30
			
		when 63  # 반영대도
			$game_party.actors[0].agi += 30
			
		when 64  # 십량분법
			@b = $game_party.actors[0].str / 10
			$game_party.actors[0].str += @b
			
		when 66  # 신수둔각도
			if $game_switches[1] == true # 청룡
				$game_party.gain_weapon(4, 1)
				$game_party.actors[0].equip(0, 4)
				
			elsif $game_switches[2] == true # 백호
				$game_party.gain_weapon(2, 1)
				$game_party.actors[0].equip(0, 2)
				
			elsif $game_switches[3] == true # 주작
				$game_party.gain_weapon(1, 1)
				$game_party.actors[0].equip(0, 1)
				
			elsif $game_switches[4] == true # 현무
				$game_party.gain_weapon(3, 1)
				$game_party.actors[0].equip(0, 3)
			end
			
		when 71  # 구량분법
			@b = $game_party.actors[0].str / 9
			$game_party.actors[0].str += @b
			
		when 72  # 혼신의힘
			$game_party.actors[0].str += 50
			
		when 76  # 팔량분법
			@b = $game_party.actors[0].str / 8
			$game_party.actors[0].str += @b
			
			# 도사
		when 50 # 야수금술
			self.party_heal(id)
			
		when 88 # 분량력법
			self.party_heal(id)
			
		when 90 # 분량방법
			self.party_heal(id)
			
		when 91 # 석화기탄
			$game_temp.common_event_id = 129
			
		when 94 # 금강불체
			$game_party.actors[0].mdef += 999
			$game_party.actors[0].pdef += 999
			
			# 도적
		when 130 # 무영보법
			$game_party.actors[0].dex += 30
			$game_party.actors[0].agi += 30
			
		when 131, 141, 142 # 투명
			self.투명
			
		when 134 # 분신
			$console.write_line("분신을 생성합니다.")
			
		when 136 # 운상미보
			$game_player.move_speed = 3.5
			Network::Main.socket.send("<5>@move_speed = #{$game_player.move_speed};</5>\n")
			
		when 140 # 운기
			$console.write_line("마력을 회복합니다.")
			
			# 도사 희원류
		when 81 # 동해의희원
			self.party_heal(id, 170)
			
		when 83	# 천공의희원
			self.party_heal(id, 200)
			
		when 86	# 바다의희원	
			self.party_heal(id, 75)
			
		when 87	# 천공의희원	
			self.party_heal(id, 200)
			
		when 89	# 구름의희원	
			self.party_heal(id, 500)
			
		when 93	# 태양의희원
			self.party_heal(id, 1000)
			
		when 92 # 공력주입	
			self.party_heal(id)
			
		when 95	# 생명의희원
			self.party_heal(id, 3000)
			
		when 117 # 백호의희원
			self.party_heal(id)
			
		when 118 # 신령의희원
			self.party_heal(id, 7000)
			
		when 119 # 봉황의희원
			self.party_heal(id, 15000)
			
		when 120 # 부활
			self.party_heal(id)
			
		end
	end
	
	def buff_del(id)
		@a = $game_party.actors[0].int / 10 if @a == nil
		@b = $game_party.actors[0].str / 10 if @b == nil
		case id 
			# 주술사
		when 26 # 누리의힘
			$game_party.actors[0].str -= 20
			
		when 28 # 야수
			$game_temp.common_event_id = 41
			
		when 35 # 비호
			$game_temp.common_event_id = 41
			
		when 42 # 주술마도
			$game_party.actors[0].int -= @a
			
		when 46 # 무장
			$game_party.actors[0].mdef -= 7
			$game_party.actors[0].pdef -= 7
		when 47 # 보호
			$game_party.actors[0].mdef -= 10
			$game_party.actors[0].pdef -= 10
			
			# 전사
		when 62  # 수심각도
			$game_party.actors[0].dex -= 30
			
		when 63  # 반영대도
			$game_party.actors[0].agi -= 30
			
		when 64  # 십량분법
			$game_party.actors[0].str -= @b
			
		when 66  # 신수둔각도
			$game_party.actors[0].equip(0, 0)
			$game_party.lose_weapon(1, 99)
			$game_party.lose_weapon(2, 99)
			$game_party.lose_weapon(3, 99)
			$game_party.lose_weapon(4, 99)
			
		when 71  # 구량분법
			$game_party.actors[0].str -= @b
			
		when 72  # 혼신의힘
			$game_party.actors[0].str -= 50
			
		when 76  # 팔량분법
			$game_party.actors[0].str -= @b
			
			# 도사
		when 50 # 야수금술
			$game_temp.common_event_id = 41
			
		when 88 # 분량력법
			$game_party.actors[0].str -= 15
			
		when 90 # 분량방법
			$game_party.actors[0].agi -= 50	
			
		when 94 # 금강불체
			$game_party.actors[0].mdef -= 999
			$game_party.actors[0].pdef -= 999
			
			# 도적
		when 130 # 무영보법
			$game_party.actors[0].dex -= 30
			$game_party.actors[0].agi -= 30
			
		when 131, 141, 142 # 투명, 1, 2성
			$game_variables[9] = 1
			Network::Main.send_trans(false)
			$state_trans = false
			
		when 134 # 분신
			$console.write_line("분신이 사라집니다.")
			
		when 136 # 운상미보
			$game_player.move_speed = 3
			Network::Main.socket.send("<5>@move_speed = #{$game_player.move_speed};</5>\n")
			
		when 140 # 운기
			$console.write_line("운기가 종료 됩니다.")
			
		end
	end
	
	def 투명
		u_hp = $game_party.actors[0].hp
		u_hp -= u_hp / (20 - $game_variables[10])
		u_hp = 1 if u_hp <= 0
		$game_party.actors[0].hp = u_hp 
		
		$game_variables[9] = 1
		$state_trans = true # 현재 자신이 투명상태인걸 뜻함
		Network::Main.send_trans(true)
	end
	
	def 비영승보(x = $game_player.x, y = $game_player.y, d = $game_player.direction)
		if 비영_passable2?(x, y, d) 
			if 비영_passable?(x, y, d)
				new_x = x + (d == 6 ? 2 : d == 4 ? -2 : 0)
				new_y = y + (d == 2 ? 2 : d == 8 ? -2 : 0)
				
				$game_player.moveto(new_x, new_y) 
				$game_player.direction = 10 - d
				$ABS.player_melee(true)
			else
				r = rand(100)
				new_x = x 
				new_y = y 
				case d
				when 4
					if 비영_passable?(x - 1, y - 1, 2)
						d = 8
						new_x -= 1
						new_y += 1
					elsif 비영_passable?(x - 1, y + 1, 8)
						d = 2
						new_x -= 1
						new_y -= 1
					end
					
				when 6
					if 비영_passable?(x + 1, y - 1, 2)
						d = 8
						new_x += 1
						new_y += 1
					elsif 비영_passable?(x + 1, y + 1, 8)
						d = 2
						new_x += 1
						new_y -= 1
					end
					
				when 2
					if 비영_passable?(x - 1, y + 1, 6)
						d = 4
						new_x += 1
						new_y += 1
					elsif 비영_passable?(x + 1, y + 1, 4)
						d = 6
						new_x -= 1
						new_y += 1
					end
					
				when 8
					if 비영_passable?(x - 1, y - 1, 6)
						d = 4
						new_x += 1
						new_y -= 1
					elsif 비영_passable?(x + 1, y - 1, 4)
						d = 6
						new_x -= 1
						new_y -= 1
					end
				end
				$game_player.moveto(new_x, new_y) 
				$game_player.direction = d
				$ABS.player_melee(true)
			end
		end
	end
	
	# 비영_passable 시작
	def 비영_passable?(x, y, d) # 해당 위치로 이동할 수 있는가?
		# Get new coordinates
		new_x = x + (d == 6 ? 2 : d == 4 ? -2 : 0)
		new_y = y + (d == 2 ? 2 : d == 8 ? -2 : 0)
		# If coordinates are outside of map; impassable
		return false unless $game_map.valid?(new_x, new_y)
		# If through is ON; passable
		return true if @through
		
		return false unless $game_map.passable?(new_x, new_y, 10 - d)
		
		# Loop all events
		for event in $game_map.events.values
			# If event coordinates are consistent with move destination
			if event.x == new_x and event.y == new_y
				unless event.through
					# With self as the player and partner graphic as character; impassable
					return false if event.character_name != ""
				end
			end
		end
		# Loop all players
		for player in Network::Main.mapplayers.values
			# If player coordinates are consistent with move destination
			next if player == nil
			if player.x == new_x and player.y == new_y
				# If through is OFF
				unless player.through
					# If self is player; impassable
					return false if self != $game_player
					# With self as the player and partner graphic as character; impassable
					return false if player.character_name != ""
				end
			end
		end
		# If player coordinates are consistent with move destination
		if $game_player.x == new_x and $game_player.y == new_y
			# If through is OFF
			unless $game_player.through
				# If your own graphic is the character; impassable
				return false if @character_name != ""
			end
		end
		# passable
		return true
	end
	# end
	
	# 비영_passable2 시작
	def 비영_passable2?(x, y, d) # 해당 이벤트를 뛰어 넘을 수 있는가?
		# Get new coordinates
		new_x = x + (d == 6 ? 1 : d == 4 ? -1 : 0)
		new_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
		
		# Loop all events
		for event in $game_map.events.values
			# If event coordinates are consistent with move destination
			if event.x == new_x and event.y == new_y
				# If through is OFF
				next if event.through or event.character_name == ""
				return true
			end
		end
		# Loop all players
		for player in Network::Main.mapplayers.values
			# If player coordinates are consistent with move destination
			next if player == nil
			if player.x == new_x and player.y == new_y
				# If through is OFF
				return false if player.through
				return true
			end
		end
		
		return false
	end
	# 비영_passable2 end
	
	# 해당 스킬을 배우는데 필요한 재료
	def req_skill_item(type, num, s_num) # 직업, 몇 번째 스킬
		# type : 1 전사, 2 주술사, 3 도사, 4 도적
		# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
		
		temp = 0 if $game_switches[1] # 청룡
		temp = 1 if $game_switches[2] # 백호
		temp = 2 if $game_switches[3] # 주작
		temp = 3 if $game_switches[4] # 현무
		
		data = REQ_SKILL_DATA[type][num]
		if data != nil
			if s_num == 1
				$game_variables[26] = data[0]
				$game_variables[28] = data[1]
				$game_variables[29] = data[2]
				$game_variables[32] = data[3]
				$game_variables[32] += temp if SINSU_SKILL_ID.include?(data[3]) 
				$game_variables[34] = data[4]
				$game_variables[35] = data[5]
				
				$game_variables[103] = $game_party.items[data[4]]
				$game_variables[104] = $game_party.items[data[5]]
				
			elsif s_num == 2
				$game_variables[27] = data[0]
				$game_variables[30] = data[1]
				$game_variables[31] = data[2]
				$game_variables[33] = data[3]
				$game_variables[33] += temp if SINSU_SKILL_ID.include?(data[3]) 
				$game_variables[36] = data[4]
				$game_variables[37] = data[5]
				
				$game_variables[105] = $game_party.items[data[4]]
				$game_variables[106] = $game_party.items[data[5]]
			end
		else
			if s_num == 1
				$game_variables[26] = 0
				$game_variables[28] = 0
				$game_variables[29] = 0
				$game_variables[32] = 0
				$game_variables[34] = 0
				$game_variables[35] = 0
				
				$game_variables[103] = 0
				$game_variables[104] = 0
			elsif s_num == 2
				$game_variables[27] = 0
				$game_variables[30] = 0
				$game_variables[31] = 0
				$game_variables[33] = 0
				$game_variables[36] = 0
				$game_variables[37] = 0
				
				$game_variables[105] = 0
				$game_variables[106] = 0
			end
		end
	end
end	
$rpg_skill = Rpg_skill.new


class Game_Actor < Game_Battler
	#--------------------------------------------------------------------------
	# * Learn Skill
	#     skill_id : skill ID
	#--------------------------------------------------------------------------
	alias rpg_skill_learn learn_skill
	def learn_skill(skill_id)
		rpg_skill_learn(skill_id) # 이전 함수 코드 실행
		
		$console.write_line("마법 #{$data_skills[skill_id].name}을(를) 배웠다!") if $global_x >= 26
		
		# 업그레이드 되는 스킬이면 이전 하위 스킬을 지움
		for i in 1..UPGRADE_SKILL_ID.size
			u_skill = UPGRADE_SKILL_ID[i]
			if u_skill.include?(skill_id)
				for j in u_skill
					return if j == skill_id
					if skill_learn?(j)
						forget_skill(j) 
						$console.write_line("이전 마법 #{$data_skills[j].name}은(는) 사라졌다!") if $global_x >= 26
					end
				end
			end
		end
		
		# 투명 등 숙련도 설정
		case skill_id
		when 131
			$game_variables[10] = 0
		when 141
			$game_variables[10] = 1
		when 142
			$game_variables[10] = 2
		end
	end
end