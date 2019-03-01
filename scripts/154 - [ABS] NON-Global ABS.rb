#==============================================================================
# ■ Action Battle System
#==============================================================================
# By Near Fantastica
# Version 4
# 29.11.05
#==============================================================================
# ■ ABS Key Commands
#==============================================================================
#   A    ● Dash
#   S    ● Sneak
#   D    ● Attack
#   1    ● Skill Key 1
#   2    ● Skill Key 2
#   3    ● Skill Key 3
#   4    ● Skill Key 4
#   5    ● Skill Key 5
#   6    ● Skill Key 6
#   7    ● Skill Key 7
#   8    ● Skill Key 8
#   9    ● Skill Key 9
#   0    ● Skill Key 0
#==============================================================================
# ■ ABS Enemy Ai List 적 인공지능 리스트
#==============================================================================
#   Name    이름
#   Name Of the Enemy in The Data Base 데이터베이스에 있는 적 이름
#---------------------------------------------------------------------------
#   Behavior  행동
#   Passive = 0 ● 공격당할때만,반격한다. 
#   Aggressive = 1 ● 적의 시야안에 있으면 공격한다. 
#   Linking = 2 ● Event will only attack when another Event is attacked with in its Detection level
#   Aggressive Linking = 3 ● Event will attack when either Aggressive or Linking is true
#---------------------------------------------------------------------------
#   Detection
#   Sound = range ● 적이 들을 수 있는 범위(0은 못들음)
#   Sight = range ● 적이 볼 수 있는 범위(0은 못봄)
#---------------------------------------------------------------------------
#   Aggressiveness
#   Aggressiveness = Level ● 적의 공격성향
#---------------------------------------------------------------------------
#   Movement
#   Speed = Level ● The movment Speed of the event when engaged
#   Frequency = Level  ● The movment Frequency of the event when engaged 
#---------------------------------------------------------------------------
#   Trigger
#   Erased = 0  ● The event will be erased on death
#   Switch = 1  ● The event will be trigger Switch[ID] on death
#   Varible = 2  ● The event will be set the Varible[ID] = VALUE on death
#   Local Switch = 3 ● The event will trigger Local_Switch[ID] on death
#==============================================================================
# ■ ABS Range Constant
#==============================================================================
#   RANGE_WEAPONS[Weapon Id] = 
#   ["Character Set Name", Ammo Speed, Anmiation Id, Ammo Item Id, Range]
#   RANGE_SKILLS[Skill Id] = 
#   [Range, Ammo Speed, "Character Set Name"]
#==============================================================================

#--------------------------------------------------------------------------
# * SDK Log Script
#--------------------------------------------------------------------------
SDK.log("ABS", "Near Fantastica", 4, "29.11.05")

if SDK.state("Input") == nil or SDK.state("Input") == false
	p "Input Addition Not Found"
	SDK.disable("ABS")
end
SDK.disable("ABS")

