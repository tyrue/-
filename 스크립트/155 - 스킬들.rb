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
	[42, 10, 10, 27, 19, 20], 	# 동해의기원
	[46, 20, 15, 66, 19, 20], 	# 신수둔각도
	
	[50, 2, 10, 1, 28, 22], 		# 신수마법
	[55, 20, 1, 67, 22, 59], 	# 건곤대나이
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
	[81, 10, 25, 43, 29, 30], 		# 위태응기
	[88, 20, 3, 142, 30, 31], 	# 투명 2성
	[92, 5, 3, 140, 31, 37], 	# 운기
	[99, 5, 3, 134, 31, 37],	# 분신
]

# 치유 마법 (기원류)
HEAL_SKILL = {}
HEAL_SKILL[5] = [75]  		# 누리의기원
HEAL_SKILL[21] = [100]		# 바다의기원
HEAL_SKILL[27] = [170]			# 동해의기원
HEAL_SKILL[29] = [300]			# 천공의기원
HEAL_SKILL[36] = [500]			# 구름의기원
HEAL_SKILL[48] = [1000]			# 태양의기원
HEAL_SKILL[54] = [2000]			# 태양의기원 1성
HEAL_SKILL[55] = [5000]			# 현인의기원

# 치유마법 (희원류)
PARTY_HEAL_SKILL = {}
PARTY_HEAL_SKILL[81] = [170]  # 동해의희원
PARTY_HEAL_SKILL[83] = [200]  # 천공의희원
PARTY_HEAL_SKILL[86] = [75]  # 바다의희원
PARTY_HEAL_SKILL[87] = [200]  # 천공의희원
PARTY_HEAL_SKILL[89] = [500]  # 구름의희원
PARTY_HEAL_SKILL[93] = [1000]  # 태양의희원
PARTY_HEAL_SKILL[92] = [1]  # 공력주입
PARTY_HEAL_SKILL[95] = [3000]  # 생명의희원
PARTY_HEAL_SKILL[117] = [1]  # 백호의희원
PARTY_HEAL_SKILL[118] = [7000]  # 신령의희원
PARTY_HEAL_SKILL[119] = [15000]  # 봉황의희원
PARTY_HEAL_SKILL[120] = [1]  # 부활

# 파티 버프 스킬 아이디 저장
PARTY_BUFF_SKILL = {}
PARTY_BUFF_SKILL[50] = [] # 야수수금술
PARTY_BUFF_SKILL[88] = [] # 분량력법
PARTY_BUFF_SKILL[90] = [] # 분량방법
PARTY_BUFF_SKILL[42] = [] # 주술마도
PARTY_BUFF_SKILL[46] = [] # 무장
PARTY_BUFF_SKILL[47] = [] # 보호
PARTY_BUFF_SKILL[121] = [] # 신령지익진
PARTY_BUFF_SKILL[122] = [] # 파력무참진
PARTY_BUFF_SKILL[136] = [] # 운상미보

# 버프 스킬 값 저장
BUFF_SKILL = {} # 스텟(int, dex, str, agi등), 값 
BUFF_SKILL[26] = [["str", 20]] # 누리의힘
BUFF_SKILL[28] = [["com", 40]] # 야수
BUFF_SKILL[35] = [["com", 42]] # 비호
BUFF_SKILL[42] = [["per_int", 1.5, 0]] # 주술마도

BUFF_SKILL[50] = [["com", 40]] # 야수수금술
BUFF_SKILL[88] = [["per_str", 1.5, 0]] # 분량력법
BUFF_SKILL[90] = [["per_agi", 1.5, 0]] # 분량방법
BUFF_SKILL[46] = [["mdef", 10], ["pdef", 10]] # 무장
BUFF_SKILL[47] = [["mdef", 15], ["pdef", 15]] # 보호

BUFF_SKILL[62] = [["dex", 50]] # 수심각도
BUFF_SKILL[63] = [["agi", 50]] # 반영대도
BUFF_SKILL[64] = [["per_str", 1.2, 0]] # 십량분법
BUFF_SKILL[66] = [["custom", 1]] # 신수둔각도
BUFF_SKILL[71] = [["per_str", 1.3, 0]] # 구량분법
BUFF_SKILL[72] = [["per_str", 2, 0]] # 혼신의힘
BUFF_SKILL[76] = [["per_str", 1.4, 0]] # 팔량분법

