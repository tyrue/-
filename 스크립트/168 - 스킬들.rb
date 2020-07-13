class Rpg_skill
	def party_heal(skill_id, heal_v = 1)
		if skill_id == 50 # 야수수금술
			
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
			$game_party.actors[0].damage = heal_v.to_s
			$game_party.actors[0].critical = "heal"
			Network::Main.socket.send "<27>@ani_map = #{$game_map.map_id}; @ani_number = #{ani_id}; @ani_id = #{Network::Main.id};</27>\n"
			
			$game_party.actors[0].hp += heal_v
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
end	
$rpg_skill = Rpg_skill.new