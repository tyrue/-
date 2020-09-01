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
			$game_party.actors[0].str += 10
			
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
			
		when 131 # 투명
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
		case id 
			# 주술사
		when 26 # 누리의힘
			$game_party.actors[0].str -= 10
			
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
			
		when 131 # 투명
			$game_variables[9] = 1
			Network::Main.send_trans(false)
			
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
	def req_skill_item(id)
		
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
		rpg_skill_learn(skill_id)
		$console.write_line("#{$data_skills[skill_id].name}을(를) 배웠다!") if $global_x >= 26
	end
end