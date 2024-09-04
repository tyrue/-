# -------------END----------------- #

# ----------------------------------#
# ----- 몬스터 스킬 주문 외우는 데이터---------#
# ----------------------------------#
#															[[시간초, "주문", (색깔 타입), (애니메이션 id)], []...]
ABS_ENEMY_SKILL_CASTING = {}
ABS_ENEMY_SKILL_CASTING[151] = [[1, "멀리 날려주마!!!!"]] # 청룡의 포효
ABS_ENEMY_SKILL_CASTING[152] = [[1, "물러나라..!"]] # 현무의 포효
ABS_ENEMY_SKILL_CASTING[153] = [[0.5, "!백호검무!!!!"]] # 백호검무
ABS_ENEMY_SKILL_CASTING[154] = [[1.3, "여의주의 힘을 받은 용이여..."], [1.3, "그대 이름은 청룡일지다..."], [1.3, "네 주인 이름으로 명하노니"], [1, "네 분노를 적에게 발산하라!"]] # 청룡마령참
ABS_ENEMY_SKILL_CASTING[155] = [[3, "암흑에 물들어라.."]] # 암흑진파
ABS_ENEMY_SKILL_CASTING[156] = [[2, "명계의 검은 용이여...!"], [1, "지금, 계약에 따라 소환될지어다!!"]] # 흑룡광포
ABS_ENEMY_SKILL_CASTING[158] = [[4, "지옥에서 불타버려라!!"]] # 지옥겁화
ABS_ENEMY_SKILL_CASTING[159] = [[2, "미천한 필멸자여.."], [1, "하늘 높은 줄 모르고 날뛰는구나.."], [0.5, "너의 나약함을 깨닫게 하리라!!"]] # 혈겁만파
ABS_ENEMY_SKILL_CASTING[160] = [[1.5, "바람처럼 나타나 그림자처럼 사라지리라..."], [1.5, "이 순간, 모든 것을 내 검 아래 휩쓸테니...!"], [0.5, "압도적인 힘에 절망하라!!"]] # 분혼경천
ABS_ENEMY_SKILL_CASTING[161] = [[1.5, "영원한 공허의 무수한 파편들이여.."], [1.3, "대지와 하늘의 연결을 허용하노니..."], [1, "지금 이 땅의 운명을 새로 써내려라!!!"]] # 폭류유성
# -------------END----------------- #

# -------------END----------------- #

# $game_variables[19] 플레이어 힘
# $game_variables[20] 플레이어 민첩
# $game_variables[21] 플레이어 지력
# $game_variables[22] 플레이어 손재주

