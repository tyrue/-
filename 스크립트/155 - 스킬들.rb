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
UPGRADE_SKILL_ID[4]	= [74, 78, 80, 102] # 십리건곤
UPGRADE_SKILL_ID[5] = [131, 141, 142] # 투명
UPGRADE_SKILL_ID[6] = [49, 52, 56] # 성려멸주

# 0~15 : 도토리, 토끼고기, 사슴고기, 녹용
# 15~25 : 쥐고기, 박쥐고기, 뱀고기
# 25~35 : 웅담, 호랑이고기
# 35~45 : 여우고기, 산돼지, 숲돼지고기
# 45~55 : 짙은호랑이고기, 돼지의뿔
# 55~85 : 호박, 진호박
# 85~99 : 진호박, 불의혼, 불의결정

# 3 도토리, 74 토끼고기, 5 사슴고기, 6 녹용
REQ_SKILL_DATA = {}
# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
# 전사
REQ_SKILL_DATA[1] = 
[
	[7, 30, 10, 5, 3, 74], 		# 누리의기원
	[10, 10, 10, 26, 5, 6], 		# 누리의힘
	[13, 5, 10, 62, 7, 8], 		# 수심각도, 쇠고기, 돼지고기
	[18, 20, 20, 74, 9, 10], 		# 십리건곤
	[25, 15, 15, 63, 10, 104], 	# 반영대도
	[32, 15, 15, 64, 11, 12], 	# 십량분법
	[38, 10, 10, 65, 12, 50], 	# 뢰마도
	[42, 10, 10, 27, 19, 20], 	# 동해의기원
	[46, 20, 15, 66, 19, 20], 	# 신수둔각도
	
	[51, 20, 1, 67, 22, 59], 	# 건곤대나이
	[56, 20, 10, 140, 29, 30],		# 운기
	[62, 10, 10, 71, 29, 30], 	# 혼신의힘
	
	[67, 5, 5, 29, 29, 30], 		# 천공의기원
	[71, 20, 20, 72, 29, 30], 	# 구량분법
	[74, 10, 30, 73, 29, 30], 	# 광량돌격
	[81, 10, 25, 43, 29, 30], 		# 위태응기
	[84, 15, 15, 78, 29, 30],		# 십리건곤 1성
	[86, 10, 30, 75, 29, 30],		# 뢰마도 1성
	[90, 10, 3, 77, 30, 31], 		# 유비후타
	[94, 10, 3, 76, 30, 31], 		# 팔분량법
	[97, 3, 1, 80, 31, 37],			# 십리건곤 2성
	[99, 4, 4, 79, 99, 100],		# 동귀어진
	
]

# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
# 주술사
REQ_SKILL_DATA[2] = 
[
	[8, 30, 10, 5, 3, 74], # 누리의기원
	[10, 20, 20, 1, 5, 6], # 신수마법
	[12, 5, 10, 46, 7, 8], # 무장
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
	[99, 4, 4, 44, 99, 100] # 헬파이어
]

# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
# 도사
REQ_SKILL_DATA[3] = 
[
	[5, 30, 10, 5, 3, 74], 			# 누리의기원
	[10, 10, 10, 1, 5, 6], 			# 신수마법
	[12, 5, 10, 46, 7, 8], 		# 무장
	[15, 20, 20, 15, 9, 10], 		# 공력증강
	[20, 15, 15, 86, 10, 104], 	# 바다의희원
	[25, 15, 15, 96, 11, 12], 	# 지진
	[32, 10, 10, 47, 12, 50], 	# 보호
	[36, 10, 10, 81, 19, 20], 	# 동해의희원
	
	[42, 20, 15, 90, 19, 20], 	# 분량방법
	[48, 2, 10, 50, 28, 22], 		# 야수수금술
	[54, 20, 1, 83, 22, 59], 		# 천공의희원
	[61, 10, 10, 88, 29, 30], 	# 분량력법
	[67, 15, 15, 89, 29, 30], 		# 구름의희원
	[74, 10, 30, 92, 29, 30], 	# 공력주입
	[80, 15, 15, 93, 29, 30],		# 태양의희원
	[92, 30, 3, 95, 30, 31],		# 생명의희원
	[95, 3, 3, 94, 31, 37], 		# 금강불체 
	[99, 4, 4, 120, 99, 100] 		# 부활
]

# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
# 도적
REQ_SKILL_DATA[4] = 
[
	[8, 30, 10, 5, 3, 74], 			# 누리의기원
	[13, 15, 15, 26, 5, 6], 		# 누리의힘
	[15, 15, 15, 1, 9, 10], 		# 신수마법
	[20, 10, 20, 27, 10, 104], 	# 동해의기원
	[23, 15, 15, 130, 11, 12],  # 무영보법
	[27, 10, 20, 131, 11, 12], 	# 투명
	[30, 10, 10, 10, 12, 50], 	# 신수마법 1성
	[33, 20, 10, 132, 50, 19], 	# 비영승보
	[37, 10, 10, 16, 19, 20], 	# 신수마법 2성
	[45, 5, 15, 29, 28, 22], 	# 천공의기원
	
	[50, 20, 10, 140, 29, 30],		# 운기
	[56, 15, 5, 133, 29, 30], 	# 필살검무
	[64, 10, 15, 64, 29, 30], 	# 십량분법
	[70, 5, 5, 34, 29, 30], 		# 귀환
	[75, 15, 20, 141, 29, 30], 	# 투명 1성
	[80, 5, 5, 28, 29, 30], 	# 야수
	[81, 10, 25, 43, 29, 30], 		# 위태응기
	[88, 20, 3, 142, 30, 31], 	# 투명 2성
	[99, 4, 4, 134, 99, 100],	# 분신
]
# -------------END----------------- #

# ----------------------------------#
# ----- 몬스터 스킬 주문 외우는 데이터---------#
# ----------------------------------#
#															[[시간초, "주문", (색깔 타입), (애니메이션 id)], []...]
ABS_ENEMY_SKILL_CASTING = {}
ABS_ENEMY_SKILL_CASTING[151] = [[1, "멀리 날려주마!!!!"]] # 청룡의 포효
ABS_ENEMY_SKILL_CASTING[152] = [[1, "물러나라..!"]] # 현무의 포효
ABS_ENEMY_SKILL_CASTING[153] = [[0.5, "백호검무!!!!"]] # 백호검무
ABS_ENEMY_SKILL_CASTING[154] = [[2, "여의주의 힘을 받은 용이여..."], [2, "그대 이름은 청룡일지다..."], [2, "네 주인 이름으로 명하노니"], [1, "네 분노를 적에게 발산하라!"]] # 청룡마령참
ABS_ENEMY_SKILL_CASTING[155] = [[3, "암흑에 물들어라.."]] # 암흑진파
ABS_ENEMY_SKILL_CASTING[156] = [[2, "명계의 검은 용이여...!"], [1, "지금, 계약에 따라 소환될지어다!!"]] # 흑룡광포
ABS_ENEMY_SKILL_CASTING[158] = [[4, "지옥에서 불타버려라!!"]] # 지옥겁화
ABS_ENEMY_SKILL_CASTING[159] = [[2, "미천한 필멸자여.."], [1, "하늘 높은 줄 모르고 날뛰는구나.."], [0.5, "너의 나약함을 깨닫게 하리라!!"]] # 혈겁만파
ABS_ENEMY_SKILL_CASTING[160] = [[2, "바람처럼 나타나 그림자처럼 사라지리라..."], [2, "이 순간, 모든 것을 내 검 아래 휩쓸테니...!"], [0.5, "압도적인 힘에 절망하라!!"]] # 분혼경천
ABS_ENEMY_SKILL_CASTING[161] = [[2, "영원한 공허의 무수한 파편들이여.."], [2, "대지와 하늘의 연결을 허용하노니..."], [2, "지금 이 땅의 운명을 새로 써내려라!!!"]] # 폭류유성
# -------------END----------------- #

# ----------------------------------#
# ----- 직업별 승급 필요 체력, 마력---------#
# ----------------------------------#
NEED_ADVANCE_RESOURCE = {} # 각 요소는 승급시 필요 체/마
NEED_ADVANCE_RESOURCE[0] = [
	[5000, 5000], 
	[10000, 20000], 
	[30000, 70000], 
	[70000, 150000]] # 주술사

NEED_ADVANCE_RESOURCE[1] = [
	[7000, 3000], 
	[30000, 7000], 
	[80000, 12000], 
	[200000, 25000]] # 전사

NEED_ADVANCE_RESOURCE[2] = [
	[5000, 5000], 
	[10000, 10000], 
	[30000, 50000], 
	[60000, 100000]] # 도사