#--------------------------------------------------------------------------
# * Begin SDK Enable Test
#--------------------------------------------------------------------------
if SDK.state("ABS") == true
	
	class ABS
		#--------------------------------------------------------------------------
		RANGE_WEAPONS = {}
		RANGE_WEAPONS[17] = ["Arrow", 5, 4, 57, 6]
		RANGE_WEAPONS[18] = ["Arrow", 5, 4, 57, 7]
		RANGE_WEAPONS[19] = ["Arrow", 5, 4, 57, 8]
		RANGE_WEAPONS[20] = ["Arrow", 5, 4, 57, 9]
		RANGE_WEAPONS[31] = ["Arrow", 5, 4, 57, 6]
		RANGE_WEAPONS[32] = ["Arrow", 5, 4, 58, 7]
		RANGE_WEAPONS[33] = ["Arrow", 5, 4, 58, 8]
		RANGE_WEAPONS[34] = ["Arrow", 5, 4, 58, 9]
		RANGE_WEAPONS[35] = ["Arrow", 5, 4, 58, 10]
		RANGE_WEAPONS[43] = ["Arrow", 5, 4, 57, 10]
		#--------------------------------------------------------------------------
		RANGE_SKILLS = {}
		RANGE_SKILLS[7] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[8] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[10] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[11] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[13] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[14] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[16] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[17] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[19] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[20] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[22] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[23] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[25] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[26] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[28] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[29] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[31] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[33] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[35] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[37] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[39] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[41] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[43] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[45] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[47] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[49] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[51] = [10, 5, "Magic Balls"]
		RANGE_SKILLS[57] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[58] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[59] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[60] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[61] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[62] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[63] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[64] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[65] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[66] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[67] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[68] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[69] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[70] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[71] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[72] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[73] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[74] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[75] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[76] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[77] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[78] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[79] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[80] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[85] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[86] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[87] = [1, 5, "Magic Balls"]
		RANGE_SKILLS[94] = [1, 5, "Magic Balls"]
		#--------------------------------------------------------------------------
		DASH_KEY = Input::Letters["D"]
		SNEAK_KEY = Input::Letters["S"]
		ATTACK_KEY = Input::Letters["F"]
		SKILL_KEYS = Input::Numberkeys
		#--------------------------------------------------------------------------
		attr_accessor :enemies
		attr_accessor :range
		attr_accessor :skills
		attr_accessor :dash_level
		attr_accessor :sneak_level
		attr_accessor :p_animations
		attr_accessor :e_animations
		#--------------------------------------------------------------------------
		def initialize  #변수 초기화
			# Enemies
			@enemies = {}
			# Range
			@range = []
			# Skills
			@skills = []
			# Dashing
			@dashing = false
			@dash_restore = false
			@dash_reduce= false
			@dash_timer = 0
			@dash_level = 5
			@dash_sec = 0
			# Sneaking
			@sneaking = false
			@sneak_restore = false
			@sneak_reduce= false
			@sneak_timer = 0
			@sneak_level = 5
			@sneak_sec = 0
			# Button Mashing
			@mash_bar = 0
			#Animation
			@p_animations = false 
			@e_animations = false
		end
		#--------------------------------------------------------------------------
		def ATTACK_KEY
			return ATTACK_KEY
		end
		#--------------------------------------------------------------------------
		def SKILL_KEYS
			return SKILL_KEYS
		end
		#--------------------------------------------------------------------------
		def RANGE_WEAPONS
			return RANGE_WEAPONS
		end
		#--------------------------------------------------------------------------
		def RANGE_SKILLS
			return RANGE_SKILLS
		end
		#--------------------------------------------------------------------------
		# * ABS 애니메이션 엔진 함수
		#--------------------------------------------------------------------------
		# Handles animating map sprites for a wide variety of uses
		#--------------------------------------------------------------------------
		def animate(object, animation_name, position, wait = 8, frames = 0, repeat = 0)
			if object != nil # -1이라면?
				object.animate(animation_name, position, frames, wait, repeat)
			end
		end
		#--------------------------------------------------------------------------
		def refresh(event, list, character_name)
			@enemies.delete(event.id)
			return if character_name == ""
			return if list == nil
			parameters = SDK.event_comment_input(event, 9, "ABS Event Command List")
			return if parameters.nil?
			name = parameters[0].split
			for x in 1...$data_enemies.size #1~적 사이즈까지
				enemy = $data_enemies[x]
				if name[1].upcase == enemy.name.upcase
					@enemies[event.id] = Game_ABS_Enemy.new(enemy.id)
					@enemies[event.id].event_id = event.id
					default_setup(event.id)
					level = parameters[1].split
					@enemies[event.id].level = level[1].to_i
					behavior = parameters[2].split
					@enemies[event.id].behavior = behavior[1].to_i
					sound = parameters[3].split
					@enemies[event.id].detection_sound = sound[1].to_i
					sight = parameters[4].split
					@enemies[event.id].detection_sight = sight[1].to_i
					aggressiveness = parameters[5].split
					@enemies[event.id].aggressiveness = aggressiveness[1].to_i
					speed = parameters[6].split
					@enemies[event.id].speed = speed[1].to_i
					frequency = parameters[7].split
					@enemies[event.id].frequency = frequency[1].to_i
					trigger = parameters[8].split
					@enemies[event.id].trigger= [trigger[1].to_i, trigger[2].to_i, trigger[3].to_i]
				end
			end
		end
		#--------------------------------------------------------------------------
		def default_setup(id)
			@enemies[id].level = 1
			@enemies[id].behavior = 3
			@enemies[id].detection_sight = 4
			@enemies[id].detection_sound = 4
			@enemies[id].aggressiveness = 1
			@enemies[id].engaged = false
			@enemies[id].speed = 4
			@enemies[id].frequency = 5
		end
		#--------------------------------------------------------------------------
		def update
			update_dash if @sneaking == false 
			update_sneak if @dashing == false
			update_enemies if @enemies != {}
			update_player
			update_range if @range != []
			Graphics.frame_reset
		end
		#--------------------------------------------------------------------------
		def update_range
			for range in @range
				range.update
			end
		end
		#--------------------------------------------------------------------------
		def update_player
			actor = $game_party.actors[0]
			@mash_bar = 100 if @mash_bar >= 100
			@mash_bar += 10
		end
		#--------------------------------------------------------------------------
		def update_dash
			if Input.pressed?(DASH_KEY)
				if $game_player.moving?
					@dashing = true
					$game_player.move_speed = 5
					@dash_restore = false
					if @dash_reduce == false
						@dash_timer = 100 # Initial time off set
						@dash_reduce = true
					else
						@dash_timer-= 1
					end
					@dash_sec = (@dash_timer / Graphics.frame_rate)%60
					if @dash_sec == 0
						if @dash_level != 0
							@dash_level -= 1
							@dash_timer = 100 # Timer Count
						end
					end
					if @dash_level == 0
						@dashing = false
						$game_player.move_speed = 4
					end
				end
			else
				@dashing = false
				$game_player.move_speed = 4
				@dash_reduce = false
				if @dash_restore == false
					@dash_timer = 80 # Initial time off set
					@dash_restore = true
				else
					@dash_timer-= 1
				end
				@dash_sec = (@dash_timer / Graphics.frame_rate)%60
				if @dash_sec == 0
					if @dash_level != 5
						@dash_level+= 1
						@dash_timer = 60
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		def update_sneak
			if Input.pressed?(SNEAK_KEY)
				if $game_player.moving?
					@sneaking = true
					$game_player.move_speed = 3
					@sneak_restore = false
					if @sneak_reduce == false
						@sneak_timer = 50 # Initial time off set
						@sneak_reduce = true
					else
						@sneak_timer-= 1
					end
					@sneak_sec = (@sneak_timer / Graphics.frame_rate)%60
					if @sneak_sec == 0
						if @sneak_level != 0
							@sneak_level -= 1
							@sneak_timer = 100 # Timer Count
						end
					end
					if @sneak_level == 0
						@sneaking = false
						$game_player.move_speed = 4
					end
				end
			else
				@sneaking = false
				$game_player.move_speed = 4
				@sneak_reduce = false
				if @sneak_restore == false
					@sneak_timer = 80 # Initial time off set
					@sneak_restore = true
				else
					@sneak_timer-= 1
				end
				@sneak_sec = (@sneak_timer / Graphics.frame_rate)%60
				if @sneak_sec == 0
					if @sneak_level != 5
						@sneak_level+= 1
						@sneak_timer = 60 # Timer Count
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		def update_enemies
			for enemy in @enemies.values
				case enemy.behavior #적의 행동
				when 0
					if enemy.engaged == true
						next if engaged_enemy_detection_sight?(enemy) == true
						next if engaged_enemy_detection_sound?(enemy) == true
					end
				when 1
					if enemy.engaged == true
						next if engaged_enemy_detection_sight?(enemy) == true
						next if engaged_enemy_detection_sound?(enemy) == true
					else
						next if enemy_detection_sight?(enemy) == true
						next if enemy_detection_sound?(enemy) == true
					end
				when 2
					if enemy.engaged == true
						next if engaged_enemy_linking_sight?(enemy) == true
						next if engaged_enemy_linking_sound?(enemy) == true
					else
						next if enemy_linking?(enemy) == true
					end
				when 3
					if enemy.engaged == true
						next if engaged_enemy_linking_sight?(enemy) == true
						next if engaged_enemy_linking_sound?(enemy) == true
					else
						next if enemy_detection_sight?(enemy) == true
						next if enemy_detection_sound?(enemy) == true
						next if enemy_linking?(enemy) == true
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		def set_event_movement(enemy)
			event = $game_map.events[enemy.event_id]
			enemy.move_type = event.move_type
			enemy.move_frequency = event.move_frequency
			enemy.move_speed = event.move_speed
			enemy.engaged = true
			event.move_type = 2
			event.move_frequency = enemy.frequency 
			event.move_speed = enemy.speed
		end
		#--------------------------------------------------------------------------
		def return_event_movement(enemy)
			enemy.engaged = false
			event = $game_map.events[enemy.event_id]
			return if event == nil # 이벤트가 없다?
			event.move_type = enemy.move_type
			event.move_frequency = enemy.move_frequency
			event.move_speed = enemy.move_speed
		end
		#--------------------------------------------------------------------------
		def engaged_enemy_linking_sight?(enemy)
			if enemy.detection_sight != 0
				if in_range?($game_map.events[enemy.event_id], $game_player, enemy.detection_sight)
					enemy.linking = false
					enemy_attack(enemy)
					return true
				else
					if enemy.linking == false
						return_event_movement(enemy)
						return false
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		def engaged_enemy_linking_sound?(enemy)
			if enemy.detection_sound != 0
				if in_range?($game_map.events[enemy.event_id], $game_player, enemy.detection_sound)
					enemy.linking = false
					enemy_attack(enemy)
					return true
				else
					if enemy.linking == false
						return_event_movement(enemy)
						return false
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		def enemy_linking?(enemy)
			for key in @enemies.keys
				if in_range?($game_map.events[enemy.event_id], $game_map.events[key], enemy.detection_sight)
					if enemy.engaged == true
						enemy.linking = true
						set_event_movement(enemy)
						return true
					end
				end
			end
			return false
		end
		#--------------------------------------------------------------------------
		def enemy_detection_sound?(enemy)
			if enemy.detection_sound != 0
				return false if enemy.level < $game_party.actors[0].level
				if in_range?($game_map.events[enemy.event_id], $game_player, enemy.detection_sound)
					if @sneaking == true
						return false
					end
					set_event_movement(enemy)
					return true
				end
			end
			return false
		end
		#--------------------------------------------------------------------------
		def enemy_detection_sight?(enemy)
			if enemy.detection_sight != 0
				return false if enemy.level < $game_party.actors[0].level
				if in_range?($game_map.events[enemy.event_id], $game_player, enemy.detection_sight)
					if facing?($game_map.events[enemy.event_id], $game_player)
						set_event_movement(enemy)
						return true
					end
				end
			end
			return false
		end
		#--------------------------------------------------------------------------
		def engaged_enemy_detection_sight?(enemy)
			if enemy.detection_sight != 0
				if in_range?($game_map.events[enemy.event_id], $game_player, enemy.detection_sight)
					enemy_attack(enemy)
					return true
				else
					return_event_movement(enemy)
					return false
				end
			end
		end
		#--------------------------------------------------------------------------
		def engaged_enemy_detection_sound?(enemy)
			if enemy.detection_sound != 0
				if in_range?($game_map.events[enemy.event_id], $game_player, enemy.detection_sound)
					enemy_attack(enemy)
					return true
				else
					return_event_movement(enemy)
					return false
				end
			end
		end
		#--------------------------------------------------------------------------
		def in_range?(element, object, range)
			return if element == nil or object == nil or range == nil
			x = (element.x - object.x) * (element.x - object.x)
			y = (element.y - object.y) * (element.y - object.y)
			r = x + y
			return true  if r <= (range * range)
			return false
		end
		#--------------------------------------------------------------------------
		def in_range(element, range)
			return if element == nil or range == nil
			objects = []
			x = (element.x - $game_player.x) * (element.x - $game_player.x)
			y = (element.y - $game_player.y) * (element.y - $game_player.y)
			r = x + y
			objects.push($game_party.actors[0]) if r <= (range * range)
			return objects
		end
		#--------------------------------------------------------------------------
		def facing?(element, object)
			return if element == nil or object == nil
			if element.direction == 2
				return true if object.y >= element.y
			end
			if element.direction == 4
				return true if object.x <= element.x
			end
			if element.direction == 6
				return true if object.x  >= element.x
			end
			if element.direction == 8
				return true if object.y <= element.y
			end
			return false
		end
		#--------------------------------------------------------------------------
		def in_line?(element, object)
			return if element == nil or object == nil
			if element.direction == 2
				return true if object.x == element.x
			end
			if element.direction == 4
				return true if object.y == element.y
			end
			if element.direction == 6
				return true if object.y == element.y
			end
			if element.direction == 8
				return true if object.x == element.x
			end
			return false
		end
		#--------------------------------------------------------------------------
		def enemy_pre_attack(enemy, actions)
			return true if enemy.hp * 100.0 / enemy.maxhp > actions.condition_hp
			return true if $game_party.max_level < actions.condition_level
			switch_id = actions.condition_switch_id
			if actions.condition_switch_id > 0 and $game_switches[switch_id] == false
				return true
			end
			n = rand(11) 
			return true if actions.rating < n
			return false
		end
		#--------------------------------------------------------------------------
		def hit_player(enemy)
			animate($game_player, $game_player.character_name + '-hit',
				$game_player.direction/2, 4, 3) if @p_animations
			$game_player.jump(0, 0)
			$game_player.animation_id = enemy.animation2_id
		end
		#--------------------------------------------------------------------------
		def actor_non_dead?(actor, enemy)
			if actor.dead?
				if not enemy.is_a?(Game_Actor)
					return_event_movement(enemy)
					enemy.engaged = false
				end
				$game_temp.gameover = true
				return false
			end
			return true
		end
		#--------------------------------------------------------------------------
		def enemy_attack(enemy)
			for actions in enemy.actions
				next if enemy_pre_attack(enemy, actions) == true
				case actions.kind
				when 0 #Basic
					if Graphics.frame_count % (enemy.aggressiveness * 30) == 0          
						case actions.basic
						when 0 #Attack
							if in_range?($game_map.events[enemy.event_id], $game_player, 1) and 
								facing?($game_map.events[enemy.event_id], $game_player)
								actor = $game_party.actors[0]
								actor.attack_effect(enemy)
								event = $game_map.events[enemy.event_id]
								animate(event, event.page.graphic.character_name + '-atk',
									event.direction/2, 4, 3, 0) if @e_animations and actor.damage != "Miss" and actor.damage != 0
								if $game_party.actors[0].damage != "Miss" and $game_party.actors[0].damage != 0
									hit_player(enemy)
								end
								actor_non_dead?(actor, enemy)
								return
							end
						when 1..3 #Nothing
							return
						end
					end
				when 1..2#Skill
					skill = $data_skills[actions.skill_id]
					case skill.scope
					when 1 # One Enemy
						if Graphics.frame_count % (enemy.aggressiveness * 30) == 0
							if in_line?($game_map.events[enemy.event_id], $game_player)
								next if enemy.can_use_skill?(skill) == false
								event = $game_map.events[enemy.event_id]
								animate(event, event.page.graphic.character_name + '-cast',
									event.direction/2, 4, 3, 0) if @e_animations
								@range.push(Game_Ranged_Skill.new($game_map.events[enemy.event_id], enemy, skill))
								enemy.sp -= skill.sp_cost
							end
						end
					when 3..4, 7 # User          
						if Graphics.frame_count % (enemy.aggressiveness * 100) == 0
							if enemy.hp < skill.power.abs
								enemy.effect_skill(enemy, skill)
								event = $game_map.events[enemy.event_id]
								animate(event, event.page.graphic.character_name + '-cast',
									event.direction/2, 4, 3, 0) if @e_animations
								enemy.sp -= skill.sp_cost
								$game_map.events[enemy.event_id].animation_id = skill.animation2_id
							end
							return
						end
					end
					return
				end
			end
		else
			return
		end
		#--------------------------------------------------------------------------
		def hit_event(event, animation)
			animate(event, event.page.graphic.character_name + '-hit',
				event.direction/2, 4, 3, 0) if @e_animations
			event.jump(0, 0)
			return if animation == 0
			event.animation_id = animation
		end
		#--------------------------------------------------------------------------
		def event_non_dead?(enemy, actor = 0)
			if enemy.dead?
				treasure(enemy) if actor = 0
				id = enemy.event_id
				@enemies.delete(id)
				event = $game_map.events[enemy.event_id]
				event.character_name = ""
				case enemy.trigger[0]
				when 0
					event.erase
				when 1
					print "EVENT " + event.id.to_s + "Trigger Not Set Right ~!" if enemy.trigger[1] == 0
					$game_switches[enemy.trigger[1]] = true
					$game_map.need_refresh = true
				when 2
					print "EVENT " + event.id.to_s + "Trigger Not Set Right ~!" if enemy.trigger[1] == 0
					if enemy.trigger[2] == 0
						$game_variables[enemy.trigger[1]] += 1
						$game_map.need_refresh = true
					else
						$game_variables[enemy.trigger[1]] = enemy.trigger[2]
						$game_map.need_refresh = true
					end
				when 3
					value = "A" if enemy.trigger[1] == 1
					value = "B" if enemy.trigger[1] == 2
					value = "C" if enemy.trigger[1] == 3
					value = "D" if enemy.trigger[1] == 4
					print "EVENT " + event.id.to_s + "Trigger Not Set Right ~!" if value == 0
					key = [$game_map.map_id, event.id, value]
					$game_self_switches[key] = true
					$game_map.need_refresh = true
				end
				return false
			end
			return true
		end
		#--------------------------------------------------------------------------
		def treasure(enemy)
			exp = 0
			gold = 0
			treasures = []
			unless enemy.hidden
				exp += enemy.exp
				gold += enemy.gold
				if rand(100) < enemy.treasure_prob
					if enemy.item_id > 0
						treasures.push($data_items[enemy.item_id])
					end
					if enemy.weapon_id > 0
						treasures.push($data_weapons[enemy.weapon_id])
					end
					if enemy.armor_id > 0
						treasures.push($data_armors[enemy.armor_id])
					end
				end
			end
			treasures = treasures[0..5]
			for i in 0...$game_party.actors.size
				actor = $game_party.actors[i]
				if actor.cant_get_exp? == false
					last_level = actor.level
					
					if not $netparty.size < 2
						Network::Main.socket.send("<nptgain>#{exp} #{gold} #{$npt} #{$game_map.map_id}</nptgain>\n")
						
					else
						
						actor.exp += exp
						$game_party.gain_gold(gold)
					end
					
					if actor.level > last_level
						$console.write_line("[정보]:레벨업!")
						actor.hp = actor.maxhp
						actor.sp = actor.maxsp
						$game_player.animation_id = 180
						Network::Main.socket.send "<player_animation>@ani_map = #{$game_map.map_id}; @ani_number = 180; @ani_id = #{Network::Main.id};</player_animation>\n"
					end
				end
			end
			
			for item in treasures
				case item
				when RPG::Item
					$game_party.gain_item(item.id, 1)
				when RPG::Weapon
					$game_party.gain_weapon(item.id, 1)
				when RPG::Armor
					$game_party.gain_armor(item.id, 1)
				end
			end
		end
		#--------------------------------------------------------------------------
		def player_attack
			actor = $game_party.actors[0]
			if RANGE_WEAPONS.has_key?(actor.weapon_id) 
				# Range Attack
				range_weapon = RANGE_WEAPONS[actor.weapon_id]
				return if $game_party.item_number(range_weapon[3]) == 0
				$game_party.lose_item(range_weapon[3], 1)
				@range.push(Game_Ranged_Weapon.new($game_player, actor, actor.weapon_id))
				animate($game_player, $game_player.character_name + '-ranged',
					$game_player.direction/2, 4, 3) if @p_animations
			else
				# Test Button Mash
				hit = rand(30) + 10
				if hit > @mash_bar
					@mash_bar = 0
					return
				end
				@mash_bar = 0
				# Melee Attack
				for enemy in @enemies.values
					event = $game_map.events[enemy.event_id]
					if facing?($game_player, event) and in_range?($game_player, event, 1)
						actor = $game_party.actors[0]
						enemy.attack_effect(actor)
						animate($game_player, $game_player.character_name + '-atk',
							$game_player.direction/2, 4, 3) if @p_animations
						hit_event(event, $data_weapons[actor.weapon_id].animation2_id) if enemy.damage != "Miss" and enemy.damage != 0
						if event_non_dead?(enemy)
							if enemy.engaged == false
								enemy.engaged = true
								set_event_movement(enemy)
							end
						end
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		def player_skill(key)
			return if @skills[key] == nil
			skill = $data_skills[@skills[key]]
			return if skill == nil
			actor = $game_party.actors[0]
			return if not actor.skills.include?(skill.id)
			return if actor.can_use_skill?(skill) == false
			case skill.scope
			when 1 # One Enemy
				@range.push(Game_Ranged_Skill.new($game_player, actor, skill))
				actor.sp -= skill.sp_cost
				animate($game_player, $game_player.character_name + '-cast',
					$game_player.direction/2, 4, 3) if @p_animations
			when 2 # All Emenies
				$game_player.animation_id = skill.animation2_id
				actor.sp -= skill.sp_cost
				for enemy in @enemies.values
					next if enemy == nil
					enemy.effect_skill(actor, skill)
					animate($game_player, $game_player.character_name + '-cast',
						$game_player.direction/2, 4, 3) if @p_animations
					
					if enemy.damage != "Miss" and enemy.damage != 0
						event = $game_map.events[enemy.event_id]
						hit_event(event, 0)
					end
					if event_non_dead?(enemy)
						if enemy.engaged == false
							enemy.behavior = 3
							enemy.linking = true
							enemy.engaged = true
							set_event_movement(enemy)
						end
					end
				end
				return
			when 3..4, 7 # User
				return if actor.can_use_skill?(skill) == false
				actor.effect_skill(actor, skill)
				actor.sp -= skill.sp_cost
				animate($game_player, $game_player.character_name + '-cast',
					$game_player.direction/2, 4, 3) if @p_animations
				$game_player.animation_id = skill.animation2_id
				return
			end
		end
	end
	
	#============================================================================
	# ■ Game ABS Enemy
	#============================================================================
	
	class Game_ABS_Enemy < Game_Battler # 상속받는다.
		#--------------------------------------------------------------------------
		attr_accessor :event_id
		attr_accessor :level
		attr_accessor :behavior
		attr_accessor :detection_sight
		attr_accessor :detection_sound
		attr_accessor :aggressiveness
		attr_accessor :trigger
		attr_accessor :speed
		attr_accessor :frequency
		attr_accessor :engaged
		attr_accessor :linking
		attr_accessor :move_type
		attr_accessor :move_frequency
		attr_accessor :move_speed
		attr_accessor :ranged
		#--------------------------------------------------------------------------
		def initialize(enemy_id)
			super() #부모생성자
			@event_id= 0
			@level = 0
			@behavior = 0
			@detection_sight = 0
			@detection_sound = 0
			@aggressiveness = 1
			@trigger = []
			@enemy_id = enemy_id
			@engaged = false
			@linking = false
			@speed = 0
			@frequency = 0
			@move_type = 0
			@move_frequency = 0
			@move_speed = 0
			@hp = maxhp
			@sp = maxsp
		end
		#--------------------------------------------------------------------------
		def id
			return @enemy_id
		end
		#--------------------------------------------------------------------------
		def index
			return @member_index
		end
		#--------------------------------------------------------------------------
		def name
			return $data_enemies[@enemy_id].name
		end
		#--------------------------------------------------------------------------
		def base_maxhp
			return $data_enemies[@enemy_id].maxhp
		end
		#--------------------------------------------------------------------------
		def base_maxsp
			return $data_enemies[@enemy_id].maxsp
		end
		#--------------------------------------------------------------------------
		def base_str
			return $data_enemies[@enemy_id].str
		end
		#--------------------------------------------------------------------------
		def base_dex
			return $data_enemies[@enemy_id].dex
		end
		#--------------------------------------------------------------------------
		def base_agi
			return $data_enemies[@enemy_id].agi
		end
		#--------------------------------------------------------------------------
		def base_int
			return $data_enemies[@enemy_id].int
		end
		#--------------------------------------------------------------------------
		def base_atk
			return $data_enemies[@enemy_id].atk
		end
		#--------------------------------------------------------------------------
		def base_pdef
			return $data_enemies[@enemy_id].pdef
		end
		#--------------------------------------------------------------------------
		def base_mdef
			return $data_enemies[@enemy_id].mdef
		end
		#--------------------------------------------------------------------------
		def base_eva
			return $data_enemies[@enemy_id].eva
		end
		#--------------------------------------------------------------------------
		def animation1_id
			return $data_enemies[@enemy_id].animation1_id
		end
		#--------------------------------------------------------------------------
		def animation2_id
			return $data_enemies[@enemy_id].animation2_id
		end
		#--------------------------------------------------------------------------
		def element_rate(element_id)
			table = [0,200,150,100,50,0,-100]
			result = table[$data_enemies[@enemy_id].element_ranks[element_id]]
			for i in @states
				if $data_states[i].guard_element_set.include?(element_id)
					result /= 2
				end
			end
			return result
		end
		#--------------------------------------------------------------------------
		def state_ranks
			return $data_enemies[@enemy_id].state_ranks
		end
		#--------------------------------------------------------------------------
		def state_guard?(state_id)
			return false
		end
		#--------------------------------------------------------------------------
		def element_set
			return []
		end
		#--------------------------------------------------------------------------
		def plus_state_set
			return []
		end
		#--------------------------------------------------------------------------
		def minus_state_set
			return []
		end
		#--------------------------------------------------------------------------
		def actions
			return $data_enemies[@enemy_id].actions
		end
		#--------------------------------------------------------------------------
		def exp
			return $data_enemies[@enemy_id].exp
		end
		#--------------------------------------------------------------------------
		def gold
			return $data_enemies[@enemy_id].gold
		end
		#--------------------------------------------------------------------------
		def item_id
			return $data_enemies[@enemy_id].item_id
		end
		#--------------------------------------------------------------------------
		def weapon_id
			return $data_enemies[@enemy_id].weapon_id
		end
		#--------------------------------------------------------------------------
		def armor_id
			return $data_enemies[@enemy_id].armor_id
		end
		#--------------------------------------------------------------------------
		def treasure_prob
			return $data_enemies[@enemy_id].treasure_prob
		end
	end
	
	#============================================================================
	# ■ Game Battler
	#============================================================================
	
	class Game_Battler
		#--------------------------------------------------------------------------
		def can_use_skill?(skill)
			if skill.sp_cost > self.sp
				return false
			end
			if dead?
				return false
			end
			if skill.atk_f == 0 and self.restriction == 1
				return false
			end
			occasion = skill.occasion
			case occasion
			when 0..1
				return true
			when 2..3
				return false
			end
		end
		#--------------------------------------------------------------------------
		def effect_skill(user, skill)
			self.critical = false
			if ((skill.scope == 3 or skill.scope == 4) and self.hp == 0) or
				((skill.scope == 5 or skill.scope == 6) and self.hp >= 1)
				return false
			end
			effective = false
			effective |= skill.common_event_id > 0
			hit = skill.hit
			if skill.atk_f > 0
				hit *= user.hit / 100
			end
			hit_result = (rand(100) < hit)
			effective |= hit < 100
			if hit_result == true
				power = skill.power + user.atk * skill.atk_f / 100
				if power > 0
					power -= self.pdef * skill.pdef_f / 200
					power -= self.mdef * skill.mdef_f / 200
					power = [power, 0].max
				end
				rate = 20
				rate += (user.str * skill.str_f / 100)
				rate += (user.dex * skill.dex_f / 100)
				rate += (user.agi * skill.agi_f / 100)
				rate += (user.int * skill.int_f / 100)
				self.damage = power * rate / 20
				self.damage *= elements_correct(skill.element_set)
				self.damage /= 100
				if self.damage > 0
					if self.guarding?
						self.damage /= 2
					end
				end
				if skill.variance > 0 and self.damage.abs > 0
					amp = [self.damage.abs * skill.variance / 100, 1].max
					self.damage += rand(amp+1) + rand(amp+1) - amp
				end
				eva = 8 * self.agi / user.dex + self.eva
				hit = self.damage < 0 ? 100 : 100 - eva * skill.eva_f / 100
				hit = self.cant_evade? ? 100 : hit
				hit_result = (rand(100) < hit)
				effective |= hit < 100
			end
			if hit_result == true
				if skill.power != 0 and skill.atk_f > 0
					remove_states_shock
					effective = true
				end
				last_hp = self.hp
				self.hp -= self.damage
				effective |= self.hp != last_hp
				@state_changed = false
				effective |= states_plus(skill.plus_state_set)
				effective |= states_minus(skill.minus_state_set)
				if skill.power == 0
					self.damage = ""
					unless @state_changed
						self.damage = "Miss"
					end
				end
			else
				self.damage = "Miss"
			end
			return effective
		end
	end
	
	#============================================================================
	# ■ Game Character
	#============================================================================
	
	class Game_Character
		attr_accessor   :move_type
		attr_accessor   :move_frequency
		attr_accessor   :move_speed
		attr_accessor   :character_name
		attr_accessor   :wait
		attr_accessor   :old_chr_name
		attr_accessor   :old_dir
		attr_accessor   :animating
		#------------------------------------------------------------------------
		alias animation_engine_game_character_initialize initialize
		#------------------------------------------------------------------------
		def initialize
			animation_engine_game_character_initialize
			@animating = false
			@wait = false
			@old_chr_name = @character_name
			@old_dir = @direction
		end
		#------------------------------------------------------------------------
		def animate(animation_name, position, frames, wait, repeat)
			@character_name = animation_name if @animating == false
			@pattern = 0
			@count = 0
			@repeat = repeat
			@direction_fix = true
			@old_dir = @direction
			@direction = position * 2
			@frames = frames
			lock
			@animating = true
			@wait = wait
			@anim_wait_count = @wait
			update
			return
		end
		#------------------------------------------------------------------------
		def update_animate
			if @anim_wait_count > 0
				@anim_wait_count -= 1
				return
			end
			if @pattern >= @frames or moving?
				if !moving?
					if @count < @repeat
						@pattern = 0
						@count += 1
						@anim_wait_count = @wait
						update
						return
					end
				end
				unlock
				@animating = false
				@pattern = 0
				@direction_fix = false
				@direction = @old_dir
				if self.is_a?(Game_Event)
					@character_name = @page != nil ? @page.graphic.character_name : ''
				else
					@character_name = @old_chr_name
				end
				$game_player.refresh
				$game_map.refresh
				return
			end
			@pattern += 1
			@anim_wait_count = @wait
			update
		end
		#------------------------------------------------------------------------
		def update_movement_type
			if @animating == true
				update_animate
				return
			end
			if jumping?
				update_jump
			elsif moving?
				update_move
			else
				update_stop
			end
		end
		#------------------------------------------------------------------------
		def update_movement
			if @stop_count > (40 - @move_frequency * 2) * (6 - @move_frequency)
				case @move_type
				when 1 # Random
					move_type_random
				when 2
					if @runpath
						run_path
					else
						move_type_toward_player
					end
				when 3
					move_type_custom
				when 4
					move_type_escape_player
				end
			end
		end
		#------------------------------------------------------------------------
		# * Move Type : Escape
		#------------------------------------------------------------------------
		def move_type_escape_player
			sx = @x - $game_player.x
			sy = @y - $game_player.y
			abs_sx = sx > 0 ? sx : -sx
			abs_sy = sy > 0 ? sy : -sy
			if sx + sy >= 20
				move_random
				return
			end
			move_away_from_player
		end
		#------------------------------------------------------------------------
		# * Move Type : Approach
		#------------------------------------------------------------------------
		def move_type_toward_player
			sx = @x - $game_player.x
			sy = @y - $game_player.y
			abs_sx = sx > 0 ? sx : -sx
			abs_sy = sy > 0 ? sy : -sy
			if sx + sy >= 20
				move_random
				return
			end
			move_toward_player
		end
		#------------------------------------------------------------------------
		# * Move away from Player
		#------------------------------------------------------------------------
		def move_away_from_player
			sx = @x - $game_player.x
			sy = @y - $game_player.y
			if sx == 0 and sy == 0
				return
			end
			abs_sx = sx.abs
			abs_sy = sy.abs
			if abs_sx == abs_sy
				rand(2) == 0 ? abs_sx += 1 : abs_sy += 1
			end
			if abs_sx > abs_sy
				sx > 0 ? move_right : move_left
				if not moving?
					rand(2) == 1 ? move_down : move_up
				end
			else
				sy > 0 ? move_down : move_up
				if not moving?
					rand(2) == 1 ? move_right : move_left
				end
			end
		end
	end
	
	#============================================================================
	# ■ Game Ranged Weapon
	#============================================================================
	
	class Game_Ranged_Weapon < Game_Character
		#--------------------------------------------------------------------------
		attr_accessor :draw
		attr_accessor :dead
		#--------------------------------------------------------------------------
		def initialize(parent, actor, attack)
			@range = 0
			@step = 0
			@parent = parent
			@actor = actor
			@draw = true
			@dead  = false
			@range_wepaon = $ABS.RANGE_WEAPONS[attack]
			super()
			refresh
		end
		#--------------------------------------------------------------------------
		def refresh
			@move_direction = @parent.direction
			moveto(@parent.x, @parent.y)
			@character_name = @range_wepaon[0]
			@move_speed = @range_wepaon[1]
			@range = @range_wepaon[4]
		end
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			hit_player if x == $game_player.x and y == $game_player.y
			for event in $game_map.events.values
				if event.x == x and event.y == y
					if event.character_name == ""
						froce_movement
					else
						hit_event(event.id)
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		def froce_movement
			case @move_direction
			when 2
				@y += 1
			when 4
				@x -= 1
			when 6
				@x += 1
			when 8
				@y -= 1
			end
		end
		#--------------------------------------------------------------------------
		def update
			super
			return if moving?
			case @move_direction
			when 2
				move_down
			when 4
				move_left
			when 6
				move_right
			when 8
				move_up
			end
			update_step
		end
		#--------------------------------------------------------------------------
		def update_step
			kill if @step >= @range
			@step += 1
		end
		#--------------------------------------------------------------------------
		def hit_player
			actor = $game_party.actors[0]
			enemy = @actor
			$ABS.animate($game_player, $game_player.character_name + '-hit',
				$game_player.direction/2, 4, 3) if $ABS.p_animations
			actor.attack_effect(enemy)
			$game_player.animation_id = @range_wepaon[2] if actor.damage != "Miss" and actor.damage != 0
			$ABS.actor_non_dead?(actor, enemy)
			p " tkqlf"
			kill
		end
		#--------------------------------------------------------------------------
		def hit_event(id)
			actor = $ABS.enemies[id]
			return if actor == nil
			if @parent.is_a?(Game_Player)
				enemy = $game_party.actors[0]
				actor.attack_effect(enemy)
				$game_map.events[id].animation_id = @range_wepaon[2] if actor.damage != "Miss" and actor.damage != 0
				if $ABS.event_non_dead?(actor)
					if actor.engaged == false
						actor.behavior = 3
						actor.linking = true
						actor.engaged = true
						$ABS.set_event_movement(actor)
					end
				end
			else
				enemy = $ABS.enemies[@parent.id]
				actor.attack_effect(enemy)
				event = $game_map.events[id]
				$ABS.animate(event, event.page.graphic.character_name + '-hit',
					event.direction/2, 4, 3, 0) if $ABS.e_animations and actor.damage != "Miss" and actor.damage != 0
				$game_map.events[id].animation_id = @range_wepaon[2] if actor.damage != "Miss" and actor.damage != 0
				$ABS.event_non_dead?(actor, enemy)
			end
			kill
		end
		#--------------------------------------------------------------------------
		def kill
			@dead = true
		end
	end
	
	#============================================================================
	# ■ Game Ranged Skill
	#============================================================================
	
	class Game_Ranged_Skill < Game_Character
		#--------------------------------------------------------------------------
		attr_accessor :draw
		attr_accessor :dead
		#--------------------------------------------------------------------------
		def initialize(parent, actor, skill)
			@range = 0
			@step = 0
			@parent = parent
			@skill = skill
			@actor = actor
			@range_skill = $ABS.RANGE_SKILLS[skill.id]
			@draw = true
			@dead  = false
			super()
			refresh
		end
		#--------------------------------------------------------------------------
		def refresh
			@move_direction = @parent.direction
			moveto(@parent.x, @parent.y)
			@range = @range_skill[0]
			@opacity = 10 if @range == 1
			@move_speed = @range_skill[1]
			@character_name = @range_skill[2]
		end
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			hit_player if x == $game_player.x and y == $game_player.y
			for event in $game_map.events.values
				if event.x == x and event.y == y
					if event.character_name == ""
						froce_movement
					else
						hit_event(event.id)
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		def froce_movement
			case @move_direction
			when 2
				@y += 1
			when 4
				@x -= 1
			when 6
				@x += 1
			when 8
				@y -= 1
			end
		end
		#--------------------------------------------------------------------------
		def update
			super
			return if moving?
			case @move_direction
			when 2
				move_down
			when 4
				move_left
			when 6
				move_right
			when 8
				move_up
			end
			update_step
		end
		#--------------------------------------------------------------------------
		def update_step
			kill if @step >= @range
			@step += 1
		end
		#--------------------------------------------------------------------------
		def hit_player
			actor = $game_party.actors[0]
			enemy = @actor
			actor.effect_skill(enemy, @skill)
			$ABS.animate($game_player, $game_player.character_name + '-hit',
				$game_player.direction/2, 4, 3) if $ABS.p_animations and actor.damage != "Miss" and actor.damage != 0
			$game_player.animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
			$ABS.actor_non_dead?(actor, enemy)
		end
		#--------------------------------------------------------------------------
		def hit_event(id)
			actor = $ABS.enemies[id]
			return if actor == nil
			if @parent.is_a?(Game_Player)
				enemy = $game_party.actors[0]
				actor.effect_skill(enemy, @skill)
				$game_map.events[id].animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
				if $ABS.event_non_dead?(actor, enemy)
					if actor.engaged == false
						actor.behavior = 3
						actor.linking = true
						actor.engaged = true
						$ABS.set_event_movement(actor)
					end
				end
			else
				enemy = $ABS.enemies[@parent.id]
				actor.effect_skill(enemy, @skill)
				$ABS.animate(event, event.page.graphic.character_name + '-hit',
					event.direction/2, 4, 3, 0) if $ABS.e_animations and actor.damage != "Miss" and actor.damage != 0
				$game_map.events[id].animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
				$ABS.event_non_dead?(actor, enemy)
			end
		end
		#--------------------------------------------------------------------------
		def kill
			@dead = true
		end
	end
	
	#============================================================================
	# ■ Game Event
	#============================================================================
	
	class Game_Event < Game_Character
		#--------------------------------------------------------------------------
		alias nf_abs_game_event_refresh_set_page refresh_set_page
		#--------------------------------------------------------------------------
		def name
			return @event.name
		end
		#--------------------------------------------------------------------------
		def id
			return @id
		end
		#--------------------------------------------------------------------------
		def refresh_set_page
			nf_abs_game_event_refresh_set_page
			$ABS.refresh(self, @list, @character_name)
		end
	end
	
	#============================================================================
	# ■ Spriteset Map
	#============================================================================
	
	class Spriteset_Map
		#--------------------------------------------------------------------------
		alias nf_abs_spriteset_map_initialize initialize
		alias nf_abs_spriteset_map_dispose dispose
		alias nf_abs_spriteset_map_update update
		#--------------------------------------------------------------------------
		def initialize
			@ranged = []
			for range in $ABS.range
				sprite = Sprite_Character.new(@viewport1, range)
				@ranged.push(sprite)
			end
			nf_abs_spriteset_map_initialize
		end
		#--------------------------------------------------------------------------
		def dispose
			for range in @ranged
				range.dispose
			end
			nf_abs_spriteset_map_dispose
		end
		#--------------------------------------------------------------------------
		def update
			for range in $ABS.range
				if range.draw == true
					sprite = Sprite_Character.new(@viewport1, range)
					@ranged.push(sprite)
					range.draw = false
				end
			end
			for range in @ranged
				if range.character.dead == true
					$ABS.range.delete(range.character)
					@ranged.delete(range)
					range.dispose
				else
					range.update
				end
			end
			nf_abs_spriteset_map_update
		end
	end
	
	#============================================================================
	# ■ Scene Title
	#============================================================================
	
	class Scene_Title
		#--------------------------------------------------------------------------
		alias nf_abs_scene_title_cng command_new_game
		#--------------------------------------------------------------------------
		def command_new_game
			$ABS = ABS.new
			nf_abs_scene_title_cng
		end
	end
	
	#============================================================================
	# ■ Scene Map
	#============================================================================
	
	class Scene_Map
		#--------------------------------------------------------------------------
		alias nf_abs_scene_map_update update
		#--------------------------------------------------------------------------
		#--------------------------------------------------------------------------
		def update
			$ABS.update
			$ABS.player_attack if Input.triggerd?($ABS.ATTACK_KEY)
			for i in 0..9
				$ABS.player_skill(i) if Input.triggerd?($ABS.SKILL_KEYS[i])
			end
			nf_abs_scene_map_update
		end
	end
	
	#============================================================================
	# ■ Scene Skill
	#============================================================================
	
	class Scene_Skill
		#--------------------------------------------------------------------------
		alias nf_abs_scene_skill_main main
		alias nf_abs_scene_skill_update update
		alias nf_abs_scene_skill_update_skill update_skill
		#--------------------------------------------------------------------------
		def main
			@shk_window = Window_Command.new(250, ["Skill Assigned to Hot Key"])
			@shk_window.visible = false
			@shk_window.active = false
			@shk_window.x = 200
			@shk_window.y = 250
			@shk_window.z = 1500
			nf_abs_scene_skill_main  
			@shk_window.dispose
		end
		#--------------------------------------------------------------------------
		def update
			@shk_window.update
			nf_abs_scene_skill_update
			if @shk_window.active
				update_shk
				return
			end
		end
		#--------------------------------------------------------------------------
		def update_skill
			nf_abs_scene_skill_update_skill
			for i in 0..9
				if Input.triggerd?($ABS.SKILL_KEYS[i])
					$game_system.se_play($data_system.decision_se)
					@skill_window.active = false
					@shk_window.active = true
					@shk_window.visible = true
					$ABS.skills[i] = @skill_window.skill.id 
				end
			end
		end
		#--------------------------------------------------------------------------
		def update_shk
			if Input.trigger?(Input::C)
				$game_system.se_play($data_system.decision_se)
				@shk_window.active = false
				@shk_window.visible = false
				@skill_window.active = true
				$scene = Scene_Skill.new(@actor_index)
				return
			end
		end
	end
	
	#============================================================================
	# ■ Scene Load
	#============================================================================
	
	class Scene_Load < Scene_File
		#--------------------------------------------------------------------------
		alias nf_abs_scene_load_read_data read_data
		#--------------------------------------------------------------------------
		def read_data(file)
			nf_abs_scene_load_read_data(file)
			$ABS = Marshal.load(file)
		end
	end
	#============================================================================
	# ■ Scene Save
	#============================================================================
	
	class Scene_Save < Scene_File
		#--------------------------------------------------------------------------
		alias nf_abs_scene_save_write_data write_data
		#--------------------------------------------------------------------------
		def write_data(file)
			nf_abs_scene_save_write_data(file)
			Marshal.dump($ABS, file)
		end
	end
	
	#--------------------------------------------------------------------------
	# * End SDK Enable Test
	#--------------------------------------------------------------------------
end