BUFF_SKILL[91] = [["com", 129]] # 석화기탄
BUFF_SKILL[94] = [["mdef", 999], ["pdef", 999]] # 금강불체
BUFF_SKILL[130] = [["dex", 50], ["agi", 50]] # 무영보법
BUFF_SKILL[131] = [["custom", 1]] # 투명
BUFF_SKILL[141] = [["custom", 1]] # 투명 1성
BUFF_SKILL[142] = [["custom", 1]] # 투명 2성
BUFF_SKILL[134] = [["custom", 1]] # 분신
BUFF_SKILL[136] = [["custom", 1]] # 운상미보
BUFF_SKILL[140] = [["custom", 1]] # 운기

# 액티브 스킬 행동 커스텀
ACTIVE_SKILL = {}
ACTIVE_SKILL[73] = [] # 광량돌격
ACTIVE_SKILL[132] = [] # 비영승보

class Rpg_skill
	def update_buff
		sec = Graphics.frame_rate
		if check_buff(140) # 운기 중
			if !$game_player.moving?
				if (Graphics.frame_count % (sec) == 0)
					$game_party.actors[0].sp += $game_party.actors[0].maxsp / 10
					$game_player.animation_id = 4
					Network::Main.ani(Network::Main.id, $game_player.animation_id) #애니메이션 공유
				end
			else
				SKILL_BUFF_TIME[140][1] = 1 # 운기 취소
			end
		end
		
		if check_buff(121) # 신령지익진
			if (Graphics.frame_count % (sec * 2) == 0)
				$game_player.animation_id = 7
				Network::Main.ani(Network::Main.id, $game_player.animation_id) #애니메이션 공유
			end
		end	
		
		if check_buff(122) # 신령지익진
			if (Graphics.frame_count % (sec * 2) == 0)
				$game_player.animation_id = 8
				Network::Main.ani(Network::Main.id, $game_player.animation_id) #애니메이션 공유
			end
		end
		
		if !$state_trans # 투명 풀기
			SKILL_BUFF_TIME[131][1] = 1 if check_buff(131)
			SKILL_BUFF_TIME[141][1] = 1 if check_buff(141)
			SKILL_BUFF_TIME[142][1] = 1 if check_buff(142)
		end
	end
	
	# 파티 힐
	def party_heal(id)
		return if PARTY_HEAL_SKILL[id] == nil
		heal_v = 1
		heal_v = PARTY_HEAL_SKILL[id][0].to_i 
		heal_v += ($game_party.actors[0].maxsp * 0.001).to_i
		heal_v = ((heal_v) * (1 + ($game_party.actors[0].int / 1000.0) + ($game_party.actors[0].maxsp / 100000.0))).to_i
		
		# 커스텀
		case id
		when 92 # 공력주입
			heal_v = $game_party.actors[0].sp
			$game_party.actors[0].sp = 0
		when 117 # 백호의희원
			heal_v = $game_party.actors[0].sp * 2
			$game_party.actors[0].sp = 0
		when 118 # 신령의희원
			$game_party.actors[0].sp -= $game_party.actors[0].sp / 50
		when 119 # 봉황의희원
			$game_party.actors[0].sp -= $game_party.actors[0].sp / 50
		when 120 # 부활
			$game_temp.common_event_id = 24
		end
		
		$game_party.actors[0].damage = heal_v.to_s
		$game_party.actors[0].critical = "heal"
		$game_party.actors[0].hp += heal_v
		
		ani_id = $data_skills[id].animation1_id # 스킬 사용 측 애니메이션 id
		$game_player.animation_id = ani_id
		Network::Main.ani(Network::Main.id, ani_id)
		
		if $netparty.size >= 2 # 파티가 2인 이상이라면
			name = $game_party.actors[0].name
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
	def heal(id)
		is_heal = false
		heal_v = 0
		if HEAL_SKILL[id] != nil
			heal_v = HEAL_SKILL[id][0].to_i 
			is_heal = true
		end
		
		# 커스텀
		case id
		when 43 # 위태응기
			heal_v = $game_party.actors[0].sp * 2
			$game_party.actors[0].sp = 0
			is_heal = true
			
		end
		
		if is_heal
			heal_v += ($game_party.actors[0].maxhp * 0.01).to_i
			$game_party.actors[0].critical = "heal"
			$game_party.actors[0].damage = heal_v.to_s
			$game_party.actors[0].hp += heal_v
			return heal_v
		end
	end
	
	# 이미 버프가 걸려있는지 확인
	def check_buff(id, actor = $game_party.actors[0])
		if actor == $game_party.actors[0]
			skill_mash = SKILL_BUFF_TIME[id]
			return (skill_mash != nil and skill_mash[1] / 60.0 > 0)
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
				when "dex" # 손재주
					$game_party.actors[0].dex += data[1].to_i
				when "int" # 지력
					$game_party.actors[0].int += data[1].to_i
				when "agi" # 민첩
					$game_party.actors[0].agi += data[1].to_i
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
				when "per_dex" # 손재주
					base = $game_party.actors[0].take_base_dex
					n = (base * (data[1].to_f - 1.0)).to_i
					data[2] = n
					$game_party.actors[0].dex += n
				when "per_int" # 지력
					base = $game_party.actors[0].take_base_int
					n = (base * (data[1].to_f - 1.0)).to_i
					data[2] = n
					$game_party.actors[0].int += n
				when "per_agi" # 민첩
					base = $game_party.actors[0].take_base_agi
					n = (base * (data[1].to_f - 1.0)).to_i
					data[2] = n
					$game_party.actors[0].agi += n
				when "per_mdef" # 마법 방어
					$game_party.actors[0].mdef *= data[1].to_f
				when "per_pdef" # 물리 방어
					$game_party.actors[0].pdef *= data[1].to_f
					
				when "com" # 커먼 이벤트
					$game_temp.common_event_id = data[1].to_i
				when "custom" # 자체 수정
					case id
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
						
					when 131, 141, 142 # 투명
						self.투명
						
					when 134 # 분신
						$console.write_line("분신을 생성합니다.")
						
					when 136 # 운상미보
						$game_player.move_speed += 0.5
						Network::Main.socket.send("<5>@move_speed = #{$game_player.move_speed};</5>\n")
						
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
				case data[0].to_s
				when "str" # 힘
					$game_party.actors[0].str -= data[1].to_i
				when "dex" # 손재주
					$game_party.actors[0].dex -= data[1].to_i
				when "int" # 지력
					$game_party.actors[0].int -= data[1].to_i
				when "agi" # 민첩
					$game_party.actors[0].agi -= data[1].to_i
				when "mdef" # 마법 방어
					$game_party.actors[0].mdef -= data[1].to_i
				when "pdef" # 물리 방어
					$game_party.actors[0].pdef -= data[1].to_i
					
					# 퍼센트
				when "per_str" # 힘
					n = 0
					if(data[2] != nil and data[2] != 0)
						n = data[2]
					else
						base = $game_party.actors[0].take_base_str
						n = base * (1 - 1.0 / data[1].to_f)
					end
					$game_party.actors[0].str -= n
				when "per_dex" # 손재주
					n = 0
					if(data[2] != nil and data[2] != 0)
						n = data[2]
					else
						base = $game_party.actors[0].take_base_dex
						n = base * (1 - 1.0 / data[1].to_f)
					end
					$game_party.actors[0].dex -= n
				when "per_int" # 지력
					n = 0
					if(data[2] != nil and data[2] != 0)
						n = data[2]
					else
						base = $game_party.actors[0].take_base_int
						n = base * (1 - 1.0 / data[1].to_f)
					end
					$game_party.actors[0].int -= n 
				when "per_agi" # 민첩
					n = 0
					if(data[2] != nil and data[2] != 0)
						n = data[2]
					else
						base = $game_party.actors[0].take_base_agi
						n = base * (1 - 1.0 / data[1].to_f)
					end
					$game_party.actors[0].agi -= n
				when "per_mdef" # 마법 방어
					$game_party.actors[0].mdef /= data[1].to_f
				when "per_pdef" # 물리 방어
					$game_party.actors[0].pdef /= data[1].to_f	
					
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
						$game_party.lose_weapon(1, 99)
						$game_party.lose_weapon(2, 99)
						$game_party.lose_weapon(3, 99)
						$game_party.lose_weapon(4, 99)
						
					when 131, 141, 142 # 투명, 1, 2성
						$game_variables[9] = 1
						Network::Main.send_trans(false)
						$state_trans = false
						
					when 134 # 분신
						$console.write_line("분신이 사라집니다.")
						
					when 136 # 운상미보
						$game_player.move_speed -= 0.5
						Network::Main.socket.send("<5>@move_speed = #{$game_player.move_speed};</5>\n")
						
					when 140 # 운기
						$console.write_line("운기가 종료 됩니다.")	
					end
				end
			end
		end
	end
	
	def skill_chat(skill)
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
		when 133 # 필살검무
			msg = "#{skill.name}!!"
		when 135 # 백호검무
			msg = "#{skill.name}!!"
		when 137 # 이기어검
			msg = "#{skill.name}!!"
		when 138 # 무형검
			msg = "#{skill.name}!!"
		when 139 # 분혼경천
			msg = "#{skill.name}!!"
		end
		
		if msg != nil
			$chat_b.input(msg, type, sec, $game_player)
			Network::Main.socket.send "<map_chat>#{name}&#{msg}&#{type}</map_chat>\n"
		end
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
		u_hp = $game_party.actors[0].hp
		u_hp -= u_hp / (20 - $game_variables[10])
		u_hp = 1 if u_hp <= 0
		$game_party.actors[0].hp = u_hp 
		
		$game_variables[9] = 1
		$state_trans = true # 현재 자신이 투명상태인걸 뜻함
		Network::Main.send_trans(true)
	end
	
	def 광량돌격(d = $game_player.direction)
		move_num = 10 # 스킬 범위만큼
		x = $game_player.x
		y = $game_player.y
		
		for i in 0...move_num
			if $game_player.passable?(x, y, $game_player.direction)
				case $game_player.direction
				when 2 # 아래
					y += 1
				when 4 # 왼쪽
					x -= 1
				when 6 # 오른쪽
					x += 1
				when 8 # 위
					y -= 1
				end
			else
				break
			end
		end
		$game_player.moveto(x, y)
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
			damage *= 1.2 if self.check_buff(71) # 혼신의힘
			damage *= 1.2 if self.check_buff(88) # 분량력법
			damage *= 2 if self.check_buff(134) # 분신
			damage *= 1.5 if self.check_buff(122) # 파력무참진
			if $state_trans # 투명
				damage *= (5 + $game_variables[10]) # 투명 숙련도
				$state_trans = false
				$game_variables[9] = 1
			end
		elsif attacker.is_a?(ABS_Enemy) # 몬스터
			
		end
		
		# 피해자 입장
		if actor.is_a?(Game_Actor)
			damage -= damage * 0.2 if self.check_buff(47) # 보호	
			damage -= damage * 0.2 if self.check_buff(90) # 분량방법
			damage -= damage * 0.5 if self.check_buff(121) # 신령지익진
		elsif actor.is_a?(ABS_Enemy)
			damage = 1 if actor.id == 41 # 청자다람쥐
		end
		return damage.to_i
	end
	
	# 스킬 공격시 버프, 디버프에 대한 데미지 계산
	def damage_calculation_skill(damage, actor, attacker)
		# 가해자 입장
		if attacker.is_a?(Game_Actor)
			damage *= 1.2 if self.check_buff(71) # 혼신의힘
			damage *= 1.2 if self.check_buff(88) # 분량력법
			damage *= 1.5 if self.check_buff(122) # 파력무참진
		elsif attacker.is_a?(ABS_Enemy)
			
		end
		
		# 피해자 입장
		if actor.is_a?(Game_Actor)
			damage -= damage * 0.2 if self.check_buff(47) # 보호	
			damage -= damage * 0.2 if self.check_buff(90) # 분량방법
			damage -= damage * 0.5 if self.check_buff(121) # 신령지익진
		elsif actor.is_a?(ABS_Enemy)
			damage = 1 if actor.id == 41 # 청자다람쥐
		end
		return damage.to_i
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
