$exp_limit = 150 # 한번에 최대 얻을 수 있는 경험치 퍼센트
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
	ABS_ENEMY_HP[37]  = [8_000_000_000, 0] # 무적토끼
	ABS_ENEMY_HP[269] = [2_000_000, 0] # 무적다람쥐
	ABS_ENEMY_HP[260]  = [20, 0] # 테스트
	
	# 기타
	ABS_ENEMY_HP[58] = [2_250_000, 1] # 수룡
	ABS_ENEMY_HP[59] = [2_250_000, 1] # 화룡
	
	ABS_ENEMY_HP[61] = [15_000_000, 1] # 주작
	ABS_ENEMY_HP[62] = [15_000_000, 1] # 백호
	
	ABS_ENEMY_HP[98] = [10_500_000, 1] # 비류장군
	
	ABS_ENEMY_HP[111] = [600_000, 1] # 산적왕
	
	ABS_ENEMY_HP[102] = [400_000_000, 1] # 반고
	ABS_ENEMY_HP[112] = [50_000_000, 1] # 청룡
	ABS_ENEMY_HP[113] = [50_000_000, 1] # 현무
	
	# 12 지신
	ABS_ENEMY_HP[119] = [1_500_000, 1] # 백호왕
	ABS_ENEMY_HP[123] = [1_000_000, 1] # 뱀왕
	ABS_ENEMY_HP[124] = [150_000, 1] # 쥐왕
	ABS_ENEMY_HP[126] = [450_000, 1] # 돼지왕
	ABS_ENEMY_HP[128] = [1_700_000, 1] # 원숭이왕
	ABS_ENEMY_HP[132] = [3_600_000, 1] # 건룡
	ABS_ENEMY_HP[133] = [3_600_000, 1] # 감룡
	ABS_ENEMY_HP[134] = [3_600_000, 1] # 진룡
	
	# 용궁
	ABS_ENEMY_HP[143] = [350_000, 1] # 복어장군
	ABS_ENEMY_HP[146] = [900_000, 1] # 게장군
	ABS_ENEMY_HP[147] = [1_500_000, 1] # 문어장군
	ABS_ENEMY_HP[150] = [3_000_000, 1] # 해마장군
	ABS_ENEMY_HP[153] = [6_000_000, 1] # 인어장군
	ABS_ENEMY_HP[156] = [10_000_000, 1] # 상어장군
	ABS_ENEMY_HP[158] = [18_000_000, 1] # 해파리장군
	ABS_ENEMY_HP[159] = [30_000_000, 1] # 거북장군
	ABS_ENEMY_HP[160] = [1_000_000, 0] # 수괴
	
	# 일본
	ABS_ENEMY_HP[172] = [300_000, 1] # 아귀
	ABS_ENEMY_HP[176] = [700_000, 1] # 백향
	ABS_ENEMY_HP[180] = [3_200_000, 1] # 견귀
	ABS_ENEMY_HP[194] = [8_500_000, 1] # 문려
	ABS_ENEMY_HP[186] = [20_000_000, 1] # 무사
	
	ABS_ENEMY_HP[187] = [1_200_000, 0] # 선월
	ABS_ENEMY_HP[188] = [1_300_000, 0] # 이광
	ABS_ENEMY_HP[189] = [30_000_000, 1] # 주마관
	
	ABS_ENEMY_HP[191] = [40_000_000, 1] # 유성지
	ABS_ENEMY_HP[192] = [50_000_000, 1] # 해골왕
	ABS_ENEMY_HP[193] = [150_000_000, 1] # 파괴왕
	
	# 중국
	ABS_ENEMY_HP[204] = [150_000, 1] # 인묘
	ABS_ENEMY_HP[208] = [300_000, 1] # 염유왕
	ABS_ENEMY_HP[212] = [1_000_000, 1] # 기린왕
	ABS_ENEMY_HP[215] = [2_000_000, 1] # 악어왕
	
	ABS_ENEMY_HP[220] = [3_000_000, 1] # 산소괴왕
	ABS_ENEMY_HP[224] = [7_000_000, 1] # 괴성왕
	ABS_ENEMY_HP[227] = [1_300_000, 0] # 뇌신'태
	ABS_ENEMY_HP[228] = [18_000_000, 1] # 뇌신왕
	
	ABS_ENEMY_HP[229] = [1_500_000, 0] # 연청천구
	ABS_ENEMY_HP[230] = [1_600_000, 0] # 연자천구
	ABS_ENEMY_HP[231] = [30_000_000, 1] # 천구왕
	
	ABS_ENEMY_HP[232] = [150_000_000, 1] # 산신대왕
	ABS_ENEMY_HP[233] = [5_000_000, 0] # 산신전사
	ABS_ENEMY_HP[234] = [3_000_000, 0] # 산신도사
	ABS_ENEMY_HP[235] = [4_000_000, 0] # 산신도적
	ABS_ENEMY_HP[236] = [3_000_000, 0] # 산신주술사
	
	# 환상의섬
	ABS_ENEMY_HP[246] = [5_000_000, 1] # 선장망령
	ABS_ENEMY_HP[249] = [1_500_000, 1] # 야월진랑
	
	ABS_ENEMY_HP[250] = [1_700_000, 0] # 철보장
	ABS_ENEMY_HP[251] = [1_800_000, 0] # 철거인
	ABS_ENEMY_HP[252] = [60_000_000, 1] # 마려
	
	ABS_ENEMY_HP[253] = [5_000_000, 1] # 현무
	ABS_ENEMY_HP[257] = [5_000_000, 1] # 태산
	ABS_ENEMY_HP[258] = [100_000_000, 1] # 길림장군
	ABS_ENEMY_HP[259] = [500_000_000, 1] # 가릉빈가
	
	# 한두고개
	ABS_ENEMY_HP[268] = [7_777_777, 1] # 최강다람쥐
	ABS_ENEMY_HP[269] = [22_222_222, 1] # 무적다람쥐
	
	# 몬스터 경험치 설정
	ENEMY_EXP = {} # [var, (hp_per, sp_per)(배율)]
	# 파티 퀘스트
	ENEMY_EXP[45] = [10_000, 1.0, 1.0] # 추격산적
	
	ENEMY_EXP[91] = [50_000, 3.0, 3.0] # 비류성창병
	ENEMY_EXP[96] = [100_000, 4.0, 4.0] # 비류성자객
	ENEMY_EXP[97] = [150_000, 5.0, 5.0] # 비류성수문장
	ENEMY_EXP[90] = [200_000, 7.0, 7.0] # 비류성정예군
	ENEMY_EXP[98] = [10_000_000, 200.0, 200.0] # 비류장군
	
	ENEMY_EXP[254] = [200_000, 10.0, 10.0] # 뇌랑
	ENEMY_EXP[255] = [250_000, 11.0, 11.0] # 왕가
	ENEMY_EXP[256] = [350_000, 20.0, 20.0] # 조왕
	ENEMY_EXP[257] = [2_500_000, 30.0, 30.0] # 태산
	ENEMY_EXP[258] = [80_000_000, 600.0, 600.0] # 길림장군
	
	# 3차 퀘스트
	ENEMY_EXP[61] = [45_000_000] # 주작
	ENEMY_EXP[62] = [45_000_000] # 백호
	
	# 4차 퀘스트
	ENEMY_EXP[112] = [250_000_000] # 청룡
	ENEMY_EXP[113] = [250_000_000] # 현무
	ENEMY_EXP[102] = [1_600_000_000] # 반고
	
	# 12지신
	ENEMY_EXP[132] = [11_600_000] # 건룡
	ENEMY_EXP[133] = [11_600_000] # 감룡
	ENEMY_EXP[134] = [11_600_000] # 진룡
	
	# 용궁
	ENEMY_EXP[150] = [7_000_000] # 해마장군
	ENEMY_EXP[153] = [15_000_000] # 인어장군
	ENEMY_EXP[156] = [30_000_000] # 상어장군
	ENEMY_EXP[158] = [55_000_000] # 해파리장군
	ENEMY_EXP[159] = [80_000_000] # 거북장군
	
	# 일본
	ENEMY_EXP[194] = [20_000_000] # 문려
	ENEMY_EXP[186] = [57_500_000] # 무사
	ENEMY_EXP[189] = [75_000_000] # 주마관
	
	ENEMY_EXP[191] = [150_000_000] # 유성지
	ENEMY_EXP[192] = [270_000_000] # 해골왕
	ENEMY_EXP[193] = [1_350_000_000] # 파괴왕
	
	# 중국
	ENEMY_EXP[224] = [15_000_000] # 괴성왕
	ENEMY_EXP[228] = [36_000_000] # 뇌신왕
	ENEMY_EXP[231] = [70_000_000] # 천구왕
	
	ENEMY_EXP[232] = [1_000_000_000] # 산신대왕
	ENEMY_EXP[233] = [22_500_000] # 산신전사
	ENEMY_EXP[234] = [21_000_000] # 산신도사
	ENEMY_EXP[235] = [22_500_000] # 산신도적
	ENEMY_EXP[236] = [21_500_000] # 산신주술사
	
	# 환상의섬
	ENEMY_EXP[246] = [15_000_000] # 선장망령
	ENEMY_EXP[252] = [300_000_000] # 마려
	ENEMY_EXP[259] = [4_000_000_000] # 가릉빈가
	
	# 한두고개
	ENEMY_EXP[268] = [9_999_999, 0] # 최강다람쥐
	ENEMY_EXP[269] = [22_222_222, 0] # 무적다람쥐
	
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
		attr_accessor :damage_bitmap
		attr_accessor :hate_group
		#--------------------------------------------------------------------------
		# * Object Initialization
		# 생성자, 변수 초기화
		#--------------------------------------------------------------------------
		def initialize
			@enemies = {} #ABS Enemy Variables
			@attack_key = ATTACK_KEY #Attack Key
			@skill_keys = SKILL_KEYS #Skill Keys
			@item_keys = ITEM_KEYS #Item Keys
			
			@skill_mash = {} #Button Mash (스킬 후딜레이)
			@item_mash = 0 # 아이템 후딜레이
			@attack_mash = 0 # 공격키 후 딜레이
			
			@range = [] #Ranged Skills and Weapons
			@damage_display = DISPLAY_DAMAGE #Display Demage true:false
			@player_ani = ANIMATE_PLAYER #Player Animated?
			@enemy_ani = ANIMATE_ENEMY #Enemy Animated?
			
			@active = true # ABS Active
			@char_dir = Dir.entries("./Graphics/Characters")
			
			@actor = $game_party.actors[0]
			@damage_bitmap = {}
			@sec = Graphics.frame_rate
			
			@hate_group = {}
			@hate_group[0] = [@actor]
			ini_create_damage_bitmap
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
		
		# 데미지 비트맵 미리 만드는 코드 
		def ini_create_damage_bitmap
			cri_arr = [
				"heal",
				"heal_sp",
				"player_hit",
				"skill_cri",
				"true",
				"false",
				"default",
				true,
				false
			]
			
			cri_arr.each do |cri|
				@damage_bitmap[cri] = {}
				(0..9).each do |i|
					@damage_bitmap[cri][i.to_s] = create_damage_bitmap(i.to_s, cri)
				end
				@damage_bitmap[cri][","] = create_damage_bitmap(",", cri)
			end
		end
		
		def create_damage_bitmap(damage_string, critical)
			bitmap = Bitmap.new(20, 30)
			font_name = Font.exist?(DAMAGE_FONT_NAME) ? DAMAGE_FONT_NAME : DAMAGE_FONT_NAME2
			font_size = critical ? DAMAGE_CRI_FONT_SIZE : DAMAGE_FONT_SIZE
			font_color, bold = get_font_color_bold(critical)
			bold ||= false
			
			bitmap.font.name = font_name
			bitmap.font.size = font_size
			bitmap.font.color = DAMAGE_FONT_COLOR
			bitmap.draw_text(+1, +1, bitmap.width, bitmap.height, damage_string, 0)
			bitmap.font.color = font_color
			bitmap.font.bold = bold
			bitmap.draw_text(0, 0, bitmap.width, bitmap.height, damage_string, 0)
			return bitmap
		end
		
		def get_font_color_bold(critical)
			case critical
			when "heal" 
				return [Color.new(102, 255, 102), false]
			when "heal_sp" 
				return [Color.new(168, 188, 255), false]
			when "player_hit"
				return [Color.new(255, 142, 165), false]
			when "skill_cri"
				return [Color.new(70, 113, 255), true]
			when true, "true" 
				return [Color.new(255, 0, 51), true]
			when false, "false"
				return [Color.new(255, 255, 255), false]
			else
				return [Color.new(255, 255, 255), false]
			end
		end
		
		#--------------------------------------------------------------------------
		# * ABS Refresh(Event, List, Characterset Name) 새로고침
		#--------------------------------------------------------------------------
		def refresh(event, list, character_name)
			return unless list # 이벤트가 없다면 무시
			
			if event.character_name != "" and !@char_dir.include?(event.character_name + ".png")
				event.character_name = "공격스킬2"
			end
			
			parameters = SDK.event_comment_input(event, 11, "ABS")
			return if parameters.nil? 
			
			@enemies.delete(event.id) #Delete the event from the list
			#Get Enemy ID
			id = parameters[0].split[1].to_i
			enemy = $data_enemies[id] 
			return unless enemy 
			
			@enemies[event.id] = ABS_Enemy.new(enemy.id)
			@enemies[event.id].event = event
			@enemies[event.id].event_id = event.id
			event.name = "[id#{@enemies[event.id].name}]" unless @enemies[event.id].name.empty?
			
			sw = event.character_name == "공격스킬2"
			if ABS_ENEMY_CHAR[enemy.id] && sw
				char_name = "(몬)" + ABS_ENEMY_CHAR[enemy.id][0]
				hue = ABS_ENEMY_CHAR[id][1] || 0
				opcity = ABS_ENEMY_CHAR[id][2] || 255
				event.es_set_graphic(char_name, opcity, hue) if @char_dir.include?(char_name + ".png")
			end
			
			n = parameters[0].split[1].to_i
			if $enemy_spec.spec(n) != nil
				spec = $enemy_spec.spec(n)
			else
				spec = parameters[1..10].map { |param| param.split[1] }
			end
			
			@enemies[event.id].orgin_move_type = @enemies[event.id].event.move_type
			@enemies[event.id].orgin_speed = @enemies[event.id].event.move_speed 
			@enemies[event.id].orgin_frequency = @enemies[event.id].event.move_frequency 
			
			@enemies[event.id].behavior = spec[0].to_i
			@enemies[event.id].see_range = spec[1].to_i
			@enemies[event.id].hear_range = spec[2].to_i
			@enemies[event.id].closest_enemy = spec[3]
			@enemies[event.id].hate_group = spec[4]
			@enemies[event.id].aggressiveness = spec[5]
			@enemies[event.id].temp_speed = spec[6].to_i
			@enemies[event.id].temp_frequency = spec[7].to_i
			@enemies[event.id].trigger = spec[8]
			@enemies[event.id].respawn = spec[9].to_i if spec[9]
			
			if @enemies[event.id].event.move_type != 3
				@enemies[event.id].event.move_speed = @enemies[event.id].temp_speed
				@enemies[event.id].event.move_frequency = @enemies[event.id].temp_frequency
			end
			
			@enemies[event.id].aggro = $is_map_first
			@enemies[event.id].aggressiveness = (@enemies[event.id].aggressiveness * 45.0 + rand(3) - 2) / 45.0 
			@enemies[event.id].rpg_skill = Rpg_skill.new(@enemies[event.id])
			
			@hate_group[enemy.id] = [] unless @hate_group[enemy.id]
			@hate_group[enemy.id] << @enemies[event.id] unless @hate_group[enemy.id].include?(@enemies[event.id])
		end
		
		#--------------------------------------------------------------------------
		# * Update(Frame) 1프레임마다 실행되는 함수
		#--------------------------------------------------------------------------
		def update
			#Update Player
			$skill_Delay_Console.update if $skill_Delay_Console
			update_player 
			update_enemy  #Update Enemy AI
			update_range
		end
		
		def update_range
			for range in @range
				next unless range
				range.update
			end
		end
		
		#--------------------------------------------------------------------------
		# * 몬스터가 리스폰 될떄 현재 맵에서 랜덤으로 스폰 될 수 있도록
		#--------------------------------------------------------------------------
		def rand_spawn(e) # 몬스터 데이터를 받음
			return if e.name.include?("무적토끼") # 제자리 스폰할 애들은 냅두기
			
			h = $game_map.height
			w = $game_map.width
			count = 0
			
			while count < 10000
				count += 1
				x = rand(w)
				y = rand(h)
				d = (rand(4) + 1) * 2
				next unless $game_map.passable?(x, y, d)
				
				e.moveto(x, y)
				Network::Main.socket.send("<mon_move>#{e.event.id},#{d},#{x},#{y}</mon_move>\n") if @enemies[e.event.id].aggro
				return 
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
			actor.skill_mash.each do |id, time|
				actor.skill_mash[id] = 0
			end
			
			actor.buff_time.each do |id, buff|
				actor.rpg_skill.buff_del(id)
			end
			
			return if actor != $game_party.actors[0]
			return if $skill_Delay_Console == nil
			
			$skill_Delay_Console.refresh
			$skill_Delay_Console.refresh
			$skill_Delay_Console.dispose
		end
		
		#--------------------------------------------------------------------------
		# * Update Enemy AI (Frame)
		#--------------------------------------------------------------------------
		def update_enemy
			@enemies.values.each do |enemy| # 적 리스트 가져옴
				next if update_enemy_check(enemy)
				
				update_enmey_state_time(enemy)
				update_enemy_phase(enemy) # 적 체력에 따른 페이즈 관리
				update_enemy_aggro(enemy) # 어그로 상태 확인
				update_enemy_battle(enemy) # 적이 전투 중이면 전투 상태 업데이트
				enemy.rpg_skill.update
			end
		end
		
		def update_enemy_check(enemy)
			if enemy.event.character_name.empty?
				@enemies.delete(enemy.event.id)
				return true 
			end
			return true if enemy.nil? 
			return true if enemy.dead? 
			return false
		end
		
		#--------------------------------------------------------------------------
		# 적 캐릭터의 상태 업데이트 : 버프, 디버프등 상태 
		#--------------------------------------------------------------------------
		def update_enmey_state_time(enemy)
			update_enemy_buff(enemy) # 적 캐릭터의 버프 업데이트
			update_enemy_skill_mash(enemy) # 적 캐릭터의 스킬 쿨타임 업데이트
			update_casting_time(enemy)
		end
		
		def update_enemy_buff(enemy)
			enemy.buff_time.each do |id, time|
				next unless time > 0
				
				enemy.buff_time[id] -= 1 
				enemy.rpg_skill.buff_del(id) if enemy.buff_time[id] <= 0
			end
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 스킬 쿨타임 업데이트 : 버프, 디버프등 상태 
		#--------------------------------------------------------------------------
		def update_enemy_skill_mash(enemy)
			return unless enemy.skill_mash 
			
			enemy.skill_mash.each do |id, time|
				enemy.skill_mash[id] -= 1 if time > 0
			end
		end
		
		def update_casting_time(enemy)
			return unless enemy.casting_mash > 0 
			
			enemy.casting_mash -= 1
			progress_enemy_casting(enemy) if enemy.casting_mash <= 0 
		end
		
		def update_enemy_battle(enemy)
			return unless enemy
			return if is_enemy_casting(enemy)
			return handle_enemy_casting_action(enemy, enemy.attacking, enemy.casting_action) if enemy.casting_action
			return reset_enemy_state(enemy) if check_enemy_battle_reset(enemy)
			
			update_enemy_attack(enemy, enemy.attacking) if should_attack?(enemy)
			move_and_turn_to_target(enemy)
		end
		
		#--------------------------------------------------------------------------
		# * Update Enemy Battle(Enemy)
		#--------------------------------------------------------------------------
		def check_enemy_battle_reset(enemy)
			return true unless check_enemy_ai(enemy)
			return true unless enemy.attacking
			return true if enemy.attacking.actor.dead?
			return true unless in_range?(enemy.event, enemy.attacking.event, enemy.see_range)
			return true unless enemy.aggro
			return false 
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 공격성
		#--------------------------------------------------------------------------
		def check_enemy_ai(enemy)
			b = enemy.behavior
			case b
			when 0 then false
			when 1 then can_enemy_see(enemy)
			when 2 then can_enemy_hear(enemy)
			when 3 then can_enemy_see(enemy) || can_enemy_hear(enemy)
			when 4 then enemy_ally_in_battle?(enemy)
			when 5 then can_enemy_see(enemy) || can_enemy_hear(enemy) || enemy_ally_in_battle?(enemy)
			when 6 then enemy.in_battle 
			else true
			end
		end
		
		def is_enemy_casting(enemy)
			return enemy.casting_mash > 0
		end
		
		def progress_enemy_casting(enemy)
			enemy.casting_idx += 1
			data = ABS_ENEMY_SKILL_CASTING[enemy.casting_action.skill_id]
			
			if data[enemy.casting_idx]
				enemy.casting_mash = data[enemy.casting_idx][0] * @sec
				enemy.rpg_skill.casting_chat(data[enemy.casting_idx])
				return 
			end
			
			enemy.casting_idx = 0
		end
		
		def handle_enemy_casting_action(e, target, action)
			process_enemy_action(e, target, action)
			reset_casting(e)
		end
		
		def reset_casting(e)
			e.casting_action = nil
			e.casting_mash = 0
			e.casting_idx = 0
		end
		
		def reset_enemy_state(enemy)
			restore_movement(enemy)
			enemy.in_battle = false
			enemy.attacking = nil
		end
		
		def should_attack?(enemy)
			Graphics.frame_count % (enemy.aggressiveness * 45.0).to_i == 0
		end
		
		def move_and_turn_to_target(enemy)
			return unless enemy.attacking
			
			target = enemy.attacking.event
			enemy.event.move_to(target) unless in_range?(enemy.event, target, 1)
			enemy.event.turn_to(target) if !in_direction?(enemy.event, target) && in_range?(enemy.event, target, 1)
		end
		
		# 몬스터 어그로 설정
		def update_enemy_aggro(enemy)
			return unless enemy.hate_group.include?(0) && enemy.aggro
			
			enemy.aggro_mash -= 1 if enemy.aggro_mash > 0
			return if enemy.aggro_mash > 0
			
			aggro_user = collect_aggro_users(enemy)
			return if aggro_user.empty?
			
			aggro_name = aggro_user[rand(aggro_user.size)]
			return unless aggro_name
			
			send_aggro_message(enemy, aggro_name)
			set_enemy_aggro_state(enemy, aggro_name)
		end
		
		def collect_aggro_users(enemy)
			aggro_user = []
			aggro_user.push(@actor.name) if in_range?(enemy.event, $game_player, enemy.see_range)
			
			Network::Main.mapplayers.values.each do |player|
				aggro_user.push(player.name) if player && in_range?(enemy.event, player, enemy.see_range)
			end
			
			aggro_user
		end
		
		def send_aggro_message(enemy, aggro_name)
			message = "#{enemy.event.id},#{aggro_name}"
			Network::Main.send_with_tag("aggro", message)
		end
		
		def set_enemy_aggro_state(enemy, aggro_name)
			if aggro_name == @actor.name
				enemy.aggro = true
				enemy.aggro_mash = 5 * @sec
			else
				enemy.aggro = false
			end
		end
		
		#--------------------------------------------------------------------------
		# * 적 캐릭터의 행동, 공격 또는 스킬
		#--------------------------------------------------------------------------
		def update_enemy_attack(e, target)
			return unless e && e.actions && !e.actions.empty?
			
			e.actions.each do |action|
				next if enemy_pre_attack(e, action)
				break if process_enemy_action(e, target, action)
			end
		end
		
		def process_enemy_action(e, target, action)
			check = case action.kind
			when 0 then handle_basic_attack(e, target, action)
			when 1, 2 then handle_skill_attack(e, target, action)
			end
			return check
		end
		
		def handle_basic_attack(e, target, action)
			return unless ready_for_basic_attack?(e, target)
			
			case action.basic
			when 0 #Attack
				a = target.is_a?(ABS_Enemy) ? target : @actor
				a.attack_effect(e)
				animation_melee(e.event.direction, e.event)
				hit_enemy(target, e) if a.damage != 0
				
				return if enemy_dead?(a, e)
				return unless a.is_a?(ABS_Enemy) 
				
				set_enemy_attacking(a, e)
			end
			return true
		end
		
		def set_enemy_attacking(enemy, target)
			enemy.attacking = target
			return if enemy.in_battle
			
			enemy.in_battle = true
			setup_movement(enemy)
		end
		
		def ready_for_basic_attack?(e, target)
			return !e.event.moving? && in_range?(e.event, target.event, 1) && in_direction?(e.event, target.event)
		end
		
		def handle_skill_attack(e, target, action)
			skill = $data_skills[action.skill_id]
			return unless valid_skill?(e, skill, target, action)
			
			skill_data = $rpg_skill_data[skill.id]
			e.skill_mash[skill.id] = (skill_data.mash_time || 0) * @sec
			return if enemy_casting_set?(e, action, skill) 
			
			execute_skill(e, target, skill, skill_data)
			return true
		end
		
		def valid_skill?(e, skill, target, action)
			return true if action == e.casting_action
			
			return false unless skill
			return false unless e.can_use_skill?(skill)
			
			skill_data = $rpg_skill_data[skill.id]
			range = skill_data.range_value
			return false if (range && !in_range?(e.event, target.event, range + 1))
			return true
		end
		
		def enemy_casting_set?(e, action, skill)
			return false if action == e.casting_action
			
			id = skill.id
			cast_data = ABS_ENEMY_SKILL_CASTING[id] # 캐스팅 갱신
			return false unless cast_data
			
			skill_data = $rpg_skill_data[id]
			e.casting_idx = 0
			e.casting_mash = cast_data[0][0] * @sec
			e.casting_action = action
			e.rpg_skill.casting_chat(cast_data[0])
			
			# 범위 이펙트 보여주기
			if skill.scope == 2 && skill_data.range_value
				make_range_sprite(e.event, skill_data.range_value, $data_skills[200], true)
			end
			
			e.event.animation_id = 145
			return true
		end
		
		def execute_skill(e, target, skill, skill_data)
			case skill.scope
			when 1 then execute_single_target_skill(e, skill, skill_data)
			when 2 then execute_aoe_skill(e, skill, skill_data)
			end
			
			e.rpg_skill.process_skill(skill.id, true, target)
			e.event.animation_id = skill.animation1_id
			e.sp = [e.sp - skill.sp_cost, 0].max
			send_network_monster(e)
		end
		
		def execute_single_target_skill(e, skill, skill_data)
			return unless skill_data.type.include?("range")
			
			dir_arr = skill_data.move_direction ? Marshal.load(Marshal.dump(skill_data.move_direction)) : []
			dir_arr << e.event.direction unless dir_arr.include?(e.event.direction)
			
			dir_arr.each do |dir|
				@range.push(Game_Ranged_Skill.new(e.event, e, skill, dir))
			end			
		end
		
		def execute_aoe_skill(e, skill, skill_data)
			return unless skill_data.type.include?("range")
			
			range = skill_data.range_value
			enemies = get_all_range(e.event, range, e.hate_group)
			enemies.push($game_player) if e.hate_group.include?(0) && in_range?($game_player, e.event, range)
			enemies_net = get_all_range_net(e.event, range) if e.hate_group.include?(0)
			
			enemies.each do |enemy|
				next unless (enemy && e.hate_group.include?(enemy.id) && !enemy.actor.dead?)
				
				hit_num = skill_data.hit_num || 1
				hit_num.times do
					enemy.actor.effect_skill(e, skill)
					hit_enemy(enemy, e, skill.animation2_id) if enemy.actor.damage != "Miss" && enemy.actor.damage != 0
				end
				
				return if enemy_dead?(enemy.actor, e)
				return if enemy.is_a?(Game_Player)
				return if enemy.attacking == e && enemy.in_battle
				
				set_enemy_attacking(enemy, e)
			end
			
			make_range_sprite(e.event, range, skill, true) if skill_data.show_effect
			handle_network_aoe(e, enemies_net, skill.id) if enemies_net
		end
		
		def handle_network_aoe(e, enemies_net, id)
			enemies_net.each do |player|
				Network::Main.socket.send("<e_skill_effect>#{player.name},#{e.event.id},#{id}</e_skill_effect>\n")
			end
		end
		
		#--------------------------------------------------------------------------
		# * Update Player  실시간 반영 되는 함수
		#--------------------------------------------------------------------------
		def update_player
			update_equip_effects
			update_actor_skill_mash
			update_actor_buff_time
			update_mash
			@actor.rpg_skill.update
			return if !active_ok
			
			check_item # 아이템 체크
			check_attack # 공격 체크
			check_skill # 스킬 체크
		end
		
		def update_equip_effects
			equip_ids = [
				@actor.armor1_id,
				@actor.armor2_id,
				@actor.armor3_id,
				@actor.armor4_id
			]
			
			# EQUIP_EFFECTS[33] = [[10 * sec, "hp", 1], [10 * sec, "sp", 1]] # 도깨비부적
			equip_ids.each do |id|
				next unless EQUIP_EFFECTS[id]
				
				EQUIP_EFFECTS[id].each do |time, type, val|
					time ||= 0
					time *= @sec
					next unless Graphics.frame_count % time == 0
					next unless type
					
					case type
					when "hp" then @actor.hp += (@actor.maxhp * val / 100.0).to_i 
					when "sp" then @actor.sp += (@actor.maxsp * val / 100.0).to_i
					when "com" then $game_temp.common_event_id = val
					when "buff" then @actor.rpg_skill.buff_active(val) unless @actor.rpg_skill.check_buff(val)
					when "custom"	then handle_custom_effect(id, val)
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
		
		def update_actor_skill_mash # 스킬 딜레이 갱신
			@actor.skill_mash.each do |id, time|
				next if time <= 0
				
				@actor.skill_mash[id] -= 1
				$console.write_line("#{$data_skills[id].name} 딜레이 끝") if @actor.skill_mash[id] == 0
			end
		end
		
		def update_actor_buff_time # 버프 지속시간 갱신
			@actor.buff_time.each do |id, time|
				next if time <= 0
				
				@actor.buff_time[id] -= 1
				next if @actor.buff_time[id] > 0
				
				$console.write_line("#{$data_skills[id].name} 끝")
				@actor.rpg_skill.buff_del(id) # 버프 끝 표시
			end
		end
		
		def update_mash # 후 딜레이 처리
			@item_mash -= 1 if @item_mash > 0
			@attack_mash -= 1 if @attack_mash > 0
			@skill_mash.each do |id, time|
				@skill_mash[id] -= 1 if time > 0
			end
		end
		
		#--------------------------------------------------------------------------
		# * Check Item  아이탬 단축키를 이용해서 사용할 경우
		#--------------------------------------------------------------------------
		def check_item # 아이템 단축키 눌렸니?
			return unless @item_mash <= 0 
			
			for key in @item_keys.keys
				id = @item_keys[key]
				next unless valid_trigger?(key, id)
				
				item = $data_items[id] # 아이템데이터 가져옴
				return unless @actor.item_effect(item)
				
				$game_player.animation_id = item.animation1_id 
				$game_system.se_play(item.menu_se)
				$game_party.lose_item(item.id, 1) if item.consumable
				@item_mash = 3
				return $game_temp.common_event_id = item.common_event_id if item.common_event_id > 0
			end
		end
		
		def check_attack # 공격키가 눌렸니?
			return unless @attack_mash <= 0
			return unless Input.trigger?(@attack_key)  
			
			if $game_switches[296]# 유저 죽음 스위치가 켜져있다면 패스
				return $console.write_line("귀신은 할 수 없습니다.") # 만약 죽은 상태면 공격 못함
			end
			
			RANGE_WEAPONS.has_key?(@actor.weapon_id) ? player_range : player_melee
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
			return if w[7] == nil #Animate
			
			animate($game_player, $game_player.character_name + w[7].to_s) if @player_ani
		end
		
		def animation_melee(dir, c = $game_player)
			ani_id = 0
			ani_id = 201 if dir == 6 # 우
			ani_id = 202 if dir == 4 # 좌
			ani_id = 203 if dir == 2 # 하 
			ani_id = 204 if dir == 8 # 상
			
			c.ani_array.push(ani_id)
		end
		
		#--------------------------------------------------------------------------
		# * 플레이어의 기본공격
		#--------------------------------------------------------------------------
		def player_melee(sw = false) # 왠지 여기서 때리는 모션 만들 수 있을 듯?
			@attack_mash = sw ? MASH_TIME * 6 : MASH_TIME * 10
			
			$Abs_item_data.weapon_se(@actor.weapon_id) # 무기 공격 효과음 재생
			animation_melee($game_player.direction) # 휘두르는 애니메이션 추가
			
			weapon = $data_weapons[@actor.weapon_id]
			weapon_ani = 109
			if weapon != nil
				$game_player.animation_id = weapon.animation1_id
				weapon_ani = weapon.animation2_id 	
			end
			
			for e in @enemies.values
				next unless check_melee_event($game_player, e, e.event)
				
				e.event.animation_id = weapon_ani
				next unless e.hate_group.include?(0)
				
				e.attack_effect(@actor) # 몬스터타격 데미지 계산
				if e.damage != "Miss" and e.damage != 0
					$game_system.se_play("타격")		
					@actor.rpg_skill.투명해제
				end
				next if enemy_dead?(e, @actor)
				
				set_enemy_attacking(e, $game_player)
			end
			
			# 다른 플레이어 공격 처리
			for player in Network::Main.mapplayers.values
				next unless check_melee_event($game_player, player, player)
				
				player.animation_id = weapon_ani # 해당 대상 애니메이션 재생하도록 보냄 
				Network::Main.socket.send("<attack_effect>#{player.name}</attack_effect>\n") # 상대방 이름
				@actor.rpg_skill.투명해제
			end
		end
		
		def check_melee_event(actor, enemy, e_event)
			return false unless enemy
			return false unless in_direction?(actor, e_event)
			return false unless in_range?(actor, e_event, 1)
			return false if enemy.is_a?(ABS_Enemy) && enemy.dead?
			return true
		end
		
		def check_skill # 스킬 단축키가 눌렸니?
			@skill_keys.each do |key, id|
				next unless valid_trigger?(key, id)
				next unless mash_ready?(@skill_mash[id])
				
				return player_skill(id)
			end
		end
		
		def valid_trigger?(key, id)
			return id && id != 0 && Input.trigger?(key)
		end
		
		def mash_ready?(mash)
			return mash.nil? || mash <= 0
		end
		
		#==============================#
		#=====무기 격 설정 - 크랩훕흐======#
		#=============================#
		def weapon_skill(id, e)
			return unless WEAPON_SKILL[id] 
			
			data, ani, rate = WEAPON_SKILL[id]
			r = rand(100)
			return if r > rate
			
			type, val = data
			case type
			when "dmg"
				e.damage += val
				e.event.animation_id = ani
			when "buff"
				e.rpg_skill.buff_active(val, false)
			end
			e.critical = true
		end
		
		#==============================#
		#=====스킬 딜레이 알려줌 - 크랩훕흐======#
		#=============================#
		def skill_console(id)
			skill_data = $rpg_skill_data[id]
			name = $data_skills[id].name
			
			# 스킬 딜레이 표시
			if skill_data.mash_time
				$console.write_line("#{name} 딜레이 : #{skill_data.mash_time.to_f}초")
			end
			
			# 버프의 지속시간 표시
			if skill_data.buff_time 
				$console.write_line("#{name} 지속시간 : #{skill_data.buff_time.to_f}초")
			end
		end
		
		# 맵을 이동하기위한 함수
		def map_m(id, x, y)
			if $game_map.map_id != id
				$game_temp.player_transferring = true # 이동 가능
				$game_temp.player_new_map_id = id
				$game_temp.player_new_x = x
				$game_temp.player_new_y = y
				return 
			end
			
			count = 0
			while count < 100
				count += 1
				return $game_player.moveto(x, y) if $game_map.passable?(x, y, 2)
				
				x += (rand(3) - 1)
				y += (rand(3) - 1)
			end
		end
		
		#=====성황당 - 크랩훕흐===========#
		def skill_sung 
			x = 11
			y = 8
			m_id = SEONG_HWANG[$game_variables[8]] ? SEONG_HWANG[$game_variables[8]][0] : 17
			map_m(m_id, x, y)
			$console.write_line("성황당으로 갑니다")
		end
		
		#=====비영사천문 - 크랩훕흐===========#
		def skill_byung(d) # d : 방향, 0 : 동, 1 : 서, 2 : 남, 3: 북 
			if $game_switches[296]# 유저 죽음 스위치가 켜져있다면 패스
				$console.write_line("귀신은 할 수 없습니다.")
				return 
			end
			return if d > 4
			
			id = $game_variables[8] # 맵 번호
			return unless BIYEONG[id]
			
			m_id = BIYEONG[id][0]
			x, y = BIYEONG[id][d]
			r = rand(3)
			map_m(m_id, x + r, y + r)
			
			case d
			when 1 then $console.write_line("동쪽에 이르렀으니... ")
			when 2 then $console.write_line("서쪽에 이르렀으니... ")
			when 3 then $console.write_line("남쪽에 이르렀으니... ")
			when 4 then $console.write_line("북쪽에 이르렀으니... ")
			end
		end
		
		#--------------------------------------------------------------------------
		# *  플레이어의 스킬 공격
		#--------------------------------------------------------------------------
		def player_skill(id)
			skill = $data_skills[id] #Get Skill
			skill_data = $rpg_skill_data[id]
			return unless player_can_skill(skill) # 스킬 사용 여부 확인
			
			@actor.skill_mash[id] = skill_data.mash_time * @sec.to_f if skill_data.mash_time
			$game_player.animation_id = skill.animation1_id # 스킬 애니메이션 
			@actor.rpg_skill.process_skill(id)
			$game_temp.common_event_id = skill.common_event_id if skill.common_event_id > 0 # 커먼 이벤트 실행
			@actor.sp -= skill.sp_cost
			
			case skill.scope # 스킬 맞는 쪽
			when 0 then apply_self_skill(id) # 자기 자신
			when 1 then apply_enemy_skill(id, skill_data, skill) # 적
			when 2 then apply_all_enemies_skill(id, skill_data, skill) # 적 전체
			end
		end
		
		def apply_self_skill(id)
			@skill_mash[id] = MASH_TIME * 2
		end
		
		def apply_enemy_skill(id, skill_data, skill)
			return unless skill_data.range_value # 원거리 스킬인가?
			
			dir_arr = skill_data.move_direction ? Marshal.load(Marshal.dump(skill_data.move_direction)) : []
			dir_arr << $game_player.direction unless dir_arr.include?($game_player.direction)
			
			dir_arr.each do |dir|
				@range.push(Game_Ranged_Skill.new($game_player, @actor, skill, dir))
			end
			
			# 스킬 사용 후 딜레이
			@skill_mash[id] = (skill_data.after_mash_time || MASH_TIME) * 10 
		end
		
		def apply_all_enemies_skill(id, skill_data, skill)
			return unless skill_data.range_value
			
			enemies = get_all_range($game_player, skill_data.range_value)
			return if enemies.empty?
			
			target_enemies = enemies.select do |e|
				e && !e.is_a?(Array) && !e.dead? && e.hate_group.include?(0)
			end
			return if target_enemies.empty?
			
			hit_num = skill_data.hit_num || 1
			target_enemies.each do |enemy|
				hit_num.times do
					enemy.effect_skill(@actor, skill)
					hit_enemy(enemy, @actor, skill.animation2_id)
				end
				
				skill_data.hit_skill_arr.each do |id, type|
					case type
					when 0 then @actor.rpg_skill.process_skill(id, true, enemy.event)
					when 1 then enemy.rpg_skill.process_skill(id, false, $game_player)
					end
				end
				next if enemy_dead?(enemy, @actor)
				
				set_enemy_attacking(enemy, $game_player)
			end
			
			@actor.rpg_skill.skill_cost_custom(skill.id)
			@skill_mash[id] = (skill_data.after_mash_time || MASH_TIME) * 10 
		end
		
		def player_can_skill(skill)
			return false unless skill #Return if the skill doesn't exist
			
			id = skill.id
			skill_data = $rpg_skill_data[id]
			return false unless @actor.skills.include?(id) #Return if the actor doesn't have the skill
			
			if $game_switches[352] or $game_switches[25] # 스킬 사용 불가 지역
				$console.write_line("스킬 사용 불가 지역입니다.")
				return false
			end
			
			if @actor.sp < skill.sp_cost # 마력이 부족하면 무시
				$console.write_line("마력이 부족합니다.")
				return false
			end
			
			mash = @actor.skill_mash[id] # 아직 스킬 딜레이가 남아있다면 무시
			if mash != nil && mash > 0
				$console.write_line("딜레이가 남아있습니다. #{'%.1f' % (mash / 60.0)}초")
				return false
			end
			
			# 엑터가 사용할 수 없는 상황이면 무시
			if @actor.hp <= 0 && !skill_data.can_use_dead
				$console.write_line("귀신은 할 수 없습니다.")
				return false
			end
			
			return false unless @actor.rpg_skill.check_need_skill_item(id) # 스킬 사용 재료가 부족하면 취소
			return true
		end
		
		def enemy_count_reset(id)
			$game_variables[id + $mon_val_start] = 0
		end
		
		def enemy_count_check(id, num)
			return $game_variables[id + $mon_val_start] >= num
		end
		
		def enemy_count_add(id, num)
			$game_variables[id + $mon_val_start] += num
		end
		
		#--------------------------------------------------------------------------
		# * 적이 죽었니? (몹 또는 유저), e가 a에 의해 죽었음
		#--------------------------------------------------------------------------	
		def enemy_dead?(e, a)
			return player_dead?(e, a) if e.is_a?(Game_Actor)
			return false unless e.dead?
			
			if a
				a.is_a?(Game_Actor) ? treasure(e) : a.attacking = nil
			end
			
			event = e.event
			event.through = true
			event.fade = true 
			
			id = event.id
			enemy_dead_process(e, event, true)
			@enemies.delete(id) if ([0, nil].include?(e.respawn))
			return true
		end
		
		def enemy_dead_process(enemy, event, sw = false)
			enemy_count_add(enemy.id, 1)
			Network::Main.send_with_tag("enemy_dead", "#{event.id}") if sw
			
			trigger, id = enemy.trigger
			case trigger
			when 1 # 스위치
				$game_switches[id] = true
			when 2 # 변수 조작
				$game_variables[id] += 1
			when 3
				value = case id
				when 1 then "A"
				when 2 then "B"
				when 3 then "C"
				when 4 then "D"
				end
				
				key = [$game_map.map_id, event.id, value]
				$game_self_switches[key] = true
			when 4 # 네트워크 스위치 공유
				Network::Main.party_switch(id, 1)
			end
			
			$game_map.need_refresh = true
		end
		
		#--------------------------------------------------------------------------
		# * Player Dead(Player,Enemy) a가 e에 의해 죽음
		#--------------------------------------------------------------------------
		def player_dead?(a, e)
			return false if @actor.hp > 0
			
			@enemies.values.each do |enemy|
				next unless enemy
				
				reset_enemy_state(enemy)
			end
			return true if $game_switches[296] # 죽음 표시 스위치
			
			$game_switches[50] = false # 유저 살음 스위치 오프
			$game_switches[296] = true # 유저 죽음 스위치 온
			
			$game_system.se_play("죽음")
			$console.write_line("죽었습니다.. 성황당에서 기원하십시오.")
			@actor.set_graphic("죽음", 0, 0, 0)
			$game_player.refresh
			
			# 이때 모든 버프들을 지우자
			@actor.buff_time.each do |id, time|
				@actor.rpg_skill.buff_del(id) if time > 0
			end
			
			for i in 0..4
				$game_party.actors[0].equip(i, 0)
			end
			
			@actor.pdef = 0 # 물리방어
			@actor.mdef = 0 # 마법방어
			Network::Main.send_map
			return true
		end
		
		#--------------------------------------------------------------------------
		# * 몬스터를 잡았을 경우 주는것
		#--------------------------------------------------------------------------
		def treasure(enemy)
			return if enemy.event.fade # 중복 방지(이미 몬스터가 죽은 상태에서 보상까지 받은 후)
			
			abs_gain_treasure(enemy)
			drop_enemy(enemy) # ABS monster item drop 파일 참조
			Network::Main.send_with_tag("party_gain", "#{enemy.event.id}")
		end
		
		def abs_gain_treasure(enemy)
			return if @actor.cant_get_exp? # 경험치를 얻을 수 없는 상황
			
			exp, gold = calculate_exp_and_gold(enemy)
			in_map_player = $net_party_manager.count_in_map_players
			gainExp, gold = adjust_exp_and_gold_for_party(exp, gold, in_map_player)
			
			@actor.exp += gainExp
			$game_party.gain_gold(gold)
		end
		
		def calculate_exp_and_gold(enemy)
			return [0, 0] if enemy.hidden
			
			exp = ENEMY_EXP[enemy.id] || enemy.exp
			exp = (exp[0] || 0) + (@actor.maxhp * (exp[1] || 0)) + (@actor.maxsp * (exp[2] || 0)) if exp.is_a?(Array)
			exp = exp.to_i			
			gold = enemy.gold
			
			return [exp, gold]
		end
		
		def adjust_exp_and_gold_for_party(exp, gold, in_map_player)
			nextExp = @actor.level < 99 ? (@actor.exp_list[@actor.level + 1] - @actor.exp_list[@actor.level]) : @actor.exp_list[100]
			limitExp = (nextExp / 100.0 * $exp_limit).to_i # 경험치 한계점
			gainExp = @actor.level < 99 ? [exp, limitExp].min : exp
			gainExp *= $exp_event if $game_switches[1500]  # 경험치 이벤트!
			
			if in_map_player >= 2
				gainExp = (gainExp * 1.5 / in_map_player).to_i
				gold = (gold * 1.5 / in_map_player).to_i
			end
			
			[gainExp, gold]
		end
		
		# 경험치 받는 함수
		def abs_gain_exp(val, hp_per = 0, sp_per = 0)
			gainExp = val + (@actor.maxhp * hp_per + @actor.maxsp * sp_per).to_i
			@actor.exp += gainExp
		end
		
		#--------------------------------------------------------------------------
		# * Hit Enemy(Enemy) or (Player) 몬스터가 공격할 경우, e가 a에게 공격당함
		#--------------------------------------------------------------------------
		def hit_enemy(e, a, animation = nil)
			return if animation == 0 
			
			if a.is_a?(ABS_Enemy)
				return if e.is_a?(Game_Player) && !a.hate_group.include?(0)
				return if e.is_a?(ABS_Enemy) && !a.hate_group.include?(e.id)
			end
			
			ani_id = animation || a.animation2_id
			e.event.ani_array.push(ani_id)
		end
		#--------------------------------------------------------------------------
		# * Jump
		#--------------------------------------------------------------------------
		def jump(object, attacker, plus)
			return unless plus
			return if plus == 0
			
			n_plus = plus * -1 
			d = attacker.direction
			
			# Calculate new pos
			new_x = (d == 6 ? plus : d == 4 ? n_plus : 0)
			new_y = (d == 2 ? plus : d == 8 ? n_plus : 0)
			
			object.jump_nt(new_x, new_y) # Jump
		end
		#--------------------------------------------------------------------------
		# * Enemy Pre-Attack(Enemy,Actions) - Checks action conditions to see if the 
		#   enemy can attack.
		#--------------------------------------------------------------------------
		def enemy_pre_attack(enemy, actions)
			switch_id = actions.condition_switch_id
			return true if switch_id > 0 and !$game_switches[switch_id]
			return true if enemy.hp * 100.0 / enemy.maxhp > actions.condition_hp
			return true if $game_party.max_level < actions.condition_level
			return true if actions.rating < rand(11)
			return false
		end
		
		#--------------------------------------------------------------------------
		# * Check if Enemy can See or Hear
		#--------------------------------------------------------------------------
		def can_enemy_perceive(e, range, type)
			enemies = []
			
			e.hate_group.each do |hate_id|
				if hate_id == 0 
					enemies.push($game_player) if $game_party.actors[0].hp > 0
					next 
				end
				next unless @hate_group[hate_id]
				
				@hate_group[hate_id].each do |target|
					enemies.push(target) if check_is_enemy(e, target, range)
				end
			end
			return false if enemies.empty?
			
			if e.closest_enemy
				enemies.sort! { |a, b| get_range(e.event, a.event) - get_range(e.event, b.event) }
			end
			
			set_enemy_attacking(e, enemies[0])
			return true
		end
		
		#--------------------------------------------------------------------------
		# * Can Enemy See (Enemy)
		#--------------------------------------------------------------------------
		def can_enemy_see(e)
			can_enemy_perceive(e, e.see_range, :see)
		end
		
		#--------------------------------------------------------------------------
		# * Can Enemy Hear (Enemy)
		#--------------------------------------------------------------------------
		def can_enemy_hear(e)
			can_enemy_perceive(e, e.hear_range, :hear)
		end
		
		#--------------------------------------------------------------------------
		# * Setup the Movement Type to 0(Enemy)
		#--------------------------------------------------------------------------
		def setup_movement(e)
			e.event.move_speed = e.temp_speed #Set Speed
			e.event.move_frequency = e.temp_frequency #Set Frequency
			e.event.move_type = e.temp_move_type #Set Move Type
			e.temp_restore_sw = false
		end
		#--------------------------------------------------------------------------
		# * Restore the Movement Type(Enemy)
		#--------------------------------------------------------------------------
		def restore_movement(e)
			return if e.temp_restore_sw
			
			e.event.move_speed = e.orgin_speed   #Set Speed
			e.event.move_frequency = e.orgin_frequency
			e.event.move_type = e.orgin_move_type #Set Move Type
			e.temp_restore_sw = true
		end
		
		
		def check_is_enemy(me, target, range)
			return false unless target
			return false if me == target
			return false unless me.hate_group.include?(target.enemy_id) 
			return false unless in_range?(me.event, target.event, range) 
			return false if target.dead? 
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
				
				set_enemy_attacking(enemy, ally.attacking)
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
		def get_all_range(element, range, hate_group = nil)
			objects = []
			if hate_group
				hate_group.each do |id|
					next unless @hate_group[id]
					
					@hate_group[id].each do |target|
						objects << target if in_range?(element, target.event, range)
					end
				end
			else
				for e in @enemies.values
					objects.push(e) if in_range?(element, e.event, range)
				end
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
			case element.direction
			when 2 then return object.y >= element.y && object.x == element.x
			when 4 then return object.x <= element.x && object.y == element.y
			when 6 then return object.x >= element.x && object.y == element.y
			when 8 then return object.y <= element.y && object.x == element.x
			end
			
			return false
		end
		
		#--------------------------------------------------------------------------
		# * Animate(object, name)
		#--------------------------------------------------------------------------
		def animate(object, name)
			object.set_animate(name)
		end
		
		# 범위안에 이벤트 만들고 이펙트 내보기
		def make_range_sprite(element, range, skill, sw = false)
			$scene.spriteset.make_range_sprite(element, range, skill, sw) # 이펙트 보여주는 스킬만 동작하도록 하자
		end
		
		def send_network_monster(monster, delete_sw = 0)
			data = {
				"map_id" => $game_map.map_id,
				"id" => monster.event.id,
				"x" => monster.event.x,
				"y" => monster.event.y,
				"hp" => monster.hp.to_i,
				"sp" => monster.sp.to_i,
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
			super()
			@step = 0
			@parent = parent
			@actor = actor
			@draw = true
			@stop  = false
			@range = 0
			@explosive = false
			
			@move_direction = @parent.direction
			@direction = @move_direction
			moveto(@parent.x, @parent.y)
			@movement = {
				1 => [-1, 1],  # 왼쪽 아래
				2 => [0, 1],   # 아래
				3 => [1, 1],   # 오른쪽 아래
				4 => [-1, 0],  # 왼쪽
				6 => [1, 0],   # 오른쪽
				7 => [-1, -1], # 왼쪽 위
				8 => [0, -1],  # 위
				9 => [1, -1]   # 오른쪽 위
			}
			@objects = []
		end
		
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			
		end
		
		#--------------------------------------------------------------------------
		# * Force Movement
		#--------------------------------------------------------------------------
		def force_movement
			return if @stop #Stop if it came to range
			
			dx, dy = @movement[@move_direction] || [0, 0]
			@x += dx
			@y += dy
			@step += 1
		end
		#--------------------------------------------------------------------------
		# * Update
		#-------------------------------------------------------------------------
		def update
			super
			return if @stop
			return if moving?
			return if update_check_nil
			
			check_collisions
			@stop = true if @step >= @range
			force_movement 
		end
		
		def update_check_nil
			return false if @parent && @actor
			
			@stop = true
			return true
		end
		
		def find_actor(object)
			return $game_party.actors[0] if object == $game_player
			return $ABS.enemies[object.id] if $ABS.enemies[object.id]
			return object if object.is_a?(Game_NetPlayer)
		end
		
		def check_enemy(enemy)
			return false unless enemy
			return false if enemy == @actor
			
			case @actor
			when ABS_Enemy 
				case enemy
				when ABS_Enemy then return @is_my && @actor.hate_group.include?(enemy.id) && !enemy.dead?
				when Game_Actor then return @actor.hate_group.include?(0)
				when Game_NetPlayer then return @actor.hate_group.include?(0)
				end
			when Game_Actor 
				case enemy
				when ABS_Enemy then return enemy.hate_group.include?(0) && !enemy.dead?
				when Game_Actor then return false
				when Game_NetPlayer then return true
				end
			when Game_NetPlayer 
				case enemy
				when ABS_Enemy then return enemy.hate_group.include?(0) && !enemy.dead?
				when Game_Actor then return true
				when Game_NetPlayer then return true
				end
			end
			return false
		end
		
		def check_collisions
			@objects = find_objects.select { |o| o.x == @x && o.y == @y && check_enemy(find_actor(o))}
			@stop = true unless @objects.empty?
		end
		
		def find_objects
			enemy_sw = @actor.is_a?(Game_Actor) || @actor.is_a?(Game_NetPlayer)
			player_sw = @actor.is_a?(Game_Actor) || @actor.is_a?(Game_NetPlayer)
			
			objects = []
			case @actor
			when ABS_Enemy 
				@actor.hate_group.each do |id|
					next player_sw = true if id == 0
					next unless $ABS.hate_group[id]
					
					objects += $ABS.hate_group[id].map {|e| e.event}
				end
			end
			
			objects += $ABS.enemies.values.map { |e| e.event } if enemy_sw
			objects += (Network::Main.mapplayers.values + [$game_player]) if player_sw
			return objects
		end
		
		#--------------------------------------------------------------------------
		# * In Range?(Element, Object, Range) - Near Fantastica
		#--------------------------------------------------------------------------
		def in_range?(element, object, range)
			x = (element.x - object.x) ** 2
			y = (element.y - object.y) ** 2
			r = x + y
			r <= (range ** 2)
		end
		
		#--------------------------------------------------------------------------
		# * Get ALL Range(Element, Range)
		#--------------------------------------------------------------------------
		def get_all_range(element, range)
			@objects += find_objects.select do |o| 
				!@objects.include?(o) && in_range?(element, o, range) && check_enemy(find_actor(o))
			end
		end
	end
	
	#============================================================================
	# * Game Ranged Skill
	#============================================================================
	class Game_Ranged_Skill < Range_Base
		attr_accessor :is_my
		attr_accessor :dummy
		
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, skill, m_dir = 0, is_my = true)
			super(parent, actor, skill)
			@range_skill = $rpg_skill_data[skill.id]
			@skill = skill
			
			initialize_range_skill_attributes
			set_graphic_and_opacity
			
			@move_direction = m_dir != 0 ? m_dir : @parent.direction
			@direction = [@move_direction, 2].max
			@dummy = false
			@is_my = is_my
			@hit_check = false
			self.show_net 
		end
		
		def initialize_range_skill_attributes
			@range = @range_skill.range_value
			@move_speed = @range_skill.move_speed
			@show_effect = @range_skill.show_effect
			@hit_num = @range_skill.hit_num || 1
		end
		
		def set_graphic_and_opacity
			char_name = ""
			hue = 0
			opacity = 255
			
			if @range_skill.character_name.is_a?(Array)
				ch_data = @range_skill.character_name
				char_name = ch_data[0] if ch_data[0]
				hue = ch_data[1] if ch_data[1]
				opacity = ch_data[2] if ch_data[2]
			else
				char_name = @range_skill.character_name
			end
			
			char_name = "공격스킬" if char_name != "" && !$ABS.char_dir.include?("#{char_name}.png")
			es_set_graphic(char_name, opacity, hue)
		end
		
		def show_net
			return unless @is_my
			
			user_type, s_id = case @actor
			when ABS_Enemy then [0, @parent.id]
			when Game_Actor then [1, Network::Main.id]
			end
			
			m_data = {
				"user_type" => user_type,
				"id" => s_id,
				"skill_id" => @skill.id,
				"skill_type" => 0,
				"dir" => @move_direction
			}
			message = m_data.map { |key, value| "#{key}:#{value}" }.join("|")
			Network::Main.send_with_tag("show_range_skill", message)
		end
		
		def update
			super
			return unless @stop
			return if @hit_check
			
			check_object_in_range
			hit_process
			end_process
		end
		
		def check_object_in_range
			get_all_range(self, @range_skill.explode_range) if @range_skill.type.include?("explode")
		end
		
		def hit_process
			@objects.each { |object| hit_object(object) }
		end
		
		def hit_object(object) # 히트시 발생하는 이벤트 처리
			return unless object
			
			enemy = find_actor(object)
			@range_skill.hit_skill_arr.each do |id, type|
				case type
				when 0 
					next if @actor.is_a?(Game_NetPlayer)
					@actor.rpg_skill.process_skill(id, true, object)
				when 1 
					next if enemy.is_a?(Game_NetPlayer)
					enemy.rpg_skill.process_skill(id, false, @parent)
				end
			end
			
			process_range_skill(object, enemy)
		end
		
		def process_range_skill(object, enemy)
			return if object.is_a?(Game_NetPlayer)
			return if @actor.is_a?(Game_NetPlayer) && !enemy.is_a?(Game_Actor)
			
			@hit_num.times { object.ani_array.push(@skill.animation2_id) }
			return if @dummy
			
			@hit_check = true
			$ABS.jump(object, self, @range_skill.hit_back) 
			@hit_num.times { enemy.effect_skill(@actor, @skill) } unless @range_skill.not_damage 
			return if $ABS.enemy_dead?(enemy, @actor)
			
			$ABS.set_enemy_attacking(enemy, @parent) if enemy.is_a?(ABS_Enemy)
		end
		
		def end_process
			$ABS.make_range_sprite(self, @range_skill.explode_range, @skill) if @show_effect
			@actor.rpg_skill.skill_cost_custom(@skill.id) if @hit_check
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
			self.show_net
		end
		
		def show_net
			m_data = {
				"user_type" => 1,
				"id" => Network::Main.id,
				"skill_id" => attack,
				"skill_type" => 2,
				"dir" => @move_direction
			}
			message = m_data.map { |key, value| "#{key}:#{value}" }.join("|")
			
			Network::Main.send_with_tag("show_range_skill", message)
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
			
			$ABS.set_enemy_attacking(actor, @parent)
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
		alias mrmo_abs_game_event_refresh_set refresh_reset
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
		
		def refresh_reset
			mrmo_abs_game_event_refresh_set
			$ABS.enemies[@id].hp = -1 if $ABS.enemies[@id]
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
			if $game_map.map_id != $game_temp.player_new_map_id
				$ABS.enemies = {}
				$ABS.hate_group = {}
			end
			mrmo_abs_scene_map_transfer_player
		end
	end
	
	class Game_Actor < Game_Battler
		alias mrmo_abs_game_actor_initialize initialize
		attr_accessor   :event                     
		
		def initialize(actor_id)
			@event = $game_player
			mrmo_abs_game_actor_initialize(actor_id)
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
			attr_accessor :_damage_string_width
			
			def initialize(viewport = nil)
				super(viewport)
				initialize_damage_variables
				initialize_animation_variables
			end
			
			def initialize_damage_variables
				@_damage_max_height = 0
				@_damage_duration = 0
				@_damage_duration_max = 60
				@_damage_idx = 0
				@_damage_muti = false
				@_damage_sprite = []
				@_damage_string = ""
				@_damage_string_width = 0
			end
			
			def initialize_animation_variables
				@_whiten_duration = 0
				@_appear_duration = 0
				@_escape_duration = 0
				@_collapse_duration = 0
				@_collapse_erase_duration = 0
				@_animation_duration = 0
				@_blink = false
				@force_opacity = false
				@stop_animation = true
			end
			
			def stop_animation?
				return @stop_animation 
			end
			
			def update
				super
				update_color_effects
				update_damage_view
				update_animations
				update_blink_effect
				@@_animations.clear
				if @_animation != nil and (Graphics.frame_count % 10 == 0)
					@_animation_duration += 1
				end
				update_collapse_erase
			end
			
			def update_color_effects
				update_whiten_duration
				update_appear_duration
				update_escape_duration
				update_collapse_duration
			end
			
			def update_whiten_duration
				return unless @_whiten_duration > 0
				
				@_whiten_duration -= 1
				self.color.alpha = 128 - (16 - @_whiten_duration) * 10
			end
			
			def update_appear_duration
				return unless @_appear_duration > 0
				
				@_appear_duration -= 1
				self.opacity = (16 - @_appear_duration) * 16
			end
			
			def update_escape_duration
				return unless @_escape_duration > 0
				
				@_escape_duration -= 1
				self.opacity = 256 - (32 - @_escape_duration) * 10
			end
			
			def update_collapse_duration
				return unless @_collapse_duration > 0
				
				@_collapse_duration -= 1
				self.opacity = 256 - (48 - @_collapse_duration) * 6
			end
			
			def update_damage_view
				@_damage_sprite.each do |sprite|
					next unless sprite
					
					sprite._damage_duration += 1
					next if sprite._damage_duration < 0
					
					sprite.visible = true 
					dispose_damage(sprite) if sprite._damage_duration == sprite._damage_duration_max
					update_sprite_position(sprite)
				end
			end
			
			def update_sprite_position(sprite)
				return unless sprite
				return if sprite.disposed?
				
				temp_y = self.y + self.height / 4 - (30 + sprite._damage_idx * 13)
				temp_y -= 50 if sprite._damage_muti
				time = sprite._damage_duration
				
				sprite.x = self.x - sprite.ox
				sprite.y = [temp_y - time * 4, temp_y - sprite._damage_max_height].max if @collapse_character.nil? || @collapse_character.character_name != ""
			end
			
			def update_animations
				if @_animation != nil and (Graphics.frame_count % 2 == 0)
					@_animation_duration -= 1
					update_animation
				end
				
				if @_loop_animation != nil and (Graphics.frame_count % 2 == 0)
					update_loop_animation
					@_loop_animation_index += 1
					@_loop_animation_index %= @_loop_animation.frame_max
				end
			end
			
			def update_blink_effect
				return unless @_blink
				
				@_blink_count = (@_blink_count + 1) % 32
				alpha = (16 - @_blink_count).abs * 6
				self.color.set(255, 255, 255, alpha)
			end
			
			def update_collapse_erase
				return unless @_collapse_erase_duration > 0
				
				@_collapse_erase_duration -= 1
				@force_opacity = true
				self.opacity = 256 - (36 - @_collapse_erase_duration) * 10 
				@force_opacity = false
				dispose_collapse_character if @_collapse_erase_duration.zero?
			end
			
			def dispose_collapse_character
				@collapse_character.character_name = ""
				self.opacity = 256
				self.color.set(0, 0, 0, 0)
				self.blend_type = 0
				@collapse_character.erase
			end
			
			def damage(value, critical, multi = false)
				return unless value
				return if value == ""
				
				damage_string = format_damage_string(value)
				bitmap = create_damage_bitmap(damage_string, critical) || create_damage_bitmap2(damage_string, critical)
				create_damage_sprite(bitmap, damage_string, multi)
			end
			
			def format_damage_string(value)
				type = $game_variables[60] # 데미지 표시 타입
				value = change_number_unit(value, type) if value.is_a?(Numeric) || value.to_i > 0
				return value
			end
			
			def create_damage_bitmap(damage_string, critical)
				source = $ABS.damage_bitmap[critical] || $ABS.damage_bitmap["default"]
				
				main_bitmap = Bitmap.new(self.width, 30)
				main_bitmap.font.name = source["0"].font.name
				main_bitmap.font.size = source["0"].font.size
				main_bitmap.font.color = source["0"].font.color
				main_bitmap.font.bold = source["0"].font.bold
				
				src_rect = Rect.new(0, 0, main_bitmap.width, main_bitmap.height)
				str_x = 0
				damage_string.split('').each do |s|
					bitmap = source[s] 
					return unless bitmap
					
					main_bitmap.blt(str_x, 0, bitmap, src_rect, 255)
					str_x += bitmap.text_size(s).width
				end
				return main_bitmap
			end
			
			def create_damage_bitmap2(damage_string, critical)
				bitmap = Bitmap.new(self.width, 30)
				font_name = Font.exist?(DAMAGE_FONT_NAME) ? DAMAGE_FONT_NAME : DAMAGE_FONT_NAME2
				font_size = critical ? DAMAGE_CRI_FONT_SIZE : DAMAGE_FONT_SIZE
				font_color, bold = get_font_color_bold(critical)
				bold ||= false
				
				bitmap.font.name = font_name
				bitmap.font.size = font_size
				bitmap.font.color = DAMAGE_FONT_COLOR
				bitmap.draw_text(+1, +1, 200, 36, damage_string, 0)
				bitmap.font.color = font_color
				bitmap.font.bold = bold
				bitmap.draw_text(0, 0, 200, 36, damage_string, 0)
				return bitmap
			end
			
			def create_damage_sprite(bitmap, damage_string, multi)
				sprite = Sprite.new(self.viewport)
				sprite.bitmap = bitmap
				
				sprite._damage_string = damage_string
				sprite._damage_string_width = sprite.bitmap.text_size(damage_string).width
				sprite._damage_idx = @_damage_idx
				sprite._damage_duration = 0 - @_damage_idx * 5
				sprite._damage_max_height = multi ? 0 : 60
				sprite._damage_muti = multi
				
				sprite.oy = self.oy
				sprite.ox = sprite._damage_string_width / 4
				sprite.x = self.x 
				sprite.y = self.y
				sprite.z = 3000
				sprite.opacity = 255
				sprite.visible = false
				
				@_damage_sprite.push(sprite)
				@_damage_idx += 1
			end
			
			def get_font_color_bold(critical)
				case critical
				when "heal" 
					return [Color.new(102, 255, 102), false]
				when "heal_sp" 
					return [Color.new(168, 188, 255), false]
				when "player_hit"
					return [Color.new(255, 142, 165), false]
				when "skill_cri"
					return [Color.new(70, 113, 255), true]
				when true, "true" 
					return [Color.new(255, 0, 51), true]
				when false, "false"
					return [Color.new(255, 255, 255), false]
				else
					return [Color.new(255, 255, 255), false]
				end
			end
			
			#--------------------------------------------------------------------------
			# * 데미지 삭제
			#--------------------------------------------------------------------------
			def dispose_damage(sprite = nil)
				if sprite != nil
					dispose_sprite(sprite)
				elsif @_damage_sprite != nil
					for s in @_damage_sprite
						dispose_sprite(s)
					end
				end
			end
			
			def dispose_sprite(sprite)
				@_damage_sprite.delete(sprite)
				sprite.visible = false
				sprite.bitmap.dispose
				sprite.dispose
				sprite = nil
			end
			
			#--------------------------------------------------------------------------
			# * Collapse and Erase
			#--------------------------------------------------------------------------
			def collapse_erase(character)
				self.blend_type = 1
				self.color.set(255, 64, 64, 255)
				self.opacity = 255
				
				@collapse_character = character
				@_collapse_erase_duration = 40
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
			#update_state_animation
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
			return if @character.animation_id == 0
			
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
			
			actor = $ABS.enemies[@character.id] if $ABS.enemies[@character.id]
			actor = $game_party.actors[0] if @character.is_a?(Game_Player)
			
			display_damage(actor)
			@_damage_idx = 0
		end
		
		def display_damage(actor)
			if actor.damage_array.empty?
				return unless actor.damage
				actor.damage_array << actor.damage
				actor.critical_array << actor.critical
			end
			
			dmg_array = actor.damage_array
			cri_array = actor.critical_array
			
			dmg = dmg_array.join("|")
			cri = cri_array.join("|")
			
			sw = dmg_array.size > 1 ? true : false
			dmg_array.each_with_index do |dmg_val, i|
				next unless dmg_val
				
				damage(dmg_val, cri_array[i], sw)
			end 
			
			m_id = @character.id
			tag = "mon_damage"
			if actor.is_a?(Game_Actor)
				m_id = Network::Main.id
				tag = "player_damage"
			end
			msg = "#{m_id},#{dmg},#{cri}"
			Network::Main.send_with_tag(tag, msg) if actor.send_damage
			clear_damage_arrays(actor)
		end
		
		def clear_damage_arrays(actor)
			actor.damage = nil
			actor.damage_array.clear
			actor.critical_array.clear
			actor.send_damage = true
		end
		
		def update_ani_array
			return unless @character.ani_array && @character.ani_array.size >= 1
			
			@character.ani_array.each do |ani|
				animation = $data_animations[ani]
				animation2(animation, true)
			end
			
			Network::Main.ani(@character, @character.ani_array) if @character.ani_show_net
			
			@character.ani_array.clear
			@character.ani_show_net = true
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
					next if r > range * range
					
					sprite = RPG::Sprite.new(@viewport1)
					sprite.visible = true
					sprite.opacity = 255
					sprite.one_use = true
					sprite.animation2($data_animations[skill.animation2_id], true)
					sprite.ox = 0
					sprite.oy = 0
					
					#nowX = element.screen_x + nowX * 32
					#nowY = element.screen_y + nowY * 32 - 32
					
					@ranged_sprites2.push([sprite, element, nowX, nowY])
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
		attr_accessor :rpg_skill # rpg_skill
		attr_accessor :send_damage
		
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
			@rpg_skill = Rpg_skill.new(self)
			@send_damage = true
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
			
			a_dex = [attacker.dex * (1.0 - (self.eva / 150.0)), 1.0].max
			eva = [(5.0 * self.agi / a_dex).to_i, 100].min  # 회피율 계산
			hit_rate = self.cant_evade? ? 100 : [100 - eva, 3].max # 회피 할 수 없는 상태면 무조건 맞음
			hit_result = (rand(100) < hit_rate)
			
			unless hit_result
				self.damage = "빗나감!"  # Set damage to "Miss"
				self.critical = false  # Clear critical flag
				return true  # End Method		
			end
			
			atk = (attacker.atk + attacker.str / 20.0)
			temp = self.is_a?(Game_Actor) ? 20.0 : 100.0
			
			self.damage = atk * (1.0 + attacker.str / 20.0)
			self.damage /= (1.0 + self.base_pdef / temp)
			
			unless attacker.is_a?(Game_NetPlayer)
				self.damage *= elements_correct(attacker.element_set)  # Element correction
				self.damage /= 100
			end
			
			self.damage = self.damage.to_i
			self.damage = 1 if self.damage <= 0
			
			self.critical = "player_hit" if self.is_a?(Game_Actor)
			plus_rate, plus_power = attacker.rpg_skill.critical_rate
			critical_rate = [(3.0 * attacker.dex / self.agi), 1].max + plus_rate
			
			if rand(100) < critical_rate  # Critical correction
				self.damage *= (3.0 + plus_power)
				self.critical = true 
			end
			
			if self.damage.abs > 0  # Dispersion
				amp = [self.damage.abs * 15 / 100, 1].max
				self.damage += rand(amp + 1) + rand(amp + 1) - amp
			end
			
			remove_states_shock  # 여기서 맞았을 경우 상태이상 해제하는 코드 넣기
			self_cha = self.rpg_skill.character
			attacker_cha = attacker.rpg_skill.character
			
			$ABS.weapon_skill(attacker.weapon_id, self)  # 특정 무기를 착용하면 추가 격 데미지가 있음
			self.damage *= 2 if self_cha.direction == attacker_cha.direction
			self.damage = attacker.rpg_skill.damage_calculation_attack(self.damage)  # 최종 데미지 계산
			self.damage = self.rpg_skill.damage_calculation_defense(self.damage)			
			self.damage = self.damage.to_i
			self.hp -= self.damage
			
			@damage_array.push(self.damage)
			@critical_array.push(self.critical)
			
			return if self.is_a?(Game_Actor) and $ABS.player_dead?(self, attacker)
			return if self.is_a?(ABS_Enemy) and $ABS.enemies[self.event.id].nil?
			
			check_enemy_aggro(self.damage)
			
			@state_changed = false  # State change
			unless attacker.is_a?(Game_NetPlayer)
				states_plus(attacker.plus_state_set)
				states_minus(attacker.minus_state_set)
			end
			return true  # End Method			
		end
		
		def check_enemy_aggro(damage)
			return unless self.is_a?(ABS_Enemy)
			return if $ABS.enemies[self.event.id].nil?
			
			aggro_chance = (damage * 100 / self.maxhp) || rand(100) <= 40
			if aggro_chance
				$ABS.enemies[self.event.id].aggro = true
				Network::Main.socket.send("<aggro>#{self.event.id},#{$game_party.actors[0].name}</aggro>\n")
			end
			$ABS.send_network_monster(self)
		end
		
		#--------------------------------------------------------------------------
		# * Apply Skill Effects
		#     user  : the one using skills (battler)
		#     skill : skill
		#--------------------------------------------------------------------------
		def effect_skill(user, skill)
			return if invalid_target?(user)
			
			self.critical = false
			return false if invalid_skill_scope?(skill)
			
			effective = process_common_event(skill)
			hit_result = calculate_hit(user, skill)
			
			if hit_result
				calculate_damage(user, skill)
				process_critical_hit(user)
				self.damage = apply_skill_modifiers(self.damage, user, skill)
				self.damage /= 10 if user.is_a?(Game_NetPlayer)
				$ABS.weapon_skill(user.weapon_id, self)
				
				effective |= apply_damage(user, skill)
			else
				self.damage = "빗나감!"
			end
			
			return effective
		end
		
		def invalid_target?(user)
			if self.is_a?(ABS_Enemy) && user.is_a?(Game_Actor)
				return true unless self.hate_group.include?(0)
			end
			if self.is_a?(ABS_Enemy) && user.is_a?(ABS_Enemy)
				return true if self.id != user.id && !self.hate_group.include?(user.id)
			end
			return false
		end
		
		def invalid_skill_scope?(skill)
			(skill.scope == 3 || skill.scope == 4 && self.hp == 0) ||
			(skill.scope == 5 || skill.scope == 6 && self.hp >= 1)
		end
		
		def process_common_event(skill)
			return skill.common_event_id > 0
		end
		
		def calculate_hit(user, skill)
			hit = skill.hit
			hit *= user.hit / 100 if skill.atk_f > 0 && !user.is_a?(Game_NetPlayer)
			rand(10) < hit
		end
		
		def calculate_damage(user, skill)
			power = skill.power + user.atk / 2
			power = user.rpg_skill.skill_power_custom(skill.id, power)
			power *= (1.0 + user.atk / 10.0)
			power = apply_defense_modifiers(power, skill)
			
			rate = calculate_rate(user, skill)
			self.damage = (power * rate / 40.0)
			self.damage *= elements_correct(skill.element_set)
			self.damage /= 100
			self.damage = self.damage.to_i
		end
		
		def apply_defense_modifiers(power, skill)
			if power > 0
				power -= self.pdef * [skill.pdef_f, 10].max / 200
				power -= self.mdef * skill.mdef_f / 100
				power = [power, 1].max
			end
			power
		end
		
		def calculate_rate(user, skill)
			rate = 40
			rate += user.str * skill.str_f / 100.0
			rate += user.dex * skill.dex_f / 100.0
			rate += user.agi * skill.agi_f / 100.0
			rate += user.int * skill.int_f / 100.0
			rate
		end
		
		def process_critical_hit(user)
			return unless self.damage > 0
			
			plus_rate, plus_power = user.rpg_skill.critical_skill_rate()
			critical_rate = (1.0 + (1.2 * user.int / 200) + plus_rate) * 100
			
			r = rand(10000)
			if r <= critical_rate.to_i
				self.damage *= (1.75 + plus_power)
				self.critical = "skill_cri"
			end
			self.damage /= 2 if self.guarding?
		end
		
		def apply_skill_modifiers(damage, user, skill)
			damage = self.rpg_skill.damage_by_skill(damage, skill.id)
			damage = apply_damage_reduction(damage)
			damage = apply_dispersion(damage, skill)
			damage = user.rpg_skill.damage_calculation_skill(damage)
			damage = self.rpg_skill.damage_calculation_defense(damage)
			damage
		end
		
		def apply_damage_reduction(damage)
			if damage > 0
				limit = self.is_a?(Game_Actor) ? 200.0 : 500.0
				damage *= limit / (limit + (self.base_pdef + self.base_mdef * 4))
			end
			return damage
		end
		
		def apply_dispersion(damage, skill)
			if skill.variance > 0 && damage.abs > 0
				amp = [damage.abs * skill.variance / 100, 1].max
				damage += rand(amp + 1) + rand(amp + 1) - amp
			end
			return damage
		end
		
		def apply_damage(user, skill)
			last_hp = self.hp
			self.hp -= self.damage
			@damage_array.push(self.damage)
			@critical_array.push(self.critical)
			
			process_aggro if self.is_a?(ABS_Enemy) && $ABS.enemies[self.event.id]
			
			return false if self.is_a?(Game_Actor) && $ABS.player_dead?(self, user)
			return false if self.is_a?(ABS_Enemy) && $ABS.enemies[self.event.id].nil?
			
			$ABS.send_network_monster(self) if self.is_a?(ABS_Enemy) && $ABS.enemies[self.event.id]
			
			effective = self.hp != last_hp
			@state_changed = false
			effective |= states_plus(skill.plus_state_set)
			effective |= states_minus(skill.minus_state_set)
			
			if skill.power == 0
				self.damage = @state_changed ? 1 : "빗나감!"
			end
			effective
		end
		
		def process_aggro
			r = rand(100)
			if r <= [(self.damage * 100 / self.maxhp), 30].max
				self.aggro = true
				Network::Main.socket.send("<aggro>#{self.event.id},#{$game_party.actors[0].name}</aggro>\n")
			end
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
		attr_accessor :ani_show_net # 애니메이션 공유할건지 여부
		attr_accessor :base_speed 
		
		alias mrmo_abs_game_character_ini initialize
		def initialize
			mrmo_abs_game_character_ini
			@ani_array = []
			@base_speed = 3
			@ani_show_net = true
		end
		
		#--------------------------------------------------------------------------
		# * Jump
		#     x_plus : x-coordinate plus value
		#     y_plus : y-coordinate plus value
		#--------------------------------------------------------------------------
		def jump_nt(x_plus, y_plus)
			x_plus != 0 ? move_horizontally(x_plus) : move_vertically(y_plus)
			@jump_count = 1
		end
		
		def move_horizontally(x_plus)
			move_in_direction(x_plus, 0, x_plus.abs, x_plus > 0 ? 1 : -1)
		end
		
		def move_vertically(y_plus)
			move_in_direction(0, y_plus, y_plus.abs, y_plus > 0 ? 1 : -1)
		end
		
		def move_in_direction(x_plus, y_plus, count, step)
			count.times do
				x = @x + x_plus * step
				y = @y + y_plus * step
				break unless passable?(x, y, 0)
				
				@x = x
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
			
			return end_animate if @frame == 0
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
			return unless self.is_a?(Game_Event)
			return unless $ABS.enemies[self.event.id]
			return unless $ABS.enemies[self.event.id].aggro
			
			$ABS.send_network_monster($ABS.enemies[self.event.id])
			Network::Main.socket.send("<mon_move>#{self.event.id},#{@direction},#{self.x},#{self.y}</mon_move>\n")
		end
		
		def check_enemy_movable(is_ok)
			return true unless self.is_a?(Game_Event)
			return true if is_ok
			
			enemy = $ABS.enemies[self.event.id]
			return true unless enemy
			return enemy.aggro 
		end
		
		def move_in_direction_with_check(x_plus, y_plus, direction, turn_enabled, is_ok)
			return unless check_enemy_movable(is_ok)
			
			if turn_enabled
				turn = case direction
				when 2 then "down"
				when 4 then "left"
				when 6 then "right"
				when 8 then "up"
				end
				send("turn_#{turn}") 
			end
			return if self.is_a?(Game_Player) && Key.press?(KEY_CTRL)
			
			if passable?(@x, @y, direction)
				@x += x_plus
				@y += y_plus
				increase_steps
				send_enemy_move
			else
				check_event_trigger_touch(@x + x_plus, @y + y_plus)
			end
		end
		
		def move_down(turn_enabled = true, is_ok = false)
			move_in_direction_with_check(0, 1, 2, turn_enabled, is_ok)
		end
		
		def move_left(turn_enabled = true, is_ok = false)
			move_in_direction_with_check(-1, 0, 4, turn_enabled, is_ok)
		end
		
		def move_right(turn_enabled = true, is_ok = false)
			move_in_direction_with_check(1, 0, 6, turn_enabled, is_ok)
		end
		
		def move_up(turn_enabled = true, is_ok = false)
			move_in_direction_with_check(0, -1, 8, turn_enabled, is_ok)
		end
		
		#--------------------------------------------------------------------------
		# * 대각선 이동
		# * Move Diagonally
		#--------------------------------------------------------------------------
		def move_diagonally(direction, x_plus, y_plus, d1, d2)
			adjust_direction(direction)
			if passable_diagonally?(x_plus, y_plus, d1, d2)
				@x += x_plus
				@y += y_plus
				increase_steps
			else
				check_event_trigger_touch(@x + x_plus, @y + y_plus)
			end
		end
		
		def move_lower_left
			move_diagonally('lower_left', -1, 1, 2, 4)
		end
		
		def move_lower_right
			move_diagonally('lower_right', 1, 1, 2, 6)
		end
		
		def move_upper_left
			move_diagonally('upper_left', -1, -1, 8, 4)
		end
		
		def move_upper_right
			move_diagonally('upper_right', 1, -1, 8, 6)
		end
		
		def adjust_direction(direction)
			return if @direction_fix
			
			@direction = case direction
			when 'lower_left' then @direction == 6 ? 4 : @direction == 8 ? 2 : @direction 
			when 'lower_right' then @direction == 4 ? 6 : @direction == 8 ? 2 : @direction 
			when 'upper_left' then @direction == 6 ? 4 : @direction == 2 ? 8 : @direction 
			when 'upper_right' then @direction == 4 ? 6 : @direction == 2 ? 8 : @direction 
			end
		end
		
		def passable_diagonally?(x_plus, y_plus, d1, d2)
			(passable?(@x, @y, d1) && passable?(@x, @y + y_plus, d2)) ||
			(passable?(@x, @y, d2) && passable?(@x + x_plus, @y, d1))
		end
		
		#--------------------------------------------------------------------------
		# * Move at Random
		#--------------------------------------------------------------------------
		def move_random()
			if $ABS.enemies[self.event.id] && $ABS.enemies[self.event.id].aggro
				return true unless $is_map_first
			end
			
			case rand(4)
			when 0 then move_down
			when 1 then move_left
			when 2 then move_right
			when 3 then move_up
			end
		end
		
		#--------------------------------------------------------------------------
		# * Move toward B
		#--------------------------------------------------------------------------
		def move_to(b)
			return if @stop_count <= (15 - @move_frequency * 2) * (6 - @move_frequency)
			
			sx, sy = @x - b.x, @y - b.y
			return if sx == 0 && sy == 0
			
			abs_sx, abs_sy = sx.abs, sy.abs
			rand(6) < 5 ? move_towards_object(abs_sx, abs_sy, sx, sy) : move_random
		end
		
		def move_towards_object(abs_sx, abs_sy, sx, sy)
			abs_sx += 1 if abs_sx == abs_sy && rand(2) == 0
			
			if abs_sx > abs_sy
				sx > 0 ? move_left : move_right
				return if moving?
				
				if rand(4) < 3
					return rand(2) == 0 ? move_up : move_down
				else
					return sy > 0 ? move_up : move_down
				end
			else
				sy > 0 ? move_up : move_down
				return if moving?
				
				if rand(4) < 3
					return rand(2) == 0 ? move_left : move_right 
				else
					return sx > 0 ? move_left : move_right
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * Turn Towards B
		#--------------------------------------------------------------------------
		def turn_to(b)
			return if @stop_count <= (15 - @move_frequency * 2) * (6 - @move_frequency)
			
			sx, sy = @x - b.x, @y - b.y
			return if sx == 0 && sy == 0
			
			if sx.abs > sy.abs
				sx > 0 ? turn_left : turn_right
			else
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
		
		attr_accessor :orgin_move_type
		attr_accessor :orgin_speed 
		attr_accessor :orgin_frequency 
		
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
			$data_enemies[enemy_id].maxhp = ABS_ENEMY_HP[enemy_id][0] if ABS_ENEMY_HP[enemy_id]
			
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
			
			@orgin_move_type = 0 
			@orgin_speed = 0
			@orgin_frequency = 0 
			
			@temp_move_type = 0 
			@temp_speed = 0
			@temp_frequency = 0 
			@temp_restore_sw = true
			
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
			
			@pdef = $data_enemies[@enemy_id].pdef
			@mdef = $data_enemies[@enemy_id].mdef	
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
			return @pdef
			#return $data_enemies[@enemy_id].pdef
		end
		#--------------------------------------------------------------------------
		# * Get Basic Magic Defense
		#--------------------------------------------------------------------------
		def base_mdef
			return @mdef
			#return $data_enemies[@enemy_id].mdef
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
		
		#--------------------------------------------------------------------------
		# * Get Physical Defense Power
		#--------------------------------------------------------------------------
		def pdef
			return @pdef
		end
		#--------------------------------------------------------------------------
		# * Get Magic Defense Power
		#--------------------------------------------------------------------------
		def mdef
			return @mdef
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