class Rpg_skill
	attr_accessor :base_str
	attr_accessor :base_int
	attr_accessor :base_agi
	attr_accessor :base_dex
	attr_accessor :player_base_move_speed
	attr_accessor :battler 
	attr_accessor :character
	
	def initialize(battler = nil)
		@base_str = 0
		@base_agi = 0
		@base_int = 0
		@base_dex = 0
		@base_move_speed = 3
		
		@battler = battler
		@character = case @battler
		when Game_Actor then $game_player
		when ABS_Enemy then @battler.event
		when Game_NetPlayer then @battler
		end
	end
	
	def process_skill(id, is_my = true, enemy = nil)
		skill = $data_skills[id]
		self.buff(id, is_my) # 이게 버프 스킬인지 확인
		self.debuff(id, is_my) # 이게 디버프 스킬인지 확인
		self.heal(id, is_my) # 이게 회복 스킬인지 확인
		self.active_skill(id, enemy) # 액티브 스킬 행동 커스텀 확인
		self.skill_chat(skill) # 스킬 사용시 말하는 것
	end
	
	def update
		self.update_buff
	end
	
	def update_buff() # 버프 지속 효과 (일정 주기마다 해야하는 것 등)
		sec = Graphics.frame_rate
		
		@battler.buff_time.each do |id, time|
			next if time <= 0 # 버프가 끝난상태면 무시
			
			data = $rpg_skill_data[id]		
			next unless data.cycle_time
			
			if data.is_move_stop && @character.moving?
				@battler.buff_time[id] = 1
				next
			end	
			next unless (Graphics.frame_count % (sec * data.cycle_time)).zero?
			
			ani_id = data.cycle_animation || data.skill_data.animation1_id 
			@character.ani_array.push(ani_id) if ani_id
			next unless data.cycle_action
			
			data.cycle_action.each do |action, s_id|
				s_id ||= id
				
				case action
				when "heal" then heal(s_id)
				when "heal_debuff" then heal_debuff(s_id)
				when "buff" then buff(s_id)
				end
			end 
		end
	end
	
	def check_speed_buff()
		speed = 0
		for data in @battler.buff_time
			next if data[1] <= 0 # 버프가 끝난상태면 무시
			id = data[0]
			next if $rpg_skill_data[id].buff_data == nil
			
			buff_data = $rpg_skill_data[id].buff_data
			buff_data.each do |d|
				speed += d[1] if d[0] == "speed"
			end
		end
		return speed
	end
	
	# 파티 버프
	def party_buff(id)
		return unless @character == $game_player
		
		ani_id = $data_skills[id].animation1_id # 스킬 사용 측 애니메이션 id
		@character.ani_array.push(ani_id)
		
		data = {
			"id" => id,
			"value" => 0
		}
		message = data.map { |key, value| "#{key}:#{value}" }.join("|")
		Network::Main.send_with_tag("party_heal", message)
	end
	
	# 자기 힐
	def heal(id, my_heal = true, value = 0)
		data = $rpg_skill_data[id]
		return unless data.type.include?("heal")
		return if data.type.include?("debuff")
		return heal_process(data, value) unless my_heal 
		
		heal_v = data.heal_value
		heal_arr = data.heal_value_per # [타입, hp, sp]
		
		if heal_arr
			t, h, s = heal_arr
			heal_v += case t
			when 0 then @battler.hp * h + @battler.sp * s # 현재
			when 1 then @battler.maxhp * h + @battler.maxsp * s # 전체
			end
		end
		
		heal_v += ((@battler.maxhp + @battler.maxsp * 2) * 0.001)
		heal_v *= (1.0 + @battler.atk / 100.0) * (1 + (@battler.int / 1000.0)) if data.is_party
		
		heal_process(data, heal_v)
		skill_cost_custom(id) 
		return unless data.is_party
		
		m_data = {
			"id" => id,
			"value" => heal_v
		}
		message = m_data.map { |key, value| "#{key}:#{value}" }.join("|")
		Network::Main.send_with_tag("party_heal", message)
	end
	
	def heal_debuff(id)
		data = $rpg_skill_data[id]
		return unless (data.type.include?("heal") && data.type.include?("debuff"))
		
		heal_v = data.heal_value
		heal_arr = data.heal_value_per # [타입, hp, sp]
		
		if heal_arr
			t, h, s = heal_arr
			heal_v += case t
			when 0 then @battler.hp * h + @battler.sp * s # 현재
			when 1 then @battler.maxhp * h + @battler.maxsp * s # 전체
			end
		end
		
		heal_process(data, heal_v)
	end
	
	def heal_process(data, heal_v)
		type = data.heal_type
		heal_v = heal_v.to_i
		
		case type
		when "hp"	
			@battler.hp += heal_v
			@battler.critical = "heal"
		when "sp"
			@battler.sp += heal_v
			@battler.critical = "heal_sp"
		when "all"
			@battler.hp += heal_v
			@battler.sp += heal_v
			@battler.critical = "heal"
		when "com"
			$game_temp.common_event_id = data.heal_value
		when "active"
			active_skill(data.id)
		end
		
		@battler.critical = "player_hit" if heal_v < 0
		@battler.damage = heal_v.abs.to_s
		@battler.hp = [@battler.hp, 1].max
		@battler.sp = [@battler.sp, 0].max
	end
	
	# 이미 버프가 걸려있는지 확인
	def check_buff(id)
		return (@battler.buff_time[id] != nil and @battler.buff_time[id] > 0)
	end
	
	# 버프 사용
	def buff_active(id, my_buff = true)
		buff(id, my_buff) # 이게 버프 스킬인지 확인
		debuff(id, my_buff) # 이게 디버프 스킬인지 확인
		@character.ani_array.push($data_skills[id].animation1_id || 0 )  # 스킬 사용 측 애니메이션 id
	end
	
	# 버프
	def buff(id, my_buff = true)
		skill_data = $rpg_skill_data[id]
		return unless skill_data.type.include?("buff")
		return if skill_data.type.include?("debuff")
		
		check_time = check_buff(id)
		buff_time_set = skill_data.buff_time * Graphics.frame_rate
		apply_buff_time(id, buff_time_set)
		party_buff(id) if skill_data.is_party && my_buff
		
		return if check_time
		return unless skill_data.buff_data
		
		skill_data.buff_data.each do |type, val|
			process_buff_effect(type.to_s, val, false, id)
		end
		true
	end
	
	def debuff(id, my_buff = true)
		skill_data = $rpg_skill_data[id]
		return unless skill_data.type.include?("debuff")
		return if my_buff
		
		check_time = check_buff(id)
		buff_time_set = skill_data.buff_time * Graphics.frame_rate
		apply_buff_time(id, buff_time_set)
		
		return if check_time
		return unless skill_data.buff_data
		
		skill_data.buff_data.each do |type, val|
			process_buff_effect(type.to_s, val, false, id)
		end
	end
	
	def apply_buff_time(id, buff_time_set)
		@battler.buff_time[id] = buff_time_set
		$ABS.skill_console(id) if @battler.is_a?(Game_Actor)
	end
	
	def process_buff_effect(type, val, is_close, id)
		case type
		when "str", "dex", "int", "agi", "mdef", "pdef"
			apply_stat_effect([type, val], is_close)
		when "per_str", "per_dex", "per_int", "per_agi", "per_mdef", "per_pdef"
			apply_percentage_effect([type, val], is_close)
		when "speed"
			change_move_speed(val, is_close)
		else
			apply_custom_effect(id, [type, val], is_close) 
		end
	end
	
	# 버프 끄기
	def buff_del(id)
		skill_data = $rpg_skill_data[id]
		@battler.buff_time[id] = 0
		return unless skill_data.buff_data
		
		skill_data.buff_data.each do |type, val|
			process_buff_effect(type.to_s, val, true, id)
		end
	end
	
	def apply_stat_effect(data, is_close = false)
		stat = data[0].to_sym
		value = data[1].to_i * (is_close ? -1 : 1)
		@battler.send("#{stat}=", @battler.send(stat) + value)
		
		return if @battler == $game_party.actors[0]
		return unless eval("@base_#{stat}")
		
		instance_variable_set("@base_#{stat}", instance_variable_get("@base_#{stat}") + value) 		
	end
	
	def apply_percentage_effect(data, is_close = false)
		stat = data[0].sub("per_", "").to_sym
		base = @battler.take_base_stat(stat)
		n = (base * (data[1].to_f - 1.0)).to_i * (is_close ? -1 : 1)
		@battler.send("#{stat}=", @battler.send(stat) + n)
		
		return if @battler != $game_party.actors[0]
		return if eval("@base_#{stat}") == nil
		instance_variable_set("@base_#{stat}", instance_variable_get("@base_#{stat}") + n)
	end
	
	def change_move_speed(value, is_close = false)
		@character.move_speed += value * (is_close ? -1 : 1)
		
		return unless @character == $game_player
		Network::Main.send_with_tag("5", "@move_speed = #{@character.move_speed};")
	end
	
	def apply_custom_effect(id, data, is_close = false)
		return unless @battler.is_a?(Game_Actor)
		
		type, val = data
		case id
		when 28, 35, 50 # 둔갑
			$game_temp.common_event_id = !is_close ? val.to_i : 41
		when 66  # 신수둔각도
			if is_close
				$game_party.actors[0].equip(0, 0)
				[1, 2, 3, 4].each { |id| $game_party.lose_weapon(id, 999) }
				$game_system.se_play("장비")
				$game_party.actors[0].equip(0, $game_variables[41]) if $game_switches[50] and $game_variables[41] > 0
				return
			end
			
			$game_variables[41] = $game_party.actors[0].weapon_id if $game_party.actors[0].weapon_id > 4 # 대충 현재 착용 했던 무기 아이디 저장
			w_id = 1
			w_id = 4 if $game_switches[1] # 청룡
			w_id = 2 if $game_switches[2] # 백호
			w_id = 1 if $game_switches[3] # 주작
			w_id = 3 if $game_switches[4] # 현무
			
			$game_party.gain_weapon(w_id, 1)
			$game_party.actors[0].equip(0, w_id)
		when 131, 141, 142
			!is_close ? self.투명 : self.투명해제
		when 134
			$console.write_line(is_close ? "분신이 사라집니다." : "분신을 생성합니다.")
		when 140
			$console.write_line(is_close ? "운기가 종료 됩니다." : "마력을 회복합니다.")
		when 143
			$console.write_line("투명을 유지합니다.")  
			self.party_buff(142)
			
			
			# 기타
		when 97
			if is_close
				Network::Main.send_with_tag("stealth", "0")
				$console.write_line("잠행을 끝냅니다.")
				self.투명해제
			else
				Network::Main.send_with_tag("stealth", "1")
				$console.write_line("잠행 합니다.")
				self.투명
			end 
		else
			# 처리할 게 없을 때
		end
	end
	
	def casting_chat(data)
		return unless @character
		
		sec = data[0]
		msg = data[1]
		type = data[2] || 3
		
		if msg 
			$chat_b.input(msg, type, sec, @character)
			Network::Main.socket.send "<map_chat>#{name}&#{msg}&#{type}</map_chat>\n" if @character == $game_player
			Network::Main.socket.send "<monster_chat>#{@character.id}&#{msg}&#{type}</monster_chat>\n" if @character != $game_player 
		end
	end
	
	# 스킬에 따른 대화를 생성하고 채팅을 보내는 함수
	def skill_chat(skill)
		id = skill.id
		name = @battler.name
		msg = nil
		type = 3
		sec = 4
		
		# 각 스킬에 대한 메시지 생성
		msg = case id
		when 44 then "#{skill.name}!!" # 헬파이어
		when 53, 57, 69 then "삼매진화!!" # 삼매진화
		when 58, 67, 101, 103, 106, 123, 133, 135, 137, 138 then "!!#{skill.name}!!" # 지정된 스킬
		when 79 then "!!#{skill.name}!!" # 동귀어진
		when 143 then "!!#{skill.name}!!" # 기문방술
		when 151, 152 then "크롸롸롸롸!" # 청룡 포효, 현무 포효
		when 154 then "!!#{skill.name}!!" # 청룡마령참
		when 155, 156 then "#{skill.name}!!" # 암흑진파, 흑룡광포
		when 157 then type = 4; "가소롭다!!" # 회복
		when 158, 159, 160, 161 then "!!#{skill.name}!!" # 지정된 스킬
		when 162 then "나에게 벗어날 수 없다!!"
		end
		
		if msg
			$chat_b.input(msg, type, sec, @character)
			Network::Main.socket.send "<map_chat>#{name}&#{msg}&#{type}</map_chat>\n" if @character == $game_player
			Network::Main.socket.send "<monster_chat>#{@character.id}&#{msg}&#{type}</monster_chat>\n" if @character != $game_player
		end
	end
	
	def calculate_critical(attribute)
		rate = 0
		power = 0
		@battler.buff_time.each do |id, time|
			next if time <= 0
			
			skill_data = $rpg_skill_data[id]
			buff_data = skill_data.send(attribute)
			next unless buff_data
			
			rate += buff_data[0] || 0
			power += buff_data[1] || 0
		end
		[rate, power]
	end
	
	def critical_rate()
		calculate_critical(:attack_critical)
	end
	
	def critical_skill_rate()
		calculate_critical(:skill_critical)
	end
	
	
	#[(파워 계산량)[타입(현재(0), 전체(1)), 체력, 마력, 기본값], (자원 소모량)[타입(현재(0), 전체(1)), 체력, 마력]]
	def skill_power_custom(id, power)
		case id
		when 6 # 도토리 던지기
			return 1
		end
		
		skill_data = $rpg_skill_data[id]
		return power unless skill_data.power_arr 
		
		data = skill_data.power_arr
		
		# 0 : 현재, 1 : 전체
		type = data[0] || -1
		p_hp = data[1] ||  0
		p_sp = data[2] || 0
		val = data[3] || 0
		return power if type == -1 || type == 2
		
		power = power.to_f
		power += case type
		when 0 then (@battler.hp * p_hp) + (@battler.sp * p_sp) # 현재 
		when 1 then (@battler.maxhp * p_hp) + (@battler.maxsp * p_sp) # 전체
		end
		
		power += val
		return power.to_i
	end
	
	# 비례 데미지 스킬
	def damage_by_skill(damage, id)
		skill_data = $rpg_skill_data[id]
		data = skill_data.power_arr
		return damage unless data
		
		# 2 : 비례데미지
		type = data[0] || -1
		p_hp = data[1] || 0
		p_sp = data[2] || 0
		val = data[3] || 0
		return damage unless type == 2
		
		damage = damage.to_f
		damage += (@battler.maxhp * p_hp) + val
		@battler.sp -= @battler.maxsp * p_sp # 마력 깎기
		return damage.to_i
	end
	
	def skill_cost_custom(id)
		skill_data = $rpg_skill_data[id]
		return unless skill_data.cost_arr 
		
		data = skill_data.cost_arr 
		type = data[0] || -1
		c_hp = data[1] || 0
		c_sp = data[2] || 0
		return if type == -1
		
		case type
		when 0 # 현재 
			@battler.hp -= @battler.hp * c_hp
			@battler.sp -= @battler.sp * c_sp
		when 1 # 전체
			@battler.hp -= @battler.maxhp * c_hp
			@battler.sp -= @battler.maxsp * c_sp
		end
		
		@battler.hp = [@battler.hp.to_i, 1].max
		@battler.sp = @battler.sp.to_i
	end
	
	# 액티브 스킬 커스텀
	def active_skill(id, enemy = nil)
		skill_data = $rpg_skill_data[id]
		return unless skill_data.is_active
		
		case id
		when 15 # 공력증강
			공력증강
		when 73 # 광량돌격
			광량돌격
		when 120 # 부활
			부활
		when 132
			비영승보(enemy)
		when 162
			추격(enemy)
		end		
	end
	
	def 공력증강
		r = rand(100)
		if(r <= 40)			
			$console.write_line("실패했습니다.") if @character == $game_player
			@character.ani_array.push(158)
			return 
		end
		
		@battler.hp /= 2
		@battler.hp = 1 if @battler.hp <= 0
		@battler.sp += @battler.maxsp
		@character.ani_array.push(135)
	end
	
	def 투명
		$state_trans = true # 현재 자신이 투명상태인걸 뜻함
		Network::Main.send_trans(true)
	end
	
	def 투명해제
		if self.check_buff(143) || self.check_buff(97) # 기문방술 걸려있을 땐 해제 안함
			$state_trans = true
			return 
		end
		return if $state_trans == false
		
		Network::Main.send_trans(false)
		$state_trans = false
		
		# 투명 버프 해제
		$game_party.actors[0].buff_time[131] = 1 if self.check_buff(131) # 투명 1성
		$game_party.actors[0].buff_time[141] = 1 if self.check_buff(141) # 투명 2성
		$game_party.actors[0].buff_time[142] = 1 if self.check_buff(142) # 투명 3성
	end
	
	def 광량돌격
		move_num = 10 # 스킬 범위만큼
		x = @character.x
		y = @character.y
		d = @character.direction
		for i in 0...move_num
			break unless @character.passable?(x, y, d)			
			x += (d == 6 ? 1 : d == 4 ? -1 : 0)
			y += (d == 2 ? 1 : d == 8 ? -1 : 0)
		end
		@character.moveto(x, y)
	end
	
	def 부활
		return if $game_switches[50]
		
		$game_switches[50] = true # 유저 살음 스위치 온
		$game_switches[296] = false # 유저 죽음 스위치 오프
		
		$game_party.actors[0].hp = 1
		$console.write_line("지옥의 문턱에서 돌아옵니다.")
		$cha_name = "바람머리" unless $cha_name
		
		$game_party.actors[0].set_graphic($cha_name, 0, 0, 0)
		$game_player.refresh
		Network::Main.send_map
		$game_party.actors[0].rpg_skill.buff_active(94) # 금강불체
	end
	
	def 비영승보(enemy = nil)
		return unless @character
		
		x = @character.x
		y = @character.y
		d = @character.direction
		
		enemy = 비영_passable2?(x, y, d) unless enemy
		return unless enemy
		
		data = 비영_passable?(enemy, d) # [x, y, d]
		if data != nil
			@character.moveto(data[0], data[1]) 
			@character.direction = data[2]
		end
		$ABS.player_melee(true) if @character == $game_player
	end
	
	def move_coordinates(x, y, direction)
		case direction
		when 2 then [x, y + 1]
		when 4 then [x - 1, y]
		when 6 then [x + 1, y]
		when 8 then [x, y - 1]
		else [x, y]
		end
	end
	
	def check_points(enemy, direction)
		x, y = enemy.x, enemy.y
		n_x, n_y = move_coordinates(x, y, direction)
		n_x2, n_y2 = move_coordinates(x, y, (direction == 2 || direction == 8) ? 4 : 2)
		n_x3, n_y3 = move_coordinates(x, y, (direction == 2 || direction == 8) ? 6 : 8)
		[[n_x, n_y], [n_x2, n_y2], [n_x3, n_y3]]
	end
	
	def object_check(objects, new_x, new_y)
		objects.each do |obj|
			next if obj.through 
			next if obj.character_name.empty?
			next if obj == @character
			
			return obj if obj.x == new_x && obj.y == new_y
		end
		nil
	end
	
	def map_object_check(new_x, new_y)
		objects = $game_map.events.values + Network::Main.mapplayers.values + [$game_player]
		object_check(objects, new_x, new_y)
	end
	
	def 비영_passable?(enemy, direction)
		check_points = check_points(enemy, direction)
		
		check_points.each do |new_x, new_y|
			next unless $game_map.valid?(new_x, new_y) && $game_map.passable?(new_x, new_y, 10 - direction)
			
			next if map_object_check(new_x, new_y)
			
			sx = new_x - enemy.x
			sy = new_y - enemy.y
			
			new_direction = if sx.abs > 0
				sx > 0 ? 4 : 6
			elsif sy.abs > 0
				sy > 0 ? 8 : 2
			else
				direction
			end
			
			return [new_x, new_y, new_direction]
		end
		nil
	end
	
	def 비영_passable2?(x, y, direction)
		new_x, new_y = move_coordinates(x, y, direction)
		map_object_check(new_x, new_y) || map_object_check(x, y)
	end
	
	def 추격(enemy)
		return unless @character 
		return unless enemy
		return if @battler.is_a?(ABS_Enemy) && !@battler.aggro
		return unless (enemy.respond_to?(:x) || enemy.instance_variables.include?("@x"))
  
		@character.moveto(enemy.x, enemy.y)
		@character.ani_array.push(158)
	end
	
	# 평타 공격시 버프, 디버프에 대한 데미지 계산
	def damage_calculation_attack(damage)
		# 가해자 입장
		@battler.buff_time.each do |id, time|
			data = $rpg_skill_data[id]
			next if time <= 0
			next unless data.attack_power_per
			
			damage *= data.attack_power_per
			damage = skill_power_custom(id, damage)
			skill_cost_custom(id)
		end
		
		return damage.to_i
	end
	
	# 스킬 공격시 버프, 디버프에 대한 데미지 계산
	def damage_calculation_skill(damage)
		# 가해자 입장
		@battler.buff_time.each do |id, time|
			data = $rpg_skill_data[id]
			next unless data.skill_power_per
			next if time <= 0
			
			damage *= data.skill_power_per
		end
		return damage
	end
	
	def damage_calculation_defense(damage)
		# 피해자 입장
		@battler.buff_time.each do |id, time|
			data = $rpg_skill_data[id]
			next if time <= 0
			next unless data.defense_per
			
			damage -= damage * data.defense_per
		end
		
		if @battler.is_a?(Game_Actor)
			
		elsif @battler.is_a?(ABS_Enemy)
			damage = 1 if @battler.id == 41 # 청자다람쥐
		end
		return damage
	end
end	