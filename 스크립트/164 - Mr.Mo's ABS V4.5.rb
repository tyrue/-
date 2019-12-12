#============================================================================
# *  Mr.Mo's ABS
#============================================================================
# Mr.Mo "Muhammet Sivri"
# Version 4.5
# 01/04/06
# Thanks to Near Fantastica's methods;
# - In Range?, Get Range, In Direction?, enemy_dead?, treasure
# - Class Game_Range(highly modified for convinience)
# - Scene_Skill(main, update_shk) 
# Most were modified by me to my style and to increase performance and 
# cleaner code.
#
# Give Credit to Near Fantastica as well, those methods saved me time and helped.
#
#============================================================================
# Intoduction
#============================================================================
# I wasnt happy with the current version of Near's ABS, and he wasn't going to
# update it anymore. So instead I made an ABS.
# Detailed Tutorial on the ABS and HUD modification tutorials added.
#============================================================================
# Explanation
#============================================================================
#--Skill Casting :
# If the skill is not ranged and its suppose to attack one enemy, it will attack
# the closest enemy.
# If the skill scope is more then 1 enemy, it can be ranged. It will just attack
# the enemies in that range.
# The skill animations can be assigned in the Constants section
# The default skill animation suffix is _cast. If you want a skill to have the 
# default animation(_casT) just don't do anything for it :)
#--Enemy AI :
# 0 = Dummy             - Will not attack but can be attacked
# 1 = See Range         - Will attack only if it can see an enemy
# 2 = Hear Range        - WIll attack only if it can hear an enemy
# 3 = Hear or See Range - Will attack if it can see or hear enemy
# 4 = Ally Under Attack - Will attack if its ally is under attack and if it can
#                         see or hear the enemy
#
#--Enemy Explanation :
# Hate Points   - The enemy will randomly give out hate points to all of it's enemies.
#                 Later, it's enemies will be ordered from most to least hate points.
#
# Hate Groups   - The enemy will attack hate groups, meaning other enemies.
#                 The hate group enemies aren't considered allies. 
#                 The player's hate id is 0.
#                 Do not use the event ID, use the Monster ID, you can find it
#                 in the Database, Enemies Tab.
#
# Closest Enemy - The enemy will attack the closest enemy, if met the right AI
#                 conditions. Hate points are no longer needed, if this BOOLEAN
#                 is true.
#
# 
#--Comment List :
# To add a comment, click on the event command list, in the first tab, you should
# see the [ Comment... ] button. It should look similar to this.
#
# V = value
#
# Comment: ABS                 - Required for recognizing enemies.
# Comment: ID V                - Enemy ID from the database.
# Comment: Behavior V          - Refer to Enemy AI.
# Comment: Sight V             - See range the enemy can hear.
# Comment: Sound V             - Sound range the enemy can hear.
# Comment: ClosestEnemy V      - Refer to Enemy explantion
# Comment: HateGroup [V]       - Refer to Enemy explantion
# Comment: Aggressiveness V    - How fast will the enemy attack.
# Comment: Speed V             - How fast will the enemy move when in battle
# Comment: Frequency V         - What rate will the enemy move when in battle
# Comment: Trigger V           - Refer to Triggers.
# Comment: Respawn V           - Respawn Time. If 0, then don't respawn
#
# Example:
#
# Comment: ABS
# Comment: ID 1
# Comment: Behavior 1
# Comment: Sight 5
# Comment: Sound 5
# Comment: ClosestEnemy true
# Comment: HateGroup [0]
# Comment: Aggressiveness 1 
# Comment: Speed 4
# Comment: Frequency 4
# Comment: Trigger 0
# Comment: Respawn 0
#
#--Triggers :
# Trigger 0     - Will erase the event. 이벤트 없음 
# Trigger 1 2   - Will turn on a switch with the ID of 2. 2번 스위치를 킴
# Trigger 2 5 9 - Will change the Varaible's value with the ID of 5 to 9. If 9 is 5번 변수는 1증가, 9번 변수는 0됨
#                 set to 0, the the Variable 5 will be added 1.
# Trigger 3 1   - Will change the local switch of the enemy to 1("A"). 셀프 스위치 A 킴
#                   1 = A
#                   2 = B
#                   3 = C
#                   4 = D
#
#--Startegy Usage :
# The ABS can be used to setup wars and make fights between NPCs. Imagination is
# the limit. 
# The events do not need to attack the player. Just remove the 0 from the hate
# group list.
#
# You can make an event a dummy, it can still be attacked, but it won't retaliate.
# This is usefull for practices, or teacing the player how to fight. It can also
# be used for NPC's.
#
# Make allias for the player. Remove the 0 from the hate group list and add all
# the monsters(their enemy IDs, database) on the map. The allias won't follow the player or anything
# but they would attack other monsters giving the effect of allince.
#
# Monster Pit Fights can also be made.
#
#--Default Animations
# charactername_melee  - melee attacks
# charactername_cast  - skills
#============================================================================
#--------------------------------------------------------------------------
# * SDK Log Script
#--------------------------------------------------------------------------
SDK.log("Mr.Mo's ABS", "Mr.Mo", 4.5, "01/04/06")
#--------------------------------------------------------------------------
# * Begin SDK Enable Test
#--------------------------------------------------------------------------
if SDK.state("Mr.Mo's ABS") == true
	#--------------------------------------------------------------------------
	# * Constants - MAKE YOUR EDITS HERE
	#--------------------------------------------------------------------------
	CAN_DASH = false  #Can the player Dash?
	CAN_SNEAK = false #Can the player sneak?
	#--------------------------------------------------------------------------
	ATTACK_KEY = Input::Letters["S"]
	#~ ATTACK_KEY = 32
	#--------------------------------------------------------------------------
	# Do not change the '=> 0', part.
	# To Add more just make a new line; there are 10 examples :P
	# Besides Numberkeys, you can use;
	#  Input::Letters["LETTER"] Make sure the letter is in CAPS. 
	#  Input::Numberpad[number]
	#  Input::Fkeys[number]
	#  For more keys look in to the Input Script
	# 넘버 패드로 스킬 지정 
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
	}
	# 위 숫자로 아이템 지정
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
	}
	#--------------------------------------------------------------------------
	SNEAK_KEY = Input::Letters["Z"]
	DASH_KEY = Input::Letters["X"]
	#--------------------------------------------------------------------------
	# Add Dash and Sneak animation_suffix here.
	DASH_ANIMATION = "_dash"
	SNEAK_ANIMATION = "_sneak"
	# Change characterset when dash or sneak?
	DASH_SHO_AN = false
	SNEAK_SHO_AN = false
	#--------------------------------------------------------------------------
	# You do not need to add the animation suffixes if you don't want the player
	# to animate when attacking.
	#--------------------------------------------------------------------------
	#Ranged Weapons 범위 무기
	RANGE_WEAPONS = {}
	# RANGE_WEAPONS[Weapon_ID] = 
	#[Character Set Name, Move Speed, Animation, Ammo, Range,  Mash Time(in seconds), Kick Back(in tiles),Animation Suffix]
	# Leave kickback 0 if you don't want kick back effect.
	#-------------------------------------------------------------------------
	#Ranged Skills
	RANGE_SKILLS = {}
	# RANGE_SKILLS[Skill_ID] = [Range, Move Speed, Character Set Name, Mash Time(in seconds), Kick Back(in tiles)]
	# 범위, 이동속도, 캐릭터이름, 지속시간, 넉백 범위
	# 데이터베이스 보고 범위 스킬 id넣으면 됨
	# 주술사 스킬
	RANGE_SKILLS[1] = [10, 10, "공격스킬2", 4, 0] 	#뢰진주
	RANGE_SKILLS[2] = [10, 10, "공격스킬2", 4, 0] 	#백열주
	RANGE_SKILLS[3] = [10, 10, "공격스킬2", 4, 0] 	#화염주
	RANGE_SKILLS[4] = [10, 10, "공격스킬2", 4, 0] 	#자무주
	RANGE_SKILLS[10] = [10, 10, "공격스킬2", 4, 0] #뢰진주 1성
	RANGE_SKILLS[11] = [10, 10, "공격스킬2", 4, 0] #백열주 1성
	RANGE_SKILLS[12] = [10, 10, "공격스킬2", 4, 0] #화염주 1성
	RANGE_SKILLS[13] = [10, 10, "공격스킬2", 4, 0] #자무주 1성
	RANGE_SKILLS[14] = [10, 10, "공격스킬2", 4, 0] #뢰진주 첨
	RANGE_SKILLS[16] = [10, 10, "공격스킬2", 4, 0] #뢰진주 2성
	RANGE_SKILLS[17] = [10, 10, "공격스킬2", 4, 0] #백열주 2성
	RANGE_SKILLS[18] = [10, 10, "공격스킬2", 4, 0] #화염주 2성
	RANGE_SKILLS[19] = [10, 10, "공격스킬2", 4, 0] #자무주 2성
	RANGE_SKILLS[22] = [10, 10, "공격스킬2", 4, 0] #뢰진주 3성
	RANGE_SKILLS[23] = [10, 10, "공격스킬2", 4, 0] #백열주 3성
	RANGE_SKILLS[24] = [10, 10, "공격스킬2", 4, 0] #화염주 3성
	RANGE_SKILLS[25] = [10, 10, "공격스킬2", 4, 0] #자무주 3성
	RANGE_SKILLS[30] = [10, 10, "공격스킬2", 4, 0] #뢰진주 4성
	RANGE_SKILLS[31] = [10, 10, "공격스킬2", 4, 0] #백열주 4성
	RANGE_SKILLS[32] = [10, 10, "공격스킬2", 4, 0] #화염주 4성
	RANGE_SKILLS[33] = [10, 10, "공격스킬2", 4, 0] #자무주 4성
	RANGE_SKILLS[37] = [10, 10, "공격스킬2", 4, 0] #뢰진주 5성
	RANGE_SKILLS[38] = [10, 10, "공격스킬2", 4, 0] #백열주 5성
	RANGE_SKILLS[39] = [10, 10, "공격스킬2", 4, 0] #화염주 5성
	RANGE_SKILLS[40] = [10, 10, "공격스킬2", 4, 0] #자무주 5성
	RANGE_SKILLS[44] = [10, 10, "공격스킬2", 4, 0] #헬파이어
	RANGE_SKILLS[49] = [10, 10, "공격스킬2", 4, 0] #성려멸주
	RANGE_SKILLS[52] = [10, 10, "공격스킬2", 4, 0] #성려멸주 1성
	RANGE_SKILLS[53] = [10, 10, "공격스킬2", 4, 0] #삼매진화
	RANGE_SKILLS[56] = [10, 10, "공격스킬2", 4, 0] #성려멸주 2성
	RANGE_SKILLS[57] = [10, 10, "공격스킬2", 4, 0] #삼매진화 1성
	RANGE_SKILLS[58] = [10, 6, "공격스킬2", 4, 0] #지폭지술
	RANGE_SKILLS[68] = [10, 6, "공격스킬2", 4, 0] #폭류유성
	
	#전사 스킬
	RANGE_SKILLS[65] = [10, 10, "공격스킬2", 4, 0] #뢰마도
	RANGE_SKILLS[67] = [0, 5, "", 4, 0] #건곤대나이
	RANGE_SKILLS[69] = [0, 5, "", 4, 0] #???
	RANGE_SKILLS[70] = [0, 5, "", 4, 0] #???
	RANGE_SKILLS[73] = [4, 6, "공격스킬2", 4, 0] #광량돌격
	RANGE_SKILLS[74] = [0, 5, "", 4, 0] #십리건곤
	RANGE_SKILLS[75] = [10, 10, "공격스킬2", 4, 0] #뢰마도 1성
	RANGE_SKILLS[77] = [0, 5, "", 4, 7] #유비후타
	RANGE_SKILLS[78] = [0, 5, "", 4, 0] #십리건곤 1성
	RANGE_SKILLS[79] = [0, 5, "", 4, 0] #동귀어진
	RANGE_SKILLS[80] = [0, 5, "", 4, 0] #십리건곤 2성
	RANGE_SKILLS[82] = [0, 5, "", 4, 0] #적반의기원
	RANGE_SKILLS[101] = [0, 5, "", 4, 0] #백호참
	RANGE_SKILLS[102] = [1, 6, "공격스킬2", 4, 0] #백리건곤 1성
	RANGE_SKILLS[104] = [10, 5, "공격스킬2", 4, 0] #포효검황
	RANGE_SKILLS[105] = [10, 5, "공격스킬2", 4, 0] #혈겁만파
	#도사 스킬
	# 부활 스킬을 넣어볼까 생각
	
	#도적 스킬
	RANGE_SKILLS[133] = [0, 5, "", 4, 0] #필살검무
	RANGE_SKILLS[135] = [0, 5, "", 4, 0] #백호검무
	RANGE_SKILLS[137] = [0, 5, "", 4, 0] #이기어검
	RANGE_SKILLS[138] = [10, 10, "공격스킬2", 4, 0] #무형검
	RANGE_SKILLS[139] = [10, 5, "", 4, 0] #분혼경천
	
	
	# 적 캐릭터 스킬
	RANGE_SKILLS[45] = [8, 4, "공격스킬", 4, 0] #산적 건곤
	RANGE_SKILLS[59] = [3, 4, "공격스킬", 4, 0] #주작의 노도성황
	RANGE_SKILLS[61] = [3, 4, "공격스킬", 4, 0] #백호의 건곤대나이
	RANGE_SKILLS[85] = [8, 5, "공격스킬2", 4, 0] # 필살검무
	RANGE_SKILLS[151] = [4, 2, "공격스킬2", 4, 0] # 청룡의 포효
	RANGE_SKILLS[152] = [4, 2, "공격스킬2", 4, 0] # 현무의 포효
	RANGE_SKILLS[153] = [7, 5, "공격스킬", 4, 0] # 백호검무
	RANGE_SKILLS[154] = [3, 4, "공격스킬", 4, 0] # 청룡마령참
	RANGE_SKILLS[155] = [5, 2, "공격스킬", 4, 0] # 암흑진파
	RANGE_SKILLS[156] = [5, 2, "공격스킬", 4, 0] # 흑룡광포
	#--------------------------------------------------------------------------
	#Ranged Explosives
	# 폭발 범위
	RANGE_EXPLODE = {}
	# RANGE_EXPLODE[Skill_ID] = [Range, Move Speed, Character Set Name, Explosive Range, Mash Time(in seconds), Kick Back(in tiles)]
	# 폭발 스킬 = 범위, 이동속도, 이미지 이름, 폭발범위, 딜레이, 넉백
	# 주술사 스킬
	RANGE_EXPLODE[69] = [7, 6, "공격스킬2", 2, 4, 0] # 삼매진화 2성
	
	# 전사스킬
	RANGE_EXPLODE[103] = [1, 6, "공격스킬2", 2, 4, 0] # 어검술
	
	
	
	#--------------------------------------------------------------------------
	# Since Melee weapons aren't listed I made this for customazation of melee weapons.
	MELEE_CUSTOM = {}
	# if left blank the default mash time will be MASH_TIME(below)
	# No need to use the animation suffix if you don't plan to animate the player's character set.
	# MELEE_CUSTOM[Weapon_ID] = [Mash Time(in seconds), Kick Back(in tiles), animation suffix]
	#무기 딜레이
	#~ MELEE_CUSTOM[101] = [5, 0]
	
	#--------------------------------------------------------------------------
	# Since some skills won't be listed(i.e non-ranged) I made this for customazation of melee weapons.
	SKILL_CUSTOM = {}
	# if left blank the default mash time will be MASH_TIME(below)
	# No need to use the animation suffix if you don't plan to animate the player's character set.
	# SKILL_CUSTOM[Skill_ID] = [Mash Time(in seconds), Kick Back(in tiles), animation suffix]
	SKILL_CUSTOM[1] = [3, 0]
	SKILL_CUSTOM[7] = [3, 0]
	SKILL_CUSTOM[8] = [3, 0, "_cast"]
	#--------------------------------------------------------------------------
	# 플레이어가 죽을때 게임오버 할거냐
	GAME_OVER_DEAD = false # 아니
	# 리더가 죽으면 다음 멤버가 리더가 될거?
	NEXT_LEADER = false #아니
	#--------------------------------------------------------------------------
	#Mash Time
	# 공격 딜레이 초단위
	MASH_TIME = 4
	
	sec = 60 # 1초
	# 스킬 딜레이 [원래 딜레이, 현재 남은 딜레이]
	SKILL_MASH_TIME = {}
	# 주술사
	SKILL_MASH_TIME[44] = [7 * sec, 0] # 헬파이어
	SKILL_MASH_TIME[53] = [7 * sec, 0] # 삼매진화
	SKILL_MASH_TIME[57] = [7 * sec, 0] # 삼매진화 1성
	SKILL_MASH_TIME[58] = [80 * sec, 0] # 지폭지술
	SKILL_MASH_TIME[68] = [140 * sec, 0] # 폭류유성
	SKILL_MASH_TIME[69] = [7 * sec, 0] # 삼매진화 2성
	
	# 전사
	SKILL_MASH_TIME[65] = [10 * sec, 0] # 뢰마도
	SKILL_MASH_TIME[67] = [5 * sec, 0] # 건곤대나이
	SKILL_MASH_TIME[73] = [10 * sec, 0] # 광량돌격
	SKILL_MASH_TIME[75] = [7 * sec, 0] # 뢰마도 1성
	SKILL_MASH_TIME[77] = [5 * sec, 0] # 유비후타
	SKILL_MASH_TIME[79] = [60 * sec, 0] # 동귀어진
	SKILL_MASH_TIME[101] = [4 * sec, 0] # 백호참
	SKILL_MASH_TIME[103] = [20 * sec, 0] # 어검술
	SKILL_MASH_TIME[104] = [80 * sec, 0] # 포효검황
	SKILL_MASH_TIME[105] = [140 * sec, 0] # 혈겁만파
	
	# 도적
	SKILL_MASH_TIME[133] = [4 * sec, 0] # 필살검무
	SKILL_MASH_TIME[135] = [1 * sec, 0] # 백호검무
	SKILL_MASH_TIME[137] = [10 * sec, 0] # 이기어검
	SKILL_MASH_TIME[138] = [10 * sec, 0] # 무형검
	SKILL_MASH_TIME[139] = [140 * sec, 0] # 분혼경천
	# 도사
	
	
	# 스킬 지속 시간 [원래 지속 시간, 현재 남은 시간, 스위치 번호]
	SKILL_BUFF_TIME = {}
	# 주술사
	SKILL_BUFF_TIME[9] = [120 * sec, 0, 123] # 무장
	SKILL_BUFF_TIME[46] = [120 * sec, 0, 123] # 무장
	SKILL_BUFF_TIME[20] = [120 * sec, 0, 124] # 보호
	SKILL_BUFF_TIME[47] = [120 * sec, 0, 124] # 보호
	SKILL_BUFF_TIME[26] = [180 * sec, 0, 16] # 누리의힘
	SKILL_BUFF_TIME[42] = [180 * sec, 0, 24] # 주술마도
	
	# 전사
	SKILL_BUFF_TIME[62] = [180 * sec, 0, 157] # 수심각도
	SKILL_BUFF_TIME[63] = [180 * sec, 0, 158] # 반영대도
	SKILL_BUFF_TIME[64] = [180 * sec, 0, 159] # 십량분법
	SKILL_BUFF_TIME[66] = [20 * sec, 0, 161] # 신수둔각도
	SKILL_BUFF_TIME[72] = [180 * sec, 0, 159] # 구량분법
	SKILL_BUFF_TIME[76] = [180 * sec, 0, 159] # 팔량분법
	SKILL_BUFF_TIME[71] = [60 * sec, 0, 163] # 혼신의힘
	
	
	# 도사
	SKILL_BUFF_TIME[88] = [60 * sec, 0, 338] # 분량력법
	SKILL_BUFF_TIME[90] = [60 * sec, 0, 196] # 분량방법
	SKILL_BUFF_TIME[91] = [60 * sec, 0, 30] # 석화기탄
	SKILL_BUFF_TIME[94] = [6 * sec, 0, 32] # 금강불체
	
	# 도적
	SKILL_BUFF_TIME[130] = [180 * sec, 0, 42] # 무영보법
	SKILL_BUFF_TIME[131] = [60 * sec, 0, 41] # 투명
	SKILL_BUFF_TIME[134] = [60 * sec, 0, 1] # 분신
	SKILL_BUFF_TIME[136] = [10 * sec, 0, 43] # 파무쾌보
	
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
	#--------------------------------------------------------------------------
	DASH_SPEED = 5
	SNEAK_SPEED = 3
	#--------------------------------------------------------------------------
	#Max frames the player can run or sneak
	DASH_MAX = 0
	SNEAK_MAX = 0
	#--------------------------------------------------------------------------
	#Should the states be gone after a while?
	STATES_UPDATE = true
	#If true
	STATES = {}
	STATES[19] = 1200    #무장
	STATES[30] = 1200    #보호
	#STATES[STATE_ID] = [DURATION in FRAMES, 0]  
	#if Duration is 0 the state will stay there until healed(item, skill). 
	#10 frames = 1 sec
	STATES[1] = 0    #Until Healed
	STATES[2] = 100  #20 seconds
	STATES[3] = 100  #20 seconds
	STATES[4] = 100  #20 seconds
	STATES[5] = 100  #20 seconds
	STATES[6] = 100  #20 seconds
	STATES[7] = 100  #20 seconds
	STATES[8] = 100  #20 seconds
	STATES[9] = 100  #20 seconds
	STATES[10] = 100 #20 seconds
	STATES[17] = 100 #20 seconds
	STATES[18] = 100 #20 seconds
	STATES[19] = 100 #20 seconds
	#--------------------------------------------------------------------------
	# Allow state effects?
	# 상태에 이펙트 처리
	STATE_EFFECTS = true
	# Assign the ID of states to each variable. Each effect is described. You can
	# add more then one id to each to get the effect you want.
	STUN_EFFECT = [2]      # No movement/atk/skill, and can't use items.
	DAZZLE_EFFECT = [4]    # Makes the screen bright.
	MUTE_EFFECT = [5]      # Can't use skill.
	CONFUSE_EFFECT = [6]   # Controls randomly don't work.
	SLEEP_EFFECT = [7]     # Can't move until you get hit.
	PARALAYZE_EFFECT = [8] # Move slowly, cant attack or use skills.
	CLUMSY_EFFECT = [9,10] # Can't run or sneak.
	DELAY_EFFECT = [11]    # Walk slow, can't run.
	BLIND_EFFECT = [17]    # Make screen darker.
	SPEED_UP = [18]        # Can run without depleting the bar.
	LIGHT_FEET =[19]       # Can sneak without depleting the bar.
	#--------------------------------------------------------------------------
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
	DAMAGE_FONT_NAME = "맑은 고딕"
	#--------------------------------------------------------------------------
	DAMAGE_FONT_SIZE = 20
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
		#--------------------------------------------------------------------------
		# * Object Initialization
		# 생성자, 변수 초기화
		#--------------------------------------------------------------------------
		def initialize
			#ABS Enemy Variables
			@enemies = {}
			#Dash
			@can_dash = CAN_DASH 
			#Sneak
			@can_sneak = CAN_SNEAK
			#States
			@can_update_states = STATES_UPDATE
			#Attack Key
			@attack_key = ATTACK_KEY
			#Skill Keys
			@skill_keys = SKILL_KEYS
			#Item Keys
			@item_keys = ITEM_KEYS
			#Button Mash
			@button_mash = 0
			#Ranged Skills and Weapons
			@range = []
			#Display Demage true:false
			@damage_display = DISPLAY_DAMAGE
			#Game Over?
			@game_over = GAME_OVER_DEAD
			#Player Animated?
			@player_ani = ANIMATE_PLAYER
			#Enemy Animated?
			@enemy_ani = ANIMATE_ENEMY
			#Get Hate
			@get_hate = true
			# Dashing
			@dashing = false
			@dash_max = DASH_MAX
			@dash_min = @dash_max
			@dash_speed = DASH_SPEED
			# Sneaking 걷기
			@sneaking = false
			@sneak_max = SNEAK_MAX
			@sneak_min = @sneak_max
			@sneak_speed = SNEAK_SPEED
			# Old Speed
			@old_speed = 4
			# PvP - N+ Only 유저 싸움 가능
			@pvp_active = true
			# ABS Active
			@active = true
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
			@get_hate = true
			#Delete the event from the list
			@enemies.delete(event.id)
			#Skip the event if its invisible or doesn't contain a list
			# 캐릭터 파일 이름이 없거나, 이벤트가 없다면 무시
			return if character_name == "" or list == nil
			#Get the parameters 속성 받아오기, 주석처리한걸
			parameters = SDK.event_comment_input(event, 11, "ABS")
			#Skip if the paramete is NIL 속성이 없다면 무시
			return if parameters.nil?
			#Get Enemy ID
			id = parameters[0].split
			#Get Enemy
			enemy = $data_enemies[id[1].to_i]
			#Skip If Enemy is NIL 적이 없다면 무시
			return if enemy == nil
			@enemies[event.id] = ABS_Enemy.new(enemy.id)
			#Set Event ID
			@enemies[event.id].event_id = event.id
			#Get Event 
			@enemies[event.id].event = event
			#Set Behavior
			behavior = parameters[1].split
			@enemies[event.id].behavior = behavior[1].to_i
			#Set See Range
			see_range = parameters[2].split
			@enemies[event.id].see_range = see_range[1].to_i
			#Set Hear Range
			hear_range = parameters[3].split
			@enemies[event.id].hear_range = hear_range[1].to_i
			#Set Closest Enemy Boolean
			closest_enemy = parameters[4].split
			@enemies[event.id].closest_enemy = eval(closest_enemy[1])
			#Set Hate Group
			hate_group = parameters[5].split
			@enemies[event.id].hate_group = eval(hate_group[1])    
			#Set Aggresiveness
			aggressiveness = parameters[6].split
			@enemies[event.id].aggressiveness = aggressiveness[1].to_i
			#Set Speed
			speed = parameters[7].split
			@enemies[event.id].temp_speed = speed[1].to_i
			#Set Frequency
			freq = parameters[8].split
			@enemies[event.id].temp_frequency = freq[1].to_i
			#Set Trigger
			trigger = parameters[9].split
			@enemies[event.id].trigger= [trigger[1].to_i, trigger[2].to_i, trigger[3].to_i]
			#Respawn
			if parameters[10] != nil
				respawn = parameters[10].split 
				@enemies[event.id].respawn = respawn[1].to_i * 6
			end
			@enemies[event.id].aggro = $is_map_first
		end
		#--------------------------------------------------------------------------
		# * Make Hate Points(Enemy)
		#--------------------------------------------------------------------------
		def make_hate_points(e)
			#Get all the enemies of the enemy
			e.hate_points[$game_player.event_id] = rand(999)
			for id in e.hate_group
				#See if the ID in the Hate group is in the enemy ID 
				for enemy in @enemies.values
					#Skip NIL values
					next if enemy == nil
					if enemy.enemy_id == id
						#Insert in to the list if the enemy is in hate group
						e.hate_points[enemy.event_id] = rand(999)
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Update(Frame) 1프레임마다 실행되는 함수
		#--------------------------------------------------------------------------
		def update
			#Update Player
			if (Graphics.frame_count % (Graphics.frame_rate / 3) == 0)
				$skill_Delay_Console.refresh if $skill_Delay_Console != nil and $skill_Delay_Console.tog
			end
			update_player if @active
			#Update Enemy AI
			update_enemy if @enemies != {} and @active
			for range in @range
				next if range == nil
				range.update
			end
		end
		
		#--------------------------------------------------------------------------
		# * 로그아웃 등 스킬 버프, 딜레이 초기화
		#--------------------------------------------------------------------------
		def close_buff
			# 스킬 딜레이 초기화
			for skill_mash in SKILL_MASH_TIME
				if skill_mash[1][1] > 0
					skill_mash[1][1] = 0
				end
			end
			
			# 버프 지속시간 초기화
			for skill_mash in SKILL_BUFF_TIME
				if skill_mash[1][1] > 0
					skill_mash[1][1] = 0 
				end
			end
			if $skill_Delay_Console != nil
				$skill_Delay_Console.refresh
				$skill_Delay_Console.refresh
				$skill_Delay_Console.dispose
			end
		end
		
		#--------------------------------------------------------------------------
		# * Revive Actor 캐릭터 부활!
		#--------------------------------------------------------------------------
		def revive_actor
			items = []
			# Get the item that revives
			for i in $game_party.items.keys
				# 지금 템이 없다면 무시
				next if $game_party.items[i] == 0 or $game_party.items[i] == nil
				item = $data_items[i]
				next if !item.minus_state_set.include?(DEATH_STATE_ID) or item.scope < 3
				items.push(i) # 템창에 옮기기
			end
			# If list is empty
			if items == [] or items == nil or !REVIVE
				$game_temp.gameover = @game_over
			else
				i = rand(items.size)
				item = $data_items[items[i]]   
				# If effect scope is an ally
				if item.scope >= 3
					# Apply item use effects to target actor
					target = @actor
					used = target.item_effect(item)
					# If an item was used
					if used
						#Show animation on player
						$game_player.animation_id = item.animation1_id 
						# Play item use SE
						$game_system.se_play(item.menu_se)
						# If consumable; Decrease used items by 1
						$game_party.lose_item(item.id, 1) if item.consumable
						# If all party members are dead; Switch to game over screen
						#613, 1003
						# If common event ID is valid; Common event call reservation
						return $game_temp.common_event_id = item.common_event_id if item.common_event_id > 0
						# If effect scope is other than an ally
					end
				else
					# If command event ID is valid
					if item.common_event_id > 0
						# Command event call reservation
						$game_temp.common_event_id = item.common_event_id
						# Play item use SE
						$game_system.se_play(item.menu_se)
						# If consumable; Decrease used items by 1
						$game_party.lose_item(item.id, 1) if item.consumable
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Update States(Frame) 1프레임마다 실행되는 함수 update함수 안에서 실행 됨
		#--------------------------------------------------------------------------
		def update_states
			# For Player
			actor = $game_party.actors[0]
			for id in $game_party.actors[0].states
				next if !STATES.has_key?(id)
				state = STATES[id] # 상태 받아오기
				next if state == 0 # 죽은 상태면 무시
				add_state_effect(state,id) if actor.state_time == 0
				actor.state_time += 1
				if actor.state_time >= state
					$game_party.actors[0].remove_state(id)
					actor.state_time = 0
					remove_state_effects(id)
					return
				end
				update_states_effects(id)
			end
			#~ # 독뎀 구현 움직일 때마다 독 뎀
			#~ if actor.hp > 0 and actor.slip_damage? and Graphics.frame_count % (40) == 0 and !$game_player.moving?
			#~ actor.hp -= [actor.maxhp / 100, 1].max
			#~ if actor.hp == 0
			#~ $game_system.se_play($data_system.actor_collapse_se)
			#~ if NEXT_LEADER and !$game_party.all_dead?
			#~ move_forward
			#~ else
			#~ revive_actor
			#~ end
			#~ end
			#~ $game_screen.start_flash(Color.new(255,0,0,128), 4)
			#~ end
		end
		#--------------------------------------------------------------------------
		# * Add State Effect(State, ID)
		#--------------------------------------------------------------------------
		def add_state_effect(state,id)
			if STATE_EFFECTS
				if DAZZLE_EFFECT.include?(id)
					$game_screen.start_tone_change(Tone.new(200, 200, 130, 0), 20)
				elsif BLIND_EFFECT.include?(id)
					$game_screen.start_tone_change(Tone.new(-200,-200,-200, 0), 50)
				elsif STUN_EFFECT.include?(id)
					$game_player.movable = false
				elsif SLEEP_EFFECT.include?(id)
					$game_player.movable = false
				elsif PARALAYZE_EFFECT.include?(id)
					if @sneaking or @dashing
						$game_player.move_speed = @old_speed
						@sneaking = false
						@dashing = false
					end
					@old_speed = $game_player.move_speed
				elsif DELAY_EFFECT.include?(id)
					if @sneaking or @dashing
						$game_player.move_speed = @old_speed
						@sneaking = false
						@dashing = false
					end
					@old_speed = $game_player.move_speed
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Update State Effect(State, ID)
		#--------------------------------------------------------------------------
		def update_states_effects(id)
			return if !STATE_EFFECTS
			if PARALAYZE_EFFECT.include?(id)
				$game_player.move_speed = 1
			elsif DELAY_EFFECT.include?(id)
				$game_player.move_speed = 2
			elsif SPEED_UP.include?(id)
				@dash_min = @dash_max
			elsif LIGHT_FEET.include?(id)
				@sneak_min = @sneak_max
			end
		end
		#--------------------------------------------------------------------------
		# * Removve State Effect(State, ID)
		#--------------------------------------------------------------------------
		def remove_state_effects(id)
			return if !STATE_EFFECTS
			if STUN_EFFECT.include?(id)
				$game_player.movable = true
			elsif DAZZLE_EFFECT.include?(id)
				$game_screen.start_tone_change(Tone.new(0, 0, 0, 0), 50)
			elsif BLIND_EFFECT.include?(id)
				$game_screen.start_tone_change(Tone.new(0, 0, 0, 0), 50)
			elsif SLEEP_EFFECT.include?(id)
				$game_player.movable = true
			elsif PARALAYZE_EFFECT.include?(id)
				$game_player.move_speed = @old_speed
			elsif DELAY_EFFECT.include?(id)
				$game_player.move_speed = @old_speed
			end
		end
		#--------------------------------------------------------------------------
		# * Update Respawn(enemy) 몬스터의 부활
		#--------------------------------------------------------------------------
		def update_respawn(enemy)
			event = enemy.event
			
			# respawn은 젠 딜레이
			return if enemy.respawn == 0 or event.erased == false
			return if !$is_map_first
			
			enemy.respawn -= 1
			if enemy.respawn == 0
				# 해당 몹 젠 됐다고 서버에 알림
				# 해당 맵의 몹의 id 체력을 풀로 채움
				event.erased = false
				event.refresh
				
				#~ # 여기서 랜덤하게 움직이는걸 해야함
				for i in 0..20
					event.move_random
				end
				event.moveto(event.x,event.y)
				Network::Main.socket.send("<monster>#{$game_map.map_id},#{event.id},#{enemy.hp},#{event.x},#{event.y},#{event.direction},#{enemy.respawn}</monster>\n")	
				Network::Main.socket.send("<respawn>#{$game_map.map_id},#{event.id},#{event.x},#{event.y},#{event.direction}</respawn>\n")	
				$game_map.refresh
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
					update_respawn(enemy)
					next
				end
				#Update Enemy State
				update_enemy_state(enemy)
				#Skip if not on screen
				next if !in_screen?(enemy.event)
				#Make Hate Points
				make_hate_points(enemy) if @get_hate
				next if !enemy.in_battle and !update_enemy_ai(enemy)
				update_enemy_battle(enemy) if enemy.in_battle and enemy.behavior != 0
			end
			@get_hate = false
		end
		#--------------------------------------------------------------------------
		# * Update Enemy State(Enemy)
		#--------------------------------------------------------------------------
		def update_enemy_state(enemy)
			for id in enemy.states
				next if !STATES.has_key?(id)
				state = STATES[id]
				next if state == 0
				enemy.state_time += 1
				if enemy.state_time >= state
					enemy.remove_state(id)
					enemy.state_time = 0
					return
				end
			end
			# 적 독뎀?
			if enemy.hp > 0 and enemy.slip_damage? and Graphics.frame_count % (40) == 0 
				enemy.hp -= [enemy.maxhp / 100, 1].max
				if enemy.hp <= 0
					enemy_dead?(enemy,nil)
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Update Enemy Battle(Enemy)
		#--------------------------------------------------------------------------
		def update_enemy_battle(enemy)
			# If the enemy can't see it's enemy, skip the enemy
			if (!in_range?(enemy.event, enemy.attacking.event, enemy.see_range) and
					!in_range?(enemy.event, enemy.attacking.event, enemy.hear_range)) or
				(enemy.attacking == nil or enemy.attacking.actor.dead? or !enemy.hate_group.include?(enemy.attacking.enemy_id)) or
				!enemy.aggro
				# Restore movement
				# 원래 움직임으로 돌아옴
				restore_movement(enemy)
				# Take it out off battle
				enemy.in_battle = false
				enemy.attacking = nil
				return
			end      
			# Update the enemy attack or follow
			update_enemy_attack(enemy,enemy.attacking) if Graphics.frame_count % (enemy.aggressiveness * 45) == 0
			# Skip this if the attack killed the enemy
			return if enemy == nil or enemy.attacking == nil or enemy.event.moving?
			enemy.event.move_to(enemy.attacking.event) if !in_range?(enemy.event, enemy.attacking.event, 1)
			enemy.event.turn_to(enemy.attacking.event) if !in_direction?(enemy.event, enemy.attacking.event) and in_range?(enemy.event, enemy.attacking.event, 1)
		end
		#--------------------------------------------------------------------------
		# * Update Enemy AI(Enemy)
		#--------------------------------------------------------------------------
		def update_enemy_ai(enemy)
			#Get the enemy behavior
			b =  enemy.behavior
			return true if b == 0 # Dummy
			#Next enemy if this enemy can't see the player
			return true if b == 1 and !can_enemy_see(enemy)
			#Next enemy if this enemy can't hear the player
			return true if b == 2 and !can_enemy_hear(enemy)
			#Next enemy if this enemy can't see or hear the player
			return true if b == 3 and !can_enemy_see(enemy) and !can_enemy_hear(enemy)
			#Next if its not
			return true if b == 4 and !enemy_ally_in_battle?(enemy)
			#Next enemy if this enemy can't see or hear the player
			return true if b == 5 and !can_enemy_see(enemy) and !can_enemy_hear(enemy) and !enemy_ally_in_battle?(enemy)
			#Return false
			return false
		end
		#--------------------------------------------------------------------------
		# * Update Enemy Attack(Enemy) 적 캐릭터의 행동, 공격 또는 스킬
		#--------------------------------------------------------------------------
		def update_enemy_attack(e,actor)
			#Return if the enemy can't attack
			return if e.actions == nil or e.actions == [] or e == nil
			#Get all actions
			for action in e.actions
				#Next if enemy can't attack
				next if enemy_pre_attack(e, action)
				#Get the current action kind
				case action.kind
				when 0 # Basic
					#Get the action 기본 액션 가져옴
					case action.basic
					when 0 #Attack
						next if !in_range?(e.event, actor.event, 1) or !in_direction?(e.event, actor.event)
						#Attack it's enemy
						a = actor if actor.is_a?(ABS_Enemy) # ABS_Enemy클래스에 속하면 적
						a = $game_party.actors[0] if !actor.is_a?(ABS_Enemy) # ABS_Enemy클래스에 속하지 않으면 플레이어
						# 몬스터가 플레이어, 또는 다른 적을 공격함 e가 a를 공격함
						a.attack_effect(e)
						#Animate the enemy
						e.event.animation_id = e.animation1_id
						animate(e.event, e.event.character_name+"_melee") if @enemy_ani
						
						Network::Main.socket.send "<27>@ani_map = #{$game_map.map_id}; @ani_number = #{e.event.animation_id}; @ani_id = #{Network::Main.id};</27>\n"
						#Show Animation
						hit_enemy(actor,e) if a.damage != "Miss" and a.damage != 0
						#Check if enemy's enemy is dead, 적의 적이 죽었니? 플레이어도 포함 될 수 있음
						return if enemy_dead?(a,e)
						#Make enemy
						return if !a.is_a?(ABS_Enemy) # a가 플레이어면 무시
						return if a.attacking == e and a.in_battle # a가 적 캐릭이면 e를 쫒아감
						#Set the new target for the enemy
						a.attacking = e
						#The enemy is now in battle
						a.in_battle = true
						#Setup movement
						setup_movement(e)
						return
					when 1..3 #Nothing
						return
					end
				when 1..2 #Skill 적 캐릭의 스킬 사용
					#Get the skill
					skill = $data_skills[action.skill_id]
					#Return if the skill is NIL
					return if skill == nil
					#Get the skill scope
					case skill.scope
					when 1 # One Enemy 적 한놈만 
						return if Graphics.frame_count % (e.aggressiveness * 45) != 0
						next if !in_direction?(e.event, actor.event)
						next if !e.can_use_skill?(skill)
						#Animate the enemy
						e.event.animation_id = skill.animation1_id
						animate(e.event, e.event.character_name+"_cast") if @enemy_ani
						if RANGE_SKILLS.has_key?(skill.id)
							@range.push(Game_Ranged_Skill.new(e.event, e, skill)) # e는a의 적(플레이어 또는 또 다른 적)여기서 알아서 데미지 계산
							e.sp -= skill.sp_cost
							return
						end
						#If the skill is not ranged
						enemies = []
						#Get all enemies    
						for enemy in @enemies.values
							next if enemy == nil or enemy == e
							next if !e.hate_group.include?(enemy.enemy_id)
							enemies.push(enemy)
						end
						enemies.push($game_player) if e.hate_group.include?(0)
						#Order them from closest to the farthest
						enemies.sort! {|a,b|
							get_range(e.event,a.event) - get_range(e.event,b.event)}
						#Attack the closest one
						enemies[0].actor.effect_skill(e, skill)
						#Take off SP
						e.sp -= skill.sp_cost
						#Show Animetion on enemy
						hit_enemy(enemies[0], e, skill.animation2_id) if enemies[0].actor.damage != "Miss" and enemies[0].actor.damage != 0
						#Return if enemy is dead 
						return if enemy_dead?(enemies[0].actor,e)
						
						return if enemies[0].attacking == e and enemies[0].in_battle
						#If its alive, put it in battle
						enemies[0].in_battle = true
						#Make it attack the player
						enemies[0].attacking = e
						#Setup movement
						setup_movement(e)
						return
						
					when 2 #All Emenies 적 전체
						# 해당 스킬 범위에 적이 있으면 그 적들에게 스킬을 발사
						return if Graphics.frame_count % (e.aggressiveness * 45) != 0
						next if !e.can_use_skill?(skill)
						#Animate the enemy
						e.event.animation_id = skill.animation1_id
						animate(e.event, e.event.character_name+"_cast") if @enemy_ani
						
						enemies = get_all_range(e.event, RANGE_SKILLS[skill.id][0])
						enemies.push($game_player) if in_range?($game_player, e.event, RANGE_SKILLS[skill.id][0])
						
						for enemy in enemies
							# 나한테 적이 아니면 공격 안하게 함
							next if !e.hate_group.include?(0)
							next if !e.hate_group.include?(enemy.id)
							#Skip NIL values
							next if enemy == nil
							#Skip 이미 적이 죽은거면 넘어가
							next if !enemy.is_a?(Game_Player) and enemy.dead?
							if enemy.is_a?(Game_Player)
								enemy.actor.effect_skill(e, skill)
								#Show Animetion on enemy
								if enemy.actor.damage != "Miss" and enemy.actor.damage != 0
									$game_player.animation_id = skill.animation2_id 
									Network::Main.socket.send "<27>@ani_map = #{$game_map.map_id}; @ani_number = #{$game_player.animation_id}; @ani_id = #{Network::Main.id};</27>\n"
								end
								next if enemy_dead?(enemy.actor, e)
							else
								enemy.effect_skill(e, skill)	
								hit_enemy(enemy, e, 0) if enemy.damage != "Miss" and enemy.damage != 0
								next if enemy_dead?(enemy, e)
							end
							
							#Skip this enemy if its dead
							next if enemy.is_a?(Game_Player)
							next if enemy.attacking == e and enemy.in_battle
							#If its alive, put it in battle
							enemy.in_battle = true
							#Make it attack the player
							enemy.attacking = e
							#Setup movement
							setup_movement(e)
						end
						return		
						
					when 3..4, 7 # User   
						return if Graphics.frame_count % (e.aggressiveness * 100) != 0
						next if e.hp > skill.power.abs
						#Animate the enemy
						e.event.animation_id = skill.animation1_id
						animate(e.event, e.event.character_name+"_cast") if @enemy_ani
						e.effect_skill(e, skill)
						e.sp -= skill.sp_cost
						e.event.animation_id = skill.animation2_id
						return
					end
					return
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Update Player  단축키를 이용하여 스킬을 사용한다.
		#--------------------------------------------------------------------------
		def update_player
			if not Hwnd.include?("NetPartyInv") and not Hwnd.include?("Trade")# 파티 초대, 교환 창이 켜지지 않았다면?
				if not $map_chat_input.active # 채팅이 활성화 된게 아니라면
					#Keep the current party leader updated
					@actor = $game_party.actors[0]
					# 스킬 딜레이 갱신
					for skill_mash in SKILL_MASH_TIME
						if skill_mash[1][1] > 0
							skill_mash[1][1] -= 1 
							if skill_mash[1][1] == 0
								$console.write_line("#{$data_skills[skill_mash[0]].name} 딜레이 끝")
							end
						end
					end
					
					# 버프 지속시간 갱신
					for skill_mash in SKILL_BUFF_TIME
						if skill_mash[1][1] > 0
							skill_mash[1][1] -= 1 
							if skill_mash[1][1] == 0
								$console.write_line("#{$data_skills[skill_mash[0]].name} 끝")
								$game_switches[skill_mash[1][2]] = true
							end
						end
					end
					
					#Update click time
					@button_mash -= 1 if @button_mash > 0
					return if @button_mash > 0
					# 공격키가 눌렸니?
					if Input.trigger?(@attack_key)
						#Check State Effect
						if STATE_EFFECTS
							for id in $game_party.actors[0].states
								# 만약 죽은 상태면 공격 못함
								return if STUN_EFFECT.include?(id) or PARALAYZE_EFFECT.include?(id)
							end
						end
						return player_range if RANGE_WEAPONS.has_key?(@actor.weapon_id)
						return player_melee
					end
					# 적이 없다면 무시
					#~ return if @enemies == {}
					# 아이템 단축키 눌렸니?
					check_item
					
					# 만약 스킬 사용 불가 지역이면 콘솔로 말하고 무시
					# 스킬 단축키가 눌렸니?
					for key in @skill_keys.keys
						next if @skill_keys[key] == nil or @skill_keys[key] == 0
						next if !Input.trigger?(key)
						
						if $game_switches[352] == true
							$console.write_line("스킬 사용 불가 지역입니다.")
							return
						end
						
						if STATE_EFFECTS
							for i in $game_party.actors[0].states
								# 상태 이상이면 사용 못함
								return if STUN_EFFECT.include?(i) or PARALAYZE_EFFECT.include?(i) or MUTE_EFFECT.include?(i)
							end
						end
						# 스킬 아이디 가져옴
						id = @skill_keys[key]
						
						# 아직 스킬 딜레이가 남아있다면 무시
						skill_mash = SKILL_MASH_TIME[id]
						if skill_mash != nil and skill_mash[1]/60.0 > 0
							$console.write_line("딜레이가 남아있습니다. #{'%.1f' % (skill_mash[1]/60.0)}초")
							return
						end
						
						# 아직 버프가 지속중이면 무시
						skill_mash = SKILL_BUFF_TIME[id]
						if skill_mash != nil and skill_mash[1]/60.0 > 0
							$console.write_line("이미 걸려있습니다. #{'%.1f' % (skill_mash[1]/60.0)}초 남음")
							return
						end
						
						if RANGE_EXPLODE.has_key?(id)
							$e_v = 0 # enemy_value, 맞출 적의 수
							return player_explode(id)
						else
							$e_v = 0 # enemy_value, 맞출 적의 수
							return player_skill(id)
						end
					end
					
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Check Item  아이탬 단축키를 이용해서 사용할 경우
		#--------------------------------------------------------------------------
		def check_item
			if not Hwnd.include?("NetPartyInv")
				if not $map_chat_input.active
					#Check for item usage
					for key in @item_keys.keys
						# 해당 키에 등록된 아이템이 없으면 무시
						next if @item_keys[key] == nil or @item_keys[key] == 0
						next if !Input.trigger?(key)
						# 죽으면 당연히 못씀
						if STATE_EFFECTS
							for i in $game_party.actors[0].states
								return if STUN_EFFECT.include?(i)
							end
						end
						# 아이템데이터 가져옴
						item = $data_items[@item_keys[key]]
						# 사용 못하는 아이템이면 못쓴다고 효과음 내고 무시
						return $game_system.se_play($data_system.buzzer_se) if !$game_party.item_can_use?(item.id)
						# 아이템이 없으면 무시
						return $game_system.se_play($data_system.buzzer_se) if $game_party.item_number(item.id) == 0
						# If effect scope is an ally
						if item.scope >= 3
							# Apply item use effects to target actor
							target = $game_party.actors[0]
							used = target.item_effect(item)
							# If an item was used
							if used
								#Show animation on player
								$game_player.animation_id = item.animation1_id 
								# Play item use SE
								$game_system.se_play(item.menu_se)
								# If consumable; Decrease used items by 1
								$game_party.lose_item(item.id, 1) if item.consumable
								# If all party members are dead; Switch to game over screen
								# If common event ID is valid; Common event call reservation
								return $game_temp.common_event_id = item.common_event_id if item.common_event_id > 0
								# If effect scope is other than an ally
							end
						else
							# 아이템이 1개 이상 있으면 사용
							# If command event ID is valid
							if item.common_event_id > 0
								# Command event call reservation
								$game_temp.common_event_id = item.common_event_id
								# Play item use SE
								$game_system.se_play(item.menu_se)
								# If consumable; Decrease used items by 1
								$game_party.lose_item(item.id, 1) if item.consumable
							end
						end
					end
				end
			end
		end
		#--------------------------------------------------------------------------
		# * 캐릭터의 범위 무기
		#--------------------------------------------------------------------------
		def player_range
			#Get the weapon
			w = RANGE_WEAPONS[@actor.weapon_id]
			#Return if the ammo isn't there
			return if w[3] != 0 and $game_party.item_number(w[3]) == 0
			$game_player.animation_id = $data_weapons[@actor.weapon_id].animation1_id
			#Add mash time
			@button_mash = (w[5] == nil ? MASH_TIME*10 : w[5]*10)
			#Delete an ammo
			$game_party.lose_item(w[3], 1) if w[3] != 0
			#Make the attack
			@range.push(Game_Ranged_Weapon.new($game_player, @actor, @actor.weapon_id))
			#Animate
			return if w[7] == nil
			animate($game_player, $game_player.character_name+w[7].to_s) if @player_ani
			return
		end
		#--------------------------------------------------------------------------
		# * 캐릭터의 밀리 공격(때리는거)
		#--------------------------------------------------------------------------
		def player_melee(sw = false) # 왠지 여기서 때리는 모션 만들 수 있을 듯?
			# 무기를 안꼈으면 공격 못함
			return if $data_weapons[@actor.weapon_id] == nil
			#Get all enemies
			# m은 무기 각 공격 딜레이를 말함, 만약 없으면 기본 공격속도
			m = MELEE_CUSTOM[@actor.weapon_id]
			if m != nil and m[0] != nil
				@button_mash = m[0]*10
			else
				@button_mash = MASH_TIME*10
			end
			
			if sw
				@button_mash = MASH_TIME*6 
			end
			
			Audio.se_play("Audio/SE/무기001-검")
			Network::Main.socket.send "<27>@ani_map = #{$game_map.map_id}; @ani_number = 191; @ani_id = #{Network::Main.id};</27>\n"
			
			for e in @enemies.values
				# 적이 없거나 적이 죽으면 공격 안함
				next if e == nil or e.dead?
				# 적이 캐릭터가 보는 방향에 없거나 바로 앞에 없으면 무시
				next if !in_direction?($game_player, e.event) or !in_range?($game_player, e.event, 1)
				# 때릴 수 없거나 아군이면 공격 못함
				next if !CAN_HURT_ALLY and e.hate_group.include?(0)
				# Show Weapon Aniamtion
				$game_player.animation_id = $data_weapons[@actor.weapon_id].animation1_id
				#Add mash time
				#Attack the enemy 적 공격
				e.attack_effect(@actor)
				#Get Animation 무기 공격 애니메이션
				a = $data_weapons[@actor.weapon_id].animation2_id
				#Hit enemy if the attack succeeds  몬스터에게 밀리 이미지
				if e.damage != "Miss" and e.damage != 0
					Audio.se_play("Audio/SE/타격")
					Network::Main.socket.send("<27>@ani_event = #{e.event.id}; @ani_number = #{a}; @ani_map = #{$game_map.map_id}</27>\n") 
				end
				#Return if the enemy is dead
				weapon_skill(@actor.weapon_id, e)
				return if enemy_dead?(e,@actor)
				return if !e.hate_group.include?(0)
				
				# 여기서 무기 격 넣기
				
				#~ #Set the new target for the enemy
				e.attacking = $game_player
				#~ #The enemy is now in battle
				e.in_battle = true
				#~ #Setup movement
				setup_movement(e)
			end
		end
		
		
		#==============================#
		#=====무기 격 설정 - 크랩훕흐======#
		#=============================#
		def weapon_skill(id, e)
			r = rand(100)
			case id
			when 114 # 주작의 검
				if r < 100
					e.damage = 1500
					e.hp -= 1500
				end
			end
		end
		
		
		#==============================#
		#=====스킬 딜레이 알려줌 - 크랩훕흐======#
		#=============================#
		def skill_console(id)
			
			skill_mash_time = SKILL_MASH_TIME[id]
			if skill_mash_time != nil and skill_mash_time[1] <= 0
				skill_mash_time[1] = skill_mash_time[0]
				# 스킬 딜레이 시작 메시지 표시
				$console.write_line("#{$data_skills[id].name} 딜레이 : #{skill_mash_time[0] / Graphics.frame_rate}초")
				$skill_Delay_Console.write_line(id)
			end
			
			
			skill_mash_time = SKILL_BUFF_TIME[id]
			if skill_mash_time != nil and skill_mash_time[1] <= 0
				skill_mash_time[1] = skill_mash_time[0]
				# 스킬 딜레이 시작 메시지 표시
				$console.write_line("#{$data_skills[id].name} 지속시간 : #{skill_mash_time[0] / Graphics.frame_rate}초")
				$skill_Delay_Console.write_line(id)
			end
		end
		
		def map_m(id, x, y)
			if $game_map.map_id != id
				$game_temp.player_transferring = true # 이동 가능
				$game_temp.player_new_map_id = id
				$game_temp.player_new_x = x
				$game_temp.player_new_y = y
			else
				$game_player.moveto(x, y)
			end
		end
		
		#==============================#
		#=====성황당 - 크랩훕흐===========#
		#=============================#
		def skill_sung
			case $game_variables[8]
			when 0 # 부여성
				map_m(17, 11, 8)
			when 1, 2 # 국내성
				map_m(135, 11, 7)				
			when 3 # 용궁
				map_m(204, 11, 8)
			when 4 # 고균도
				map_m(85, 11, 8)
			when 5 # 일본
				map_m(234, 11, 8)
			when 6 # 대방성
				map_m(17, 11, 8)
			end
		end
		
		
		#==============================#
		#=====비영사천문 - 크랩훕흐===========#
		#=============================#
		def skill_byung(d) # d : 방향, 0 : 동, 1 : 서, 2 : 남, 3: 북
			r = 4
			case $game_variables[8]
			when 0 # 부여성
				id = 1
				case d
				when 0
					map_m(id, 66 + rand(r), 33 + rand(r))
				when 1
					map_m(id, 5 + rand(r), 30 + rand(r))
				when 2
					map_m(id, 34 + rand(r), 68 + rand(r))
				when 3
					map_m(id, 34 + rand(r), 2 + rand(r))
				end
				
			when 1 # 국내성
				id = 123
				case d
				when 0
					map_m(id, 118 + rand(r), 60 + rand(r))
				when 1
					map_m(id, 7 + rand(r), 60 + rand(r))
				when 2
					map_m(id, 63 + rand(r), 109 + rand(r))
				when 3
					map_m(id, 63 + rand(r), 12 + rand(r))
				end
				
			when 2 # 12지신
				id = 110
				case d
				when 0
					map_m(id, 35 + rand(r), 16 + rand(r))
				when 1
					map_m(id, 1 + rand(r), 16 + rand(r))
				when 2
					map_m(id, 17 + rand(r), 33 + rand(r))
				when 3
					map_m(id, 17 + rand(r), 2 + rand(r))
				end
				
			when 3 # 용궁
				id = 203
				case d
				when 0
					map_m(id, 52, 23)
				when 1
					map_m(id, 4, 24)
				when 2
					map_m(id, 27, 43)
				when 3
					map_m(id, 29, 8)
				end
				
			when 4 # 고균도
				id = 60
				case d
				when 0
					map_m(id, 56 + rand(r), 33 + rand(r))
				when 1
					map_m(id, 4 + rand(r), 32 + rand(r))
				when 2
					map_m(id, 39 + rand(r), 57 + rand(r))
				when 3
					map_m(id, 29 + rand(r), 10 + rand(r))
				end
				
			when 5 # 일본
				id = 230
				case d
				when 0
					map_m(id, 114 + rand(r), 30 + rand(r))
				when 1
					map_m(id, 5 + rand(r), 31 + rand(r))
				when 2
					map_m(id, 64 + rand(r), 90 + rand(r))
				when 3
					map_m(id, 55 + rand(r), 2 + rand(r))
				end
				
			when 6 # 대방성
				id = 276
				case d
				when 0
					map_m(id, 113 + rand(r), 61 + rand(r))
				when 1
					map_m(id, 8 + rand(r), 61 + rand(r))
				when 2
					map_m(id, 61 + rand(r), 108 + rand(r))
				when 3
					map_m(id, 61 + rand(r), 10 + rand(r))
				end
				
			when 7
				case d
				when 0
					
				when 1
					
				when 2
					
				when 3
					
				end
				
			end	
		end
		
		#--------------------------------------------------------------------------
		# *  플레이어의 스킬 공격
		#--------------------------------------------------------------------------
		def player_skill(id)
			@actor = $game_party.actors[0]
			#Get Skill
			skill = $data_skills[id]
			# 단축키에 스킬이 없으면 실행 안됨
			return if skill == nil
			# 액터가 가지고 있는 스킬이 아님
			return if !@actor.skills.include?(skill.id)
			# 마력이 부족하면 무시
			if @actor.sp < skill.sp_cost
				$console.write_line("마력이 부족합니다.")
				return
			end
			# 엑터가 사용할 수 없는 상황이면 무시
			return if !@actor.can_use_skill?(skill) and skill.id != 8 #성황령은 죽을 때 사용하는 거니까 죽어서 사용할 수 있어야함
			
			id = skill.id 
			
			#Animate
			if SKILL_CUSTOM.has_key?(id)
				l = SKILL_CUSTOM[id]
				animate($game_player, $game_player.character_name+l[2].to_s) if @player_ani
			else
				animate($game_player, $game_player.character_name+"_cast") if @player_ani
			end
			# 스킬 아이디
			skill_console(id)
			
			#Activate Common Event
			if skill.common_event_id > 0
				# Common event call reservation
				$game_temp.common_event_id = skill.common_event_id
			end
			
			# 스킬 애니메이션 
			$game_player.animation_id = skill.animation1_id
			
			#Get the skill scope
			# 스킬 맞는 쪽
			case skill.scope
			when 0
				@actor.sp -= skill.sp_cost
				@button_mash = MASH_TIME*3
			when 1 #Enemy 적
				#If the skill is ranged
				if RANGE_SKILLS.has_key?(skill.id)
					
					#Add to range
					@range.push(Game_Ranged_Skill.new($game_player, @actor, skill))
					#Take off SP
					@actor.sp -= skill.sp_cost
					w = RANGE_SKILLS[id]
					#Add mash time
					@button_mash = (w[3] == nil ? MASH_TIME*10 : w[3]*10)
					return
				end
				
				if SKILL_CUSTOM[id] != nil
					@button_mash = (SKILL_CUSTOM[id] == nil ? MASH_TIME*10 : SKILL_CUSTOM[id] != nil and SKILL_CUSTOM[id][0] != nil ? SKILL_CUSTOM[id][0]*10 : MASH_TIME*10)
				else
					@button_mash = MASH_TIME*10
				end
				#If the skill is not ranged
				enemies = []
				#Get all enemies
				
				for enemy in @enemies.values
					next if enemy == nil
					next if !enemy.hate_group.include?(0) and !CAN_HURT_ALLY
					enemies.push(enemy)
				end
				e = $game_player
				#Order them from closest to the farthest
				enemies.sort! {|a,b|
					get_range(e.event,a.event) - get_range(e.event,b.event) }
				# Return if enemies = nil
				return if enemies[0] == nil
				
				# Attack the closest one
				enemies[0].effect_skill(@actor, skill)
				#Take off SP
				@actor.sp -= skill.sp_cost
				#Show Animetion on enemy
				hit_enemy(enemies[0], @actor, skill.animation2_id) if enemies[0].damage != "Miss" and enemies[0].damage != 0
				e = enemies[0]
				# 적이 스킬을 맞으면 점프함
				#jump(e.event, $game_player, SKILL_CUSTOM[id][1]) if SKILL_CUSTOM[id] != nil and e.damage != "Miss" and e.damage != 0
				#Return if enemy is dead 
				return if enemy_dead?(enemies[0],@actor)
				return if !enemy.hate_group.include?(0)
				#If its alive, put it in battle
				enemies[0].in_battle = true
				#Make it attack the player
				enemies[0].attacking = $game_player
				#Setup movement
				setup_movement(enemies[0])
				return
				
			when 2 #All Emenies 적 전체
				#Play the animation on player
				$game_player.animation_id = skill.animation2_id
				#Take off SP
				@actor.sp -= skill.sp_cost
				id = skill.id
				#If the skill is ranged
				if RANGE_SKILLS.has_key?(skill.id)
					enemies = get_all_range($game_player, RANGE_SKILLS[skill.id][0])
					w = RANGE_SKILLS[id]
					#Add mash time
					@button_mash = (w[3] == nil ? MASH_TIME*10 : w[3]*10) 
				else
					if SKILL_CUSTOM[id] != nil
						@button_mash = (SKILL_CUSTOM[id] == nil ? MASH_TIME*10 : SKILL_CUSTOM[id] != nil and SKILL_CUSTOM[id][0] != nil ? SKILL_CUSTOM[id][0]*10 : MASH_TIME*10)
					else
						@button_mash = MASH_TIME*10
					end
					enemies = @enemies
				end
				
				$alive_size = 0
				for e in enemies#.values
					#Skip NIL values
					next if e== nil
					#Skip 이미 적이 죽은거면 넘어가
					next if e.dead?
					# Skip if the enemy is an ally and can't hurt allies.
					next if !CAN_HURT_ALLY and e.hate_group.include?(0)
					$alive_size += 1
				end
				
				
				#Get all enemies
				for e in enemies#.values
					#Skip NIL values
					next if e== nil
					#Skip 이미 적이 죽은거면 넘어가
					next if e.dead?
					# Skip if the enemy is an ally and can't hurt allies.
					next if !CAN_HURT_ALLY and e.hate_group.include?(0)
					
					#Attack enemy
					e.effect_skill(@actor, skill)
					#Show Animetion on enemy
					hit_enemy(e, @actor, 0) if e.damage != "Miss" and e.damage != 0
					#jump(e.event, $game_player, SKILL_CUSTOM[id][1]) if SKILL_CUSTOM[id] != nil and e.damage != "Miss" and e.damage != 0
					#Skip this enemy if its dead
					next if enemy_dead?(e,@actor)
					next if !e.hate_group.include?(0)
					#If its alive, put it in battle
					e.in_battle = true
					#Make it attack the player
					e.attacking = $game_player
					#Setup movement
					setup_movement(e)
				end
				return
			when 3..4, 7 #User
				if SKILL_CUSTOM[id] != nil
					@button_mash = (SKILL_CUSTOM[id] == nil ? MASH_TIME*10 : SKILL_CUSTOM[id] != nil and SKILL_CUSTOM[id][0] != nil ? SKILL_CUSTOM[id][0]*10 : MASH_TIME*10)
				else
					@button_mash = MASH_TIME*10
				end
				#Use the skill on the player
				@actor.effect_skill(@actor, skill)
				#Take off SP
				@actor.sp -= skill.sp_cost
				#Play animation
				$game_player.animation_id = skill.animation2_id
				return
			end
		end
		#--------------------------------------------------------------------------
		# * Player Explode Attack  플레이어의 범위 공격
		#--------------------------------------------------------------------------
		def player_explode(id)
			#Get Skill
			skill = $data_skills[id]
			#Return if the skill doesn't exist
			return if skill == nil
			#Return if the actor doesn't have the skill
			return if !@actor.skills.include?(skill.id)
			#Return if the actor can't use the skill
			return if !@actor.can_use_skill?(skill)
			w = RANGE_EXPLODE[skill.id]
			# Show Animation
			$game_player.animation_id = skill.animation1_id
			#Add mash time
			@button_mash = (w[4] == nil ? MASH_TIME*10 : w[4]*10)
			
			skill_console(id)
			
			#Animate
			if SKILL_CUSTOM.has_key?(id)
				l = SKILL_CUSTOM[id]
				animate($game_player, $game_player.character_name+l[2].to_s) if @player_ani
			else
				animate($game_player, $game_player.character_name+"_cast") if @player_ani
			end
			#Add to range
			@range.push(Game_Ranged_Explode.new($game_player, @actor, skill))
			#Take off SP
			@actor.sp -= skill.sp_cost
			return
		end
		
		#--------------------------------------------------------------------------
		# * 적이 죽었니? (몹 또는 유저)
		#--------------------------------------------------------------------------
		def enemy_dead?(e,a)
			# e가 유저라면 유저 죽을 때 함수 반환
			return player_dead?(e,a) if e.is_a?(Game_Actor)
			#Return false if enemy dead
			return false if !e.dead?
			enemy = e
			treasure(enemy) if a != nil and a.is_a?(Game_Actor)
			# 적 유닛이 적을 죽이면 평상시로 돌아옴
			a.attacking = nil if a != nil and !a.is_a?(Game_Actor)
			a.in_battle = false if a != nil and !a.is_a?(Game_Actor)
			id = enemy.event_id
			#Remove from list 리스폰이 없으면 아예 지워버림
			@enemies.delete(id) if @enemies[id].respawn == 0
			event = enemy.event
			#여기다가 이 이벤트를 없애는 명령하기
			Network::Main.socket.send("<monster>#{$game_map.map_id},#{event.id},#{0},#{event.x},#{event.y},#{event.direction},#{enemy.respawn}</monster>\n")
			Network::Main.socket.send("<enemy_dead>#{id},#{event.id},#{$game_map.map_id},#{$npt}</enemy_dead>\n")
			case enemy.trigger[0]
			when 0
				
				event.fade = true if FADE_DEAD
				if !FADE_DEAD
					event.character_name = ""
					event.erase
				end
			when 1
				event.fade = true if FADE_DEAD
				print "EVENT " + event.id.to_s + "Trigger Not Set Right ~!" if enemy.trigger[1] == 0
				$game_switches[enemy.trigger[1]] = true
				$game_map.need_refresh = true
			when 2
				event.fade = true if FADE_DEAD
				print "EVENT " + event.id.to_s + "Trigger Not Set Right ~!" if enemy.trigger[1] == 0
				if enemy.trigger[2] == 0
					$game_variables[enemy.trigger[1]] += 1
					$game_map.need_refresh = true
				else
					$game_variables[enemy.trigger[1]] = enemy.trigger[2]
					$game_map.need_refresh = true
				end
			when 3 
				event.fade = true if FADE_DEAD
				value = "A" if enemy.trigger[1] == 1
				value = "B" if enemy.trigger[1] == 2
				value = "C" if enemy.trigger[1] == 3
				value = "D" if enemy.trigger[1] == 4
				print "EVENT " + event.id.to_s + "Trigger Not Set Right ~!" if value == 0
				key = [$game_map.map_id, event.id, value]
				$game_self_switches[key] = true
				$game_map.need_refresh = true
			end
			#Return true if the e is dead
			return true
		end
		#--------------------------------------------------------------------------
		# * Player Dead(Player,Enemy)
		#--------------------------------------------------------------------------
		def player_dead?(a,e)
			#Check State Effect
			if STATE_EFFECTS
				for id in $game_party.actors[0].states
					$game_player.movable = true if SLEEP_EFFECT.include?(id)
					$game_party.actors[0].states.delete(id) if SLEEP_EFFECT.include?(id)
				end
			end
			#return if the player is not dead
			return false if !a.dead?
			#If the player is dead;
			$console.write_line("죽었습니다.. 성황당에서 기원하십시오.")
			$cha_name = $game_party.actors[0].character_name
			$game_party.actors[0].set_graphic("죽음", 0, 0, 0)
			$game_party.actors[0].equip(0, 0)
			$game_party.actors[0].equip(1, 0)
			$game_party.actors[0].equip(2, 0)
			$game_party.actors[0].equip(3, 0)
			$game_party.actors[0].equip(4, 0)
			$scene = Scene_Map.new
			# 이때 모든 버프들을 지우자
			for skill_mash in SKILL_BUFF_TIME
				if skill_mash[1][1] > 0
					skill_mash[1][1] = 1 
				end
			end
			
			
			# 플레이어가 죽으면 몹들 다가가는거 멈춤
			e.in_battle = false if e != nil and !e.is_a?(Game_Actor)
			e.attacking = nil if e != nil and !e.is_a?(Game_Actor)
			#Game Over?
			if NEXT_LEADER and !$game_party.all_dead?
				#~ move_forward
			else
				revive_actor
			end
			return true
		end
		#--------------------------------------------------------------------------
		# * 몬스터를 잡았을 경우 주는것
		#--------------------------------------------------------------------------
		def treasure(enemy)
			exp = 0
			gold = 0
			treasures = []
			unless enemy.hidden
				# 경험치 이벤트!
				if $game_switches[1500] == true  
					exp += enemy.exp*2
				elsif
					$game_switches[1501] == true 
					exp += enemy.exp*3
				elsif
					$game_switches[1502] == true 
					exp += enemy.exp*5
				else
					exp += enemy.exp
				end
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
				if actor.cant_get_exp? == false # 경험치를 얻을 수 있는 상황
					last_level = actor.level
					if $netparty.size >= 2   # 파티중일경우 경험치, 돈의 습득
						Network::Main.socket.send("<nptgain>#{exp} #{gold} #{$npt} #{$game_map.map_id} #{enemy.event.id}</nptgain>\n")
					else
						$console.write_line("경험치:#{exp} 금전:#{gold}을 얻었습니다.")
						actor.exp += exp    #골드를 습득하는 경우 (파티 아닐때)
						$game_party.gain_gold(gold)
					end
					
					drop_enemy(enemy) # ABS monster item drop 파일 참조
					
					if actor.level > last_level    #레벨업을 하는 경우 (파티 아닐때)
						#~ 자동저장
						#~ $console.write_line("[정보]:레벨업!")
						#~ # 직업에 따라 체력, 마력 증가량 다르게 함
						#~ if(actor.class_id == 7) # 전사 99때 체력 4500
							#~ actor.maxhp += 16
							#~ actor.str += 2
						#~ elsif(actor.class_id == 2 or actor.class_id == 4) # 주술사, 도사 99때 마력 2000
							#~ actor.maxsp += 5
							#~ actor.int += 2
						#~ elsif(actor.class_id == 17) # 도적
							#~ actor.maxhp += 8
							#~ actor.dex += 2 # 손재주(명중률)
							#~ actor.agi += 2 # 민첩 (회피율)
						#~ end
						#~ # 풀체
						#~ actor.hp = actor.maxhp
						#~ actor.sp = actor.maxsp
						#~ $game_player.animation_id = 180
						#~ Network::Main.socket.send "<27>@ani_map = #{$game_map.map_id}; @ani_number = 180; @ani_id = #{Network::Main.id};</27>\n"
					end
				end
			end
			for item in treasures      #아이템 드롭
				case item
				when RPG::Item
					$game_party.gain_item(item.id, 1)
					$game_player.show_demage("습득 : #{item.name}",false)
				when RPG::Weapon
					$game_party.gain_weapon(item.id, 1)
					$game_player.show_demage("습득 :  #{item.name}",false)
				when RPG::Armor
					$game_party.gain_armor(item.id, 1)
					$game_player.show_demage("습득 :  #{item.name}",false)
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * Hit Enemy(Enemy) or (Player) 몬스터가 공격할 경우
		#--------------------------------------------------------------------------
		def hit_enemy(e,a,animation=nil)
			return if animation == 0
			# 나한테 적이 아니면 공격 안하게 함
			if a.is_a?(ABS_Enemy) and e.is_a?(Game_Actor)
				return if !a.hate_group.include?(0)
			end
			if a.is_a?(ABS_Enemy) and e.is_a?(ABS_Enemy)
				return if !a.hate_group.include?(e.id)
			end
			# Animate player
			# hit 애니메이션 재생
			animate(e,e.character_name+"_hit") if e.is_a?(Game_Player) and @player_ani
			# Animate Enemy
			animate(e.event, e.event.character_name+"_hit") if e.is_a?(ABS_Enemy) and @enemy_ani
			if animation == nil
				e.event.animation_id = a.animation2_id
				Network::Main.socket.send("<27>@ani_id = #{Network::Main.id}; @ani_number = #{e.event.animation_id}; @ani_map = #{$game_map.map_id}</27>\n")
			else
				e.event.animation_id = animation
			end
		end
		#--------------------------------------------------------------------------
		# * Jump
		#--------------------------------------------------------------------------
		def jump(object,attacker,plus)
			return if plus == nil
			n_plus = plus-(plus*2)
			d = attacker.direction
			# Calculate new pos
			new_x = (d == 6 ? plus : d == 4 ? n_plus : 0)
			new_y = (d == 2 ? plus : d == 8 ? n_plus : 0)
			# Jump
			object.jump_nt(new_x,new_y)
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
			enemies.push($game_player) if e.hate_group.include?(0) and in_range?(e.event, $game_player, e.see_range) or in_direction?(e.event, $game_player)
			if e.hate_group.size > 1 or (e.hate_group.size == 1 and !e.hate_group.include?(0))
				#Get the hate enemies
				for enemy in @enemies.values
					next if enemy == nil or enemy == e or !e.hate_group.include?(enemy.enemy_id) or
					!in_range?(e.event, enemy.event, e.see_range) or !in_direction?(e.event, enemy.event)
					#Insert in to the list if the enemy is in hate group
					enemies.push(enemy)
				end
			end
			#Return false if the list is nil or empty
			return false if enemies == nil or enemies == []    
			#Order the enemies
			if !e.closest_enemy
				#Order from hate points
				enemies.sort! {|a,b|
					e.hate_points[b.event_id] - e.hate_points[a.event_id] }
			else
				enemies.sort! {|a,b|
					get_range(e.event,a.event) - get_range(e.event,b.event) }
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
			#Set Speed
			e.event.move_speed = e.temp_speed
			#Set Frequency
			e.event.move_frequency = e.temp_frequency
			#Set Move Type
			e.temp_move_type = e.event.move_type
			e.event.move_type = 0
		end
		#--------------------------------------------------------------------------
		# * Restore the Movement Type(Enemy)
		#--------------------------------------------------------------------------
		def restore_movement(e)
			#Restore Speed
			e.temp_speed = e.event.move_speed
			#Restore Frequency
			e.temp_frequency = e.event.move_frequency
			#Restore Move Type
			e.event.move_type = e.temp_move_type
			e.temp_move_type = 0
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
					!in_range?(e.event, enemy.event, e.hear_range+d)
					#Insert in to the list if the enemy is in hate group
					enemies.push(enemy)
				end
			end
			#Return False
			return false if enemies == nil or enemies == []
			#Order the enemies
			if !e.closest_enemy
				#Order from hate points
				enemies.sort! {|a,b|
					e.hate_points[b.event_id] - e.hate_points[a.event_id] }
			else
				enemies.sort! {|a,b|
					get_range(e.event,a.event) - get_range(e.event,b.event) }
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
		def enemy_ally_in_battle?(enemy)
			#Start list
			allies = []
			#Get all allies
			for ally in @enemies.values
				#Skip NIL Value or value is in hate group
				next if ally == nil or enemy.hate_group.include?(ally.enemy_id)
				#Skip if the ally is not in_battle or the enemy can't see ally
				next if !ally.in_battle or !in_range?(enemy.event, ally.event, enemy.see_range)
				#Skip if the enemy can't hear ally
				next if !in_range?(enemy.event, ally.event, enemy.hear_range)
				#Skip if is player and can't be player
				next if ally.attacking == $game_player and !enemy.hate_group.include?(0)
				#Add to enemy attack list
				enemy.attacking = ally.attacking
				#Enemy is now in battle
				enemy.in_battle = true
				#Setup the movement
				setup_movement(enemy)
				#Return True
				return true
			end
			#Return False
			return false
		end
		#--------------------------------------------------------------------------
		# * Update Dash
		#--------------------------------------------------------------------------
		def update_dash
			return if @sneaking
			if Input.pressed?(DASH_KEY)
				#Check State Effect
				if STATE_EFFECTS
					for id in $game_party.actors[0].states
						return if CLUMSY_EFFECT.include?(id) or PARALAYZE_EFFECT.include?(id) or DELAY_EFFECT.include?(id)
					end
				end
				if $game_player.moving?
					@old_speed = $game_player.move_speed if !@dashing
					$game_player.character_name = "#{$game_player.character_name}#{DASH_ANIMATION}" if !@dashing and DASH_SHO_AN
					@dashing = true
					$game_player.move_speed = DASH_SPEED
					@dash_min -= 1
					if @dash_min <= 0
						@dashing = false
						$game_player.move_speed = 4
					end
				end
			elsif @dashing
				@dashing = false
				$game_player.move_speed = @old_speed if !@sneaking
				$game_player.character_name = $game_player.character_name.sub(/#{DASH_ANIMATION}/){} if DASH_SHO_AN
			else
				@dash_min += 1 if @dash_min < @dash_max
			end
		end
		#--------------------------------------------------------------------------
		# * Update Sneak
		#--------------------------------------------------------------------------
		def update_sneak
			return if @dashing
			if Input.pressed?(SNEAK_KEY)
				#Check State Effect
				if STATE_EFFECTS
					for id in $game_party.actors[0].states
						return if CLUMSY_EFFECT.include?(id) or PARALAYZE_EFFECT.include?(id) or DELAY_EFFECT.include?(id)
					end
				end
				if $game_player.moving?
					@old_speed = $game_player.move_speed if !@sneaking
					$game_player.character_name = "#{$game_player.character_name}#{SNEAK_ANIMATION}" if !@sneaking and SNEAK_SHO_AN
					@sneaking = true
					$game_player.move_speed = SNEAK_SPEED
					@sneak_min -= 1
					if @sneak_min <= 0
						@sneaking = false
						$game_player.move_speed = 4
					end
				end
			elsif @sneaking
				@sneaking = false
				$game_player.move_speed = @old_speed if !@dashing
				$game_player.character_name = $game_player.character_name.sub(/#{SNEAK_ANIMATION}/){} if SNEAK_SHO_AN
			else
				@sneak_min += 1 if @sneak_min < @sneak_max
			end
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
			@y += 1 if m == 2
			@x -= 1 if m == 4
			@x += 1 if m == 6
			@y -= 1 if m == 8
		end
		#--------------------------------------------------------------------------
		# * Update
		#-------------------------------------------------------------------------
		def update
			super
			return if @explosive
			#Return if moving
			return if moving?
			#Check if something is still here
			if @parent == nil or @actor == nil
				@stop = true
			end
			# Get new coordinates
			d = @move_direction
			new_x = @x + (d == 6 ? 1 : d == 4 ? -1 : 0)
			new_y = @y + (d == 2 ? 1 : d == 8 ? -1 : 0)
			return force_movement if $game_map.terrain_tag(new_x, new_y) == $ABS.PASS_TAG and no_one?
			m = @move_direction
			move_down if m == 2
			move_left if m == 4
			move_right if m == 6
			move_up if m == 8
			#Stop if it came to range
			return @stop = true if @step >= @range
			#Increase step
			@step += 1
		end
		#--------------------------------------------------------------------------
		# * No One
		#-------------------------------------------------------------------------
		def no_one?
			#Get All Events
			objects = {}
			for event in $game_map.events.values
				next if event == nil
				objects[event.id] = event
			end
			objects[0] = $game_player
			# Get new coordinates
			d = @move_direction
			new_x = @x + (d == 6 ? 1 : d == 4 ? -1 : 0)
			new_y = @y + (d == 2 ? 1 : d == 8 ? -1 : 0)
			#Get all pos
			for o in objects.values
				next if o == nil
				return false if o.x == new_x and o.y == new_y
			end
			#Return False if no one was found
			return true
		end
	end
	#============================================================================
	# * Game Ranged Explode
	#============================================================================
	class Game_Ranged_Explode < Range_Base
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(parent, actor, skill)
			super(parent,actor,skill)
			@range_skill = $ABS.RANGE_EXPLODE[skill.id]
			@range = @range_skill[0]
			@opacity = 10 if @range == 1
			@move_speed = @range_skill[1]
			@character_name = @range_skill[2]
			@skill = skill
			@explosive = true
		end
		#--------------------------------------------------------------------------
		# * Check Event Trigger Touch(x,y)
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			return
		end
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			super
			#Return if moving
			return if moving?
			#Check if something is still here
			if @parent == nil or @actor == nil
				@stop = true
			end
			# Get new coordinates
			d = @move_direction
			new_x = x + (d == 6 ? 1 : d == 4 ? -1 : 0)
			new_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
			return force_movement if $game_map.terrain_tag(new_x, new_y) == $ABS.PASS_TAG and no_one?
			#Stop if can't move
			return blow if !passable?(@x, @y, @move_direction)
			m = @move_direction
			move_down if m == 2
			move_left if m == 4
			move_right if m == 6
			move_up if m == 8
			#Stop if it came to range
			return blow if @step >= @range
			#Increase step
			@step += 1
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
			$alive_size = 0
			objects = []
			for e in $ABS.enemies.values
				#Skip NIL values
				next if e== nil
				#Skip 이미 적이 죽은거면 넘어가
				next if e.dead?
				# Skip if the enemy is an ally and can't hurt allies.
				next if !CAN_HURT_ALLY and e.hate_group.include?(0)
				if in_range?(element, e.event, range)
					$alive_size += 1				
					objects.push(e) 
				end
			end
			
			# 여기서 넷 플레이어인지 확인해야함
			for player in Network::Main.mapplayers.values
				next if player == nil
				if in_range?(element, player, range)
					hit_net_player(player)
				end
			end
			# 여기다가 개수 추가
			$alive_size = objects.size
			#~ objects.push($game_player) if in_range?(element, $game_player, range)
			return objects
		end
		#--------------------------------------------------------------------------
		# * Blow
		#--------------------------------------------------------------------------
		def blow
			#Stop
			@stop = true
			#Play Animation
			#Show animation on event
			self.animation_id = @skill.animation2_id
			@showing_ani = true
			#Get Everyone in Range of the Explosive Skill
			objects = get_all_range(self, @range_skill[3])
			#Hit Everyone
			hit_player if objects.include?($game_player)
			#Hit Enemies
			for e in objects
				next if e == nil or e == $game_player
				#Hit
				hit_event(e.event_id)
			end
		end
		
		#--------------------------------------------------------------------------
		# * Hit net_Player
		#--------------------------------------------------------------------------
		def hit_net_player(actor)
			@stop = true
			#Attack It's enemy
			#~ actor.effect_skill($game_party.actors[0], @skill)
			#Show animation on event
			
			# 해당 대상 애니메이션 재생하도록 보냄
			Network::Main.socket.send "<player_animation>@ani_map = #{$game_map.map_id}; @ani_number = #{@skill.animation2_id}; @ani_id = #{actor.netid};</player_animation>\n"
		end 
		
		
		#--------------------------------------------------------------------------
		# * Hit Player
		#--------------------------------------------------------------------------
		def hit_player
			@stop = true
			#Get Actor
			actor = $game_party.actors[0]
			#Get Enemy
			enemy = @actor
			#Attack Actor
			actor.effect_skill(enemy, @skill) if enemy != nil 
			
			$game_player.animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
			Network::Main.socket.send "<27>@ani_map = #{$game_map.map_id}; @ani_number = #{$game_player.animation_id}; @ani_id = #{Network::Main.id};</27>\n"
			#Jump
			#$ABS.jump($game_player,self,$ABS.RANGE_EXPLODE[@skill.id][5]) if actor.damage != "Miss" and actor.damage != 0
			#Check if enemy is dead
			$ABS.enemy_dead?(actor, enemy)
		end  
		#--------------------------------------------------------------------------
		# * Object Initialization 요기
		#--------------------------------------------------------------------------
		def hit_event(id)
			@stop = true
			#Get enemy
			actor = $ABS.enemies[id]
			
			#Return if actor has NIL value
			return if actor == nil or actor.hp == 0
			#If the parent is player
			if @parent.is_a?(Game_Player)
				#Get enemy
				enemy = $game_party.actors[0]
				#Attack It's enemy
				actor.effect_skill(enemy, @skill)
				#Show animation on event
				actor.event.animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
				#Jump
				e = actor
				#몬스터 대상의 애니매이션 공유
				Network::Main.socket.send("<27>@ani_event = #{actor.event.id}; @ani_number = #{@skill.animation2_id}; @ani_map = #{$game_map.map_id}</27>\n") if actor.damage != "Miss" and actor.damage != 0
				#$ABS.jump(e.event,self,$ABS.RANGE_EXPLODE[@skill.id][5]) if actor.damage != "Miss" and actor.damage != 0
				return if $ABS.enemy_dead?(actor, enemy)
				return if !actor.hate_group.include?(0)
				#Put enemy in battle
				actor.in_battle = true
				actor.attacking = $game_player
				$ABS.setup_movement(actor)
				return
			end
			#Get enemy
			enemy = $ABS.enemies[@parent.id]
			return if enemy == nil
			#Attack It's enemy
			actor.effect_skill(enemy, @skill)
			#Show animation on event
			actor.event.animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
			#몬스터 대상의 애니매이션 공유
			Network::Main.socket.send("<27>@ani_event = #{actor.event.id}; @ani_number = #{@skill.animation2_id}; @ani_map = #{$game_map.map_id}</27>\n") if actor.damage != "Miss" and actor.damage != 0
			#Jump
			e=actor
			#$ABS.jump(e.event,self,$ABS.RANGE_EXPLODE[@skill.id][5]) if actor.damage != "Miss" and actor.damage != 0
			#return if enemy is dead
			return if $ABS.enemy_dead?(actor, enemy)
			return if !actor.hate_group.include?(enemy.enemy_id)
			actor.in_battle = true
			actor.attacking = enemy
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
		def initialize(parent, actor, skill)
			super(parent,actor,skill)
			@range_skill = $ABS.RANGE_SKILLS[skill.id]
			@range = @range_skill[0]
			@opacity = 20 if @range == 1
			@move_speed = @range_skill[1]
			@character_name = @range_skill[2]
			@skill = skill
		end
		#--------------------------------------------------------------------------
		# * Check Event Trigger Touch(x,y)
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			return if @stop
			hit_player if x == $game_player.x and y == $game_player.y
			
			# 여기서 넷 플레이어인지 확인해야함
			for player in Network::Main.mapplayers.values
				next if player == nil
				if player.x == x and player.y == y
					hit_net_player(player)
				end
			end
			
			for event in $game_map.events.values
				if event.x == x and event.y == y
					if event.character_name == "" or ($ABS.enemies[event.id] != nil and $ABS.enemies[event.id].dead?) or event.erased
						force_movement
					else
						hit_event(event.id)
					end
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# * Hit net_Player
		#--------------------------------------------------------------------------
		def hit_net_player(actor)
			@stop = true
			#Attack It's enemy
			#~ actor.effect_skill($game_party.actors[0], @skill)
			#Show animation on event
			
			# 해당 대상 애니메이션 재생하도록 보냄
			Network::Main.socket.send "<player_animation>@ani_map = #{$game_map.map_id}; @ani_number = #{@skill.animation2_id}; @ani_id = #{actor.netid};</player_animation>\n"
		end 
		
		
		#--------------------------------------------------------------------------
		# * Hit Player
		#--------------------------------------------------------------------------
		def hit_player
			@stop = true
			#Get Actor
			actor = $game_party.actors[0]
			#Get Enemy
			enemy = @actor
			return if enemy == nil
			#Attack Actor
			# 만약 내게 호의적인 적이라면 무시
			if enemy.is_a?(ABS_Enemy) and actor.is_a?(Game_Actor)
				return if !enemy.hate_group.include?(0)
			end
			actor.effect_skill(enemy, @skill)
			#Show animation on player
			$game_player.animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
			Network::Main.socket.send "<27>@ani_map = #{$game_map.map_id}; @ani_number = #{$game_player.animation_id}; @ani_id = #{Network::Main.id};</27>\n"
			
			#Jump
			#$ABS.jump($game_player,self,@range_skill[4]) if actor.damage != "Miss" and actor.damage != 0
			#Check if enemy is dead
			$ABS.enemy_dead?(actor, enemy)
		end  
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def hit_event(id)
			@stop = true
			#Get enemy
			actor = $ABS.enemies[id]
			#Return if actor has NIL value
			return if actor == nil
			#If the parent is player
			if @parent.is_a?(Game_Player)
				#Get enemy
				enemy = $game_party.actors[0]
				# 만약 내게 호의적인 적이라면 무시
				if actor.is_a?(ABS_Enemy) and enemy.is_a?(Game_Actor)
					return if !actor.hate_group.include?(0)
				end
				#Attack It's enemy
				actor.effect_skill(enemy, @skill)
				
				if @skill.id == 138
					$rpg_skill.비영승보(x, y, @move_direction)
				end
				
				#Show animation on event
				@enani = actor.event
				#몬스터 대상의 애니매이션 공유
				Network::Main.socket.send("<27>@ani_event = #{@enani.id}; @ani_number = #{@skill.animation2_id}; @ani_map = #{$game_map.map_id}</27>\n") if actor.damage != "Miss" and actor.damage != 0
				#Jump
				return if $ABS.enemy_dead?(actor, enemy)
				return if !actor.hate_group.include?(0)
				#Put enemy in battle
				actor.in_battle = true
				actor.attacking = $game_player
				$ABS.setup_movement(actor)
				return
			end
			#Get enemy
			enemy = $ABS.enemies[@parent.id]
			return if enemy == nil
			# 적끼리 싸우는게 아니면 무시
			if enemy.is_a?(ABS_Enemy) and actor.is_a?(ABS_Enemy)
				return if !actor.hate_group.include?(enemy.id)
			end
			#Attack It's enemy
			actor.effect_skill(enemy, @skill)
			#Show animation on event
			actor.event.animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
			@enani = actor.event
			Network::Main.socket.send("<27>@ani_event = #{@enani.id}; @ani_number = #{@skill.animation2_id}; @ani_map = #{$game_map.map_id}</27>\n") if actor.damage != "Miss" and actor.damage != 0
			#Jump
			#$ABS.jump($game_map.events[id],self,@range_skill[4]) if actor.damage != "Miss" and actor.damage != 0
			#return if enemy is dead
			return if $ABS.enemy_dead?(actor, enemy)
			return if !actor.hate_group.include?(enemy.enemy_id)
			actor.in_battle = true
			actor.attacking = enemy
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
		def initialize(parent, actor, attack)
			super(parent,actor,attack)
			@range_weapon = $ABS.RANGE_WEAPONS[attack]
			@character_name = @range_weapon[0]
			@move_speed = @range_weapon[1]
			@range = @range_weapon[4]
		end
		#--------------------------------------------------------------------------
		# * Check Event Trigger Touch(x,y)
		#--------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			return if @stop
			hit_player if x == $game_player.x and y == $game_player.y
			for event in $game_map.events.values
				next if event.x != x or event.y != y
				if event.character_name == "" or ($ABS.enemies[event.id] != nil and $ABS.enemies[event.id].dead?) or event.erased
					force_movement
				else
					hit_event(event.id)
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Hit Player
		#--------------------------------------------------------------------------
		def hit_player
			@stop = true
			#Get Actor
			actor = $game_party.actors[0]
			#Get Enemy
			enemy = @actor
			#Attack Actor 적이 플레이어를 공격함
			actor.attack_effect(enemy)
			# 여기다가 플레이어 데미지 보여주기 하면 될듯?
			damage(actor.damage, actor.critical) if actor.damage != 0
			$game_player.show_demage(actor.damage, false)
			#Show animation on player
			$game_player.animation_id = @range_weapon[2] if actor.damage != "Miss" and actor.damage != 0
			#jump
			#$ABS.jump($game_player, self, @range_weapon[6]) if actor.damage != "Miss" and actor.damage != 0
			#Check if enemy is dead
			$ABS.enemy_dead?(actor, enemy)
		end  
		#--------------------------------------------------------------------------
		# * Object Initialization   범위 무기 ( 표창 같은거)
		#--------------------------------------------------------------------------
		def hit_event(id)
			@stop = true
			#Get enemy
			actor = $ABS.enemies[id]
			#Return if actor has NIL value
			return if actor == nil or actor.dead?
			#If the parent is player
			if @parent.is_a?(Game_Player)
				#Get enemy
				enemy = $game_party.actors[0]
				#Attack It's enemy
				actor.attack_effect(enemy)
				#Show animation on event
				actor.event.animation_id = @range_weapon[2] if actor.damage != "Miss" and actor.damage != 0
				#jump
				#$ABS.jump(actor.event, self, @range_weapon[6]) if actor.damage != "Miss" and actor.damage != 0
				return if $ABS.enemy_dead?(actor, enemy)
				return if !actor.hate_group.include?(0)
				#Put enemy in battle
				actor.in_battle = true
				actor.attacking = $game_player
				$ABS.setup_movement(actor)
				return
			end
			#Get enemy
			enemy = $ABS.enemies[@parent.id]
			#Attack It's enemy
			actor.attack_effect(enemy)
			#Show animation on event
			actor.event.animation_id = @skill.animation2_id if actor.damage != "Miss" and actor.damage != 0
			#$ABS.jump(actor.event, self, @range_weapon[6]) if actor.damage != "Miss" and actor.damage != 0
			#return if enemy is dead
			return if $ABS.enemy_dead?(actor, enemy)
			return if !actor.hate_group.include?(enemy.enemy_id)
			actor.in_battle = true
			actor.attacking = enemy
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
			def initialize(viewport = nil)
				super(viewport)
				@_whiten_duration = 0
				@_appear_duration = 0
				@_escape_duration = 0
				@_collapse_duration = 0
				@_collapse_erase_duration = 0
				@_damage_duration = 0
				@_animation_duration = 0
				@_blink = false
				@force_opacity = false
				@stop_animation = true
			end
			def update_animation
				if @_animation_duration > 0
					frame_index = @_animation.frame_max - @_animation_duration
					cell_data = @_animation.frames[frame_index].cell_data
					position = @_animation.position
					animation_set_sprites(@_animation_sprites, cell_data, position)
					for timing in @_animation.timings
						if timing.frame == frame_index
							animation_process_timing(timing, @_animation_hit)
						end
					end
				else
					@stop_animation = true
					dispose_animation
				end
			end
			def animation(animation, hit)
				@stop_animation = false
				dispose_animation
				@_animation = animation
				return if @_animation == nil
				@_animation_hit = hit
				@_animation_duration = @_animation.frame_max
				animation_name = @_animation.animation_name
				animation_hue = @_animation.animation_hue
				bitmap = RPG::Cache.animation(animation_name, animation_hue)
				if @@_reference_count.include?(bitmap)
					@@_reference_count[bitmap] += 1
				else
					@@_reference_count[bitmap] = 1
				end
				@_animation_sprites = []
				if @_animation.position != 3 or not @@_animations.include?(animation)
					for i in 0..15
						sprite = ::Sprite.new(self.viewport)
						sprite.bitmap = bitmap
						sprite.visible = false
						@_animation_sprites.push(sprite)
					end
					unless @@_animations.include?(animation)
						@@_animations.push(animation)
					end
				end
				update_animation
			end
			def stop_animation?
				return @stop_animation 
			end
			#-------------------------------------------------------------------------
			alias mrmo_abs_sprite_update_collapse update
			#-------------------------------------------------------------------------
			def update
				mrmo_abs_sprite_update_collapse # sprite의 업데이트
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
			def damage(value, critical)
				dispose_damage
				if value.is_a?(Numeric)
					damage_string = value.abs.to_s
				else
					damage_string = value.to_s
				end
				bitmap = Bitmap.new(160, 100)
				bitmap.font.name = $ABS.DAMAGE_FONT_NAME
				bitmap.font.size = $ABS.DAMAGE_FONT_SIZE
				bitmap.font.color = $ABS.DAMAGE_FONT_COLOR
				# draw_text(x, y, width, height, string, align)
				
				y = self.height / 20
				# 데미지 그림자
				bitmap.draw_text(-1, y-1, 160, 36, damage_string, 1)
				bitmap.draw_text(+1, y-1, 160, 36, damage_string, 1)
				bitmap.draw_text(-1, y+1, 160, 36, damage_string, 1)
				bitmap.draw_text(+1, y+1, 160, 36, damage_string, 1)
				# 폰트 칼라 색
				if value.is_a?(Numeric) and value < 0
					bitmap.font.color.set(176, 255, 144)
				else
					bitmap.font.color.set(255, 255, 255) # 흰색
				end
				
				bitmap.font.color.set(255, 0, 51) if critical # 빨간색 
				bitmap.font.color.set(255, 255, 255) if !critical # 흰색	
				bitmap.font.color.set(102, 255, 102) if critical.to_s == "heal" # 연두색
					
				bitmap.draw_text(0, y, 160, 36, damage_string, 1)	
				@_damage_sprite = ::Sprite.new(self.viewport)
				@_damage_sprite.bitmap = bitmap
				@_damage_sprite.ox = 80
				@_damage_sprite.oy = 20
				@_damage_sprite.x = self.x
				@_damage_sprite.y = self.y - self.oy
				@_damage_sprite.z = 3000
				@_damage_duration = 40
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
			# End every animation and update
			if @_collapse_erase_duration > 0
				@collapse_character.character_name = ""
				self.opacity = @character.opacity
				self.blend_type = @character.blend_type
				self.bush_depth = @character.bush_depth
				self.color.set(0, 0, 0, 0)
				@collapse_character.erase
				@_collapse_erase_duration = 0
			end
			dispose_loop_animation
			super
		end
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			if @_damage_duration <= 0 and @_damage_sprite != nil and !@_damage_sprite.disposed?
				dispose_damage
			end
			mrmo_abs_sc_update
			
			#Skip if no demage or dead;
			if !@character.is_a?(Game_Player) and $ABS.enemies[@character.id] != nil
				#Show State Animation
				id = @character.id
				if $ABS.enemies[id].damage == nil and $ABS.enemies[id].state_animation_id != @state_animation_id
					@state_animation_id = $ABS.enemies[id].state_animation_id
					loop_animation($data_animations[@state_animation_id])
				end
			elsif @character.is_a?(Game_Player)
				a = $game_party.actors[0]
				#Show State Animation
				if a.damage == nil and a.state_animation_id != @state_animation_id
					@state_animation_id = a.state_animation_id
					loop_animation($data_animations[@state_animation_id])
				end
			end
			#Check fade
			if @character.fade
				if @character.is_a?(Game_Event) and @character.page != @page
					@page = @character.page
				elsif @character.is_a?(Game_Event) or @character.is_a?(Game_Player)
					collapse_erase(@character)
				end
				@character.fade = false
			end
			if @character.is_a?(Game_Event) and @character.page != @page
				@page = @character.page
			end
			id = @character.id
			#if demage not displayed
			if $ABS.damage_display
				#Skip if no demage or dead;
				if !@character.is_a?(Game_Player) and $ABS.enemies[id] != nil
					#Display damage  #몬스터한태 데미지 표시        
					if $ABS.enemies[id].damage != nil
						damage($ABS.enemies[id].damage, $ABS.enemies[id].critical) 
						
						id2 = 0
						for i in $game_map.events.keys.sort
							break if i == id
							id2 += 1
						end
						# 몬스터 데미지 표시(맵 id, 몹 id, 데미지, 크리티컬)
						Network::Main.socket.send("<mon_damage>#{$game_map.map_id},#{id2},#{$ABS.enemies[id].damage},#{$ABS.enemies[id].critical}</mon_damage>\n")	
					end
					#Make Damage nil
					$ABS.enemies[id].damage = nil
				elsif @character.is_a?(Game_Player)					
					a = $game_party.actors[0]
					#Display damage
					if a.damage != nil
						damage(a.damage, a.critical) 
						# 사람 데미지 표시(맵 id, 네트워크 id, 데미지, 크리티컬)
						Network::Main.socket.send("<player_damage>#{$game_map.map_id},#{Network::Main.id},#{a.damage},#{a.critical}</player_damage>\n")	
					end
					#Make Damage nil
					a.damage = nil
				end
			end
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
		# * Character Sprite Initialization
		#--------------------------------------------------------------------------
		def init_characters
			mrmo_spriteset_map_init_characters
			# Make character sprites
			@ranged_sprites = []
			for range in $ABS.range
				#Skip NIL Values
				next if range == nil and !range.draw
				sprite = Sprite_Character.new(@viewport1, range)
				@ranged_sprites.push(sprite)
			end
		end
		#--------------------------------------------------------------------------
		# * Dispose
		#--------------------------------------------------------------------------
		def dispose
			# Dispose ranged sprites
			for range in @ranged_sprites
				#Skip NIL Values
				next if range == nil
				range.dispose
			end
			mrmo_spriteset_map_dispose
		end
		#--------------------------------------------------------------------------
		# * Update Character Sprites
		#--------------------------------------------------------------------------
		def update_character_sprites
			mrmo_spriteset_map_update_character_sprites
			# Update ranged sprites
			for range in @ranged_sprites
				#Skip NIL Values
				next if range == nil
				range.update
				#If its stop
				if range.character.stop and range.stop_animation?
					@ranged_sprites.delete(range)
					range.dispose
					$ABS.range.delete(range.character)
				elsif range.character.stop 
					range.character.character_name = ""
				end
			end
			# Draw Sprite
			for range in $ABS.range
				#Skip NIL Values
				next if range == nil and !range.draw
				#If its draw
				sprite = Sprite_Character.new(@viewport1, range)
				@ranged_sprites.push(sprite)
				range.draw = false
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
		#--------------------------------------------------------------------------
		alias mrmo_abs_gb_int initialize
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize
			mrmo_abs_gb_int
			@state_time = 0
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
			
			# If there's not enough SP, the skill cannot be used.
			return false if skill.sp_cost > self.sp
			# Unusable if incapacitated
			return false if dead?
			# If silent, only physical skills can be used
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
			if self.is_a?(ABS_Enemy) and attacker.is_a?(Game_Actor)
				return if !self.hate_group.include?(0)
			end
			# Clear critical flag
			self.critical = false
			# First hit detection
			hit_result = (rand(100) < attacker.hit)
			# If hit occurs
			if hit_result == true
				# Calculate basic damage
				atk = [(attacker.atk + attacker.str / 100)- (self.pdef * 2 / 5), 2].max
				self.damage = atk * (20 + attacker.str) / 20
				# Element correction
				self.damage *= elements_correct(attacker.element_set)
				self.damage /= 100
				self.damage = 1 if self.damage <= 0
				# If damage value is strictly positive
				if self.damage > 0
					# Critical correction
					# 여기다가 크리티컬 확률 높힐 수도 있음
					if rand(100) < 4 * attacker.dex / self.agi
						self.damage *= 2
						self.critical = true
					end
					# Guard correction
					if self.guarding?
						self.damage /= 2
					end
				end
				
				# Dispersion
				if self.damage.abs > 0
					amp = [self.damage.abs * 15 / 100, 1].max
					self.damage += rand(amp+1) + rand(amp+1) - amp
				end
				# Second hit detection
				# agi : 민첩 (회피율), dex : 손재주 (명중률)
				eva = [(8 * self.agi / attacker.dex + self.eva), 100].min
				hit = self.damage < 0 ? 100 : [100 - eva, 25].max
				hit = self.cant_evade? ? 100 : hit
				hit_result = (rand(100) < hit)
			end
			# If hit occurs
			if hit_result == true
				# State Removed by Shock
				remove_states_shock
				# Substract damage from HP
				
				if self.is_a?(Game_Actor) and attacker.is_a?(ABS_Enemy)
					if $game_player.direction == attacker.event.direction
						self.damage *= 2
					end
				elsif attacker.is_a?(Game_Actor) and self.is_a?(ABS_Enemy)
					if self.event.direction == $game_player.direction
						self.damage *= 2
					end
				end
				
				# 여기다가 사용자의 버프 상태에 따라 평타 공격력 증가 할 수 있음
				if attacker.is_a?(Game_Actor)
					if SKILL_BUFF_TIME[131][1] > 0 # 투명
						self.damage *= (4 + $game_variables[10]) # 투명 숙련도
						SKILL_BUFF_TIME[131][1] = 1
					end
					if SKILL_BUFF_TIME[134][1] > 0 # 분신
						self.damage *= 2 
					end
				end
				
				r = rand(100)
				if r <= (self.damage * 100 / self.maxhp) or r <= 30
					if !self.is_a?(Game_Actor)
						
						$ABS.enemies[self.event.id].aggro = true
						Network::Main.socket.send("<aggro>#{$game_map.map_id},#{self.event.id}</aggro>\n")
					end
				end
				
				self.hp -= self.damage
				# 맵 id, 몹id, 몹 hp, x, y, 방향, 딜레이 시간
				if !self.is_a?(Game_Actor)
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{self.hp},#{self.event.x},#{self.event.y},#{self.event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<hp>#{$game_map.map_id},#{self.event.id},#{self.hp}</hp>\n")
				end
				# State change
				@state_changed = false
				states_plus(attacker.plus_state_set)
				states_minus(attacker.minus_state_set)
				# When missing
			else
				# Set damage to "Miss"
				self.damage = "Miss"
				# Clear critical flag
				self.critical = false
			end
			# End Method
			return true
		end
		
		#--------------------------------------------------------------------------
		# * Apply Skill Effects
		#     user  : the one using skills (battler)
		#     skill : skill
		#--------------------------------------------------------------------------
		def effect_skill(user, skill)
			# 나한테 적이 아니면 공격 안하게 함
			if self.is_a?(ABS_Enemy) and user.is_a?(Game_Actor)
				return if !self.hate_group.include?(0)
			end
			if self.is_a?(ABS_Enemy) and user.is_a?(ABS_Enemy)
				return if !self.hate_group.include?(user.id)
			end
			# Clear critical flag
			self.critical = false
			# If skill scope is for ally with 1 or more HP, and your own HP = 0,
			# or skill scope is for ally with 0, and your own HP = 1 or more
			if ((skill.scope == 3 or skill.scope == 4) and self.hp == 0) or
				((skill.scope == 5 or skill.scope == 6) and self.hp >= 1)
				# End Method
				return false
			end
			# Clear effective flag
			effective = false
			# Set effective flag if common ID is effective
			effective |= skill.common_event_id > 0
			# First hit detection
			hit = skill.hit
			if skill.atk_f > 0
				hit *= user.hit / 100
			end
			
			# 스킬 명중률
			hit_result = (rand(10) < hit)
			# Set effective flag if skill is uncertain
			effective |= hit < 100
			
			# If hit occurs
			if hit_result == true
				# Calculate power
				power = 0
				
				# 여기서 헬파이어, 건곤대나이등 체력, 마력 비레해서 공격력 올리도록 하자
				case skill.id
					# 주술사 스킬
				when 44 # 헬파이어
					power += user.sp * 1.5
					user.sp = 0
				when 49 # 성려멸주
					power += user.maxsp / 8 + 80
					user.sp -= user.maxsp / 10
				when 52 # 성려멸주 1성
					power += user.maxsp / 7 + 100
					user.sp -= user.maxsp / 9
				when 53 # 삼매진화 
					power += user.sp * 2
					user.sp = 0
				when 56 # 성려멸주 2성
					power += user.maxsp / 6 + 120
					user.sp -= user.maxsp / 8
				when 57 # 삼매진화 1성
					power += user.sp * 2.5
					user.sp = 0
				when 58 # 지폭지술
					$e_v += 1
					power += user.sp * 2
					# 적들이 다 맞을때 마나를 0으로 만듦
					if $e_v == $alive_size
						user.sp = 0
					end
				when 68 # 폭류유성
					$e_v += 1
					power += (user.sp * 2) + (user.hp * 1) 
					# 적들이 다 맞을때 마나를 0으로 만듦
					if $e_v == $alive_size
						user.sp -= user.sp / 2
						user.hp -= user.hp / 2
					end	
				when 69 # 삼매진화 2성
					power += user.sp * 2.5
					$e_v += 1
					# 한 맵에 적들이 다 없을 때 체력을 0으로 만듦
					if $e_v == $alive_size
						user.sp = 0
					end
					
					# 전사스킬
				when 67 # 건곤대나이
					power += user.hp * 2 
					user.hp -= (user.hp / 3) * 2
				when 73 # 광량돌격
					power += user.maxhp * 1.5 
					user.hp -= user.maxhp / 6
					user.hp = 1 if user.hp <= 0 
				when 74 # 십리건곤
					power += user.maxhp / 8 + 10
					user.hp -= user.maxhp / 10
					user.hp = 1 if user.hp <= 0
				when 78 # 십리건곤 1성
					power += user.maxhp / 7 + 15
					user.hp -= user.maxhp / 9
					user.hp = 1 if user.hp <= 0
				when 79 # 동귀어진
					power += user.hp * 5
					user.hp -= user.hp - 10
				when 80 # 십리건곤 2성
					power += user.maxhp / 6 + 20
					user.hp -= user.maxhp / 8
					user.hp = 1 if user.hp <= 0
				when 101 # 백호참
					power += user.hp * 2.5
					user.hp -= user.hp / 2
				when 102 # 백리건곤 1성
					power += user.maxhp / 6 + 30
					user.hp -= user.maxhp / 7
					user.hp = 1 if user.hp <= 0
				when 103 # 어검술
					power += user.hp
					$e_v += 1
					# 한 맵에 적들이 다 없을 때 체력을 0으로 만듦
					if $e_v == $alive_size
						user.hp -= user.hp / 2
					end
					
				when 104 # 포효검황
					power += user.hp * 1.2
					$e_v += 1
					# 한 맵에 적들이 다 없을 때 체력을 0으로 만듦
					if $e_v == $alive_size
						user.hp -= user.hp / 3
						user.hp = 1 if user.hp <= 0
					end
				when 105 # 혈겁만파
					$e_v += 1
					power += (user.sp) + (user.hp * 2) + 100
					# 적들이 다 맞을때 마나를 0으로 만듦
					if $e_v == $alive_size
						user.sp = 0
						user.hp -= user.hp / 2
						user.hp = 1 if user.hp <= 0
					end		
					
					# 도적 스킬
				when 133 # 필살검무
					power += (user.hp * 1 + user.sp * 0.5).to_i
					user.hp -= (user.hp / 2) 
					user.sp = 0
				when 135 # 백호검무
					power += (user.hp * 1.5 + user.sp * 0.01).to_i
					user.hp -= (user.hp / 2) 	
				when 137 # 이기어검
					power += (user.hp * 1.6 + user.sp * 0.5).to_i
					user.hp -= (user.hp / 6) 
					user.sp -= user.sp / 2
					self.pdef -= 5
					self.mdef -= 5
				when 138 # 무형검
					power += (user.hp * 3 + user.sp * 0.5).to_i
					user.hp -= (user.hp / 2) 	
					user.sp -= user.sp / 2
				when 139 # 분혼경천
					$e_v += 1
					power += (user.sp) + (user.hp * 2) + 100
					# 적들이 다 맞을때 마나를 0으로 만듦
					if $e_v == $alive_size
						user.sp = 0
						user.hp -= user.hp / 2
						user.hp = 1 if user.hp <= 0
					end		
					
					# 도사스킬
				else
					power = skill.power + user.atk / 2 
				end				
				power = (power * (1.0 + user.atk / 150.0)).to_i
				if power > 0
					power -= self.pdef * [skill.pdef_f, 10].max / 200
					power -= self.mdef * skill.mdef_f / 100
					power = [power, 1].max
				end
				
				
				# Calculate rate
				rate = 20
				
				rate += (user.str * skill.str_f / 100)
				rate += (user.dex * skill.dex_f / 100)
				rate += (user.agi * skill.agi_f / 100)
				rate += (user.int * skill.int_f / 100)
				# Calculate basic damage
				self.damage = (power * rate / 20)
				# Element correction
				self.damage *= elements_correct(skill.element_set)
				self.damage /= 100
				# If damage value is strictly positive
				if self.damage > 0
					
					# Guard correction
					if self.guarding?
						self.damage /= 2
					end
				end
				
				
				if self.damage > 0
					self.damage = (self.damage/4) + ((self.damage * 3) / ([self.pdef / 30, 3].max + [self.mdef / 15, 1].max))
				end
				
				# Dispersion
				if skill.variance > 0 and self.damage.abs > 0
					amp = [self.damage.abs * skill.variance / 100, 1].max
					self.damage += rand(amp+1) + rand(amp+1) - amp
				end
				
				# Second hit detection
				eva = [(8 * self.agi / user.dex + self.eva), 100].min
				hit = self.damage < 0 ? 100 : [(100 - eva * skill.eva_f / 100), 25].max
				hit = self.cant_evade? ? 100 : hit
				hit_result = (rand(100) < hit)
				# Set effective flag if skill is uncertain
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
				
				r = rand(100)
				if r <= (self.damage * 100 / self.maxhp) or r <= 30
					if !self.is_a?(Game_Actor)
						
						self.aggro = true
						Network::Main.socket.send("<aggro>#{$game_map.map_id},#{self.event.id}</aggro>\n")
					end
				end
				
				
				# Substract damage from HP
				last_hp = self.hp
				self.hp -= self.damage
				
				# 맵 id, 몹id, 몹 hp, x, y, 방향, 딜레이 시간
				if !self.is_a?(Game_Actor)
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{self.hp},#{self.event.x},#{self.event.y},#{self.event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<hp>#{$game_map.map_id},#{self.event.id},#{self.hp}</hp>\n")
				end
				effective |= self.hp != last_hp
				# State change
				@state_changed = false
				effective |= states_plus(skill.plus_state_set)
				effective |= states_minus(skill.minus_state_set)
				
				# If power is 0
				if skill.power == 0
					# Set damage to an empty string
					self.damage = 1
					# If state is unchanged
					unless @state_changed
						# Set damage to "Miss"
						
						self.damage = "Miss"
					end
				end
				# If miss occurs
			else
				# Set damage to "Miss"
				
				self.damage = "Miss"
			end
			# End Method
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
		#--------------------------------------------------------------------------
		# * Jump
		#     x_plus : x-coordinate plus value
		#     y_plus : y-coordinate plus value
		#--------------------------------------------------------------------------
		def jump_nt(x_plus, y_plus)
			# Calculate new coordinates
			new_x = @x + x_plus
			new_y = @y + y_plus
			# If plus value is (0,0) or jump destination is passable
			if (x_plus == 0 and y_plus == 0) or passable?(new_x, new_y, 0)
				# Straighten position
				straighten
				# Update coordinates
				@x = new_x
				@y = new_y
				# Calculate distance
				distance = Math.sqrt(x_plus * x_plus + y_plus * y_plus).round
				# Set jump count
				@jump_peak = 10 + distance - @move_speed
				@jump_count = @jump_peak * 2
				# Clear stop count
				@stop_count = 0
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
		
		#--------------------------------------------------------------------------
		# * Move Down
		#     turn_enabled : a flag permits direction change on that spot
		#--------------------------------------------------------------------------
		def move_down(turn_enabled = true, is_ok = false) # is_ok : 이동 가능
			if !self.is_a?(Game_Ranged_Skill) and !self.is_a?(Game_Ranged_Explode) and $ABS.enemies[self.event.id] != nil and !$ABS.enemies[self.event.id].aggro
				return if !is_ok
			end
			# Turn down
			if turn_enabled
				turn_down
			end
			# If passable
			if passable?(@x, @y, 2)
				# Turn down
				turn_down
				# Update coordinates
				@y += 1
				# Increase steps
				increase_steps
				# If impassable
				# 이때 계속 몹 정보 보내주면?
				
				if !self.is_a?(Game_Ranged_Skill) and !self.is_a?(Game_Ranged_Explode) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{$ABS.enemies[self.event.id].hp},#{self.x},#{self.y},#{$ABS.enemies[self.event.id].event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<mon_move>#{$game_map.map_id},#{self.event.id},1,#{self.x},#{self.y}</mon_move>\n")
				end
			else
				# Determine if touch event is triggered
				check_event_trigger_touch(@x, @y+1)
			end
		end
		#--------------------------------------------------------------------------
		# * Move Left
		#     turn_enabled : a flag permits direction change on that spot
		#--------------------------------------------------------------------------
		def move_left(turn_enabled = true, is_ok = false)		
			if !self.is_a?(Game_Ranged_Skill) and !self.is_a?(Game_Ranged_Explode) and $ABS.enemies[self.event.id] != nil and !$ABS.enemies[self.event.id].aggro
				return if !is_ok
			end	
			# Turn left
			if turn_enabled
				turn_left
			end
			# If passable
			if passable?(@x, @y, 4)
				# Turn left
				turn_left
				# Update coordinates
				@x -= 1
				# Increase steps
				increase_steps
				# If impassable
				# 이때 계속 몹 정보 보내주면?
				if !self.is_a?(Game_Ranged_Skill) and !self.is_a?(Game_Ranged_Explode) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{$ABS.enemies[self.event.id].hp},#{self.x},#{self.y},#{$ABS.enemies[self.event.id].event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<mon_move>#{$game_map.map_id},#{self.event.id},2,#{self.x},#{self.y}</mon_move>\n")
				end
			else
				# Determine if touch event is triggered
				check_event_trigger_touch(@x-1, @y)
			end
		end
		#--------------------------------------------------------------------------
		# * Move Right
		#     turn_enabled : a flag permits direction change on that spot
		#--------------------------------------------------------------------------
		def move_right(turn_enabled = true, is_ok = false)
			if !self.is_a?(Game_Ranged_Skill) and !self.is_a?(Game_Ranged_Explode) and $ABS.enemies[self.event.id] != nil and !$ABS.enemies[self.event.id].aggro
				return if !is_ok
			end
			# Turn right
			if turn_enabled
				turn_right
			end
			# If passable
			if passable?(@x, @y, 6)
				# Turn right
				turn_right
				# Update coordinates
				@x += 1
				# Increase steps
				increase_steps
				# If impassable
				# 이때 계속 몹 정보 보내주면?
				if !self.is_a?(Game_Ranged_Skill) and !self.is_a?(Game_Ranged_Explode) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{$ABS.enemies[self.event.id].hp},#{self.x},#{self.y},#{$ABS.enemies[self.event.id].event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<mon_move>#{$game_map.map_id},#{self.event.id},3,#{self.x},#{self.y}</mon_move>\n")
				end
			else
				# Determine if touch event is triggered
				check_event_trigger_touch(@x+1, @y)
			end
		end
		#--------------------------------------------------------------------------
		# * Move up
		#     turn_enabled : a flag permits direction change on that spot
		#--------------------------------------------------------------------------
		def move_up(turn_enabled = true, is_ok = false)
			if !self.is_a?(Game_Ranged_Skill) and !self.is_a?(Game_Ranged_Explode) and $ABS.enemies[self.event.id] != nil and !$ABS.enemies[self.event.id].aggro
				return if !is_ok
			end
			# Turn up
			if turn_enabled
				turn_up
			end
			# If passable
			if passable?(@x, @y, 8)
				# Turn up
				turn_up
				# Update coordinates
				@y -= 1
				# Increase steps
				increase_steps
				# If impassable
				# 이때 계속 몹 정보 보내주면?
				if !self.is_a?(Game_Ranged_Skill) and !self.is_a?(Game_Ranged_Explode) and $ABS.enemies[self.event.id] != nil and $ABS.enemies[self.event.id].aggro
					Network::Main.socket.send("<monster>#{$game_map.map_id},#{self.event.id},#{$ABS.enemies[self.event.id].hp},#{self.x},#{self.y},#{$ABS.enemies[self.event.id].event.direction},#{$ABS.enemies[self.event.id].respawn}</monster>\n")
					Network::Main.socket.send("<mon_move>#{$game_map.map_id},#{self.event.id},4,#{self.x},#{self.y}</mon_move>\n")
				end
			else
				# Determine if touch event is triggered
				check_event_trigger_touch(@x, @y-1)
			end
		end
		
		#--------------------------------------------------------------------------
		# * Move at Random
		#--------------------------------------------------------------------------
		def move_random()
			if !self.is_a?(Game_Ranged_Skill) and !self.is_a?(Game_Ranged_Explode) and $ABS.enemies[self.event.id] != nil and !$ABS.enemies[self.event.id].aggro
				return true
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
		attr_accessor :actor
		attr_accessor :respawn
		attr_accessor :aggro
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(enemy_id)
			super()
			# 보스 최대 체력, 경험치등 정할 수 있음
			$data_enemies[102].maxhp = 4000000 # 반고
			$data_enemies[159].maxhp = 2000000 # 거북장군
			
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
			@actor = self
			@respawn = 0
			@aggro = $is_map_first
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
	#==============================================================================
	# ** Scene_Skill
	#------------------------------------------------------------------------------
	#  This class performs skill screen processing.
	#==============================================================================
	class Scene_Skill
		#--------------------------------------------------------------------------
		alias mrmo_moabs_scene_skill_main main
		alias mrmo_moabs_scene_skill_update update
		alias mrmo_moabs_scene_skill_update_skill update_skill
		#--------------------------------------------------------------------------
		# * Main Processing
		#--------------------------------------------------------------------------
		def main
			@shk_window = Window_Command.new(250, [$ABS.HOTKEY_SAY.to_s])
			@shk_window.visible = false
			@shk_window.active = false
			@shk_window.x = 200
			@shk_window.y = 250
			@shk_window.z = 1500
			mrmo_moabs_scene_skill_main  
			@shk_window.dispose
		end
		#--------------------------------------------------------------------------
		# * Frame Update
		#--------------------------------------------------------------------------
		def update 
			@shk_window.update if @shk_window.active
			mrmo_moabs_scene_skill_update
			return update_shk if @shk_window.active
		end
		#--------------------------------------------------------------------------
		# * Frame Update (if skill window is active)   핫키에 스킬을 추가
		#--------------------------------------------------------------------------
		def update_skill
			mrmo_moabs_scene_skill_update_skill
			#Get all the keys
			for key in $ABS.skill_keys.keys
				#Check is the the key is pressed
				next if !Input.trigger?(key)
				#Play decision
				
				
				$game_system.se_play($data_system.decision_se)
				#Record Skill
				$ABS.skill_keys[key] = @skill_window.skill.id
				$ABS.item_keys[key] = 0
				
				@skill_window.active = false
				@shk_window.active = @shk_window.visible = true
			end
		end
		#--------------------------------------------------------------------------
		# * Frame Update Skill Hot Key  핫키에 스킬을 추가
		#--------------------------------------------------------------------------
		def update_shk
			#Return if Enter isn't pressed
			return if !Input.trigger?(Input::C)
			#Play decision
			$game_system.se_play($data_system.decision_se)
			@shk_window.active = @shk_window.visible = false
			@skill_window.active = true
			$scene = Scene_Skill.new(@actor_index)
		end
	end
	#==============================================================================
	# ** Scene_Item
	#==============================================================================
	class Scene_Item
		#--------------------------------------------------------------------------
		alias mrmo_moabs_scene_item_main main
		alias mrmo_moabs_scene_item_update update
		alias mrmo_moabs_scene_item_update_item update_item
		#--------------------------------------------------------------------------
		# * Main Processing
		#--------------------------------------------------------------------------
		def main
			@ihk_window = Window_Command.new(250, [$ABS.HOTKEY_SAY.to_s])
			@ihk_window.visible = false
			@ihk_window.active = false
			@ihk_window.x = 200
			@ihk_window.y = 250
			@ihk_window.z = 1500
			mrmo_moabs_scene_item_main  
			@ihk_window.dispose
		end
		#--------------------------------------------------------------------------
		# * Frame Update
		#--------------------------------------------------------------------------
		def update
			@ihk_window.update if @ihk_window.active
			mrmo_moabs_scene_item_update
			return update_ihk if @ihk_window.active
		end
		#--------------------------------------------------------------------------
		# * Frame Update (if item window is active)  아이템 단축키에 추가
		#--------------------------------------------------------------------------
		def update_item
			mrmo_moabs_scene_item_update_item
			#Get all the keys
			for key in $ABS.item_keys.keys
				next if !@item_window.item.is_a?(RPG::Item) or @item_window.item.occasion == 3
				#Check is the the key is pressed
				next if !Input.trigger?(key)
				#Play decision
				$game_system.se_play($data_system.decision_se)
				#Record Item
				$ABS.item_keys[key] = @item_window.item.id
				$ABS.skill_keys[key] = 0
				@item_window.active = false
				@ihk_window.active = @ihk_window.visible = true
			end
		end
		#--------------------------------------------------------------------------
		# * Frame Update Item Hot Key   아이템 단축키에 추가
		#--------------------------------------------------------------------------
		def update_ihk
			#Return if Enter isn't pressed
			return if !Input.trigger?(Input::C)
			#Play decision
			$game_system.se_play($data_system.decision_se)
			@ihk_window.active = false
			@ihk_window.visible = false
			@item_window.active = true
			$scene = Scene_Item.new
		end
	end
	#--------------------------------------------------------------------------
	# * SDK End
	#--------------------------------------------------------------------------
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