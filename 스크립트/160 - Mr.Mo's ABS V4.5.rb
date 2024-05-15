$exp_limit = 45 # 한번에 최대 얻을 수 있는 경험치 퍼센트
$exp_event = 0 # 경험치 이벤트

SDK.log("Mr.Mo's ABS", "Mr.Mo", 4.5, "01/04/06")
#--------------------------------------------------------------------------
# * Begin SDK Enable Test
#--------------------------------------------------------------------------
if SDK.state("Mr.Mo's ABS") == true
	#--------------------------------------------------------------------------
	# * Constants - MAKE YOUR EDITS HERE
	#--------------------------------------------------------------------------
	ATTACK_KEY = Input::Letters["S"]
	#~ ATTACK_KEY = 32
	#--------------------------------------------------------------------------
	SKILL_KEYS = {
		Input::Numberpad[0] => 0,
		Input::Numberpad[1] => 0,
		Input::Numberpad[2] => 0,
		Input::Numberpad[3] => 0,
		Input::Numberpad[4] => 0,
		Input::Numberpad[5] => 0,
		Input::Numberpad[6] => 0,
		Input::Numberpad[7] => 0,
		Input::Numberpad[8] => 0,
		Input::Numberpad[9] => 0,
		
		Input::Numberkeys[0] => 0,
		Input::Numberkeys[1] => 0,
		Input::Numberkeys[2] => 0,
		Input::Numberkeys[3] => 0,
		Input::Numberkeys[4] => 0,
		Input::Numberkeys[5] => 0,
		Input::Numberkeys[6] => 0,
		Input::Numberkeys[7] => 0,
		Input::Numberkeys[8] => 0,
		Input::Numberkeys[9] => 0,
		
		Input::Underscore => 0,
		Input::Equal => 0,
		Input::Letters["Z"] => 0,
		Input::Letters["X"] => 0,
	}
	
	ITEM_KEYS =  {
		Input::Numberpad[0] => 0,
		Input::Numberpad[1] => 0,
		Input::Numberpad[2] => 0,
		Input::Numberpad[3] => 0,
		Input::Numberpad[4] => 0,
		Input::Numberpad[5] => 0,
		Input::Numberpad[6] => 0,
		Input::Numberpad[7] => 0,
		Input::Numberpad[8] => 0,
		Input::Numberpad[9] => 0,
		
		Input::Numberkeys[0] => 0,
		Input::Numberkeys[1] => 0,
		Input::Numberkeys[2] => 0,
		Input::Numberkeys[3] => 0,
		Input::Numberkeys[4] => 0,
		Input::Numberkeys[5] => 0,
		Input::Numberkeys[6] => 0,
		Input::Numberkeys[7] => 0,
		Input::Numberkeys[8] => 0,
		Input::Numberkeys[9] => 0,
		
		Input::Underscore => 0,
		Input::Equal => 0,
		Input::Letters["Z"] => 0,
		Input::Letters["X"] => 0,
	}
	
	#--------------------------------------------------------------------------
	#Ranged Weapons 범위 무기
	# RANGE_WEAPONS[Weapon_ID] = 
	#[Character Set Name, Move Speed, Animation, Ammo, Range,  Mash Time(in seconds), Kick Back(in tiles),Animation Suffix]
	#[캐릭터 이름, 이동속도, 맞을 때 애니메이션, 소모할 아이템, 범위, 후딜, 넉백정도]
	#-------------------------------------------------------------------------
	RANGE_WEAPONS = {}
	RANGE_WEAPONS[31] = ["(스킬)화살", 6, 109, 75, 15, 2, 1] 	# 활
	#--------------------------------------------------------------------------
	# 플레이어가 죽을때 게임오버 할거냐
	GAME_OVER_DEAD = false # 아니
	# 리더가 죽으면 다음 멤버가 리더가 될거?
	NEXT_LEADER = false #아니
	#--------------------------------------------------------------------------
	#Mash Time
	# 공격 딜레이 초단위
	MASH_TIME = 4
	
	# 백만 넘어가는 체력 설정
	ABS_ENEMY_HP = {}
	#ABS_ENEMY_HP[37]  = [20, 0] # 무적토끼
	ABS_ENEMY_HP[37]  = [2000000000, 0] # 무적토끼
	ABS_ENEMY_HP[269] = [2000000, 0] # 무적다람쥐
	
	# 기타
	ABS_ENEMY_HP[58] = [800000, 1] # 수룡
	ABS_ENEMY_HP[59] = [800000, 1] # 화룡
	
	ABS_ENEMY_HP[61] = [5000000, 1] # 주작
	ABS_ENEMY_HP[62] = [5000000, 1] # 백호
	
	ABS_ENEMY_HP[98] = [2500000, 1] # 비류장군
	
	ABS_ENEMY_HP[111] = [600000, 1] # 산적왕
	
	ABS_ENEMY_HP[102] = [100000000, 1] # 반고
	ABS_ENEMY_HP[112] = [20000000, 1] # 청룡
	ABS_ENEMY_HP[113] = [20000000, 1] # 현무
	
	# 12 지신
	ABS_ENEMY_HP[119] = [1500000, 1] # 백호왕
	ABS_ENEMY_HP[123] = [1000000, 1] # 뱀왕
	ABS_ENEMY_HP[124] = [150000, 1] # 쥐왕
	ABS_ENEMY_HP[126] = [450000, 1] # 돼지왕
	ABS_ENEMY_HP[128] = [1700000, 1] # 원숭이왕
	ABS_ENEMY_HP[132] = [3600000, 1] # 건룡
	ABS_ENEMY_HP[133] = [3600000, 1] # 감룡
	ABS_ENEMY_HP[134] = [3600000, 1] # 진룡
	
	# 용궁
	ABS_ENEMY_HP[150] = [2000000, 1] # 해마장군
	ABS_ENEMY_HP[153] = [4000000, 1] # 인어장군
	ABS_ENEMY_HP[156] = [7000000, 1] # 상어장군
	ABS_ENEMY_HP[158] = [12000000, 1] # 해파리장군
	ABS_ENEMY_HP[159] = [20000000, 1] # 거북장군
	ABS_ENEMY_HP[160] = [1000000, 0] # 수괴
	
	# 일본
	ABS_ENEMY_HP[172] = [300000, 1] # 아귀
	ABS_ENEMY_HP[176] = [700000, 1] # 백향
	ABS_ENEMY_HP[180] = [3200000, 1] # 견귀
	ABS_ENEMY_HP[194] = [7000000, 1] # 문려
	
	ABS_ENEMY_HP[186] = [10000000, 1] # 무사
	
	ABS_ENEMY_HP[187] = [1100000, 0] # 선월
	ABS_ENEMY_HP[188] = [1200000, 0] # 이광
	ABS_ENEMY_HP[189] = [20000000, 1] # 주마관
	
	ABS_ENEMY_HP[191] = [8000000, 1] # 유성지
	ABS_ENEMY_HP[192] = [15000000, 1] # 해골왕
	ABS_ENEMY_HP[193] = [60000000, 1] # 파괴왕
	
	# 중국
	ABS_ENEMY_HP[204] = [150000, 1]# 인묘
	ABS_ENEMY_HP[208] = [300000, 1]# 염유왕
	ABS_ENEMY_HP[212] = [1000000, 1]# 기린왕
	ABS_ENEMY_HP[215] = [2000000, 1]# 악어왕
	
	ABS_ENEMY_HP[220] = [3000000, 1]# 산소괴왕
	ABS_ENEMY_HP[224] = [7000000, 1]# 괴성왕
	ABS_ENEMY_HP[227] = [1300000, 0]# 뇌신'태
	ABS_ENEMY_HP[228] = [18000000, 1]# 뇌신왕
	
	ABS_ENEMY_HP[229] = [1500000, 0]# 연청천구
	ABS_ENEMY_HP[230] = [1600000, 0]# 연자천구
	ABS_ENEMY_HP[231] = [30000000, 1] # 천구왕
	
	ABS_ENEMY_HP[232] = [90000000, 1] # 산신대왕
	ABS_ENEMY_HP[233] = [5000000, 0]# 산신전사
	ABS_ENEMY_HP[234] = [3000000, 0]# 산신도사
	ABS_ENEMY_HP[235] = [4000000, 0]# 산신도적
	ABS_ENEMY_HP[236] = [3000000, 0]# 산신주술사
	
	# 환상의섬
	ABS_ENEMY_HP[246] = [5000000, 1]	# 선장망령
	ABS_ENEMY_HP[249] = [1500000, 1]	# 야월진랑
	
	ABS_ENEMY_HP[250] = [1700000, 0]	# 철보장
	ABS_ENEMY_HP[251] = [1800000, 0]	#	철거인
	ABS_ENEMY_HP[252] = [60000000, 1]	# 마려
	
	ABS_ENEMY_HP[253] = [5000000, 1]	# 현무
	ABS_ENEMY_HP[257] = [2000000, 1]	# 태산
	ABS_ENEMY_HP[258] = [30000000, 1]	# 길림장군
	ABS_ENEMY_HP[259] = [500000000, 1]# 가릉빈가
	
	# 한두고개
	ABS_ENEMY_HP[268] = [7777777, 1]# 최강다람쥐
	ABS_ENEMY_HP[269] = [22222222, 1]# 무적다람쥐
	
	# 몬스터 경험치 설정
	ENEMY_EXP = {} # [var, (hp_per, sp_per)(배율)]
	# 파티 퀘스트
	ENEMY_EXP[45] = [60000, 1.5, 1.5] # 산속군사
	
	ENEMY_EXP[91] = [600000, 5.0, 5.0] # 비류성창병
	ENEMY_EXP[96] = [1500000, 7.0, 7.0] # 비류성자객
	ENEMY_EXP[97] = [1500000, 9.0, 9.0] # 비류성수문장
	ENEMY_EXP[90] = [3000000, 15.0, 15.0] # 비류성정예군
	ENEMY_EXP[98] = [10000000, 100.0, 100.0] # 비류장군
	
	ENEMY_EXP[254] = [5000000, 10.0, 10.0] # 뇌랑
	ENEMY_EXP[255] = [6000000, 11.0, 11.0] # 왕가
	ENEMY_EXP[256] = [10000000, 20.0, 20.0] # 조왕
	ENEMY_EXP[257] = [50000000, 30.0, 30.0] # 태산
	ENEMY_EXP[258] = [500000000, 1000.0, 1000.0] # 길림장군
	
	# 4차 퀘스트
	ENEMY_EXP[102] = [160000000] # 반고
	
	# 12지신
	ENEMY_EXP[132] = [11600000] # 건룡
	ENEMY_EXP[133] = [11600000] # 감룡
	ENEMY_EXP[134] = [11600000] # 진룡
	
	# 용궁
	ENEMY_EXP[150] = [7000000] # 해마장군
	ENEMY_EXP[153] = [15000000] # 인어장군
	ENEMY_EXP[156] = [27000000] # 상어장군
	ENEMY_EXP[158] = [40000000] # 해파리장군
	ENEMY_EXP[159] = [80000000] # 거북장군
	
	# 일본
	ENEMY_EXP[194] = [17000000] # 문려
	ENEMY_EXP[186] = [27500000] # 무사
	ENEMY_EXP[189] = [45000000] # 주마관
	
	ENEMY_EXP[191] = [50000000] # 유성지
	ENEMY_EXP[192] = [70000000] # 해골왕
	ENEMY_EXP[193] = [350000000] # 파괴왕
	
	
	# 중국
	ENEMY_EXP[224] = [15000000]# 괴성왕
	ENEMY_EXP[228] = [36000000] # 뇌신왕
	ENEMY_EXP[231] = [70000000] # 천구왕
	
	ENEMY_EXP[232] = [700000000] # 산신대왕
	ENEMY_EXP[233] = [14500000]# 산신전사
	ENEMY_EXP[234] = [9000000]# 산신도사
	ENEMY_EXP[235] = [11500000]# 산신도적
	ENEMY_EXP[236] = [9500000]# 산신주술사
	
	# 환상의섬
	ENEMY_EXP[246] = [15000000]	# 선장망령
	ENEMY_EXP[252] = [300000000] # 마려
	ENEMY_EXP[259] = [4000000000] # 가릉빈가
	
	# 한두고개
	ENEMY_EXP[268] = [9999999, 0]# 최강다람쥐
	ENEMY_EXP[269] = [22222222, 0]# 무적다람쥐
	#--------------------------------------------------------------------------
	#데미지 뜨게 할거임?
	DISPLAY_DAMAGE = true
	#--------------------------------------------------------------------------
	#단축키 등록 메시지
	HOTKEY_SAY = "단축키등록"
	#--------------------------------------------------------------------------
	#Terrain Tag
	PASS_TAG = 1
	#--------------------------------------------------------------------------
	ANIMATE_PLAYER = false
	ANIMATE_ENEMY = false
	
	# 레벨업 표시
	DISPLAY_LEVELUP = true
	# 레벨업시 음악
	LEVELUP_MUSIC = "Level UP"
	#--------------------------------------------------------------------------
	#Fade dead?
	FADE_DEAD = true
	#--------------------------------------------------------------------------
	#Can Hurt Allies
	CAN_HURT_ALLY = true
	#--------------------------------------------------------------------------
	ANIMATION_DIVIDE = 2
	#--------------------------------------------------------------------------
	DAMAGE_FONT_NAME = "메이플스토리"
	DAMAGE_FONT_NAME2 = "맑은 고딕"
	#--------------------------------------------------------------------------
	DAMAGE_FONT_SIZE = 19
	DAMAGE_CRI_FONT_SIZE = 22
	#--------------------------------------------------------------------------
	# To change the color you need to adjust the numbers below.
	# The numbers reperesnt 3 colors, red, greend and blue. All you have to do is
	# just change the numbers.
	# Color.new(RED,GREEN,BLUE)
	DAMAGE_FONT_COLOR = Color.new(0,0,0)
	#--------------------------------------------------------------------------
	# 부활 아이템 있으면 부활 가능~
	REVIVE = true
	# Death(Knockout) state Id
	DEATH_STATE_ID = 1
	#--------------------------------------------------------------------------
	# * Class Mo ABS - DO NOT EDIT BELOW, if you don't know what you are doing :)
	#--------------------------------------------------------------------------
	
	class MrMo_ABS
		#--------------------------------------------------------------------------
		# * Public Instance Variables
		#--------------------------------------------------------------------------
		attr_accessor :enemies     #Enemy List
		attr_accessor :can_dash    #Player Dash Boolean
		attr_accessor :can_sneak   #Player Sneak Boolean
		attr_accessor :can_update_states # Update States
		attr_accessor :attack_key  #Attack Key
		attr_accessor :skill_keys  #Skill Keys
		attr_accessor :item_keys   #Item Keys
		attr_accessor :range
		attr_accessor :damage_display
		attr_accessor :dash_max
		attr_accessor :dash_min
		attr_accessor :sneak_max
		attr_accessor :sneak_min
		attr_accessor :active
		attr_accessor :button_mash
		attr_accessor :char_dir
		#--------------------------------------------------------------------------
		# * Object Initialization
		# 생성자, 변수 초기화
		#--------------------------------------------------------------------------
		def initialize
			#ABS Enemy Variables
			@enemies = {}
			#Attack Key
			@attack_key = ATTACK_KEY
			#Skill Keys
			@skill_keys = SKILL_KEYS
			#Item Keys
			@item_keys = ITEM_KEYS
			
			#Button Mash (스킬 후딜레이)
			@skill_mash = {}
			# 아이템 후딜레이
			@item_mash = 0
			# 공격키 후 딜레이
			@attack_mash = 0
			
			#Ranged Skills and Weapons
			@range = []
			#Display Demage true:false
			@damage_display = DISPLAY_DAMAGE
			#Player Animated?
			@player_ani = ANIMATE_PLAYER
			#Enemy Animated?
			@enemy_ani = ANIMATE_ENEMY
			#Get Hate
			@get_hate = true
			
			# ABS Active
			@active = true
			@char_dir = Dir.entries("./Graphics/Characters")
		end
		# 반환 함수들
		#--------------------------------------------------------------------------
		# * Range Weapons
		#--------------------------------------------------------------------------
		def RANGE_WEAPONS
			return RANGE_WEAPONS
		end
		#--------------------------------------------------------------------------
		# * Damage Font Size
		#--------------------------------------------------------------------------
		def DAMAGE_FONT_SIZE
			return DAMAGE_FONT_SIZE
		end
		
		def DAMAGE_CRI_FONT_SIZE
			return DAMAGE_CRI_FONT_SIZE
		end
		#--------------------------------------------------------------------------
		# * Damage Font Name
		#--------------------------------------------------------------------------
		def DAMAGE_FONT_NAME
			return DAMAGE_FONT_NAME
		end
		#--------------------------------------------------------------------------
		# * Damage Font Color
		#--------------------------------------------------------------------------
		def DAMAGE_FONT_COLOR
			return DAMAGE_FONT_COLOR
		end
		#--------------------------------------------------------------------------
		# * Range Skills
		#--------------------------------------------------------------------------
		def RANGE_SKILLS
			return RANGE_SKILLS
		end
		#--------------------------------------------------------------------------
		# * Range Explode
		#--------------------------------------------------------------------------
		def RANGE_EXPLODE
			return RANGE_EXPLODE
		end
		#--------------------------------------------------------------------------
		# * Hotkey
		#--------------------------------------------------------------------------
		def HOTKEY_SAY
			return HOTKEY_SAY
		end
		#--------------------------------------------------------------------------
		# * Pass Tag
		#--------------------------------------------------------------------------
		def PASS_TAG
			return PASS_TAG
		end
		#--------------------------------------------------------------------------
		# * Animation Divide
		#--------------------------------------------------------------------------
		def ANIMATION_DIVIDE
			return ANIMATION_DIVIDE
		end
		#--------------------------------------------------------------------------
		# * ABS Refresh(Event, List, Characterset Name) 새로고침
		#--------------------------------------------------------------------------
		def refresh(event, list, character_name)
			if event.character_name != "" and !@char_dir.include?(event.character_name + ".png")
				event.character_name = "공격스킬2"
			end
			
			@get_hate = true
			@enemies.delete(event.id) #Delete the event from the list
			return if list == nil # 이벤트가 없다면 무시
			
			parameters = SDK.event_comment_input(event, 11, "ABS")
			return if parameters.nil? 
			
			#Get Enemy ID
			id = parameters[0].split
			id = id[1].to_i
			
			enemy = $data_enemies[id] 
			return if enemy == nil
			@enemies[event.id] = ABS_Enemy.new(enemy.id)
			@enemies[event.id].event_id = event.id
			event.name = "[id#{@enemies[event.id].name}]" if @enemies[event.id].name != ""
			
			sw = event.character_name == "공격스킬2"
			if ABS_ENEMY_CHAR[enemy.id] && sw
				char_name = "(몬)" + ABS_ENEMY_CHAR[enemy.id][0]
				hue = ABS_ENEMY_CHAR[id][1] || 0
				opcity = ABS_ENEMY_CHAR[id][2] || 255
				event.es_set_graphic(char_name, opcity, hue) if @char_dir.include?(char_name + ".png")
			end
			
			@enemies[event.id].event = event
			n = parameters[0].split[1].to_i
			if $enemy_spec.spec(n) != nil
				spec = $enemy_spec.spec(n)
			else
				spec = parameters[1..10].map { |param| param.split[1] }
			end
			
			@enemies[event.id].behavior = spec[0].to_i
			@enemies[event.id].see_range = spec[1].to_i
			@enemies[event.id].hear_range = spec[2].to_i
			@enemies[event.id].closest_enemy = spec[3]
			@enemies[event.id].hate_group = spec[4]
			@enemies[event.id].aggressiveness = spec[5]
			@enemies[event.id].temp_speed = spec[6].to_i
			@enemies[event.id].temp_frequency = spec[7].to_i
			@enemies[event.id].trigger = spec[8]
			@enemies[event.id].respawn = spec[9].to_i * 6 if spec[9]
			
			if @enemies[event.id].event.move_type != 3
				@enemies[event.id].event.move_speed = @enemies[event.id].temp_speed
				@enemies[event.id].event.move_frequency = @enemies[event.id].temp_frequency
			end
			
			@enemies[event.id].aggro = $is_map_first
			@enemies[event.id].aggressiveness = (@enemies[event.id].aggressiveness * 45.0 + rand(3) - 2) / 45.0 
		end
		
		#--------------------------------------------------------------------------
		# * Update(Frame) 1프레임마다 실행되는 함수
		#--------------------------------------------------------------------------
		def update
			#Update Player
			if (Graphics.frame_count % (Graphics.frame_rate / 5) == 0)
				$skill_Delay_Console.refresh if $skill_Delay_Console != nil and $skill_Delay_Console.tog
			end
			update_player if @active
			update_enemy if @enemies != {} and @active #Update Enemy AI
			for range in @range
				next if range == nil
				range.update
			end
			$rpg_skill.update_buff
			update_equip_effects
		end
		
		#--------------------------------------------------------------------------
		# * 몬스터가 리스폰 될떄 현재 맵에서 랜덤으로 스폰 될 수 있도록
		#--------------------------------------------------------------------------
		def rand_spawn(e) # 몬스터 데이터를 받음
			# 제자리 스폰할 애들은 냅두기
			return if e.name.include?("무적토끼")
			x = e.x
			y = e.y
			d = e.direction
			
			h = $game_map.height
			w = $game_map.width
			
			count = 0
			while count < 10000
				count += 1
				x = rand(w)
				y = rand(h)
				if $game_map.passable?(x, y, d)
					e.moveto(x, y)
					Network::Main.socket.send("<mon_move>#{e.event.id},#{d},#{x},#{y}</mon_move>\n") if @enemies[e.event.id].aggro
					return
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * ABS 비활성화 여부 확인
		#--------------------------------------------------------------------------
		def active_ok
			#~ return false if Hwnd.include?("NetPartyInv")
			#~ return false if Hwnd.include?("Trade")
			#~ return false if Hwnd.include?("Npc_dialog")
			#~ return false if Hwnd.include?("Item_Drop")
			#~ return false if Hwnd.include?("Shop_Num_Window")
			#~ return false if $map_chat_input.active # 채팅이 활성화 된게 아니라면
			return false if Hwnd.include?("Keyset_menu") # 단축키 지정
			return false if $inputKeySwitch # 채팅이 활성화 된게 아니라면
			return true
		end
		
		#--------------------------------------------------------------------------
		# * 로그아웃 등 스킬 버프, 딜레이 초기화
		#--------------------------------------------------------------------------
		def close_buff(actor = $game_party.actors[0])
			# 스킬 딜레이 초기화
			SKILL_MASH_TIME.each { |skill_mash| skill_mash[1][1] = 0 if skill_mash[1][1] > 0 }
			
			buff_data = actor.buff_time
			buff_data.each do |buff|
				id = buff[0]
				$rpg_skill.buff_del(id)
			end
			
			return if actor != $game_party.actors[0]
			return if $skill_Delay_Console == nil
			
			$skill_Delay_Console.refresh
			$skill_Delay_Console.refresh
			$skill_Delay_Console.dispose
		end
		
		#--------------------------------------------------------------------------
		# 특정 장비를 착용할 때 효과 
		#--------------------------------------------------------------------------
		def update_equip_effects
			equip_ids = [
				$game_party.actors[0].armor1_id,
				$game_party.actors[0].armor2_id,
				$game_party.actors[0].armor3_id,
				$game_party.actors[0].armor4_id
			]
			
			# EQUIP_EFFECTS[33] = [[10 * sec, "hp", 1], [10 * sec, "sp", 1]] # 도깨비부적
			equip_ids.each do |id|
				next unless EQUIP_EFFECTS[id]
				
				EQUIP_EFFECTS[id].each do |effect|
					next unless Graphics.frame_count % effect[0] == 0
					
					type, val = effect[1], effect[2]
					case type
					when "hp"
						$game_party.actors[0].hp += ($game_party.actors[0].maxhp * val / 100.0).to_i 
					when "sp"
						$game_party.actors[0].sp += ($game_party.actors[0].maxsp * val / 100.0).to_i
					when "com"
						$game_temp.common_event_id = val
					when "buff"
						$rpg_skill.buff_active(val) unless $rpg_skill.check_buff(val)
					when "custom"	
						handle_custom_effect(id, val)
					end
				end
			end
		end
		
		# 커스텀 효과 처리
		def handle_custom_effect(id, val)
			case id
			when 1
				# 처리할 내용 추가
			end
		end
		
		#--------------------------------------------------------------------------
		# * Update Enemy AI(Frame)
		#--------------------------------------------------------------------------
		def update_enemy
			# 적 리스트 가져옴
			for enemy in @enemies.values
				#Skip NIL values
				next if enemy == nil
				if enemy.dead?
					next
				else # 죽지도 않았는데 캐릭터가 없다? 그러면 죽어
					if enemy.event.character_name == ""
						@enemies.delete(enemy.event.id)
						next 
					end
				end
				
				update_enemy_state(enemy) # 적 캐릭터의 상태 업데이트
				update_enemy_skill_mash(enemy) # 적 캐릭터의 스킬 쿨타임 업데이트
				update_enemy_phase(enemy) # 적 체력에 따른 페이즈 관리
				update_enemy_aggro(enemy) # 어그로 상태 확인
				
				# 전투중이아니고 공격성 ai가 false면 무시
				next if !enemy.in_battle and !update_enemy_ai(enemy)
				
				update_enemy_battle(enemy) if enemy.in_battle and enemy.behavior != 0
			end
			@get_hate = false
		end
		
		#--------------------------------------------------------------------------
		# 적 캐릭터의 상태 업데이트 : 버프, 디버프등 상태 
		#--------------------------------------------------------------------------
		def update_enemy_state(enemy)
			enemy.buff_time.each do |buff_data|
				id, remaining_turns = buff_data[0], buff_data[1]
				next unless remaining_turns > 0
				
				enemy.buff_time[id] -= 1 
				$rpg_skill.buff_del(id, enemy) if enemy.buff_time[id] == 0
			end
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 스킬 쿨타임 업데이트 : 버프, 디버프등 상태 
		#--------------------------------------------------------------------------
		def update_enemy_skill_mash(enemy)
			return if enemy.skill_mash == nil
			enemy.skill_mash.each { |mash| enemy.skill_mash[mash[0]] -= 1 if mash[1] > 0 }
		end
		
		#--------------------------------------------------------------------------
		# * Update Enemy Battle(Enemy)
		#--------------------------------------------------------------------------
		def update_enemy_battle_check(enemy)
			return true if enemy.attacking == nil
			return true if enemy.attacking.actor.dead?
			return true if !enemy.hate_group.include?(enemy.attacking.enemy_id)
			return true if !in_range?(enemy.event, enemy.attacking.event, enemy.see_range)
			return true if !in_range?(enemy.event, enemy.attacking.event, enemy.hear_range)
			return true if !enemy.aggro
			return false 
		end
		
		def update_enemy_battle(enemy)
			return if enemy == nil
			return if update_enemy_casting(enemy)
			return update_enemy_attack(enemy, enemy.attacking) if enemy.casting_action != nil
			
			# 만약 적의 시야에 들어오지 않거나 목표로 설정한 적이 죽었거나 어그로가 풀리면 원래대로 돌아옴
			if enemy.attacking == nil or update_enemy_battle_check(enemy)	
				# 원래 움직임으로 돌아옴
				restore_movement(enemy)
				# 적대모드 풀림
				enemy.in_battle = false
				enemy.attacking = nil
				return
			end      
			
			# 공격주기마다 행동 시작
			update_enemy_attack(enemy, enemy.attacking) if Graphics.frame_count % (enemy.aggressiveness * 45.0).to_i == 0
			return if enemy == nil
			return if enemy.attacking == nil
			
			enemy.event.move_to(enemy.attacking.event) if !in_range?(enemy.event, enemy.attacking.event, 1)
			enemy.event.turn_to(enemy.attacking.event) if !in_direction?(enemy.event, enemy.attacking.event) and in_range?(enemy.event, enemy.attacking.event, 1)
		end
		
		# 몬스터 어그로 설정
		def update_enemy_aggro(enemy)
			return if !enemy.hate_group.include?(0)
			return if !enemy.aggro
			
			enemy.aggro_mash -= 1 if enemy.aggro_mash > 0
			return if enemy.aggro_mash > 0	
			
			aggro_user = []
			aggro_user.push($game_party.actors[0].name) if in_range?(enemy.event, $game_player, enemy.see_range)
			
			for player in Network::Main.mapplayers.values
				next if player == nil
				aggro_user.push(player.name) if in_range?(enemy.event, player, enemy.see_range)
			end
			return if aggro_user.size <= 0
			
			rand_idx = rand(aggro_user.size)
			aggro_name = aggro_user[rand_idx]
			return if aggro_name == nil
			
			enemy.aggro = false
			Network::Main.socket.send("<aggro>#{enemy.event.id},#{aggro_name}</aggro>\n")
			if aggro_name == $game_party.actors[0].name
				enemy.aggro = true
				enemy.aggro_mash = 5 * 60	
			end
		end
		
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 공격성
		#--------------------------------------------------------------------------
		def update_enemy_ai(enemy)
			b = enemy.behavior
			return true if b == 0 # Dummy
			return true if b == 1 and !can_enemy_see(enemy)
			return true if b == 2 and !can_enemy_hear(enemy)
			return true if b == 3 and !can_enemy_see(enemy) and !can_enemy_hear(enemy)
			return true if b == 4 and !enemy_ally_in_battle?(enemy)
			return true if b == 5 and !can_enemy_see(enemy) and !can_enemy_hear(enemy) and !enemy_ally_in_battle?(enemy)
			return false
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터가 강력한 스킬을 사용하기전 주문 외우는 함수
		#--------------------------------------------------------------------------
		def update_enemy_casting(enemy)
			if enemy.casting_mash > 0
				enemy.casting_mash -= 1 
				return true if enemy.casting_mash > 0
				
				enemy.casting_idx += 1
				data = ABS_ENEMY_SKILL_CASTING[enemy.casting_action.skill_id]
				if data[enemy.casting_idx] == nil
					enemy.casting_idx = 0
					return false
				else
					enemy.casting_mash = data[enemy.casting_idx][0] * Graphics.frame_rate
					$rpg_skill.casting_chat(data[enemy.casting_idx], enemy.event)
					return true
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 행동, 공격 또는 스킬
		#--------------------------------------------------------------------------
		def update_enemy_attack(e, actor)
			return unless e
			return unless e.actions
			return if e.actions.empty?
			
			e.actions.each do |action|
				if e.casting_action != nil
					action = e.casting_action
				else
					next if enemy_pre_attack(e, action)
				end
				
				case action.kind
				when 0 # 기본공격
					case action.basic
					when 0 #Attack
						next if e.event.moving?
						next if !in_range?(e.event, actor.event, 1)
						next if !in_direction?(e.event, actor.event)
						
						a = actor.is_a?(ABS_Enemy) ? actor : $game_party.actors[0]
						a.attack_effect(e)
						
						# 애니메이션 실행
						animation_melee(e.event.direction, e.event)
						hit_enemy(actor, e) if a.damage != "Miss" and a.damage != 0
						
						return if enemy_dead?(a, e)
						return if !a.is_a?(ABS_Enemy) # a가 플레이어면 무시
						return if a.attacking == e and a.in_battle # a가 적 캐릭이면 e를 쫒아감
						
						a.attacking = e # a가 적캐릭터일 경우 e를 적대하게 됨
						a.in_battle = true
						setup_movement(e)
						return
					when 1..3 #Nothing
						return
					end
					
				when 1..2 #Skill 적 캐릭의 스킬 사용
					skill = $data_skills[action.skill_id]
					next if skill.nil? || (!e.casting_action && !e.can_use_skill?(skill))
					
					range = nil
					range = RANGE_SKILLS[skill.id][0] if RANGE_SKILLS.has_key?(skill.id)
					range = RANGE_EXPLODE[skill.id][0] if RANGE_EXPLODE.has_key?(skill.id)
					next if range && !in_range?(e.event, actor.event, range + 1)
					
					# 스킬 쿨타임 갱신
					e.skill_mash[skill.id] = SKILL_MASH_TIME[skill.id][0] if SKILL_MASH_TIME[skill.id] != nil 
					return if enemy_casting_action(e, action, skill)
					
					# 캐스팅 초기화
					if e.casting_action != nil
						e.casting_mash = 0
						e.casting_action = nil
						e.casting_idx
					end
					
					# 스킬을 받는 타입
					case skill.scope
					when 1 # One Enemy 적 한놈만 				
						target_type = 0
						target_type = 1	if RANGE_SKILLS.has_key?(skill.id)
						target_type = 2	if RANGE_EXPLODE.has_key?(skill.id)
						
						dir_arr = SKILL_DIRECTION.has_key?(skill.id) ? Marshal.load(Marshal.dump(SKILL_DIRECTION[skill.id])) : []
						dir_arr << e.event.direction if !dir_arr.include?(e.event.direction)
						
						case target_type
						when 0 # 원거리 스킬이 아닌것
							$rpg_skill.active_skill(skill.id, e.event, e)
						when 1 # 원거리
							for dir in dir_arr
								@range.push(Game_Ranged_Skill.new(e.event, e, skill, dir)) # e가 날리는 스킬을 구현해줌
								Network::Main.send_with_tag("show_range_skill", "#{0},#{e.event.id},#{skill.id},#{0},#{dir}")
							end
						when 2 # 폭발
							for dir in dir_arr
								@range.push(Game_Ranged_Explode.new(e.event, e, skill, dir))
								Network::Main.send_with_tag("show_range_skill", "#{0},#{e.event.id},#{skill.id},#{1},#{dir}")
							end
						end
						
					when 2 #All Emenies 적 전체
						next if !RANGE_SKILLS.has_key?(skill.id)
						
						range = RANGE_SKILLS[skill.id][0]
						
						enemies = get_all_range(e.event, range) # 스킬 범위내 있는 모든 적 추가
						enemies.push($game_player) if e.hate_group.include?(0) and in_range?($game_player, e.event, range)
						enemies_net = get_all_range_net(e.event, range) if e.hate_group.include?(0)
						
						# 범위 이펙트 보여주기
						make_range_sprite(e.event, range, skill, true)
						
						for enemy in enemies
							next if !e.hate_group.include?(enemy.id)
							next if enemy == nil #Skip NIL values
							next if !enemy.is_a?(Game_Player) and enemy.dead? 
							
							hit_num = RANGE_SKILLS[skill.id][5] || 1
							hit_num.times{
								enemy.actor.effect_skill(e, skill)
								hit_enemy(enemy, e, skill.animation2_id) if enemy.actor.damage != "Miss" and enemy.actor.damage != 0
							}
							
							next if enemy_dead?(enemy.actor, e)
							next if enemy.is_a?(Game_Player)
							next if enemy.attacking == e and enemy.in_battle
							
							enemy.in_battle = true
							enemy.attacking = e
							setup_movement(e)
						end
						
						if enemies_net != nil
							for player in enemies_net
								Network::Main.socket.send("<e_skill_effect>#{player.name},#{e.event.id},#{skill.id}</e_skill_effect>\n")	# 몬스터 스킬 맞음
							end
						end
					end
					
					$rpg_skill.heal(skill.id, e) # 이게 회복 스킬인지 확인
					$rpg_skill.buff(skill.id, e) # 이게 버프 스킬인지 확인
					
					e.event.animation_id = skill.animation1_id # Animate the enemy
					Network::Main.ani(e.event.id, skill.animation1_id, 1)
					
					e.sp = [e.sp - skill.sp_cost, 0].max
					send_network_monster(e)
					$rpg_skill.skill_chat(skill, e.event) 
					return
				end
			end
		end
		
		def enemy_casting_action(e, action, skill)
			return false if e.casting_action
			
			id = skill.id
			cast_data = ABS_ENEMY_SKILL_CASTING[id] # 캐스팅 갱신
			return false unless cast_data
			
			e.casting_idx = 0
			e.casting_mash = cast_data[0][0] * Graphics.frame_rate
			e.casting_action = action
			$rpg_skill.casting_chat(cast_data[0], e.event)
			
			# 범위 이펙트 보여주기
			if skill.scope == 2 and RANGE_SKILLS.has_key?(id)
				make_range_sprite(e.event, RANGE_SKILLS[id][0], $data_skills[200], true)
			end
			
			e.event.animation_id = 145
			return true
		end
		
		#--------------------------------------------------------------------------
		# * Update Player  실시간 반영 되는 함수
		#--------------------------------------------------------------------------
		def update_player
			# 스킬 딜레이 갱신
			for skill_mash in SKILL_MASH_TIME
				id, val = skill_mash
				next if val[1] <= 0
				
				val[1] -= 1 	
				$console.write_line("#{$data_skills[id].name} 딜레이 끝") if val[1] == 0
			end
			
			# 버프 지속시간 갱신
			for buff_data in $game_party.actors[0].buff_time
				id, time = buff_data
				next if time <= 0
				
				$game_party.actors[0].buff_time[id] -= 1
				next if $game_party.actors[0].buff_time[id] > 0
				
				$console.write_line("#{$data_skills[id].name} 끝")
				$rpg_skill.buff_del(id) # 버프 끝 표시
			end
			
			# 후 딜레이 처리
			@item_mash -= 1 if @item_mash > 0
			@attack_mash -= 1 if @attack_mash > 0
			for s_mash in @skill_mash
				@skill_mash[s_mash[0]] -= 1 if s_mash[1] > 0
			end
			
			return if !active_ok
			
			check_item if @item_mash == 0 # 아이템 단축키 눌렸니?
			@actor = $game_party.actors[0]
			
			if Input.trigger?(@attack_key) and @attack_mash == 0 # 공격키가 눌렸니?
				# 만약 죽은 상태면 공격 못함
				if $game_switches[296]# 유저 죽음 스위치가 켜져있다면 패스
					$console.write_line("귀신은 할 수 없습니다.")
					return 
				end
				
				RANGE_WEAPONS.has_key?(@actor.weapon_id) ? player_range : player_melee
			end
			
			# 만약 스킬 사용 불가 지역이면 콘솔로 말하고 무시
			# 스킬 단축키가 눌렸니?
			for key in @skill_keys.keys
				next if @skill_keys[key] == nil or @skill_keys[key] == 0
				next if !Input.trigger?(key)
				
				id = @skill_keys[key] # 스킬 아이디 가져옴
				next if @skill_mash[id] != nil and @skill_mash[id] > 0
				
				if RANGE_EXPLODE.has_key?(id)
					return player_explode(id)
				else
					return player_skill(id)
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * Check Item  아이탬 단축키를 이용해서 사용할 경우
		#--------------------------------------------------------------------------
		def check_item
			#Check for item usage
			for key in @item_keys.keys
				# 해당 키에 등록된 아이템이 없으면 무시
				next if @item_keys[key] == nil or @item_keys[key] == 0
				next if !Input.trigger?(key)
				
				item = $data_items[@item_keys[key]] # 아이템데이터 가져옴
				target = $game_party.actors[0]
				return if !target.item_effect(item)
				
				$game_player.animation_id = item.animation1_id 
				Network::Main.ani(Network::Main.id, item.animation1_id)
				$game_system.se_play(item.menu_se)
				$game_party.lose_item(item.id, 1) if item.consumable
				@item_mash = 3
				return $game_temp.common_event_id = item.common_event_id if item.common_event_id > 0
			end
		end
		
		#--------------------------------------------------------------------------
		# * 캐릭터의 범위 무기
		#--------------------------------------------------------------------------
		def player_range
			w = RANGE_WEAPONS[@actor.weapon_id]
			return if w[3] != 0 and $game_party.item_number(w[3]) == 0
			$game_player.animation_id = $data_weapons[@actor.weapon_id].animation1_id
			@attack_mash = (w[5] == nil ? MASH_TIME * 10 : w[5] * 10)
			
			$game_party.lose_item(w[3], 1) #Delete an ammo
			$Abs_item_data.weapon_se(@actor.weapon_id)
			
			#Make the attack
			@range.push(Game_Ranged_Weapon.new($game_player, @actor, @actor.weapon_id))
			Network::Main.socket.send("<show_range_skill>#{1},#{Network::Main.id},#{@actor.weapon_id},#{2}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
			
			return if w[7] == nil #Animate
			animate($game_player, $game_player.character_name+w[7].to_s) if @player_ani
		end
		
		def animation_melee(dir, c = $game_player)
			ani_id = 0
			ani_id = 201 if dir == 6 # 우
			ani_id = 202 if dir == 4 # 좌
			ani_id = 203 if dir == 2 # 하 
			ani_id = 204 if dir == 8 # 상
			
			c.ani_array.push(ani_id)
			if c == $game_player
				Network::Main.ani(Network::Main.id, ani_id)
			else
				Network::Main.ani(c.id, ani_id, 1)
			end
		end
		
		#--------------------------------------------------------------------------
		# * 플레이어의 기본공격
		#--------------------------------------------------------------------------
		def player_melee(sw = false) # 왠지 여기서 때리는 모션 만들 수 있을 듯?
			@attack_mash = MASH_TIME * 10
			@attack_mash = MASH_TIME * 6 if sw # 만약 스킬로 인한 공격이라면..?
			
			$Abs_item_data.weapon_se(@actor.weapon_id) # 무기 공격 효과음 재생
			animation_melee($game_player.direction) # 휘두르는 애니메이션 추가
			
			for e in @enemies.values
				next if e == nil # 적이 없거나 적이 죽으면 공격 안함
				next if e.dead?
				next if !in_direction?($game_player, e.event) or !in_range?($game_player, e.event, 1) # 적이 캐릭터가 보는 방향에 없거나 바로 앞에 없으면 무시
				next if !CAN_HURT_ALLY and e.hate_group.include?(0) # 때릴 수 없거나 아군이면 공격 못함
				
				a = 109 # 기본 이펙트
				if $data_weapons[@actor.weapon_id] != nil
					$game_player.animation_id = $data_weapons[@actor.weapon_id].animation1_id
					a = $data_weapons[@actor.weapon_id].animation2_id 	
				end
				
				e.event.animation_id = a
				Network::Main.ani(e.event.id, a, 1)
				e.attack_effect(@actor)
				
				# 몬스터타격 데미지 계산
				if e.damage != "Miss" and e.damage != 0
					Audio.se_play("Audio/SE/타격", $game_variables[13])					
					$rpg_skill.투명해제
				end
				
				return if enemy_dead?(e, @actor)
				return if !e.hate_group.include?(0)
				
				e.attacking = $game_player
				e.in_battle = true
				setup_movement(e)
			end
			
			# 다른 플레이어 공격 처리
			for player in Network::Main.mapplayers.values
				next if player == nil
				next if !in_direction?($game_player, player)
				next if !in_range?($game_player, player, 1)
				
				# 해당 대상 애니메이션 재생하도록 보냄
				ani_id = $data_weapons[$game_party.actors[0].weapon_id].animation2_id if $data_weapons[$game_party.actors[0].weapon_id] != nil
				ani_id = 109 if ani_id == nil
				$ani_character[player.netid.to_i].animation_id = ani_id if $ani_character[player.netid.to_i] != nil
				Network::Main.ani(player.netid, ani_id)
				
				# 상대방 이름
				Network::Main.socket.send("<attack_effect>#{player.name}</attack_effect>\n")
				$rpg_skill.투명해제
			end
		end
		
		
		#==============================#
		#=====무기 격 설정 - 크랩훕흐======#
		#=============================#
		def weapon_skill(id, e)
			r = rand(100)
			ani = 0
			dmg = 0
			return 0 if WEAPON_SKILL[id] == nil
			
			dmg = WEAPON_SKILL[id][0]
			ani = WEAPON_SKILL[id][1]
			ra = WEAPON_SKILL[id][2] # 발동 확률
			
			return 0 if r > ra
			return 0 unless dmg
			return 0 unless ani
			
			e.event.animation_id = ani
			Network::Main.ani(e.event.id, ani, 1)
			return dmg.to_i
		end
		
		#==============================#
		#=====스킬 딜레이 알려줌 - 크랩훕흐======#
		#=============================#
		def skill_console(id)
			# 스킬 딜레이 표시
			skill_mash_time = SKILL_MASH_TIME[id]
			if skill_mash_time != nil and skill_mash_time[1] <= 0
				skill_mash_time[1] = skill_mash_time[0]
				$console.write_line("#{$data_skills[id].name} 딜레이 : #{skill_mash_time[0] / Graphics.frame_rate}초")
				$skill_Delay_Console.write_line(id)
			end
			
			# 버프의 지속시간 표시
			buff_data = BUFF_SKILL[id]
			if buff_data != nil
				time = buff_data[0] * Graphics.frame_rate.to_f
				$console.write_line("#{$data_skills[id].name} 지속시간 : #{time / Graphics.frame_rate}초")
				$skill_Delay_Console.write_line(id)
			end
		end
		
		# 맵을 이동하기위한 함수
		def map_m(id, x, y)
			if $game_map.map_id != id
				$game_temp.player_transferring = true # 이동 가능
				$game_temp.player_new_map_id = id
				$game_temp.player_new_x = x
				$game_temp.player_new_y = y
			else
				count = 0
				while count < 10000
					count += 1
					if $game_map.passable?(x, y, 2)
						$game_player.moveto(x, y)
						return
					else
						x += (rand(3) - 1)
						y += (rand(3) - 1)
					end
				end
			end
		end
		
		#==============================#
		#=====성황당 - 크랩훕흐===========#
		#=============================#
		def skill_sung
			x = 11
			y = 8
			m_id = SEONG_HWANG[$game_variables[8]][0] || 17
			map_m(m_id, x, y)
			$console.write_line("성황당으로 갑니다")
		end
		
		#=============================#
		#=====비영사천문 - 크랩훕흐===========#
		#=============================#
		def skill_byung(d) # d : 방향, 0 : 동, 1 : 서, 2 : 남, 3: 북
			if $game_switches[296]# 유저 죽음 스위치가 켜져있다면 패스
				$console.write_line("귀신은 할 수 없습니다.")
				return 
			end
			return if d > 4
			
			id = $game_variables[8] # 맵 번호
			return unless BIYEONG[id]
			
			m_id = BIYEONG[id][0]
			x = BIYEONG[id][d][0]
			y = BIYEONG[id][d][1]
			r = rand(3)
			map_m(m_id, x + r, y + r)
			
			case d
			when 1 then $console.write_line("동쪽에 이르렀으니... ")
			when 2 then $console.write_line("서쪽에 이르렀으니... ")
			when 3 then $console.write_line("남쪽에 이르렀으니... ")
			when 4 then $console.write_line("북쪽에 이르렀으니... ")
			end
			Network::Main.ani(Network::Main.id, 129)
		end
		
		def check_rpg_skill(id, character, battler)
			$rpg_skill.heal(id, battler) # 이게 회복 스킬인지 확인
			$rpg_skill.party_heal(id, battler) # 이게 파티 회복 스킬인지 확인
			$rpg_skill.buff(id, battler) # 이게 버프 스킬인지 확인
			$rpg_skill.active_skill(id, character, battler) # 액티브 스킬 행동 커스텀 확인
		end
		
		#--------------------------------------------------------------------------
		# *  플레이어의 스킬 공격
		#--------------------------------------------------------------------------
		def player_skill(id)
			@actor = $game_party.actors[0]
			#Get Skill
			skill = $data_skills[id]
			return if !player_can_skill(skill) # 스킬 사용 여부 확인
			
			# 스킬 애니메이션 
			$game_player.animation_id = skill.animation1_id
			Network::Main.ani(Network::Main.id, skill.animation1_id)
			
			check = $rpg_skill.buff(id) # 이게 버프 스킬인지 확인
			$rpg_skill.heal(id) # 이게 회복 스킬인지 확인
			$rpg_skill.party_heal(id) # 이게 파티 회복 스킬인지 확인
			$rpg_skill.active_skill(id) # 액티브 스킬 행동 커스텀 확인
			$rpg_skill.skill_chat(skill) # 스킬 사용시 말하는 것
			skill_console(id) if check == nil   # 스킬 딜레이 표시
			
			# 커먼 이벤트 실행
			$game_temp.common_event_id = skill.common_event_id if skill.common_event_id > 0
			
			@actor.sp -= skill.sp_cost
			# 스킬 맞는 쪽
			case skill.scope
			when 0 # 자기 자신
				@skill_mash[id] = MASH_TIME * 2
			when 1 #Enemy 적
				# 원거리 스킬인가?
				return if !RANGE_SKILLS.has_key?(id)
				
				# 원거리 스킬 캐릭터 생성
				if SKILL_DIRECTION.has_key?(id)
					for dir in SKILL_DIRECTION[id]
						@range.push(Game_Ranged_Skill.new($game_player, @actor, skill, dir))
						Network::Main.socket.send("<show_range_skill>#{1},#{Network::Main.id},#{id},#{0},#{dir}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
					end
				else
					@range.push(Game_Ranged_Skill.new($game_player, @actor, skill))
					Network::Main.socket.send("<show_range_skill>#{1},#{Network::Main.id},#{id},#{0}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
				end
				
				w = RANGE_SKILLS[id]
				# 스킬 사용 후 딜레이
				@skill_mash[id] = (w[3] == nil ? MASH_TIME * 10 : w[3] * 10)
				return
				
			when 2 #All Emenies 적 전체
				return if !RANGE_SKILLS.has_key?(id)
				
				w = RANGE_SKILLS[id]
				enemies = get_all_range($game_player, w[0])
				return if enemies.size == 0
				
				@skill_mash[id] = (w[3] == nil ? MASH_TIME * 10 : w[3] * 10) 
				hit_num = 1
				hit_num = w[5] == nil ? 1 : [w[5], 1].max
				
				target_enemies = []
				for e in enemies
					next if e == nil
					next if e.is_a?(Array)
					next if e.dead?
					next if !CAN_HURT_ALLY and e.hate_group.include?(0)
					next if !e.hate_group.include?(0) # 내 적이 아니면 패스
					target_enemies.push(e)
				end
				
				#Get all enemies
				for e in target_enemies
					#Attack enemy
					hit_num.times{
						e.effect_skill(@actor, skill)
						hit_enemy(e, @actor, skill.animation2_id)
					}
					#Show Animetion on enemy
					#jump(e.event, $game_player, SKILL_CUSTOM[id][1]) if SKILL_CUSTOM[id] != nil and e.damage != "Miss" and e.damage != 0
					
					next if enemy_dead?(e, @actor)
					e.in_battle = true
					e.attacking = $game_player
					setup_movement(e)
				end
				
				$rpg_skill.skill_cost_custom(@actor, skill.id) if target_enemies.size > 0
				return
			end
		end
		
		#--------------------------------------------------------------------------
		# * 플레이어의 범위 공격 스킬
		#--------------------------------------------------------------------------
		def player_explode(id)
			return if !RANGE_EXPLODE.has_key?(id)
			#Get Skill
			skill = $data_skills[id]
			return if !player_can_skill(skill) # 스킬 사용 여부 확인
			
			w = RANGE_EXPLODE[skill.id]
			# Show Animation
			$game_player.animation_id = skill.animation1_id
			#Add mash time
			@skill_mash[id] = (w[4] == nil ? MASH_TIME*10 : w[4]*10)
			
			skill_console(id)
			$rpg_skill.skill_chat(skill) # 스킬 사용시 말하는 것
			
			#Add to range
			if SKILL_DIRECTION.has_key?(skill.id)
				for dir in SKILL_DIRECTION[skill.id]
					@range.push(Game_Ranged_Explode.new($game_player, @actor, skill, dir))
					Network::Main.socket.send("<show_range_skill>#{1},#{Network::Main.id},#{skill.id},#{1},#{dir}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
				end
			else
				@range.push(Game_Ranged_Explode.new($game_player, @actor, skill))
				Network::Main.socket.send("<show_range_skill>#{1},#{Network::Main.id},#{skill.id},#{1}</show_range_skill>\n")	# range 스킬 사용했다고 네트워크 알리기
			end
			
			#Take off SP
			@actor.sp -= skill.sp_cost
			return
		end
		
		def player_can_skill(skill)
			return false if skill == nil #Return if the skill doesn't exist
			return false if !@actor.skills.include?(skill.id) #Return if the actor doesn't have the skill
			
			# 스킬 사용 불가 지역
			if $game_switches[352] or $game_switches[25]
				$console.write_line("스킬 사용 불가 지역입니다.")
				return false
			end
			
			# 마력이 부족하면 무시
			if @actor.sp < skill.sp_cost
				$console.write_line("마력이 부족합니다.")
				return false
			end
			
			# 아직 스킬 딜레이가 남아있다면 무시
			skill_mash = SKILL_MASH_TIME[skill.id]
			if skill_mash != nil and skill_mash[1]/60.0 > 0
				$console.write_line("딜레이가 남아있습니다. #{'%.1f' % (skill_mash[1]/60.0)}초")
				return false
			end
			
			# 엑터가 사용할 수 없는 상황이면 무시
			if !@actor.can_use_skill?(skill) and skill.id != 8 and skill.id != 120 #성황령, 부활은 죽을 때 사용하는 거니까 죽어서 사용할 수 있어야함
				$console.write_line("귀신은 할 수 없습니다.")
				return false
			end
			
			return false if !$rpg_skill.check_need_skill_item(skill.id) # 스킬 사용 재료가 부족하면 취소
			return true
		end
		
		def enemy_count_reset(id)
			$game_variables[id + $mon_val_start] = 0
		end
		
		def enemy_count_check(id, num)
			return $game_variables[id + $mon_val_start] >= num
		end
		
		#--------------------------------------------------------------------------
		# * 적이 죽었니? (몹 또는 유저), e가 a에 의해 죽었음
		#--------------------------------------------------------------------------	
		def enemy_dead?(e, a)
			return player_dead?(e, a) if e.is_a?(Game_Actor)
			return false unless e.dead?
			
			treasure(e) if a && a.is_a?(Game_Actor)
			a.attacking = nil if a && !a.is_a?(Game_Actor)
			
			id = e.event_id
			@enemies.delete(id) if @enemies[id] && ([0, nil].include?(enemies[id].respawn))
			
			send_network_monster(e)
			Network::Main.socket.send("<enemy_dead>#{id},#{$game_map.map_id},#{$npt}</enemy_dead>\n")
			
			event = e.event
			event.through = true
			event.fade = true 
			$game_variables[e.id + $mon_val_start] += 1
			
			case e.trigger[0]
			when 1 # 스위치
				$game_switches[e.trigger[1]] = true
			when 2 # 변수 조작
				$game_variables[e.trigger[1]] += 1
			when 3
				value = case e.trigger[1]
				when 1 then "A"
				when 2 then "B"
				when 3 then "C"
				when 4 then "D"
				end
				
				key = [$game_map.map_id, event.id, value]
				$game_self_switches[key] = true
			end
			
			$game_map.need_refresh = true
			return true
		end
		
		#--------------------------------------------------------------------------
		# * Player Dead(Player,Enemy) a가 e에 의해 죽음
		#--------------------------------------------------------------------------
		def player_dead?(a, e)
			return false if $game_party.actors[0].hp > 0
			# 플레이어가 죽으면 몹들 다가가는거 멈춤
			if e.is_a?(ABS_Enemy) and @enemies[e.event.id] != nil
				e.attacking = nil 
				e.in_battle = false
				restore_movement(e)
			end
			return true if $game_switches[296] # 죽음 표시 스위치
			
			#If the player is dead;
			Audio.se_play("Audio/SE/죽음", $game_variables[13])
			Network::Main.ani(Network::Main.id, 199)
			
			$console.write_line("죽었습니다.. 성황당에서 기원하십시오.")
			$cha_name = $game_party.actors[0].character_name
			
			for i in 0..4
				$game_party.actors[0].equip(i, 0)
			end
			
			$game_party.actors[0].set_graphic("죽음", 0, 0, 0)
			$game_player.refresh
			
			$game_switches[50] = false if $game_switches[50] != false # 유저 살음 스위치 오프
			$game_switches[296] = true if $game_switches[296] != true # 유저 죽음 스위치 온
			
			# 이때 모든 버프들을 지우자
			for buff_data in $game_party.actors[0].buff_time
				id = buff_data[0]
				$game_party.actors[0].buff_time[id] = 1  if buff_data[1] > 0
			end
			
			$game_party.actors[0].pdef = 0 # 물리방어
			$game_party.actors[0].mdef = 0 # 마법방어
			
			Network::Main.send_map
			return true
		end
		
		#--------------------------------------------------------------------------
		# * 몬스터를 잡았을 경우 주는것
		#--------------------------------------------------------------------------
		def treasure(enemy)
			actor = $game_party.actors[0]
			return if enemy.event.fade # 중복 방지(이미 몬스터가 죽은 상태에서 보상까지 받은 후)
			abs_gain_treasure(enemy)
			
			Network::Main.socket.send("<party_gain>#{enemy.event.id}</party_gain>\n")
			drop_enemy(enemy) # ABS monster item drop 파일 참조
		end
		
		def abs_gain_treasure(enemy)
			actor = $game_party.actors[0]
			return if actor.cant_get_exp? # 경험치를 얻을 수 없는 상황
			
			exp = 0
			gold = 0
			
			unless enemy.hidden
				exp = ENEMY_EXP[enemy.id] || enemy.exp
				if exp.is_a?(Array) && exp.size > 1
					exp = (actor.maxhp * (exp[1] || 0).to_f) + (actor.maxsp * (exp[2] || 0).to_f)
				end
				exp = exp.to_i
				gold += enemy.gold
			end
			
			in_map_player = 1
			if !$net_party_manager.party_empty?   # 파티중일경우 경험치, 돈의 습득
				# 여기서 파티원이 맵에 있는지 확인			
				for player in Network::Main.mapplayers.values
					next if player == nil
					next if player.name == $game_party.actors[0].name
					
					in_map_player += 1 if $net_party_manager.is_party_member?(player.name)
				end
			end
			
			nextExp = actor.level < 99 ? (actor.exp_list[actor.level + 1] - actor.exp_list[actor.level]) : actor.exp_list[100]
			limitExp = (nextExp / 100.0 * $exp_limit).to_i # 경험치 한계점
			gainExp = actor.level < 99 ? [exp, limitExp].min : exp
			gainExp *= $exp_event if $game_switches[1500]  # 경험치 이벤트!
			
			if in_map_player >= 2
				gainExp = (gainExp * 1.5 / in_map_player).to_i
				gold = (gold * 1.5 / in_map_player).to_i
			end
			
			actor.exp += gainExp
			$game_party.gain_gold(gold)
		end
		
		# 경험치 받는 함수
		def abs_gain_exp(val, hp_per = 0, sp_per = 0)
			actor = $game_party.actors[0]
			gainExp = val + (actor.maxhp * hp_per + actor.maxsp * sp_per).to_i
			actor.exp += gainExp
		end
		
		#--------------------------------------------------------------------------
		# * Hit Enemy(Enemy) or (Player) 몬스터가 공격할 경우, e가 a에게 공격당함
		#--------------------------------------------------------------------------
		def hit_enemy(e, a, animation=nil)
			return if animation == 0
			if a.is_a?(ABS_Enemy)
				return if e.is_a?(Game_Player) && !a.hate_group.include?(0)
				return if e.is_a?(ABS_Enemy) && !a.hate_group.include?(e.id)
			end
			
			ani_id = animation || a.animation2_id
			e.event.ani_array.push(ani_id)
			Network::Main.ani(e.event.id, ani_id, 1) if e.is_a?(ABS_Enemy)
			Network::Main.ani(Network::Main.id, ani_id) if e.is_a?(Game_Player)
		end
		#--------------------------------------------------------------------------
		# * Jump
		#--------------------------------------------------------------------------
		def jump(object,attacker,plus)
			return if plus == nil
			n_plus = plus - (plus * 2)
			
			d = attacker.direction
			
			# Calculate new pos
			new_x = (d == 6 ? plus : d == 4 ? n_plus : 0)
			new_y = (d == 2 ? plus : d == 8 ? n_plus : 0)
			# Jump
			object.jump_nt(new_x, new_y)
		end
		#--------------------------------------------------------------------------
		# * Enemy Pre-Attack(Enemy,Actions) - Checks action conditions to see if the 
		#   enemy can attack.
		#--------------------------------------------------------------------------
		def enemy_pre_attack(enemy, actions)
			return true if enemy.hp * 100.0 / enemy.maxhp > actions.condition_hp
			return true if $game_party.max_level < actions.condition_level
			switch_id = actions.condition_switch_id
			return true if actions.condition_switch_id > 0 and $game_switches[switch_id] == false
			n = rand(11) 
			return true if actions.rating < n
			return false
		end
		#--------------------------------------------------------------------------
		# * Can Enemy See(Enemy)
		#--------------------------------------------------------------------------
		def can_enemy_see(e)
			#Get all enemies of the enemy
			enemies = []
			if e.hate_group.include?(0) and in_range?(e.event, $game_player, e.see_range) or in_direction?(e.event, $game_player)
				if $game_party.actors[0].hp <= 0
					e.in_battle = false
					return false 
				end
				enemies.push($game_player) 
			end		
			
			if e.hate_group.size > 1 or (e.hate_group.size == 1 and !e.hate_group.include?(0))
				#Get the hate enemies
				for enemy in @enemies.values
					next if enemy == nil or enemy == e or !e.hate_group.include?(enemy.enemy_id) or
					!in_range?(e.event, enemy.event, e.see_range) or enemy.dead? #or !in_direction?(e.event, enemy.event)
					#Insert in to the list if the enemy is in hate group
					enemies.push(enemy)
				end
			end
			#Return false if the list is nil or empty
			if enemies == nil or enemies == []
				return false 
			end
			
			#Order the enemies
			if e.closest_enemy
				enemies.sort! {|a,b| get_range(e.event,a.event) - get_range(e.event,b.event) }
			end
			
			#Add to enemy attack list
			e.attacking = enemies[0]
			#Enemy is now in battle
			e.in_battle = true
			#Setup the movement
			setup_movement(e)
			
			#Return true
			return true
		end
		#--------------------------------------------------------------------------
		# * Setup the Movement Type to 0(Enemy)
		#--------------------------------------------------------------------------
		def setup_movement(e)
			e.event.move_speed = e.temp_speed #Set Speed
			e.event.move_frequency = e.temp_frequency #Set Frequency
			e.temp_move_type = e.event.move_type #Set Move Type
			e.event.move_type = 0 if e.behavior != 0
			e.temp_restore_sw = false
		end
		#--------------------------------------------------------------------------
		# * Restore the Movement Type(Enemy)
		#--------------------------------------------------------------------------
		def restore_movement(e)
			return if e.temp_restore_sw
			e.temp_speed = e.event.move_speed #Restore Speed
			e.temp_frequency = e.event.move_frequency #Restore Frequency
			e.event.move_type = e.temp_move_type #Restore Move Type
			e.temp_move_type = 0
			e.temp_restore_sw = true
		end
		#--------------------------------------------------------------------------
		# * Can Enemy Hear(Enemy)
		#--------------------------------------------------------------------------
		def can_enemy_hear(e)
			enemies = []
			#Get player
			d = 0
			d = DASH_SPEED if @dashing
			enemies.push($game_player) if e.hate_group.include?(0) and !@sneaking and 
			in_range?(e.event, $game_player, e.hear_range+d)
			if e.hate_group.size > 1 or (e.hate_group.size == 1 and !e.hate_group.include?(0))
				#Get the hate enemies
				for enemy in @enemies.values
					next if enemy == nil or enemy == e or !e.hate_group.include?(enemy.enemy_id) or
					!in_range?(e.event, enemy.event, e.hear_range+d) or enemy.dead?
					#Insert in to the list if the enemy is in hate group
					enemies.push(enemy)
				end
			end
			#Return False
			if enemies == nil or enemies == []
				return false 
			end
			
			#Order the enemies
			if e.closest_enemy
				enemies.sort! {|a,b| get_range(e.event,a.event) - get_range(e.event,b.event) }
			end
			
			#Add to enemy attack list
			e.attacking = enemies[0]
			#Enemy is now in battle
			e.in_battle = true
			#Setup the movement
			setup_movement(e)
			#Return true
			
			return true
		end
		
		#--------------------------------------------------------------------------
		# * Enemy Ally in_battle?(Enemy)
		#--------------------------------------------------------------------------
		def enemy_ally_in_battle?(enemy) # 동료가 전투중인가?
			allies = []
			for ally in @enemies.values
				next if ally == nil or enemy.hate_group.include?(ally.enemy_id)
				next if !ally.in_battle or !in_range?(enemy.event, ally.event, enemy.see_range)
				next if !in_range?(enemy.event, ally.event, enemy.hear_range)
				next if ally.attacking == $game_player and !enemy.hate_group.include?(0)
				enemy.attacking = ally.attacking
				enemy.in_battle = true
				setup_movement(enemy)
				return true
			end
			return false
		end
		
		#--------------------------------------------------------------------------
		# * Get Range(Element, Object) - Near Fantastica
		#--------------------------------------------------------------------------
		def get_range(element, object)
			x = (element.x - object.x) * (element.x - object.x)
			y = (element.y - object.y) * (element.y - object.y)
			r = x + y
			#r = Math.sqrt(r)
			return r.to_i
		end
		#--------------------------------------------------------------------------
		# * Checks the object range
		#--------------------------------------------------------------------------
		def in_screen?(object)
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
		#--------------------------------------------------------------------------
		# * In Range?(Element, Object, Range) - Near Fantastica
		#--------------------------------------------------------------------------
		def in_range?(element, object, range)
			x = (element.x - object.x) * (element.x - object.x)
			y = (element.y - object.y) * (element.y - object.y)
			r = x + y
			return true if r <= (range * range)
			return false
		end
		#--------------------------------------------------------------------------
		# * Get ALL Range(Element, Range)
		#--------------------------------------------------------------------------
		def get_all_range(element, range)
			objects = []
			for e in @enemies.values
				objects.push(e) if in_range?(element, e.event, range)
			end
			return objects
		end
		
		#--------------------------------------------------------------------------
		# * 범위 안에 다른 유저를 포함한다. (Element, Range)
		#--------------------------------------------------------------------------
		def get_all_range_net(element, range)
			# 여기서 넷 플레이어인지 확인해야함
			objects = []
			for player in Network::Main.mapplayers.values
				next if player == nil
				objects.push(player) if in_range?(element, player, range)
			end
			return objects
		end
		
		#--------------------------------------------------------------------------
		# * In Direction?(Element, Object) - Near Fantastica
		#--------------------------------------------------------------------------
		def in_direction?(element, object)
			return true if element.direction == 2 and object.y >= element.y and object.x == element.x
			return true if element.direction == 4 and object.x <= element.x and object.y == element.y
			return true if element.direction == 6 and object.x >= element.x and object.y == element.y
			return true if element.direction == 8 and object.y <= element.y and object.x == element.x
			return false
		end
		
		#--------------------------------------------------------------------------
		# * Animate(object, name)
		#--------------------------------------------------------------------------
		def animate(object, name)
			object.set_animate(name)
		end
		
		# 범위안에 이벤트 만들고 이펙트 내보기
		def make_range_event(element, range, skill)
			x = element.x
			y = element.y
			
			for i in 0..range * 2 # y 
				for j in 0..range * 2 # x
					nowY = y + i - range
					nowX = x + j - range
					
					ry = (y - nowY) * (y - nowY)
					rx = (x - nowX) * (x - nowX)
					r = ry + rx
					if r <= range * range
						event = create_events2(1, nowX, nowY, 0)
						next if event == nil
						event.ani_array.push(skill.animation2_id)
						event.one_use = true
					end
				end
			end
		end
		
		# 범위안에 이벤트 만들고 이펙트 내보기
		def make_range_sprite(element, range, skill, sw = false)
			return if SHOW_SKILL_EFECT[skill.id] == nil
			# 이펙트 보여주는 스킬만 동작하도록 하자
			$scene.spriteset.make_range_sprite(element, range, skill, sw)
		end
		
		def send_network_monster(monster, delete_sw = 0)
			data = {
				"map_id" => $game_map.map_id,
				"id" => monster.event.id,
				"x" => monster.event.x,
				"y" => monster.event.y,
				"hp" => monster.hp,
				"sp" => monster.sp,
				"direction" => monster.event.direction,
				"respawn" => monster.respawn,
				"mon_id" => monster.enemy_id,
				"delete_sw" => delete_sw,
			}
			message = data.map { |key, value| "#{key}:#{value}" }.join("|")
			Network::Main.send_with_tag("monster_save", message)
		end
		#--------------------------------------------------------------------------
		# * End of class
		#--------------------------------------------------------------------------
	end
	
	#============================================================================
	# *  Range Base
	#============================================================================
	class Range_Base < Game_Character
		attr_accessor :range
		attr_accessor :draw
		attr_accessor :stop
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, attack)
			@step = 0
			@parent = parent
			@actor = actor
			@draw = true
			@stop  = false
			@range = 0
			@explosive = false
			@showing_ani = false
			super()
			@move_direction = @parent.direction
			@direction = @move_direction
			moveto(@parent.x, @parent.y)
			
			@objects = []
		end
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			@character_name = @range_weapon[0]
			@move_speed = @range_weapon[1]
			@range = @range_weapon[4]
		end
		#--------------------------------------------------------------------------
		# * Force Movement
		#--------------------------------------------------------------------------
		def force_movement
			m = @move_direction
			@y += 1 if m == 1; @x -= 1 if m == 1
			@y += 1 if m == 2
			@y += 1 if m == 3; @x += 1 if m == 3
			@x -= 1 if m == 4
			@x += 1 if m == 6
			@y -= 1 if m == 7; @x -= 1 if m == 7
			@y -= 1 if m == 8
			@y -= 1 if m == 9; @x += 1 if m == 9
		end
		#--------------------------------------------------------------------------
		# * Update
		#-------------------------------------------------------------------------
		def update
			super
			return if @stop
			return if moving?
			
			if @parent == nil or @actor == nil
				@stop = true
				return
			end
			
			no_one?
			#Stop if it came to range
			if @step <= @range
				force_movement
				@step += 1
			else
				@stop = true
			end
		end
		
		def is_enemy?(event)
			e = $ABS.enemies[event.id]
			if @parent == $game_player # 공격자가 플레이어
				return false if e == nil
				return true if e.hate_group.include?(0)
			else 
				if event == $game_player # 피해자가 플레이어
					return true if @parent.is_a?(Game_NetPlayer)
					return true if @actor.hate_group.include?(0)
				else # 그 외
					return false if e == nil
					return true if e.hate_group.include?(@actor.id)
				end
			end
			return false
		end
		
		#--------------------------------------------------------------------------
		# * No One
		#-------------------------------------------------------------------------
		def no_one?
			# 적 이벤트 넣기
			@objects = []
			objects = {}
			for event in $game_map.events.values
				next if event == nil
				next if $ABS.enemies[event.id] == nil
				next if $ABS.enemies[event.id].dead?
				next if @parent == event
				objects[event.id] = event 
			end
			
			objects[0] = $game_player if @parent != $game_player	
			sw = true
			
			#Get all pos
			for o in objects.values
				next if o == nil
				if (o.x == @x and o.y == @y)
					next if !is_enemy?(o)
					sw = false
					@objects.push(o)
					@stop = true
				end
			end
			
			# 여기서 넷 플레이어인지 확인해야함
			for player in Network::Main.mapplayers.values
				next if player == nil
				next if @parent == player
				if (player.x == @x and player.y == @y)
					@objects.push(player) 
					@stop = true
					sw = false
				end
			end
			
			#Return False if no one was found
			return sw
		end
		
	end
	#============================================================================
	# * Game Ranged Explode
	#============================================================================
	class Game_Ranged_Explode < Range_Base
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, skill, m_dir = 0, dummy = false)
			super(parent, actor, skill)
			@range_skill = $ABS.RANGE_EXPLODE[skill.id]
			@range = @range_skill[0]
			@move_speed = @range_skill[1]
			
			char_name = ""
			hue = 0
			opcity = 255
			if @range_skill[2].is_a?(Array)
				char_name = @range_skill[2][0] if @range_skill[2][0] != nil
				hue = @range_skill[2][1] if @range_skill[2][1] != nil
				opcity = @range_skill[2][2] if @range_skill[2][2] != nil
			else
				char_name = @range_skill[2]
			end
			
			if char_name != "" and !$ABS.char_dir.include?(char_name + ".png")				
				char_name = "공격스킬2"
			end
			
			es_set_graphic(char_name, opcity, hue)
			
			@skill = skill
			
			@explosive = true
			@move_direction = m_dir != 0 ? m_dir : @parent.direction
			@dummy = dummy
			@hit_num = @range_skill[6] == nil ? 1 : [@range_skill[6], 1].max
			
			@direction = @move_direction
			@direction = 2 if @direction <= 1
			@check_blow = false
		end
		
		def check_event_trigger_touch(x, y)
			
		end
		
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			super
			@stop = true if @step >= @range
			return blow if @stop
		end
		
		#--------------------------------------------------------------------------
		# * In Range?(Element, Object, Range) - Near Fantastica
		#--------------------------------------------------------------------------
		def in_range?(element, object, range)
			x = (element.x - object.x) * (element.x - object.x)
			y = (element.y - object.y) * (element.y - object.y)
			r = x + y
			return true if r <= (range * range)
			return false
		end
		
		# 범위안에 이벤트 만들고 이펙트 내보기
		def make_range_event(element, range)
			x = element.x
			y = element.y
			
			for i in 0..range * 2 # y 
				for j in 0..range * 2 # x
					nowY = y + i - range
					nowX = x + j - range
					
					ry = (y - nowY) * (y - nowY)
					rx = (x - nowX) * (x - nowX)
					r = ry + rx
					if r <= range * range
						event = create_events2(1, nowX, nowY, 0)
						event.ani_array.push(@skill.animation2_id)
						event.one_use = true
					end
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * Get ALL Range(Element, Range)
		#--------------------------------------------------------------------------
		def get_all_range(element, range)
			objects = []
			for e in $ABS.enemies.values
				#Skip NIL values
				next if e == nil
				#Skip 이미 적이 죽은거면 넘어가
				next if e.dead?
				# Skip if the enemy is an ally and can't hurt allies.
				next if !CAN_HURT_ALLY and e.hate_group.include?(0)
				next if !e.hate_group.include?(0) and @parent.is_a?(Game_Player) # 나에게 적이 아닌 몬스터는 포함x
				if in_range?(element, e.event, range)
					objects.push(e) 
				end
			end
			
			# 여기다가 개수 추가
			objects.push($game_player) if in_range?(element, $game_player, range)
			return objects
		end
		#--------------------------------------------------------------------------
		# * Blow
		#--------------------------------------------------------------------------
		def blow
			
			return if @check_blow
			#Stop
			@check_blow = true
			
			#Play Animation
			#Show animation on event
			self.animation_id = @skill.animation2_id
			@showing_ani = true
			#Get Everyone in Range of the Explosive Skill
			objects = get_all_range(self, @range_skill[3])
			
			if objects.include?($game_player)
				hit_player 
				objects.delete($game_player)
			end
			
			#Hit Enemies
			for e in objects
				next if e == nil
				#Hit
				hit_event(e.event_id)
			end
			
			if objects.size > 0
				$rpg_skill.skill_cost_custom(@actor, @skill.id) # 스킬 코스트
			end
			
			$ABS.make_range_sprite(self, @range_skill[3], @skill)
		end
		
		#--------------------------------------------------------------------------
		# * Hit Player
		#--------------------------------------------------------------------------
		def hit_player
			return if @actor == $game_party.actors[0]
			@hit_num.times{
				$game_player.ani_array.push(@skill.animation2_id)
			}
			Network::Main.ani(Network::Main.id, @skill.animation2_id)
			return if @dummy
			
			#Get Actor
			actor = $game_party.actors[0]
			#Get Enemy
			enemy = @actor
			#Attack Actor
			@hit_num.times{
				actor.effect_skill(enemy, @skill)
			}
			$rpg_skill.skill_cost_custom(enemy, @skill.id) # 스킬 코스트 
			
			#Jump
			$ABS.jump($game_player,self,$ABS.RANGE_EXPLODE[@skill.id][5]) if actor.damage != "Miss" and actor.damage != 0
			#Check if enemy is dead
			$ABS.enemy_dead?(actor, enemy)
		end  
		#--------------------------------------------------------------------------
		# * Object Initialization 요기
		#--------------------------------------------------------------------------
		def hit_event(id)
			#Get enemy
			actor = $ABS.enemies[id]
			return if @actor == actor
			return if @dummy
			enemy = nil
			
			#If the parent is player
			if @parent.is_a?(Game_Player)
				enemy = $game_party.actors[0]
				return if !actor.hate_group.include?(0)
			else
				enemy = $ABS.enemies[@parent.id]
				return if enemy == nil
				return if !actor.hate_group.include?(enemy.enemy_id)
			end
			
			@hit_num.times{
				actor.effect_skill(enemy, @skill)
				actor.event.ani_array.push(@skill.animation2_id)
			}
			Network::Main.ani(actor.event.id, @skill.animation2_id, 1, @hit_num) #몬스터 대상의 애니매이션 공유
			
			e = actor
			$ABS.jump(e.event, self, $ABS.RANGE_EXPLODE[@skill.id][5]) if actor.damage != "Miss" and actor.damage != 0 and $ABS.RANGE_EXPLODE[@skill.id][5] != 0
			return if $ABS.enemy_dead?(actor, enemy)
			
			#Put enemy in battle
			actor.in_battle = true
			actor.attacking = @parent.is_a?(Game_Player) ? $game_player : enemy
			$ABS.setup_movement(actor)
		end
	end
	
	#============================================================================
	# * Game Ranged Skill
	#============================================================================
	class Game_Ranged_Skill < Range_Base
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, skill, m_dir = 0, dummy = false) # 만약 더미라면 그냥 스킬 효과 안나고 통과하도록 하게 해보자
			super(parent, actor, skill)
			@range_skill = $ABS.RANGE_SKILLS[skill.id]
			@range = @range_skill[0]
			@move_speed = @range_skill[1]
			
			char_name = ""
			hue = 0
			opcity = 255
			if @range_skill[2].is_a?(Array)
				char_name = @range_skill[2][0] if @range_skill[2][0] != nil
				hue = @range_skill[2][1] if @range_skill[2][1] != nil
				opcity = @range_skill[2][2] if @range_skill[2][2] != nil
			else
				char_name = @range_skill[2]
			end
			
			if char_name != "" and !$ABS.char_dir.include?(char_name + ".png")				
				char_name = "공격스킬"
			end
			
			es_set_graphic(char_name, opcity, hue)
			
			@skill = skill
			@move_direction = m_dir != 0 ? m_dir : @parent.direction
			
			@dummy = dummy
			@hit_num = @range_skill[5] == nil ? 1 : [@range_skill[5], 1].max
			@direction = @move_direction
			@direction = 2 if @direction <= 1
		end
		
		#--------------------------------------------------------------------------
		# * Update
		#-------------------------------------------------------------------------
		def update
			super
			check_event_trigger_touch(@x, @y) if @stop
		end
		
		#--------------------------------------------------------------------------
		# * Check Event Trigger Touch(x,y)
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			for o in @objects
				if o == $game_player
					hit_player
				elsif o.is_a?(Game_NetPlayer)
					hit_net_player(o)
				elsif ($ABS.enemies[o.id] != nil and !$ABS.enemies[o.id].dead?)
					hit_event(o.id)
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * Hit net_Player
		#--------------------------------------------------------------------------
		def hit_net_player(net_player)
			return if !@parent.is_a?(Game_Player)
			if @skill.id == 138
				$rpg_skill.비영승보(@parent, net_player)
			end
		end 
		
		#--------------------------------------------------------------------------
		# * Hit Player
		#--------------------------------------------------------------------------
		def hit_player
			@hit_num.times{
				$game_player.ani_array.push(@skill.animation2_id)
			}
			Network::Main.ani(Network::Main.id, @skill.animation2_id) #애니매이션 공유
			#Get Actor
			return if @dummy
			
			actor = $game_party.actors[0]
			#Get Enemy
			enemy = @actor
			
			@hit_num.times{
				actor.effect_skill(enemy, @skill)
			}
			
			$rpg_skill.skill_cost_custom(enemy, @skill.id)
			
			#Jump
			$ABS.jump($game_player, self, @range_skill[4]) if actor.damage != "Miss" and @range_skill[4] != 0
			#Check if enemy is dead
			$ABS.enemy_dead?(actor, enemy)
		end  
		
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def hit_event(id)
			actor = $ABS.enemies[id]
			enemy = nil
			skill_id = @skill.id
			animation_id = @skill.animation2_id
			should_jump = false
			@enani = actor.event
			
			if @parent.is_a?(Game_Player)
				enemy = $game_party.actors[0]
				target_id = 0
				
				if skill_id == 138 # 무형검
					$rpg_skill.비영승보(@parent, @enani)
				end
			else
				enemy = $ABS.enemies[@parent.id]
				return if enemy == nil
				target_id = enemy.enemy_id	
			end
			
			@hit_num.times do
				actor.effect_skill(enemy, @skill)
				@enani.ani_array.push(animation_id)
			end
			Network::Main.ani(@enani.id, animation_id, 1, @hit_num)
			
			$rpg_skill.skill_cost_custom(enemy, skill_id)
			
			should_jump = actor.damage != "Miss" && actor.damage != 0 && @range_skill[4] != 0
			$ABS.jump(@enani, self, @range_skill[4]) if should_jump
			
			return if $ABS.enemy_dead?(actor, enemy)
			return unless actor.hate_group.include?(target_id)
			
			actor.in_battle = true
			actor.attacking = @parent.is_a?(Game_Player) ? $game_player : enemy
			$ABS.setup_movement(actor)
		end
	end
	#============================================================================
	# * Game Ranged Weapons
	#============================================================================
	class Game_Ranged_Weapon < Range_Base
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, attack, m_dir = 0, dummy = false)
			super(parent,actor,attack)
			@range_weapon = $ABS.RANGE_WEAPONS[attack]
			@character_name = @range_weapon[0]
			@move_speed = @range_weapon[1]
			@range = @range_weapon[4]
			
			@move_direction = m_dir != 0 ? m_dir : @parent.direction
			@dummy = dummy
		end
		
		#--------------------------------------------------------------------------
		# * Update
		#-------------------------------------------------------------------------
		def update
			super
			check_event_trigger_touch(@x, @y) if @stop
		end
		
		#--------------------------------------------------------------------------
		# * Check Event Trigger Touch(x,y)
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			for o in @objects
				if o == $game_player
					hit_player
				elsif ($ABS.enemies[o.id] != nil and !$ABS.enemies[o.id].dead?)
					hit_event(o.id)
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Hit Player
		#--------------------------------------------------------------------------
		def hit_player
			$game_player.animation_id = @range_weapon[2]
			return if @dummy
			#Get Actor
			actor = $game_party.actors[0]
			#Get Enemy
			enemy = @actor
			#Attack Actor 적이 플레이어를 공격함
			actor.attack_effect(enemy)
			#jump
			$ABS.jump($game_player, self, @range_weapon[6]) if actor.damage != "Miss" and actor.damage != 0
			#Check if enemy is dead
			$ABS.enemy_dead?(actor, enemy)
		end  
		#--------------------------------------------------------------------------
		# * Object Initialization   범위 무기 ( 표창 같은거)
		#--------------------------------------------------------------------------
		def hit_event(id)
			actor = $ABS.enemies[id]
			enemy = nil
			animation_id = nil
			
			if @parent.is_a?(Game_Player)
				enemy = $game_party.actors[0]
				animation_id = @range_weapon[2]
				target_id = 0
			else
				enemy = $ABS.enemies[@parent.id]
				return if enemy == nil
				animation_id = @skill.animation2_id
				target_id = enemy.enemy_id
			end
			
			actor.attack_effect(enemy)
			if actor.damage != "Miss" && actor.damage != 0
				actor.event.animation_id = animation_id
				$ABS.jump(actor.event, self, @range_weapon[6])
			end
			
			return if $ABS.enemy_dead?(actor, enemy)
			return unless actor.hate_group.include?(target_id)
			
			actor.in_battle = true
			actor.attacking = @parent.is_a?(Game_Player) ? $game_player : enemy
			$ABS.setup_movement(actor)
		end
	end
	#============================================================================
	# *  Game Event 
	#============================================================================
	class Game_Event < Game_Character
		attr_reader   :event
		attr_accessor :erased
		attr_reader   :page
		
		attr_accessor :one_use
		#--------------------------------------------------------------------------
		# * Alias
		#--------------------------------------------------------------------------
		alias mrmo_abs_game_event_refresh_set_page refresh_set_page
		#--------------------------------------------------------------------------
		# * Event Name
		#--------------------------------------------------------------------------
		def name
			return @event.name
		end
		#--------------------------------------------------------------------------
		# * Event ID
		#--------------------------------------------------------------------------
		def id
			return @id
		end
		#--------------------------------------------------------------------------
		# * Refreshes Page
		#--------------------------------------------------------------------------
		def refresh_set_page
			mrmo_abs_game_event_refresh_set_page # == refresh_set_page
			$ABS.refresh(self, @list, @character_name) # 한 맵에 있는 이벤트 리스트를 보내줌
			
		end
	end
	#============================================================================
	# * Scene Load
	#============================================================================
	class Scene_Load < Scene_File
		#--------------------------------------------------------------------------
		alias mrmo_abs_scene_load_read_data read_data
		#--------------------------------------------------------------------------
		def read_data(file)
			mrmo_abs_scene_load_read_data(file)
			$ABS = Marshal.load(file)  
			# Change Animation Size
			for an in $data_animations
				next if an == nil
				frames = an.frames
				for i in 0...frames.size
					for j in 0...frames[i].cell_max
						frames[i].cell_data[j, 1] /= $ABS.ANIMATION_DIVIDE
						frames[i].cell_data[j, 2] /= $ABS.ANIMATION_DIVIDE
						frames[i].cell_data[j, 3] /= $ABS.ANIMATION_DIVIDE
					end
				end
			end
		end
	end
	#============================================================================
	# * Scene Save
	#============================================================================
	class Scene_Save < Scene_File
		#--------------------------------------------------------------------------
		alias mrmo_abs_scene_save_write_data write_data
		#--------------------------------------------------------------------------
		def write_data(file)
			mrmo_abs_scene_save_write_data(file)
			Marshal.dump($ABS, file)
		end
	end
	#============================================================================
	# * Scene Title
	#============================================================================
	class Scene_Title
		#--------------------------------------------------------------------------
		alias mrmo_abs_scene_title_cng command_new_game
		#--------------------------------------------------------------------------
		# * Command: New Game
		#--------------------------------------------------------------------------
		def command_new_game
			$ABS = MrMo_ABS.new    
			# Change Animation Size
			for an in $data_animations
				next if an == nil
				frames = an.frames
				for i in 0...frames.size
					for j in 0...frames[i].cell_max
						frames[i].cell_data[j, 1] /= $ABS.ANIMATION_DIVIDE
						frames[i].cell_data[j, 2] /= $ABS.ANIMATION_DIVIDE
						frames[i].cell_data[j, 3] /= $ABS.ANIMATION_DIVIDE
					end
				end
			end
			mrmo_abs_scene_title_cng 
		end
	end
	#============================================================================
	# * Scene Map
	#============================================================================
	class Scene_Map
		attr_accessor :spriteset
		#--------------------------------------------------------------------------
		alias mrmo_abs_scene_map_update update
		alias mrmo_abs_scene_map_transfer_player transfer_player
		#--------------------------------------------------------------------------
		def update
			$ABS.update
			mrmo_abs_scene_map_update
		end
		#--------------------------------------------------------------------------
		# * Player Place Move
		#--------------------------------------------------------------------------
		def transfer_player
			$ABS.enemies = {} if $game_map.map_id != $game_temp.player_new_map_id
			mrmo_abs_scene_map_transfer_player
		end
	end
	#============================================================================
	# * Game Player
	#============================================================================
	class Game_Player
		#--------------------------------------------------------------------------
		alias mrmo_abs_game_player_initialize initialize
		alias mrmo_abs_game_player_upm update_player_movement
		alias mrmo_sbabs_game_player_update update
		#--------------------------------------------------------------------------
		attr_accessor :event_id
		attr_accessor :event
		attr_accessor :actor
		attr_accessor :enemy_id
		attr_accessor :in_battle
		attr_accessor :movable
		def initialize
			super
			@event_id = 0
			@event = self
			@enemy_id = 0
			@actor = $game_party.actors[0]
			@in_battle = false
			@movable = true
			mrmo_abs_game_player_initialize
		end
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			# Record leader actor.
			@actor = $game_party.actors[0]
			mrmo_sbabs_game_player_update
		end
		#--------------------------------------------------------------------------
		# * Player Movement Update
		#--------------------------------------------------------------------------
		def update_player_movement
			return if !@movable
			mrmo_abs_game_player_upm
		end
	end
	#============================================================================
	# * RPG::Sprite
	#============================================================================
	module RPG
		class Sprite < ::Sprite
			attr_accessor :_damage_duration
			attr_accessor :_damage_duration_max
			attr_accessor :_damage_max_height
			attr_accessor :_damage_string
			attr_accessor :_damage_idx
			attr_accessor :_damage_muti
			
			def initialize(viewport = nil)
				super(viewport)
				@_whiten_duration = 0
				@_appear_duration = 0
				@_escape_duration = 0
				@_collapse_duration = 0
				@_collapse_erase_duration = 0
				
				@_damage_max_height = 0
				@_damage_duration = 0
				@_damage_duration_max = 60
				@_damage_idx = 0
				@_damage_muti = false
				@_damage_sprite = []
				
				@_animation_duration = 0
				@_blink = false
				@force_opacity = false
				@stop_animation = true
				
				@_damage_string = ""
			end
			
			def stop_animation?
				return @stop_animation 
			end
			
			#-------------------------------------------------------------------------
			# update
			#-------------------------------------------------------------------------
			def update
				super
				if @_whiten_duration > 0
					@_whiten_duration -= 1
					self.color.alpha = 128 - (16 - @_whiten_duration) * 10
				end
				if @_appear_duration > 0
					@_appear_duration -= 1
					self.opacity = (16 - @_appear_duration) * 16
				end
				if @_escape_duration > 0
					@_escape_duration -= 1
					self.opacity = 256 - (32 - @_escape_duration) * 10
				end
				if @_collapse_duration > 0
					@_collapse_duration -= 1
					self.opacity = 256 - (48 - @_collapse_duration) * 6
				end
				
				update_damage_view if @_damage_sprite.size > 0
				
				if @_animation != nil and (Graphics.frame_count % 2 == 0)
					@_animation_duration -= 1
					update_animation
				end
				if @_loop_animation != nil and (Graphics.frame_count % 2 == 0)
					update_loop_animation
					@_loop_animation_index += 1
					@_loop_animation_index %= @_loop_animation.frame_max
				end
				
				if @_blink
					@_blink_count = (@_blink_count + 1) % 32
					if @_blink_count < 16
						alpha = (16 - @_blink_count) * 6
					else
						alpha = (@_blink_count - 16) * 6
					end
					self.color.set(255, 255, 255, alpha)
				end
				@@_animations.clear
				
				if @_animation != nil and (Graphics.frame_count % 10 == 0)
					@_animation_duration += 1
				end
				
				#Update Duration
				if @_collapse_erase_duration > 0
					@_collapse_erase_duration -= 1
					@force_opacity = true
					# 불투명도 조절
					self.opacity = 256 - (36 - @_collapse_erase_duration) * 10
					@force_opacity = false
					if @_collapse_erase_duration == 0
						@collapse_character.character_name = ""
						self.opacity = 256
						self.color.set(0, 0, 0, 0) # 검은색으로 만듦
						self.blend_type = 0
						@collapse_character.erase # 이벤트 삭제
					end
				end
			end
			
			#--------------------------------------------------------------------------
			# * update damage view, 데미지 표시 효과 설정
			#--------------------------------------------------------------------------
			def update_damage_view
				count = 0
				if @_damage_sprite.size > 50
					dispose_damage(@_damage_sprite.first)
				end
				
				for sprite in @_damage_sprite
					sprite._damage_duration += 1
					next if sprite._damage_duration < 0
					sprite.visible = true if sprite._damage_duration >= 0
					
					if sprite._damage_duration == sprite._damage_duration_max
						dispose_damage(sprite)
						next
					end
					
					tempY = self.y + self.height / 4 - (30 + sprite._damage_idx * 13)
					tempY -= 50 if sprite._damage_muti
					time = sprite._damage_duration
					
					sprite.x = self.x - sprite.ox
					#sprite.y = tempY if @collapse_character == nil or @collapse_character.character_name != ""
					sprite.y = [tempY - time * 4, tempY - sprite._damage_max_height].max if @collapse_character == nil or @collapse_character.character_name != ""
				end
			end
			
			#--------------------------------------------------------------------------
			# * 데미지 삭제
			#--------------------------------------------------------------------------
			def dispose_damage(sprite = nil)
				if sprite != nil
					@_damage_sprite.delete(sprite)
					sprite.visible = false
					sprite.bitmap.dispose
					sprite.dispose
					sprite = nil
				else
					if @_damage_sprite != nil
						for sprite in @_damage_sprite
							@_damage_sprite.delete(sprite)
							sprite.visible = false
							sprite.bitmap.dispose
							sprite.dispose
							sprite = nil
						end
					end
				end
			end
			
			#--------------------------------------------------------------------------
			# * Collapse and Erase
			#--------------------------------------------------------------------------
			def collapse_erase(character)
				self.blend_type = 1
				self.color.set(255, 64, 64, 255)
				self.opacity = 255
				@collapse_character = character
				@_collapse_erase_duration = 36
				@_collapse_duration = 0
				@_whiten_duration = 0
				@_appear_duration = 0
				@_escape_duration = 0
				@_loop_animation = nil
				dispose_loop_animation
			end
			#--------------------------------------------------------------------------
			# * Opacity
			#--------------------------------------------------------------------------
			def opacity=(o)
				return if @_collapse_erase_duration > 0 and !@force_opacity
				super(o)
			end
			#--------------------------------------------------------------------------
			# * Damage  데미지를 표시하는 부분
			#--------------------------------------------------------------------------
			def damage(value, critical, multi = false)
				type = $game_variables[60] # 데미지 표시 타입
				#dispose_damage
				if value.is_a?(Numeric)
					damage_string = value.abs.to_s
				else
					damage_string = value.to_s
				end
				damage_string = change_number_unit(damage_string, type) if damage_string.to_i > 0
				
				bitmap = Bitmap.new(self.width, 30)
				bitmap.font.name = Font.exist?($ABS.DAMAGE_FONT_NAME) ? $ABS.DAMAGE_FONT_NAME : DAMAGE_FONT_NAME2
				
				bitmap.font.size = critical ? DAMAGE_CRI_FONT_SIZE : $ABS.DAMAGE_FONT_SIZE 
				bitmap.font.color = $ABS.DAMAGE_FONT_COLOR
				
				bitmap.draw_text(+1, +1, 200, 36, damage_string, 0)
				
				if critical.to_s == "heal" 
					bitmap.font.color.set(102, 255, 102) # 연두색
				elsif critical.to_s == "player_hit"
					bitmap.font.color.set(255, 142, 165) # 분홍색
				elsif critical.to_s == "skill_cri"
					bitmap.font.bold = true
					bitmap.font.color.set(70, 113, 255) # 파란색
				elsif !critical # 일반적 표시
					bitmap.font.color.set(255, 255, 255) # 흰색	
				elsif critical # 크리티컬 표시
					bitmap.font.bold = true
					bitmap.font.color.set(255, 0, 51) # 빨간색 
				end
				
				
				bitmap.draw_text(0, 0, 200, 36, damage_string, 0)
				
				sprite = Sprite.new(self.viewport)
				sprite.bitmap = bitmap
				sprite.oy = self.oy
				sprite.ox = sprite.bitmap.text_size(damage_string).width / 4
				sprite.x = self.x - sprite.ox
				sprite._damage_string = damage_string
				sprite.y = self.y# + self.height / 4 #self.oy
				sprite.z = 3000
				sprite.opacity = 255
				sprite._damage_idx = @_damage_idx
				sprite._damage_duration = 0 - @_damage_idx * 5
				sprite.visible = false
				#sprite._damage_max_height = 11 * @_damage_sprite.size + 60
				sprite._damage_max_height = multi ? 0 : 60
				sprite._damage_muti = multi
				@_damage_sprite.push(sprite)
				@_damage_idx += 1
			end
		end
	end
	#==============================================================================
	# ** Sprite_Character
	#------------------------------------------------------------------------------
	#  This sprite is used to display the character.It observes the Game_Character
	#  class and automatically changes sprite conditions.
	#==============================================================================
	class Sprite_Character < RPG::Sprite
		#--------------------------------------------------------------------------
		alias mrmo_abs_sc_int initialize
		alias mrmo_abs_sc_update update
		alias mrmo_abs_sc_dispose dispose
		#--------------------------------------------------------------------------
		# * Object Initialization
		#     viewport  : viewport
		#     character : character (Game_Character)
		#--------------------------------------------------------------------------
		def initialize(viewport, character = nil)
			@state_animation_id = 0
			@page = nil
			mrmo_abs_sc_int(viewport, character)
		end
		#--------------------------------------------------------------------------
		# * Dispose
		#--------------------------------------------------------------------------
		def dispose
			dispose_collapse_erase_duration
			dispose_loop_animation
			dispose_animation_overlap
			super
		end
		
		def dispose_collapse_erase_duration
			return if @_collapse_erase_duration <= 0
			
			@collapse_character.character_name = ""
			self.opacity = @character.opacity
			self.blend_type = @character.blend_type
			self.bush_depth = @character.bush_depth
			self.color.set(0, 0, 0, 0)
			@collapse_character.erase
			@_collapse_erase_duration = 0
		end
		
		def dispose_animation_overlap
			return unless @_animation_overlap.any?
			
			@_animation_overlap.each do |ani|
				dispose_animation2(ani)
			end
		end
		
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			update_damage_sprites
			update_animation_id
			mrmo_abs_sc_update
			update_state_animation
			update_fade
			update_damage_display
			update_ani_array
			check_event_deletion
		end
		
		def update_damage_sprites
			return unless @_damage_sprite
			
			@_damage_sprite.each do |sprite|
				next unless sprite
				next if sprite.disposed?
				next if sprite._damage_duration < sprite._damage_duration_max
				
				dispose_damage(sprite)
			end
		end
		
		def update_animation_id
			return unless @character.animation_id != 0
			
			@character.ani_array ||= []
			@character.ani_array.push(@character.animation_id) unless @character.ani_array.include?(@character.animation_id)
			@character.animation_id = 0
		end
		
		def update_state_animation
			a = @character.is_a?(Game_Player) ? $game_party.actors[0] : $ABS.enemies[@character.id]
			return unless a 
			return if a.damage
			return if a.state_animation_id == @state_animation_id
			
			@state_animation_id = a.state_animation_id
			loop_animation($data_animations[@state_animation_id])
		end
		
		def update_fade
			if @character.is_a?(Game_Event) && @character.page != @page
				@page = @character.page
			end
			return unless @character.fade
			
			if @character.is_a?(Game_Event) || @character.is_a?(Game_Player)
				collapse_erase(@character)
			end
			@character.fade = false
		end
		
		def update_damage_display
			return unless $ABS.damage_display
			return unless @character.is_a?(Game_Player) || $ABS.enemies[@character.id]
			
			display_monster_damage if $ABS.enemies[@character.id]
			display_player_damage if @character.is_a?(Game_Player)
			@_damage_idx = 0
		end
		
		def display_monster_damage
			return unless $ABS.enemies[@character.id].damage || ($ABS.enemies[@character.id].damage_array && $ABS.enemies[@character.id].damage_array.size > 0)
			
			process_monster_damage
			clear_monster_damage_arrays
		end
		
		def process_monster_damage
			dmg_array = $ABS.enemies[@character.id].damage_array
			cri_array = $ABS.enemies[@character.id].critical_array
			dmg = ""
			
			sw = dmg_array.size > 1 ? true : false
			dmg_array.each_with_index do |dmg_val, i|
				next unless dmg_val
				
				damage(dmg_val, cri_array[i], sw)
				dmg += "#{dmg_val}|"
			end 
			Network::Main.socket.send("<mon_damage>#{id},#{dmg},#{$ABS.enemies[@character.id].critical}</mon_damage>\n") if $ABS.enemies[@character.id].send_damage
		end
		
		def clear_monster_damage_arrays
			$ABS.enemies[@character.id].damage = nil
			$ABS.enemies[@character.id].damage_array.clear
			$ABS.enemies[@character.id].critical_array.clear
			$ABS.enemies[@character.id].send_damage = true
		end
		
		def display_player_damage
			a = $game_party.actors[0]
			return unless a.damage || (a.damage_array && a.damage_array.size > 0)
			
			process_player_damage(a)
			clear_player_damage_arrays(a)
		end
		
		def process_player_damage(a)
			sw = dmg_array.size > 1 ? true : false
			unless sw
				a.damage_array << a.damage
				a.critical_array << a.critical
			end
			
			dmg_array = a.damage_array
			cri_array = a.critical_array
			dmg = ""
			
			dmg_array.each_with_index do |dmg_val, i|
				next unless dmg_val
				
				damage(dmg_val, cri_array[i], sw)
				dmg += "#{dmg_val}|"
			end
			Network::Main.socket.send("<player_damage>#{Network::Main.id},#{dmg},#{a.critical}</player_damage>\n")
		end
		
		def clear_player_damage_arrays(a)
			a.damage = nil
			a.damage_array.clear
			a.critical_array.clear
		end
		
		def update_ani_array
			return unless @character.ani_array && @character.ani_array.size >= 1
			
			@character.ani_array.each do |ani|
				animation = $data_animations[ani]
				animation2(animation, true)
			end
			@character.ani_array.clear
		end
		
		def check_event_deletion
			return unless @_animation_overlap && @_animation_overlap.size == 0
			return unless @character.is_a?(Game_Event) && @character.one_use
			
			delete_events(@character.id)
		end
	end
	#==============================================================================
	# ** Spriteset_Map
	#------------------------------------------------------------------------------
	#  This class brings together map screen sprites, tilemaps, etc.
	#  It's used within the Scene_Map class.
	#==============================================================================
	class Spriteset_Map
		#--------------------------------------------------------------------------
		alias mrmo_spriteset_map_init_characters init_characters
		alias mrmo_spriteset_map_update_character_sprites update_character_sprites
		alias mrmo_spriteset_map_dispose dispose
		#--------------------------------------------------------------------------
		def init_characters
			mrmo_spriteset_map_init_characters
			@ranged_sprites = []
			@ranged_sprites2 = []
			for range in $ABS.range.compact
				sprite = Sprite_Character.new(@viewport1, range)
				@ranged_sprites.push(sprite)
			end
		end
		#--------------------------------------------------------------------------
		def dispose
			for range in @ranged_sprites.compact
				range.dispose
			end
			mrmo_spriteset_map_dispose
		end
		#--------------------------------------------------------------------------
		def update_character_sprites
			mrmo_spriteset_map_update_character_sprites
			update_range_sprite
			update_range_sprite2
			for range in $ABS.range.compact
				next if !range.draw
				
				sprite = Sprite_Character.new(@viewport1, range)
				@ranged_sprites.push(sprite)
				range.draw = false
			end
		end
		#--------------------------------------------------------------------------
		# 범위안에 이벤트 만들고 이펙트 내보기
		def make_range_sprite(element, range, skill, sw = false) 
			Network::Main.send_with_tag("make_range_sprite", "#{element.id},#{range},#{skill.id}") if sw
			
			for i in 0..range * 2 # y 
				for j in 0..range * 2 # x
					nowY = i - range
					nowX = j - range
					
					ry = (nowY) * (nowY)
					rx = (nowX) * (nowX)
					r = ry + rx
					
					if r <= range * range
						sprite = RPG::Sprite.new(@viewport1)
						sprite.visible = true
						sprite.opacity = 255
						sprite.one_use = true
						sprite.animation2($data_animations[skill.animation2_id], true)
						sprite.ox = 0
						sprite.oy = 0
						@ranged_sprites2.push([sprite, element, nowX, nowY])
					end
				end
			end
		end
		
		def update_range_sprite
			for range in @ranged_sprites # Update ranged sprites
				next if range == nil #Skip NIL Values
				range.update
				next if !range.character.stop
				
				range.character.character_name = ""
				@ranged_sprites.delete(range)
				range.dispose
				$ABS.range.delete(range.character)				
			end
		end
		
		def update_range_sprite2
			for data in @ranged_sprites2
				range = data[0]
				element = data[1]
				ox = data[2]
				oy = data[3]
				
				if range == nil or range.disposed?
					@ranged_sprites2.delete(data)
					next
				end
				
				range.x = element.screen_x + ox * 32
				range.y = element.screen_y + oy * 32 - 32
				range.update
			end
		end
	end
	#==============================================================================
	# ** Game_Battler (part 3)
	#------------------------------------------------------------------------------
	#  This class deals with battlers. It's used as a superclass for the Game_Actor
	#  and Game_Enemy classes.
	#==============================================================================
	class Game_Battler
		attr_accessor :state_time
		attr_accessor :damage_array # 표시할 데미지를 모아두는 배열
		attr_accessor :critical_array # 표시할 크리티컬을 모아두는 배열
		attr_accessor :ani_array # 표시할 애니메이션 아이디를 모아두는 배열
		attr_accessor :buff_time # 버프 남은 시간
		attr_accessor :skill_mash # 쿨타임 남은 시간
		#--------------------------------------------------------------------------
		alias mrmo_abs_gb_int initialize
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize
			mrmo_abs_gb_int
			@state_time = 0
			@damage_array = []
			@critical_array = []
			@ani_array = []
			@buff_time = {} # 버프 남은 시간
			@skill_mash = {} # 쿨타임 남은 시간
		end
		
		#--------------------------------------------------------------------------
		# * Change 물리방어력
		#--------------------------------------------------------------------------
		def pdef=(pdef)
			@pdef = pdef
		end
		#--------------------------------------------------------------------------
		# * Change 마법방어력
		#--------------------------------------------------------------------------
		def mdef=(mdef)
			@mdef = mdef
		end
		
		#--------------------------------------------------------------------------
		# * Determine Usable Skills
		#     skill_id : skill ID
		#--------------------------------------------------------------------------
		def can_use_skill?(skill)
			# 여기다가 스킬 딜레이가 남아있으면 무시하도록 만들어보자
			return false if @skill_mash != nil and @skill_mash[skill.id] != nil and @skill_mash[skill.id] > 0
			return false if skill.sp_cost > self.sp
			return false if dead?
			return false if skill.atk_f == 0 and self.restriction == 1
			
			# Get usable time
			occasion = skill.occasion
			case occasion
			when 0..1
				return true
			when 2..3
				return false
			end
		end
		
		#--------------------------------------------------------------------------
		# * Applying Normal Attack Effects
		#     attacker : battler
		#--------------------------------------------------------------------------
		def attack_effect(attacker)
			# 나한테 적이아니면 공격 못함
			return if self.is_a?(ABS_Enemy) && attacker.is_a?(Game_Actor) && !self.hate_group.include?(0)
			
			self.critical = false  # Clear critical flag
			hit_result = true  # First hit detection
			
			atk = (attacker.atk + attacker.str / 20.0)
			if self.is_a?(Game_Actor)
				self.damage = (atk * (1.0 + attacker.str / 20.0)) * (20.0 / (20 + self.base_pdef))  # Calculate basic damage
			else
				self.damage = (atk * (1.0 + attacker.str / 20.0)) * (100.0 / (100 + self.base_pdef)) # Calculate basic damage
			end
			
			if !attacker.is_a?(Game_NetPlayer)
				self.damage *= elements_correct(attacker.element_set)  # Element correction
				self.damage /= 100
			end
			
			self.damage = self.damage.to_i
			self.damage = 1 if self.damage <= 0
			
			if self.damage > 0  # If damage value is strictly positive
				critical_data = $rpg_skill.critical_rate(attacker)
				
				critical_rate = [(3.0 * attacker.dex / self.agi), 1].max
				critical_rate += critical_data[0]
				
				self.critical = "player_hit" if self.is_a?(Game_Actor)
				if rand(100) < critical_rate  # Critical correction
					self.damage *= (3 + critical_data[1])
					self.critical = true 
				end
				
				self.damage /= 2 if self.guarding?  # Guard correction
			end
			
			if self.damage.abs > 0  # Dispersion
				amp = [self.damage.abs * 15 / 100, 1].max
				self.damage += rand(amp + 1) + rand(amp + 1) - amp
			end
			
			a_dex = [attacker.dex * (1.0 - (self.eva / 150.0)), 1.0].max
			eva = [(8.0 * self.agi / a_dex).to_i, 100].min  # Second hit detection
			
			hit = [100 - eva, 5].max  # Hit probability
			hit = 100 if self.cant_evade?  # If evasion is impossible, set hit probability to 100
			
			hit_result = (rand(100) < hit)
			
			if hit_result
				remove_states_shock  # State Removed by Shock
				
				if (self.is_a?(Game_Actor) && attacker.is_a?(ABS_Enemy) && $game_player.direction == attacker.event.direction) ||
					(attacker.is_a?(Game_Actor) && self.is_a?(ABS_Enemy) && self.event.direction == $game_player.direction)
					self.damage *= 2
				end
				
				self.damage = $rpg_skill.damage_calculation_attack(self.damage, self, attacker)  # 최종 데미지 계산
				self.damage += $ABS.weapon_skill(attacker.weapon_id, self)  # 특정 무기를 착용하면 추가 격 데미지가 있음
				self.hp -= self.damage
				
				@damage_array.push(self.damage)
				@critical_array.push(self.critical)
				
				return if self.is_a?(Game_Actor) and $ABS.player_dead?(self, attacker)
				return if self.is_a?(ABS_Enemy) and $ABS.enemies[self.event.id] == nil
				
				r = rand(100)
				if r <= (self.damage * 100 / self.maxhp) || r <= 40
					if self.is_a?(ABS_Enemy)
						$ABS.enemies[self.event.id].aggro = true if $ABS.enemies[self.event.id] != nil
						Network::Main.socket.send("<aggro>#{self.event.id},#{$game_party.actors[0].name}</aggro>\n")
					end
				end
				
				$ABS.send_network_monster(self) if self.is_a?(ABS_Enemy)
				
				@state_changed = false  # State change
				if !attacker.is_a?(Game_NetPlayer)
					states_plus(attacker.plus_state_set)
					states_minus(attacker.minus_state_set)
				end
				
			else
				self.damage = "Miss!"  # Set damage to "Miss"
				self.critical = false  # Clear critical flag
			end
			
			return true  # End Method			
		end
		
		#--------------------------------------------------------------------------
		# * Apply Skill Effects
		#     user  : the one using skills (battler)
		#     skill : skill
		#--------------------------------------------------------------------------
		def effect_skill(user, skill)
			if self.is_a?(ABS_Enemy) && user.is_a?(Game_Actor) # 공격 대상 확인
				return if !self.hate_group.include?(0)
			end
			
			if self.is_a?(ABS_Enemy) && user.is_a?(ABS_Enemy)
				return if self.id != user.id && !self.hate_group.include?(user.id)
			end
			
			self.critical = false
			
			# 스킬 범위에 따른 처리
			if (skill.scope == 3 || skill.scope == 4) && self.hp == 0 ||
				(skill.scope == 5 || skill.scope == 6) && self.hp >= 1
				return false
			end
			
			effective = false # Clear effective flag
			effective |= skill.common_event_id > 0 # 스킬이 효과를 가지는 경우
			
			hit = skill.hit # 첫 번째 명중 판정
			if skill.atk_f > 0 # 스킬 사용자의 명중률 계산
				hit *= user.hit / 100 if !user.is_a?(Game_NetPlayer)
			end
			
			hit_result = rand(10) < hit # 명중 판정
			effective |= hit < 100 # 불확실한 명중률인 경우 효과가 있다고 설정
			
			# 명중 시
			if hit_result
				power = skill.power + user.atk / 2
				power = $rpg_skill.skill_power_custom(user, skill.id, power)
				power *= (1.0 + user.atk / 20.0)
				
				if power > 0
					power -= self.pdef * [skill.pdef_f, 10].max / 200
					power -= self.mdef * skill.mdef_f / 100
					power = [power, 1].max
				end
				
				rate = 30
				rate += user.str * skill.str_f / 100.0
				rate += user.dex * skill.dex_f / 100.0
				rate += user.agi * skill.agi_f / 100.0
				rate += user.int * skill.int_f / 100.0
				
				self.damage = (power * rate / 30.0)
				self.damage *= elements_correct(skill.element_set)
				self.damage /= 100
				self.damage = self.damage.to_i
				
				if self.damage > 0  # If damage value is strictly positive
					critical_data = $rpg_skill.critical_skill_rate(user)
					
					critical_rate = 1.0 + (1.2 * user.int / 200)
					critical_rate += critical_data[0]
					critical_rate *= 100
					r = rand(10000)
					
					if r <= critical_rate.to_i  # Critical correction
						self.damage *= (1.5 + critical_data[1])
						self.critical = "skill_cri"
					end
					
					self.damage /= 2 if self.guarding?
				end
				
				self.damage = $rpg_skill.damage_by_skill(self.damage, skill.id, self)
				
				# 방어력에 따른 데미지 감소
				if self.damage > 0
					if self.is_a?(Game_Actor)
						limit = 200.0
					else
						limit = 500.0
					end					
					self.damage *= limit / (limit + (self.base_pdef + self.base_mdef * 4))
				end
				
				
				# Dispersion
				if skill.variance > 0 && self.damage.abs > 0
					amp = [self.damage.abs * skill.variance / 100, 1].max
					self.damage += rand(amp + 1) + rand(amp + 1) - amp
				end
				
				# 최종 데미지 계산
				self.damage = $rpg_skill.damage_calculation_skill(self.damage, self, user)
				self.damage /= 5 if user.is_a?(Game_NetPlayer) # pvp라면 1/5
				
				temp = $ABS.weapon_skill(user.weapon_id, self)
				if temp > 0
					self.critical = true
					self.damage += temp
				end
				
				# Second hit detection
				eva = [(4 * self.agi / user.dex + self.eva), 100].min
				hit = self.damage < 0 ? 100 : [(100 - eva * skill.eva_f / 100), 10].max
				hit = self.cant_evade? ? 100 : hit
				hit_result = rand(100) < hit
				
				# 불확실한 명중률인 경우 효과가 있다고 설정
				effective |= hit < 100
			end
			
			# If hit occurs
			if hit_result == true
				# If physical attack has power other than 0
				if skill.power != 0 and skill.atk_f > 0
					# State Removed by Shock
					remove_states_shock
					# Set to effective flag
					effective = true
				end
				
				# Substract damage from HP
				last_hp = self.hp
				self.hp -= self.damage
				@damage_array.push(self.damage)
				@critical_array.push(self.critical)
				
				r = rand(100)
				if r <= [(self.damage * 100 / self.maxhp), 30].max
					if self.is_a?(ABS_Enemy) and $ABS.enemies[self.event.id] != nil
						
						self.aggro = true
						Network::Main.socket.send("<aggro>#{self.event.id},#{$game_party.actors[0].name}</aggro>\n")
					end
				end
				
				return if self.is_a?(Game_Actor) and $ABS.player_dead?(self, user) 
				return if self.is_a?(ABS_Enemy) and $ABS.enemies[self.event.id] == nil
				
				
				# 맵 id, 몹id, 몹 hp, x, y, 방향, 딜레이 시간
				$ABS.send_network_monster(self) if self.is_a?(ABS_Enemy) and $ABS.enemies[self.event.id] != nil
				
				effective |= self.hp != last_hp
				# State change
				@state_changed = false
				effective |= states_plus(skill.plus_state_set)
				effective |= states_minus(skill.minus_state_set)
				
				if skill.power == 0
					self.damage = @state_changed ? 1 : "Miss"
				end
			else
				self.damage = "Miss"
			end
			return effective
		end
	end
	
	#==============================================================================
	# ** Game_Character (part 1)
	#------------------------------------------------------------------------------
	#  This class deals with characters. It's used as a superclass for the
	#  Game_Player and Game_Event classes.
	#==============================================================================
	class Game_Character
		attr_accessor :move_type
		attr_accessor :move_speed
		attr_accessor :move_frequency
		attr_accessor :character_name
		attr_accessor :animating
		attr_accessor :frame
		attr_accessor :fade
		attr_accessor :through # 겹치기 가능 여부
		attr_accessor :ani_array # 표시할 애니메이션 아이디를 모아두는 배열
		
		alias mrmo_abs_game_character_ini initialize
		def initialize
			mrmo_abs_game_character_ini
			@ani_array = []
		end
		
		#--------------------------------------------------------------------------
		# * Jump
		#     x_plus : x-coordinate plus value
		#     y_plus : y-coordinate plus value
		#--------------------------------------------------------------------------
		def jump_nt(x_plus, y_plus)
			new_x = @x + x_plus
			new_y = @y + y_plus
			
			if x_plus != 0
				move_horizontally(x_plus)
			elsif y_plus != 0
				move_vertically(y_plus)
			end
			
			@jump_count = 1
		end
		
		def move_horizontally(x_plus)
			count = x_plus.abs
			step = x_plus > 0 ? 1 : -1
			count.times do
				x = @x + step
				break unless passable?(x, @y, 0)
				@x = x
			end
		end
		
		def move_vertically(y_plus)
			count = y_plus.abs
			step = y_plus > 0 ? 1 : -1
			count.times do
				y = @y + step
				break unless passable?(@x, y, 0)
				@y = y
			end
		end
		
		#--------------------------------------------------------------------------
		# * Set Animation
		#--------------------------------------------------------------------------
		def set_animate(name)
			return if @animating
			@frame = 4
			@old_char = @character_name
			@character_name = name
			@animating = true
			@anim_wait = 40
			@pattern = 0
			@direction_fix = true
		end
		#--------------------------------------------------------------------------
		alias mrmo_abs_game_character_update update
		#--------------------------------------------------------------------------
		# * Frame Update
		#--------------------------------------------------------------------------
		def update
			return animate_pose if @animating
			mrmo_abs_game_character_update
		end
		#--------------------------------------------------------------------------
		# * Frame Update Pose
		#--------------------------------------------------------------------------
		def animate_pose
			if @anim_wait >= 8
				@pattern = (@pattern + 1) % 4
				@frame -= 1
				@anim_wait = 0
			end
			
			@anim_wait += 1 if @anim_wait < 18 - @move_speed * 2
			if @frame == 0
				end_animate
				return
			end
			update_jump if jumping?
		end
		
		#--------------------------------------------------------------------------
		# * End Animate
		#--------------------------------------------------------------------------
		def end_animate
			@animating = false
			@character_name = @old_char
			@direction_fix = false
		end
		
		def send_enemy_move
			return if !self.is_a?(Game_Event)
			return if $ABS.enemies[self.event.id] == nil 
			return if !$ABS.enemies[self.event.id].aggro
			
			$ABS.send_network_monster($ABS.enemies[self.event.id])
			Network::Main.socket.send("<mon_move>#{self.event.id},#{@direction},#{self.x},#{self.y}</mon_move>\n")
		end
		
		def check_enemy_movable(is_ok)
			return true if !self.is_a?(Game_Event)
			
			enemy = $ABS.enemies[self.event.id]
			return true unless enemy
			return true if is_ok
			return enemy.aggro 
		end
		
		def move_down(turn_enabled = true, is_ok = false) # is_ok : 이동 가능
			return if !check_enemy_movable(is_ok)
			turn_down if turn_enabled # Turn down
			return if self.is_a?(Game_Player) and Key.press?(KEY_CTRL)
			
			if passable?(@x, @y, 2)
				@y += 1
				increase_steps
				send_enemy_move
			else
				check_event_trigger_touch(@x, @y + 1) # Determine if touch event is triggered
			end
		end
		
		def move_left(turn_enabled = true, is_ok = false) # is_ok는 외부요인으로 옮기는거		
			return if !check_enemy_movable(is_ok)
			turn_left if turn_enabled
			return if self.is_a?(Game_Player) and Key.press?(KEY_CTRL)
			
			if passable?(@x, @y, 4)
				@x -= 1
				increase_steps
				send_enemy_move
			else
				check_event_trigger_touch(@x - 1, @y)
			end
		end
		
		def move_right(turn_enabled = true, is_ok = false)
			return if !check_enemy_movable(is_ok)
			turn_right if turn_enabled
			return if self.is_a?(Game_Player) and Key.press?(KEY_CTRL)
			
			if passable?(@x, @y, 6)	
				@x += 1
				increase_steps
				send_enemy_move
			else
				check_event_trigger_touch(@x + 1, @y)
			end
		end
		
		def move_up(turn_enabled = true, is_ok = false)
			return if !check_enemy_movable(is_ok)
			turn_up if turn_enabled
			return if self.is_a?(Game_Player) and Key.press?(KEY_CTRL)
			
			if passable?(@x, @y, 8)
				@y -= 1
				increase_steps
				send_enemy_move
			else
				check_event_trigger_touch(@x, @y - 1)
			end
		end
		
		#--------------------------------------------------------------------------
		# * 대각선 이동
		# * Move Lower Left
		#--------------------------------------------------------------------------
		def move_lower_left
			# If no direction fix
			unless @direction_fix
				# Face down is facing right or up
				@direction = (@direction == 6 ? 4 : @direction == 8 ? 2 : @direction)
			end
			# When a down to left or a left to down course is passable
			if (passable?(@x, @y, 2) and passable?(@x, @y + 1, 4)) or
				(passable?(@x, @y, 4) and passable?(@x - 1, @y, 2))
				# Update coordinates
				@x -= 1
				@y += 1
				# Increase steps
				increase_steps
			else
				check_event_trigger_touch(@x - 1, @y + 1)
			end
		end
		#--------------------------------------------------------------------------
		# * Move Lower Right
		#--------------------------------------------------------------------------
		def move_lower_right
			# If no direction fix
			unless @direction_fix
				# Face right if facing left, and face down if facing up
				@direction = (@direction == 4 ? 6 : @direction == 8 ? 2 : @direction)
			end
			# When a down to right or a right to down course is passable
			if (passable?(@x, @y, 2) and passable?(@x, @y + 1, 6)) or
				(passable?(@x, @y, 6) and passable?(@x + 1, @y, 2))
				# Update coordinates
				@x += 1
				@y += 1
				# Increase steps
				increase_steps
			else
				check_event_trigger_touch(@x + 1, @y + 1)
				
			end
		end
		#--------------------------------------------------------------------------
		# * Move Upper Left
		#--------------------------------------------------------------------------
		def move_upper_left
			# If no direction fix
			unless @direction_fix
				# Face left if facing right, and face up if facing down
				@direction = (@direction == 6 ? 4 : @direction == 2 ? 8 : @direction)
			end
			# When an up to left or a left to up course is passable
			if (passable?(@x, @y, 8) and passable?(@x, @y - 1, 4)) or
				(passable?(@x, @y, 4) and passable?(@x - 1, @y, 8))
				# Update coordinates
				@x -= 1
				@y -= 1
				# Increase steps
				increase_steps
			else
				check_event_trigger_touch(@x - 1, @y - 1)
			end
		end
		#--------------------------------------------------------------------------
		# * Move Upper Right
		#--------------------------------------------------------------------------
		def move_upper_right
			# If no direction fix
			unless @direction_fix
				# Face right if facing left, and face up if facing down
				@direction = (@direction == 4 ? 6 : @direction == 2 ? 8 : @direction)
			end
			# When an up to right or a right to up course is passable
			if (passable?(@x, @y, 8) and passable?(@x, @y - 1, 6)) or
				(passable?(@x, @y, 6) and passable?(@x + 1, @y, 8))
				# Update coordinates
				@x += 1
				@y -= 1
				# Increase steps
				increase_steps
			else
				check_event_trigger_touch(@x + 1, @y - 1)
			end
		end
		
		#--------------------------------------------------------------------------
		# * Move at Random
		#--------------------------------------------------------------------------
		def move_random()
			if self.is_a?(Game_Event) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
				return true if !$is_map_first
			end
			
			case rand(4)
			when 0  # Move down
				move_down()
			when 1  # Move left
				move_left()
			when 2  # Move right
				move_right()
			when 3  # Move up
				move_up()
			end
		end
		
		#--------------------------------------------------------------------------
		# * Move toward B
		#--------------------------------------------------------------------------
		def move_to(b)
			return if @stop_count <= (15 - @move_frequency * 2) * (6 - @move_frequency)
			#~ @stop_count = 0
			# Get difference in player coordinates
			sx = @x - b.x
			sy = @y - b.y
			# If coordinates are equal
			if sx == 0 and sy == 0
				return
			end
			# Get absolute value of difference
			abs_sx = sx > 0 ? sx : -sx
			abs_sy = sy > 0 ? sy : -sy
			# Branch by random numbers 0-5
			case rand(6)
			when 0..4  # Approach player
				# If horizontal and vertical distances are equal
				if abs_sx == abs_sy
					# Increase one of them randomly by 1
					rand(2) == 0 ? abs_sx += 1 : abs_sy += 1
				end
				# If horizontal distance is longer
				if abs_sx > abs_sy
					# Move towards player, prioritize left and right directions
					if sx > 0
						move_left()
					else
						move_right()
					end
					
					if not moving? and sy != 0
						if sy > 0
							move_up()
						else
							move_down()
						end
					end
					# If vertical distance is longer
				else
					# Move towards player, prioritize up and down directions
					if sy > 0
						move_up()
					else
						move_down()
					end
					if not moving? and sx != 0						
						if sx > 0
							move_left()
						else
							move_right()
						end
					end
				end
			when 5  # random
				move_random
			end
			#~ turn_to(b)
		end
		#--------------------------------------------------------------------------
		# * Turn Towards B
		#--------------------------------------------------------------------------
		def turn_to(b)
			return if @stop_count <= (15 - @move_frequency * 2) * (6 - @move_frequency)
			# Get difference in player coordinates
			sx = @x - b.x
			sy = @y - b.y
			# If coordinates are equal
			if sx == 0 and sy == 0
				return
			end
			# If horizontal distance is longer
			if sx.abs > sy.abs
				# Turn to the right or left towards player
				sx > 0 ? turn_left : turn_right
				# If vertical distance is longer
			else
				# Turn up or down towards player
				sy > 0 ? turn_up : turn_down
			end
		end
	end
	#==============================================================================
	# ** Game_Party
	#------------------------------------------------------------------------------
	#  This class handles the party. It includes information on amount of gold 
	#  and items. Refer to "$game_party" for the instance of this class.
	#==============================================================================
	class Game_Party
		#--------------------------------------------------------------------------
		alias mrmo_abs_game_party_setup_starting_members setup_starting_members
		#--------------------------------------------------------------------------
		attr_accessor :items
		#--------------------------------------------------------------------------
		# * Initial Party Setup
		#--------------------------------------------------------------------------
		def setup_starting_members
			mrmo_abs_game_party_setup_starting_members
			$game_player.actor = $game_party.actors[0]
		end
	end
	#============================================================================
	# * ABS Enemy
	#============================================================================
	class ABS_Enemy < Game_Battler
		#--------------------------------------------------------------------------
		attr_accessor :event_id
		attr_accessor :enemy_id
		attr_accessor :behavior
		attr_accessor :see_range
		attr_accessor :hear_range
		attr_accessor :aggressiveness
		attr_accessor :trigger   
		attr_accessor :hate_points
		attr_accessor :hate_group
		attr_accessor :closest_enemy
		attr_accessor :in_battle
		attr_accessor :ranged
		attr_accessor :event
		attr_accessor :attacking
		attr_accessor :temp_move_type
		attr_accessor :temp_speed
		attr_accessor :temp_frequency
		attr_accessor :temp_restore_sw
		
		attr_accessor :actor
		attr_accessor :respawn
		
		attr_accessor :aggro
		attr_accessor :aggro_mash # 어그로 유지 시간
		
		attr_accessor :send_damage
		attr_accessor :skill_mash # 적 스킬 딜레이 넣기
		
		attr_accessor :casting_mash # 주문외우는 딜레이
		attr_accessor :casting_action # 주문 외우는 스킬
		attr_accessor :casting_idx
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(enemy_id)
			super()
			$data_enemies[enemy_id].maxhp = ABS_ENEMY_HP[enemy_id][0] if ABS_ENEMY_HP[enemy_id] != nil 
			
			@event_id= 0
			@see_range = 0
			@hear_range = 0
			@aggressiveness = 1
			@trigger = []
			@enemy_id = enemy_id
			@in_battle = false
			@hp = maxhp
			@sp = maxsp
			@closest_enemy = false
			@hate_points = []
			@ranged = nil
			@hate_group = []
			@event = nil
			@attacking = nil
			
			@temp_move_type = 0 
			@temp_speed = 0
			@temp_frequency = 0 
			@temp_restore_sw = false
			
			@actor = self
			@respawn = 0
			@aggro = $is_map_first
			@aggro_mash = 0 # 어그로 유지 시간
			@send_damage = true
			@skill_mash = {}
			
			# 캐스팅
			@casting_mash = 0
			@casting_action = nil
			@casting_idx = 0
		end
		#--------------------------------------------------------------------------
		# * Get Enemy ID
		#--------------------------------------------------------------------------
		def id
			return @enemy_id
		end
		#--------------------------------------------------------------------------
		# * Get Index
		#--------------------------------------------------------------------------
		def index
			return @member_index
		end
		#--------------------------------------------------------------------------
		# * Get Name
		#--------------------------------------------------------------------------
		def name
			return $data_enemies[@enemy_id].name
		end
		#--------------------------------------------------------------------------
		# * Get Basic Maximum HP
		#--------------------------------------------------------------------------
		def base_maxhp
			return $data_enemies[@enemy_id].maxhp
		end
		#--------------------------------------------------------------------------
		# * Get Basic Maximum SP
		#--------------------------------------------------------------------------
		def base_maxsp
			return $data_enemies[@enemy_id].maxsp
		end
		#--------------------------------------------------------------------------
		# * Get Basic Strength
		#--------------------------------------------------------------------------
		def base_str
			return $data_enemies[@enemy_id].str
		end
		#--------------------------------------------------------------------------
		# * Get Basic Dexterity
		#--------------------------------------------------------------------------
		def base_dex
			return $data_enemies[@enemy_id].dex
		end
		#--------------------------------------------------------------------------
		# * Get Basic Agility
		#--------------------------------------------------------------------------
		def base_agi
			return $data_enemies[@enemy_id].agi
		end
		#--------------------------------------------------------------------------
		# * Get Basic Intelligence
		#--------------------------------------------------------------------------
		def base_int
			return $data_enemies[@enemy_id].int
		end
		#--------------------------------------------------------------------------
		# * Get Basic Attack Power
		#--------------------------------------------------------------------------
		def base_atk
			return $data_enemies[@enemy_id].atk
		end
		#--------------------------------------------------------------------------
		# * Get Basic Physical Defense
		#--------------------------------------------------------------------------
		def base_pdef
			return $data_enemies[@enemy_id].pdef
		end
		#--------------------------------------------------------------------------
		# * Get Basic Magic Defense
		#--------------------------------------------------------------------------
		def base_mdef
			return $data_enemies[@enemy_id].mdef
		end
		#--------------------------------------------------------------------------
		# * Get Basic Evasion
		#--------------------------------------------------------------------------
		def base_eva
			return $data_enemies[@enemy_id].eva
		end
		#--------------------------------------------------------------------------
		# * Get Offensive Animation ID for Normal Attack
		#--------------------------------------------------------------------------
		def animation1_id
			return $data_enemies[@enemy_id].animation1_id
		end
		#--------------------------------------------------------------------------
		# * Get Target Animation ID for Normal Attack
		#--------------------------------------------------------------------------
		def animation2_id
			return $data_enemies[@enemy_id].animation2_id
		end
		#--------------------------------------------------------------------------
		# * Get Element Revision Value
		#     element_id : Element ID
		#--------------------------------------------------------------------------
		def element_rate(element_id)
			# Get a numerical value corresponding to element effectiveness
			table = [0,200,150,100,50,0,-100]
			result = table[$data_enemies[@enemy_id].element_ranks[element_id]]
			# If protected by state, this element is reduced by half
			for i in @states
				if $data_states[i].guard_element_set.include?(element_id)
					result /= 2
				end
			end
			# End Method
			return result
		end
		#--------------------------------------------------------------------------
		# * Get State Effectiveness
		#--------------------------------------------------------------------------
		def state_ranks
			return $data_enemies[@enemy_id].state_ranks
		end
		#--------------------------------------------------------------------------
		# * Determine State Guard
		#     state_id : state ID
		#--------------------------------------------------------------------------
		def state_guard?(state_id)
			return false
		end
		#--------------------------------------------------------------------------
		# * Get Normal Attack Element
		#--------------------------------------------------------------------------
		def element_set
			return []
		end
		#--------------------------------------------------------------------------
		# * Get Normal Attack State Change (+)
		#--------------------------------------------------------------------------
		def plus_state_set
			return []
		end
		#--------------------------------------------------------------------------
		# * Get Normal Attack State Change (-)
		#--------------------------------------------------------------------------
		def minus_state_set
			return []
		end
		#--------------------------------------------------------------------------
		# * Aquire Actions
		#--------------------------------------------------------------------------
		def actions
			return $data_enemies[@enemy_id].actions
		end
		#--------------------------------------------------------------------------
		# * Get EXP
		#--------------------------------------------------------------------------
		def exp
			return $data_enemies[@enemy_id].exp
		end
		#--------------------------------------------------------------------------
		# * Get Gold
		#--------------------------------------------------------------------------
		def gold
			return $data_enemies[@enemy_id].gold
		end
		#--------------------------------------------------------------------------
		# * Get Item ID
		#--------------------------------------------------------------------------
		def item_id
			return $data_enemies[@enemy_id].item_id
		end
		#--------------------------------------------------------------------------
		# * Get Weapon ID
		#--------------------------------------------------------------------------
		def weapon_id
			return $data_enemies[@enemy_id].weapon_id
		end
		#--------------------------------------------------------------------------
		# * Get Armor ID
		#--------------------------------------------------------------------------
		def armor_id
			return $data_enemies[@enemy_id].armor_id
		end
		#--------------------------------------------------------------------------
		# * Get Treasure Appearance Probability
		#--------------------------------------------------------------------------
		def treasure_prob
			return $data_enemies[@enemy_id].treasure_prob
		end
	end
	
	
end
class Interpreter
	#--------------------------------------------------------------------------
	# * Script
	#--------------------------------------------------------------------------
	def command_355
		# Set first line to script
		script = @list[@index].parameters[0] + "\n"
		# Loop
		loop do
			# If next event command is second line of script or after
			if @list[@index+1].code == 655
				# Add second line or after to script
				script += @list[@index+1].parameters[0] + "\n"
				# If event command is not second line or after
			else
				# Abort loop
				break
			end
			# Advance index
			@index += 1
		end
		# Evaluation
		result = eval(script)
		# Continue
		return true
	end
end