NEED_ADVANCE_RESOURCE[3] = [
	[7000, 3000], 
	[30000, 7000], 
	[80000, 12000], 
	[200000, 25000]] # 도적
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
	
	def initialize
		@base_str = 0
		@base_agi = 0
		@base_int = 0
		@base_dex = 0
		@player_base_move_speed = 3
	end
	
	def update_buff # 버프 지속 효과 (일정 주기마다 해야하는 것 등)
		sec = Graphics.frame_rate
		
		if check_buff(140) # 운기 중
			if !$game_player.moving?
				if (Graphics.frame_count % (sec) == 0)
					$game_party.actors[0].sp += $game_party.actors[0].maxsp * 0.12
					$game_player.ani_array.push(4)  
					Network::Main.ani(Network::Main.id, $game_player.animation_id) #애니메이션 공유
				end
			else
				SKILL_BUFF_TIME[140][1] = 1 # 운기 취소
			end
		end
		
		if check_buff(121) # 신령지익진
			if (Graphics.frame_count % (sec * 2) == 0)
				$game_player.ani_array.push(7)
				Network::Main.ani(Network::Main.id, $game_player.animation_id) #애니메이션 공유
			end
		end	
		
		if check_buff(122) # 신령지익진
			if (Graphics.frame_count % (sec * 2) == 0)
				$game_player.ani_array.push(8)
				Network::Main.ani(Network::Main.id, $game_player.animation_id) #애니메이션 공유
			end
		end
		
		if !$state_trans # 투명 풀기
			SKILL_BUFF_TIME[131][1] = 1 if check_buff(131)
			SKILL_BUFF_TIME[141][1] = 1 if check_buff(141)
			SKILL_BUFF_TIME[142][1] = 1 if check_buff(142)
		end
	end
	
	def check_speed_buff
		speed = 0
		speed += BUFF_SKILL[99][0][1] if check_buff(99) # 속도시약
		speed += BUFF_SKILL[136][0][1] if check_buff(136) # 파무쾌보
		return speed
	end
	
	
	# 파티 힐
	def party_heal(id, user = $game_party.actors[0])
		return if PARTY_HEAL_SKILL[id] == nil
		heal_v = 1
		heal_v = PARTY_HEAL_SKILL[id][0].to_i 
		
		# 커스텀
		case id
		when 92 # 공력주입
			heal_v = user.sp
		when 117 # 백호의희원
			heal_v = user.sp * 4
		when 120 # 부활
			$game_temp.common_event_id = 24
		end
		
		heal_v += (user.maxsp * 0.001) * (1.0 + user.atk / 100.0)
		heal_v = ((heal_v) * (1 + (user.int / 1000.0) + (user.maxsp / 100000.0))).to_i
		
		skill_cost_custom(user, id)
		
		user.damage = heal_v.to_s
		user.critical = "heal"
		user.hp += heal_v
		
		if $netparty.size >= 2 # 파티가 2인 이상이라면
			name = user.name
			Network::Main.socket.send("<partyhill>#{name} #{id.to_i} #{$npt} #{$game_map.map_id} #{heal_v}</partyhill>\n")	
		end
	end
	
	# 파티 버프
	def party_buff(id)
		is_party_buff = false
		is_party_buff = true if PARTY_BUFF_SKILL[id] != nil
		
		if is_party_buff
			ani_id = $data_skills[id].animation1_id # 스킬 사용 측 애니메이션 id
			$game_player.animation_id = ani_id
			Network::Main.ani(Network::Main.id, ani_id)
			
			if $netparty.size >= 2 # 파티가 2인 이상이라면
				name = $game_party.actors[0].name
				Network::Main.socket.send("<partyhill>#{name} #{id.to_i} #{$npt} #{$game_map.map_id} #{0}</partyhill>\n")	
			end
		end
	end
	
	# 자기 힐
	def heal(id, user = $game_party.actors[0])
		return if HEAL_SKILL[id] == nil
		heal_v = HEAL_SKILL[id][0].to_i 
		
		# 커스텀
		case id
		when 43 # 위태응기
			heal_v = user.sp * 2.1
			
			# 적 유닛 스킬
		when 157 # n퍼 회복
			heal_v = user.maxhp * 0.3
		end
		
		skill_cost_custom(user, id)
		heal_v += (user.maxhp * 0.005).to_i
		user.critical = "heal"
		user.damage = heal_v.to_s
		user.hp += heal_v
		return heal_v
	end
	
	# 이미 버프가 걸려있는지 확인
	def check_buff(id, actor = $game_party.actors[0])
		if actor == $game_party.actors[0]
			skill_mash = SKILL_BUFF_TIME[id]
			return (skill_mash != nil and skill_mash[1] > 0)
		else # 몬스터의 버프 확인
			return nil
		end
	end
	
	# 버프 사용
	def buff_active(id)
		buff(id) # 이게 버프 스킬인지 확인
		ani_id = $data_skills[id].animation1_id # 스킬 사용 측 애니메이션 id
		if ani_id != nil
			$game_player.animation_id = ani_id
			Network::Main.ani(Network::Main.id, ani_id)
		end
	end
	
	def buff(id)
		# 아직 버프가 지속중이면 무시
		skill_mash = SKILL_BUFF_TIME[id]
		return if skill_mash == nil
		time_now = skill_mash[1]
		$ABS.skill_console(id) # 스킬 표시
		return if time_now > 0
		
		if BUFF_SKILL[id] != nil
			for data in BUFF_SKILL[id]
				case data[0].to_s
				when "str" # 힘
					$game_party.actors[0].str += data[1].to_i
					@base_str += data[1].to_i
				when "dex" # 손재주
					$game_party.actors[0].dex += data[1].to_i
					@base_dex += data[1].to_i
				when "int" # 지력
					@base_int += data[1].to_i
					$game_party.actors[0].int += data[1].to_i
				when "agi" # 민첩
					$game_party.actors[0].agi += data[1].to_i
					@base_agi += data[1].to_i
				when "mdef" # 마법 방어
					$game_party.actors[0].mdef += data[1].to_i
				when "pdef" # 물리 방어
					$game_party.actors[0].pdef += data[1].to_i
					
					# 퍼센트
				when "per_str" # 힘
					base = $game_party.actors[0].take_base_str
					n = (base * (data[1].to_f - 1.0)).to_i
					data[2] = n
					$game_party.actors[0].str += n
					@base_str += n
				when "per_dex" # 손재주
					base = $game_party.actors[0].take_base_dex
					n = (base * (data[1].to_f - 1.0)).to_i
					data[2] = n
					$game_party.actors[0].dex += n
					@base_dex += n
				when "per_int" # 지력
					base = $game_party.actors[0].take_base_int
					n = (base * (data[1].to_f - 1.0)).to_i
					data[2] = n
					$game_party.actors[0].int += n
					@base_int += n
				when "per_agi" # 민첩
					base = $game_party.actors[0].take_base_agi
					n = (base * (data[1].to_f - 1.0)).to_i
					data[2] = n
					$game_party.actors[0].agi += n
					@base_agi += n
				when "per_mdef" # 마법 방어
					$game_party.actors[0].mdef *= data[1].to_f
				when "per_pdef" # 물리 방어
					$game_party.actors[0].pdef *= data[1].to_f
					
				when "com" # 커먼 이벤트
					$game_temp.common_event_id = data[1].to_i
					
				when "speed" # 속도 변경
					$game_player.move_speed += data[1]
					Network::Main.socket.send("<5>@move_speed = #{$game_player.move_speed};</5>\n")
					
				when "custom" # 자체 수정
					case id
					when 66  # 신수둔각도
						$game_variables[41] = $game_party.actors[0].weapon_id # 대충 현재 착용 했던 무기 아이디 저장
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
						
					when 131, 141, 142 # 투명
						self.투명
						
					when 134 # 분신
						$console.write_line("분신을 생성합니다.")
						
					when 140 # 운기
						$console.write_line("마력을 회복합니다.")
					else
						
					end
				end
			end
		end
	end
	
	
	def buff_del(id)
		if BUFF_SKILL[id] != nil
			for data in BUFF_SKILL[id]
				n = data[1]
				case data[0].to_s
				when "str" # 힘
					$game_party.actors[0].str -= n.to_i
					@base_str = [0, @base_str - n].max
				when "dex" # 손재주
					$game_party.actors[0].dex -= n.to_i
					@base_dex = [0, @base_dex - n].max
				when "int" # 지력
					$game_party.actors[0].int -= n.to_i
					@base_int = [0, @base_int - n].max
				when "agi" # 민첩
					$game_party.actors[0].agi -= n.to_i
					@base_agi = [0, @base_agi - n].max
				when "mdef" # 마법 방어
					$game_party.actors[0].mdef -= n.to_i
					$game_party.actors[0].mdef = 0 if $game_party.actors[0].mdef < 0
				when "pdef" # 물리 방어
					$game_party.actors[0].pdef -= n.to_i
					$game_party.actors[0].pdef = 0 if $game_party.actors[0].pdef < 0
					# 퍼센트
				when "per_str" # 힘
					n = 0
					if(data[2] != nil and data[2] != 0)
						n = data[2]
					else
						r = (data[1].to_f - 1.0)
						base = $game_party.actors[0].take_base_str
						n = base * (r / (1 + r))
					end
					$game_party.actors[0].str -= n
					@base_str = [0, @base_str - n].max
					
				when "per_dex" # 손재주
					n = 0
					if(data[2] != nil and data[2] != 0)
						n = data[2]
					else
						r = (data[1].to_f - 1.0)
						base = $game_party.actors[0].take_base_dex
						n = base * (r / (1 + r))
					end
					$game_party.actors[0].dex -= n
					@base_dex = [0, @base_dex - n].max
					
				when "per_int" # 지력
					n = 0
					if(data[2] != nil and data[2] != 0)
						n = data[2]
					else
						base = $game_party.actors[0].take_base_int
						r = (data[1].to_f - 1.0)
						n = base * (r / (1 + r))
					end
					$game_party.actors[0].int -= n 
					@base_int = [0, @base_int - n].max
					
				when "per_agi" # 민첩
					n = 0
					if(data[2] != nil and data[2] != 0)
						n = data[2]
					else
						base = $game_party.actors[0].take_base_agi
						r = (data[1].to_f - 1.0)
						n = base * (r / (1 + r))
					end
					$game_party.actors[0].agi -= n
					@base_agi = [0, @base_agi - n].max
					
				when "per_mdef" # 마법 방어
					$game_party.actors[0].mdef /= n
					$game_party.actors[0].mdef = 0 if $game_party.actors[0].mdef < 0
				when "per_pdef" # 물리 방어
					$game_party.actors[0].pdef /= n
					$game_party.actors[0].pdef = 0 if $game_party.actors[0].pdef < 0
				when "speed"	
					$game_player.move_speed -= n
					Network::Main.socket.send("<5>@move_speed = #{$game_player.move_speed};</5>\n")
					
				else
					case id
					when 28 # 야수
						$game_temp.common_event_id = 41
					when 35 # 비호
						$game_temp.common_event_id = 41
					when 50 # 야수금술
						$game_temp.common_event_id = 41
					when 66  # 신수둔각도
						$game_party.actors[0].equip(0, 0)
						$game_party.lose_weapon(1, 999)
						$game_party.lose_weapon(2, 999)
						$game_party.lose_weapon(3, 999)
						$game_party.lose_weapon(4, 999)
						Audio.se_play("Audio/SE/장비", $game_variables[13])
						
						$game_party.actors[0].equip(0, $game_variables[41]) if $game_switches[50] and $game_variables[41] > 0
						
					when 131, 141, 142 # 투명, 1, 2성
						$game_variables[9] = 1
						Network::Main.send_trans(false)
						$state_trans = false
						
					when 134 # 분신
						$console.write_line("분신이 사라집니다.")
						
					when 140 # 운기
						$console.write_line("운기가 종료 됩니다.")	
					end
				end
			end
		end
	end
	
	def casting_chat(data, user = $game_player)
		sec = data[0]
		msg = data[1]
		type = data[2] != nil ? data[2] : 3
		
		if msg != nil
			$chat_b.input(msg, type, sec, user)
			if user == $game_player
				Network::Main.socket.send "<map_chat>#{name}&#{msg}&#{type}</map_chat>\n"
			else
				Network::Main.socket.send "<monster_chat>#{user.id}&#{msg}&#{type}</monster_chat>\n" 
			end
		end
	end
	
	def skill_chat(skill, user = $game_player)
		id = skill.id
		name = $game_party.actors[0].name
		msg = nil
		type = 3
		sec = 4
		
		case id
		when 44 # 헬파이어
			msg = "#{skill.name}!!"
		when 53, 57, 69 # 삼매진화
			msg = "삼매진화!!"
		when 58 # 지폭지술
			msg = "!!#{skill.name}!!"
		when 67 # 건곤대나이
			msg = "#{skill.name}!!"
		when 68 # 폭류유성
			msg = "!!#{skill.name}!!"
		when 79 # 동귀어진
			msg = "!!#{skill.name}!!"
		when 101 # 백호참
			msg = "#{skill.name}!!"
		when 103 # 어검술
			msg = "#{skill.name}!!"
		when 104 # 포효검황
			msg = "!!#{skill.name}!!"
		when 105 # 혈겁만파
			msg = "!!#{skill.name}!!"
		when 123 # 귀염추혼소
			msg = "!!#{skill.name}!!"
		when 133 # 필살검무
			msg = "#{skill.name}!!"
		when 135 # 백호검무
			msg = "#{skill.name}!!"
		when 137 # 이기어검
			msg = "#{skill.name}!!"
		when 138 # 무형검
			msg = "#{skill.name}!!"
		when 139 # 분혼경천
			msg = "!!#{skill.name}!!"
			
			# 적 스킬
		when 85 # 필살검무
			msg = "필살검무!"
		when 151 # 청룡 포효
			msg = "크롸롸롸롸!"
		when 152 # 현무 포효
			msg = "크롸롸롸롸!"
		when 154 # 청룡마령참
			msg = "!!#{skill.name}!!"
		when 155 # 암흑진파
			msg = "#{skill.name}!!"
		when 156 # 흑룡광포
			msg = "#{skill.name}!!"
		when 157 # 회복
			msg = "가소롭다!!"
		when 158 # 지옥겁화
			msg = "!!지옥겁화!!"
		when 159 # 혈겁만파
			msg = "!!혈겁만파!!"
		when 160 # 분혼경천
			msg = "!!분혼경천!!"
		when 161 # 폭류유성
			msg = "!!폭류유성!!"
		end
		
		if msg != nil
			$chat_b.input(msg, type, sec, user)
			if user == $game_player
				Network::Main.socket.send "<map_chat>#{name}&#{msg}&#{type}</map_chat>\n"
			else
				Network::Main.socket.send "<monster_chat>#{user.id}&#{msg}&#{type}</monster_chat>\n" 
			end
		end
	end
	
	#[(파워 계산량)[타입(현재(0), 전체(1)), 체력, 마력, 기본값], (자원 소모량)[타입(현재(0), 전체(1)), 체력, 마력]]
	def skill_power_custom(user, id, power)
		return power if SKILL_POWER_CUSTOM[id] == nil
		data = SKILL_POWER_CUSTOM[id][0]
		
		# 0 : 현재, 1 : 전체
		type = data[0] != nil ? data[0] : -1
		p_hp = data[1] != nil ? data[1].to_f : 0
		p_sp = data[2] != nil ? data[2].to_f : 0
		val = data[3] != nil ? data[3].to_f : 0
		
		power = power.to_f
		case type
		when 0 # 현재 
			power += (user.hp * p_hp) + (user.sp * p_sp)
		when 1 # 전체
			power += (user.maxhp * p_hp) + (user.maxsp * p_sp)
		end
		power += val
		return power.to_i
	end
	
	def skill_cost_custom(user, id)
		return if SKILL_COST_CUSTOM[id] == nil
		data = SKILL_COST_CUSTOM[id][0]
		type = data[0] != nil ? data[0] : -1
		c_hp = data[1] != nil ? data[1] : 0
		c_sp = data[2] != nil ? data[2] : 0
		
		case type
		when 0 # 현재 
			user.hp -= user.hp * c_hp
			user.sp -= user.sp * c_sp
		when 1 # 전체
			user.hp -= user.maxhp * c_hp
			user.sp -= user.maxsp * c_sp
		end
		user.hp = [user.hp.to_i, 1].max
		user.sp = user.sp.to_i
	end
	
	# 액티브 스킬 커스텀
	def active_skill(id)
		if ACTIVE_SKILL[id] != nil
			case id
			when 73 # 광량돌격
				광량돌격
			when 132
				비영승보
			end
		end
	end
	
	def 투명
		$game_variables[9] = 1
		$state_trans = true # 현재 자신이 투명상태인걸 뜻함
		Network::Main.send_trans(true)
	end
	
	def 투명해제
		
	end
	
	def 광량돌격(d = $game_player.direction)
		move_num = 10 # 스킬 범위만큼
		x = $game_player.x
		y = $game_player.y
		d = $game_player.direction
		for i in 0...move_num
			break if !$game_player.passable?(x, y, d)			
			x += (d == 6 ? 1 : d == 4 ? -1 : 0)
			y += (d == 2 ? 1 : d == 8 ? -1 : 0)
		end
		$game_player.moveto(x, y)
	end
	
	def 비영승보(enemy = nil, actor = $game_player)
		return if actor == nil
		x = actor.x
		y = actor.y
		d = actor.direction
		
		if(enemy == nil)
			enemy = 비영_passable2?(x, y, d)
			return if enemy == nil	
		end
		data = 비영_passable?(enemy, d) # [x, y, d]
		if data != nil
			actor.moveto(data[0], data[1]) 
			actor.direction = data[2]
		end
		$ABS.player_melee(true) if actor == $game_player
	end
	
	# 비영_passable 시작
	def 비영_passable?(enemy, d) # 해당 위치로 이동할 수 있는가?
		# Get new coordinates
		x = enemy.x
		y = enemy.y
		check_point = []
		
		n_x = x + (d == 6 ? 1 : d == 4 ? -1 : 0)
		n_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
		
		n_x2 = x + ((d == 2 or d == 8) ? -1 : 0)
		n_y2 = y + ((d == 4 or d == 6) ? -1 : 0)
		
		n_x3 = x + ((d == 2 or d == 8) ? 1 : 0)
		n_y3 = y + ((d == 4 or d == 6) ? 1 : 0)
		
		check_point.push([n_x, n_y])
		check_point.push([n_x2, n_y2])
		check_point.push([n_x3, n_y3])
		
		for check in check_point
			new_x = check[0]
			new_y = check[1]
			
			sx = new_x - x
			sy = new_y - y
			
			if sx.abs > 0
				d = sx > 0 ? 4 : 6
			elsif sy.abs > 0
				d = sy > 0 ? 8 : 2
			end
			
			data = [new_x, new_y, d]
			
			# If coordinates are outside of map; impassable
			next unless $game_map.valid?(new_x, new_y)
			next unless $game_map.passable?(new_x, new_y, 10 - d)
			# If through is ON; passable
			return data if @through
			
			object = []
			# Loop all events
			for event in $game_map.events.values
				# If event coordinates are consistent with move destination
				if event.x == new_x and event.y == new_y
					unless event.through
						# With self as the player and partner graphic as character; impassable
						object.push(event) if event.character_name != ""
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
						object.push(player) if self != $game_player or player.character_name != ""
					end
				end
			end
			
			# If player coordinates are consistent with move destination
			if $game_player.x == new_x and $game_player.y == new_y
				# If through is OFF
				unless $game_player.through
					# If your own graphic is the character; impassable
					object.push($game_player) if @character_name != ""
				end
			end
			next if object.size > 0
			
			# passable
			return data
		end
		return
	end
	# end
	
	# 비영_passable2 시작
	def 비영_passable2?(x, y, d) # 좌표에 이벤트가 있는가?
		# Get new coordinates
		new_x = x + (d == 6 ? 1 : d == 4 ? -1 : 0)
		new_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
		
		# Loop all events
		for event in $game_map.events.values
			# If event coordinates are consistent with move destination
			if (event.x == new_x and event.y == new_y) or (event.x == x and event.y == y)
				# If through is OFF
				next if event.through or event.character_name == ""
				return event
			end
		end
		
		# Loop all players
		for player in Network::Main.mapplayers.values
			# If player coordinates are consistent with move destination
			next if player == nil
			if player.x == new_x and player.y == new_y
				# If through is OFF
				next if player.through
				return player
			end
		end
		
		return
	end
	# 비영_passable2 end
	
	# 이미 가지고 있던 스킬인가?
	def has_skill?(type) # 직업
		return false if REQ_SKILL_DATA[type][$game_variables[38]] == nil
		s_id = REQ_SKILL_DATA[type][$game_variables[38]][3]
		
		return true if $game_party.actors[0].skill_learn?(s_id)
		# 업그레이드 되는 스킬이면 이전 하위 스킬을 지움
		for i in 1..UPGRADE_SKILL_ID.size
			u_skill = UPGRADE_SKILL_ID[i]
			if u_skill.include?(s_id)
				for j in u_skill
					return true if $game_party.actors[0].skill_learn?(j) and s_id < j
				end
				return false
			end
		end
		return false
	end
	
	# 해당 스킬을 배우는데 필요한 재료
	def req_skill_item(type, num, s_num) # 직업, 몇 번째 스킬
		# type : 1 전사, 2 주술사, 3 도사, 4 도적
		temp = 0
		temp = 0 if $game_switches[1] # 청룡
		temp = 1 if $game_switches[2] # 백호
		temp = 2 if $game_switches[3] # 주작
		temp = 3 if $game_switches[4] # 현무
		
		# data : 스킬 필요 레벨, 재료1 개수, 재료2 개수, 스킬 아이디, 재료1 아이디, 재료2 아이디
		data = REQ_SKILL_DATA[type][num]
		if data != nil
			$game_variables[26] = data[0]
			$game_variables[28] = data[1]
			$game_variables[29] = data[2]
			$game_variables[32] = data[3]
			$game_variables[32] += temp if SINSU_SKILL_ID.include?(data[3]) 
			$game_variables[34] = data[4]
			$game_variables[35] = data[5]
			
			$game_variables[103] = $game_party.item_number(data[4])
			$game_variables[104] = $game_party.item_number(data[5])
		else
			$game_variables[26] = 0
			$game_variables[28] = 0
			$game_variables[29] = 0
			$game_variables[32] = 0
			$game_variables[34] = 0
			$game_variables[35] = 0
			
			$game_variables[103] = 0
			$game_variables[104] = 0
		end
	end
	
	# 승급시 필요 체력, 마력 반환하는 함수
	def need_advancement_resource
		self.job_select # 현재 상태 초기화
		# NEED_ADVANCE_RESOURCE[0] = [[4500, 4500], [10000, 15000], [25000, 40000], [70000, 120000]] # 주술사
		idx = -1
		if $game_switches[6] # 주술사
			idx = 0
		elsif $game_switches[156] # 전사
			idx = 1
		elsif $game_switches[144] # 도사
			idx = 2
		elsif $game_switches[426] # 도적	
			idx = 3
		end
		return if idx == -1
		return if NEED_ADVANCE_RESOURCE[idx] == nil
		return if NEED_ADVANCE_RESOURCE[idx][$job_degree.to_i] == nil
		
		$game_variables[195] = NEED_ADVANCE_RESOURCE[idx][$job_degree.to_i][0] # 승급 필요 체
		$game_variables[196] = NEED_ADVANCE_RESOURCE[idx][$job_degree.to_i][1] # 승급 필요 마
	end
	
	# 자기 직업 스위치 온
	def job_select
		n = $game_party.actors[0].class_id
		$game_switches[6] = false
		$game_switches[156] = false
		$game_switches[144] = false
		$game_switches[426] = false
		case n
			# 주술사
		when 2, 3, 5, 6, 14 
			$game_switches[6] = true
			# 전사
		when 7..10, 15
			$game_switches[156] = true
			# 도사
		when 4, 11..13, 16
			$game_switches[144] = true
			# 도적
		when 17..21
			$game_switches[426] = true
		end
		degree_arr = [0, 143, 150, 155, 358]
		
		# 승급 차수 확인
		$game_switches[143] = false # 1차
		$game_switches[150] = false # 2차
		$game_switches[155] = false # 3차
		$game_switches[358] = false # 4차
		
		$job_degree = 0
		$job_degree = 1 if (n == 3 or n == 8 or n == 11 or n == 18)
		$job_degree = 2 if (n == 5 or n == 9 or n == 12 or n == 19)		
		$job_degree = 3	if (n == 6 or n == 10 or n == 13 or n == 20)
		$job_degree = 4 if (n == 14 or n == 15 or n == 16 or n == 21)
		
		for i in 1..$job_degree
			$game_switches[degree_arr[i]] = true
		end
	end
	
	# 평타 공격시 버프, 디버프에 대한 데미지 계산
	def damage_calculation_attack(damage, actor, attacker)
		# 가해자 입장
		if attacker.is_a?(Game_Actor) # 플레이어
			for data in $skill_Delay_Console.console_log2
				id = data[0]
				damage *= DAMAGE_CAL_ATTACK[id][0] if DAMAGE_CAL_ATTACK[id] != nil
			end
			
			if $state_trans # 투명 풀기
				damage *= (6 + $game_variables[10]) # 투명 숙련도
				$state_trans = false
				$game_variables[9] = 1
				id = nil
				id = 131 if self.check_buff(131) # 투명 1성
				id = 141 if self.check_buff(141) # 투명 2성
				id = 142 if self.check_buff(142) # 투명 3성
				
				damage = skill_power_custom(attacker, id, damage) if id != nil
				skill_cost_custom(attacker, id) if id != nil
			end
			
		elsif attacker.is_a?(ABS_Enemy) # 몬스터
			
		end
		
		# 피해자 입장
		# 플레이어
		if actor.is_a?(Game_Actor) 
			for data in $skill_Delay_Console.console_log2
				id = data[0]
				damage -= damage * DAMAGE_CAL_DEFENSE[id][0] if DAMAGE_CAL_DEFENSE[id] != nil
			end
			# 몬스터
		elsif actor.is_a?(ABS_Enemy)
			damage = 1 if actor.id == 41 # 청자다람쥐
		end
		return damage.to_i
	end
	
	# 스킬 공격시 버프, 디버프에 대한 데미지 계산
	def damage_calculation_skill(damage, actor, attacker)
		# 가해자 입장
		if attacker.is_a?(Game_Actor)
			for data in $skill_Delay_Console.console_log2
				id = data[0]
				damage *= DAMAGE_CAL_SKILL[id][0] if DAMAGE_CAL_SKILL[id] != nil
			end
		elsif attacker.is_a?(ABS_Enemy)
			
		end
		
		# 피해자 입장
		if actor.is_a?(Game_Actor)
			for data in $skill_Delay_Console.console_log2
				id = data[0]
				damage -= damage * DAMAGE_CAL_DEFENSE[id][0] if DAMAGE_CAL_DEFENSE[id] != nil
			end
		elsif actor.is_a?(ABS_Enemy)
			damage = 1 if actor.id == 41 # 청자다람쥐
		end
		return damage.to_i
	end
	
	# 비례 데미지 스킬
	def damage_by_skill(damage, id, victim = nil)
		case id
		when 6 # 도토리 던지기
			return 1
		end
		
		return damage if SKILL_POWER_CUSTOM[id] == nil
		return damage if victim == nil
		data = SKILL_POWER_CUSTOM[id][0]
		return damage if data[0] != 2
		
		# 2 : 비례데미지
		type = data[0] != nil ? data[0] : -1
		p_hp = data[1] != nil ? data[1].to_f : 0
		p_sp = data[2] != nil ? data[2].to_f : 0
		val = data[3] != nil ? data[3].to_f : 0
		
		damage = damage.to_f
		damage += (victim.maxhp * p_hp) + val
		victim.sp -= victim.maxsp * p_sp # 마력 깎기
		return damage.to_i
	end
	
	# 스킬을 사용하기 위한 재료가 준비 됐는지 확인
	def check_need_skill_item(id)
		return true if NEED_SKILL_ACTIVE_ITEM[id] == nil
		for data in NEED_SKILL_ACTIVE_ITEM[id]
			type = data[0]
			item_id = data[1]
			num = data[2]
			
			my_num = 0
			item_name = ""
			case type
			when 0 # 아이템
				my_num = $game_party.item_number(item_id)
				item_name = $data_items[item_id].name
			when 1 # 무기
				my_num = $game_party.weapon_number(item_id)
				item_name = $data_weapons[item_id].name
			when 2 # 방어구
				my_num = $game_party.armor_number(item_id)
				item_name = $data_armors[item_id].name
			end
			
			if my_num < num
				$console.write_line("#{item_name}(이)가 #{num - my_num}개 부족합니다.")
				return false 
			end
		end
		
		# 재료 아이템 소모
		for data in NEED_SKILL_ACTIVE_ITEM[id]
			type = data[0]
			item_id = data[1]
			num = data[2]
			
			case type
			when 0 # 아이템
				$game_party.lose_item(item_id, num)
			when 1 # 무기
				$game_party.lose_weapon(item_id, num)
			when 2 # 방어구
				$game_party.lose_armor(item_id, num)
			end
		end
		return true
	end
end	


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
