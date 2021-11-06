class MrMo_ABS
	#--------------------------------------------------------------------------
	# * 아이템의 처리
	#--------------------------------------------------------------------------
	def take_item2(item_index)
		if $game_switches[296] # 죽었으면 못 먹음
			$console.write_line("귀신은 할 수 없습니다.") 
			return
		end
		
		$state_trans = false # 투명 풀림
		Audio.se_play("Audio/SE/장", $game_variables[13])
		Network::Main.ani(Network::Main.id, 198)
		
		if $Drop[item_index] != nil
			id = $Drop[item_index].id
			type = $Drop[item_index].type
			type2 = $Drop[item_index].type2
			num = $Drop[item_index].amount
			
			if type2 == 1 # 일반 아이템
				if type == 0 # 아이템
					n = $game_party.item_number(id)
					if n >= $item_maximum
						$console.write_line("더 이상 가질 수 없습니다.")
						return
					end
					
					$game_party.gain_item(id, num)
				elsif type == 1 # 무기
					n = $game_party.weapon_number(id)
					if n >= $item_maximum
						$console.write_line("더 이상 가질 수 없습니다.")
						return
					end
					
					$game_party.gain_weapon(id, num)
				elsif type == 2 # 장비
					n = $game_party.armor_number(id)
					if n >= $item_maximum
						$console.write_line("더 이상 가질 수 없습니다.")
						return
					end
					
					$game_party.gain_armor(id, num)
				end
				
			elsif type2 == 0 # 돈
				$game_party.gain_gold($Drop[item_index].amount)
				$console.write_line("#{$Drop[item_index].amount}전 획득 ")
			end
			Network::Main.socket.send "<Drop_Get>#{item_index},#{$game_map.map_id}</Drop_Get>\n"
		end
		$Drop[item_index] = nil
	end
	
	
	def take_item(type, id, num) # 아이템의 종류(무기, 방어구, 아이템), id, 개수
		if $game_switches[296] # 죽었으면 못 먹음
			$console.write_line("귀신은 할 수 없습니다.") 
			return
		end
		
		n = 0
		case type
		when 0 # 아이템
			item = $data_items[id]
			n = $game_party.item_number(item.id)
			if n >= $item_maximum
				$console.write_line("더 이상 가질 수 없습니다.")
				return
			end
			
			$game_party.gain_item(item.id, num)
			n = $game_party.item_number(item.id)
		when 1 # 무기
			item = $data_weapons[id]
			n = $game_party.weapon_number(item.id)
			if n >= $item_maximum
				$console.write_line("더 이상 가질 수 없습니다.")
				return
			end
			
			$game_party.gain_weapon(item.id, num)
			n = $game_party.weapon_number(item.id)
		when 2 # 방어구
			item = $data_armors[id]
			n = $game_party.armor_number(item.id)
			if n >= $item_maximum
				$console.write_line("더 이상 가질 수 없습니다.")
				return
			end
			
			$game_party.gain_armor(item.id, num)
			n = $game_party.armor_number(item.id)
			
		when 3 # 돈
			$game_party.gain_gold(num.to_i)
			$console.write_line("#{num.to_i}전 획득 ")
		end
		$state_trans = false # 투명 풀림
		
		eid = $game_variables[218]
		ex = $game_variables[215]
		ey = $game_variables[216]
		
		Audio.se_play("Audio/SE/장", $game_variables[13])
		Network::Main.ani(Network::Main.id, 198)
		
		Network::Main.socket.send "<drop_del>#{$game_map.map_id},#{eid},#{ex},#{ey}</drop_del>\n"
		Network::Main.socket.send "<del_item>#{$game_map.map_id},#{eid},#{ex},#{ey}</del_item>\n"
	end
	
		
	#--------------------------------------------------------------------------
	# * 몬스터마다의 템 줄 확률 설정
	#--------------------------------------------------------------------------
	def drop_enemy(e)
		id = e.id.to_i
		
		if ITEM_DROP_DATA[id] != nil
			r = rand(100)
			i_id = []
			temp = []
			num = ITEM_DROP_DATA[id][0][0]
			
			# 확률에 맞는 아이템 id를 넣는다.
			for d in ITEM_DROP_DATA[id]
				next if d.size == 1
				type = d[0]
				id = d[1]
				take_num = rand(d[2]) + 1
				chance = d[3]
				sw = d[4]
				
				if r <= chance
					if sw != nil and $game_switches[sw] == true
						temp.push([type, id, take_num]) 
					elsif sw == nil
						temp.push([type, id, take_num]) 
					end
				end
			end
			
			# 최대 드랍될 아이템 종류 개수
			if num == -1 or temp.size <= num
				i_id = temp
			else
				# 랜덤으로 temp에 있는 것 중에 num개를 추출한다.
				for i in 0...num
					r = rand(temp.size)
					i_id.push(temp[r])
					temp.delete_at(r)
				end
			end
			
			for item in i_id
				if item[0] == 3 # 돈 드랍
					create_moneys(item[1], e.event.x, e.event.y)
				else
					create_drops(item[0], item[1], e.event.x, e.event.y, item[2])
				end
			end
		end
	end
	
	# 아이템 드랍 데이터
	# [몬스터 아이디] = [[최대 드랍될 아이템 개수], [타입(아이템 0, 무기 1, 장비 2, 돈 3), 아이템 id or money, 최대 나올 개수, 드랍 확률, (조건스위치)], ...] 
	ITEM_DROP_DATA = {}
	# 초보사냥터
	ITEM_DROP_DATA[1] = [[-1], [0, 74, 1, 80], [2, 10, 1, 10]] # 토끼 : 토끼고기, 토끼화서
	ITEM_DROP_DATA[2] = [[-1], [0, 3, 50, 80], [2, 9, 1, 10]] # 다람쥐 : 도토리, 다람쥐화서
	ITEM_DROP_DATA[3] = [[-1], [0, 5, 1, 70]] # 암사슴 : 사슴고기
	ITEM_DROP_DATA[4] = [[-1], [0, 6, 1, 50]] # 숫사슴 : 녹용
	ITEM_DROP_DATA[5] = [[-1], [3, 100, 1, 40]] # 늑대 : 100전
	ITEM_DROP_DATA[6] = [[-1], [0, 7, 1, 60]] # 소 : 쇠고기
	ITEM_DROP_DATA[7] = [[-1], [0, 8, 1, 70]] # 돼지 : 돼지고기
	
	# 쥐굴
	ITEM_DROP_DATA[8] = [[-1], [0, 9, 1, 70]] # 쥐 : 쥐고기
	ITEM_DROP_DATA[9] = [[-1], [0, 9, 1, 70], [3, 100, 1, 20]] # 병든쥐 : 쥐고기, 100전
	ITEM_DROP_DATA[10] = [[-1], [3, 100, 1, 30]] # 시궁창쥐 : 100전
	ITEM_DROP_DATA[11] = [[-1], [0, 10, 1, 80]] # 박쥐 : 박쥐고기
	ITEM_DROP_DATA[12] = [[-1], [0, 10, 1, 80], [3, 100, 1, 10]] # 보라박쥐 : 박쥐고기, 100전
	ITEM_DROP_DATA[40] = [[-1], [3, 200, 1, 60]] # 자생원 : 200전
	
	# 곰굴
	ITEM_DROP_DATA[13] = [[-1], [0, 11, 1, 70]] # 평웅 : 웅담
	ITEM_DROP_DATA[14] = [[-1], [2, 2, 1, 5]] # 진웅 : 지력의투구1
	ITEM_DROP_DATA[15] = [[-1], [0, 12, 1, 50]] # 호랑이 : 호랑이고기
	ITEM_DROP_DATA[16] = [[-1], [0, 12, 1, 70]] # 평호 : 호랑이고기
	ITEM_DROP_DATA[17] = [[-1], [0, 12, 1, 40], [2, 2, 1, 50]] # 진호 : 호랑이고기, 지력의투구1
	
	# 돼지굴
	ITEM_DROP_DATA[21] = [[-1], [0, 19, 1, 60], [0, 28, 1, 10]] # 산돼지 : 산돼지고기, 돼지의뿔
	ITEM_DROP_DATA[22] = [[-1], [0, 20, 1, 60], [0, 28, 1, 10]] # 숲돼지 : 숲돼지고기, 돼지의뿔
	
	# 사슴굴
	ITEM_DROP_DATA[23] = [[-1], [0, 5, 1, 80]] # 주홍사슴 : 사슴고기
	ITEM_DROP_DATA[25] = [[-1], [0, 6, 1, 80], [1, 22, 1, 5]] # 흑/백순록 : 녹용, 비철단도
	
	# 자호굴
	ITEM_DROP_DATA[26] = [[-1], [0, 22, 1, 60]] # 자호 : 짙은호랑이고기
	ITEM_DROP_DATA[27] = [[-1], [0, 22, 1, 60], [3, 100, 1, 20]] # 천자호 : 짙은호랑이고기, 100전
	ITEM_DROP_DATA[28] = [[-1], [0, 22, 1, 60], [3, 100, 1, 30]] # 구자호 : 짙은호랑이고기, 100전
	ITEM_DROP_DATA[29] = [[-1], [0, 22, 1, 30], [3, 100, 1, 20], [1, 23, 1, 30]] # 적호 : 짙은호랑이고기, 100전, 철도
	
	# 해골굴
	ITEM_DROP_DATA[30] = [[-1], [0, 29, 1, 60]] # 해골 : 호박
	ITEM_DROP_DATA[31] = [[-1], [0, 29, 1, 60]] # 날쌘해골 : 호박
	ITEM_DROP_DATA[32] = [[1], [0, 29, 1, 60], [0, 30, 1, 10]] # 자해골 : 호박, 진호박
	ITEM_DROP_DATA[33] = [[-1], [0, 30, 1, 50]] # 흑해골 : 진호박
	
	# 흉가
	ITEM_DROP_DATA[34] = [[-1], [0, 29, 1, 30], [0, 30, 1, 70]] # 달걀귀신 : 호박, 진호박
	ITEM_DROP_DATA[35] = [[-1], [0, 29, 1, 30], [0, 30, 1, 70]] # 몽달귀신 : 호박, 진호박
	ITEM_DROP_DATA[39] = [[-1], [0, 30, 1, 40], [0, 31, 1, 30], [0, 37, 1, 10]] # 불귀신 : 진호박, 불의혼, 불의결정
	ITEM_DROP_DATA[36] = [[-1], [0, 116, 1, 20]] # 처녀귀신 : 황금호박
	
	# 기타 
	ITEM_DROP_DATA[36] = [[-1], [0, 41, 1, 40]] # 짚단 : 짚단
	ITEM_DROP_DATA[41] = [[1], [0, 38, 1, 5], [0, 39, 1, 4], [0, 92, 1, 1]] # 청자다람쥐 : 작은상자, 고급상자, 최고급상자
	ITEM_DROP_DATA[49] = [[1], [0, 38, 1, 90], [0, 39, 1, 40], [0, 92, 1, 5]] # 고래 :  작은상자, 고급상자, 최고급상자
	
	# 도깨비굴
	ITEM_DROP_DATA[47] = [[-1], [0, 29, 1, 40], [0, 30, 1, 20]] # 도깨비 : 호박, 진호박
	ITEM_DROP_DATA[48] = [[-1], [0, 29, 1, 40], [0, 30, 1, 20]] # 도깨비불 : 호박, 진호박
	
	
	def drop_enemy2(e)
		r = rand(100)
		i_id = 0
		case e.id.to_i
			
		
		when 49 # 고래
			if r <= 30 
				i_id = 56 # 작은보물상자
			elsif r <= 90
				i_id = 57 # 고급보물상자
			elsif r <= 95
				i_id = 121 # 최고급보물상자
			end
		when 50 # 녹웅객
			if r <= 30 
				i_id = 51 # 낡은 수리검
			end
		when 51 # 흑여우
			if r <= 40 
				i_id = 43 # 여우고기
			end
		when 52, 53 # 서여우, 백여우
			if r <= 60 
				i_id = 43 # 여우고기
			elsif r <= 80
				i_id = 38 # 100전
			end
		when 54 # 불여우
			if r <= 60 
				i_id = 43 # 여우고기
			end
		when 55 # 전갈
			if r <= 30 
				i_id = 39 # 호박
			end
		when 56 # 전갈장
			if r <= 30 
				i_id = 40 # 진호박
			end
		when 57 # 청웅객
			i_id = []
			if r <= 50 and $game_switches[141] == true # 승급 퀘스트
				i_id.push(52) # 청웅의 환
			end
			if r <= 20
				i_id.push(51) # 낡은 수리검
			end
			
		when 58 # 수룡
			if r <= 98 
				i_id = 60 # 용의비늘
			elsif r <= 100
				i_id = 62 # 수룡의비늘
			end
		when 59 # 화룡
			if r <= 98 
				i_id = 60 # 용의비늘
			elsif r <= 100
				i_id = 61 # 화룡의비늘
			end
		when 60 # 청비
			if r <= 40 
				i_id = 53 # 갈색시약
			end
		when 61 # 주작
			if r <= 60 
				i_id = 68 # 주작의 깃
			end
		when 62 # 백호
			if r <= 60
				i_id = 69 # 백호의 발톱
			end
		when 75 # 청진웅
			if r <= 50 
				i_id = 20 # 지력의 투구1
			end
		when 76 # 청순록
			if r <= 20 
				i_id = 15 # 녹용
			elsif r <= 40
				i_id = 39 # 호박
			elsif r <= 60
				i_id = 47 # 비철단도
			end
		when 77 # 청산숲돼지
			if r <= 70 
				i_id = 50 # 청산돼지뿔
			elsif r <= 80
				i_id = 63 # 철도
			end
		when 78 # 마령해골
			if r <= 10 
				i_id = 64 # 불의 영혼봉
			elsif r <= 20
				i_id = 66 # 흑철중검
			elsif r <= 30
				i_id = 122 # 영혼죽장
			elsif r <= 40
				i_id = 125 # 흑월도
			end
		when 79 # 청철해골
			if r <= 15 
				i_id = 64 # 불의 영혼봉
			elsif r <= 30
				i_id = 66 # 흑철중검
			elsif r <= 45
				i_id = 122 # 영혼죽장
			elsif r <= 60
				i_id = 125 # 흑월도
			end
		when 80 # 청명도깨비
			if r <= 15
				i_id = 67 # 도깨비 부적
			end
		when 81 # 현랑전갈
			if r <= 10 
				i_id = 124 # 영혼마령봉
			elsif r <= 20
				i_id = 65 # 현철중검
			elsif r <= 30
				i_id = 101 # 해골죽장
			elsif r <= 40
				i_id = 123 # 야월도
			end
		when 82 # 구미호
			if r <= 60 
				i_id = 58 # 쇠조각
			end
		when 83 # 불구미호
			if r <= 60 
				i_id = 59 # 수정의조각
			end
		when 85 # 녹비
			if r <= 20 
				i_id = 54 # 초록시약
			end
		when 86 # 용
			if r <= 10 
				i_id = 60 # 용의비늘
			end
		when 100 # 일본세작
			if r <= 40 
				i_id = 39 # 호박
			elsif r <= 70
				i_id = 40 # 진호박
			end
		when 101 # 일본세작대장
			if r <= 40 
				i_id = 87 # 황금호박
			end
		when 102 # 반고
			if r <= 100
				i_id = 90 # 반고의심장
			end
		when 104 # 왕구렁이
			if r <= 30 
				i_id = 100 # 힘의투구1
			end
		when 105 # 에메랄드인형(극지방 보스)
			if r <= 30 
				i_id = 71 # 얼음
			elsif r <= 70
				i_id = 87 # 황금호박
			end	
			
		when 106 # 뱀
			if r <= 70 
				i_id = 72 # 뱀고기
			end
		when 107 # 적비
			if r <= 20 
				i_id = 55 # 빨간시약
			end
		when 108 # 겁살수
			if r <= 30 
				i_id = 55 # 빨간시약
			elsif r <= 40
				i_id = 70 # 일월대도
			end
		when 109 # 눈괴물
			if r <= 60 
				i_id = 71 # 얼음
			end
		when 110 # 북극사슴
			if r <= 60 
				i_id = 71 # 얼음
			elsif r <= 70
				i_id = 15 # 녹용
			end
		when 111 # 산적왕
			if r <= 40 
				i_id = 55 # 빨간시약
			elsif r <= 50
				i_id = 70 # 일월대도
			elsif r <= 55
				i_id = 73 # 도깨비방망이
			elsif r <= 59
				i_id = 74 # 여명의도복
			elsif r <= 64
				i_id = 75 # 산적왕의 칼
			end
		when 112 # 청룡
			if r <= 100
				i_id = 88 # 청룡의 보옥
			end
		when 113 # 현무
			if r <= 100
				i_id = 89 # 현무의 보옥
			end	
			
			#---------#
			#----12지신-#
			#---------#	
		when 116 # 범증
			if r <= 10 
				i_id = 40 # 진호박
			elsif r <= 15
				i_id = 44 # 불의 혼
			elsif r <= 16
				i_id = 76 # 현랑부
			end
		when 117 # 범천
			if r <= 10 
				i_id = 40 # 진호박
			elsif r <= 15
				i_id = 44 # 불의 혼
			elsif r <= 16
				i_id = 77 # 백화검
			end
		when 118 # 범수
			if r <= 10 
				i_id = 40 # 진호박
			elsif r <= 25
				i_id = 45 # 불의 결정
			elsif r <= 30
				i_id = 78 # 1만전
			end
		when 119 # 백호왕
			if r <= 20
				i_id = 102 # 크리스탈
			elsif r <= 40 
				i_id = 103 # 수정
			elsif r <= 70 
				i_id = 79 # 건괘
			end
		when 121 # 새끼용
			if r <= 2
				i_id = 104 # 은나무가지
			elsif r <= 40 
				i_id = 40 # 진호박
			end
		when 123 # 뱀왕
			if r <= 30 
				i_id = 80 # 곤괘
			end
		when 124 # 쥐왕
			if r <= 30 
				i_id = 81 # 감괘
			end
		when 125 # 양왕
			if r <= 2 
				i_id = 82 # 리괘
			end
		when 126 # 돼지왕
			if r <= 30 
				i_id = 83 # 진괘
			end
		when 127 # 말왕
			if r <= 2
				i_id = 84 # 선괘
			end
		when 128 # 원숭이왕
			if r <= 30 
				i_id = 85 # 태괘
			end
		when 129 # 개왕
			if r <= 2
				i_id = 86 # 간괘
			end
		when 132 # 건룡
			if r <= 50
				i_id = 105 # 건룡의어금니
			elsif r <= 70
				i_id = 104 # 은나무가지
			end
		when 133 # 감룡
			if r <= 50
				i_id = 106 # 감룡의어금니
			elsif r <= 70
				i_id = 104 # 은나무가지
			end
		when 134 # 진룡
			if r <= 50
				i_id = 107 # 진룡의어금니
			elsif r <= 70
				i_id = 104 # 은나무가지
			end
			
			#-----------#
			#-----용궁---#
			#-----------#
		when 141, 142 # 복돌, 복순
			if r <= 20
				i_id = 94 # 복어의심장
			end
		when 145 # 사산게
			if r <= 5
				i_id = 92 # 게집게
			else r <= 10
				i_id = 93 # 게등껍질
			end
		when 148 # 해마
			if r <= 2
				i_id = 91 # 해마꼬리
			end
		when 149 # 해마병사
			if r <= 20
				i_id = 95 # 해마의심장
			end
		when 151, 152 # 고양인어, 이쁜이인어
			if r <= 20
				i_id = 96 # 인어의심장
			end
		when 154, 155 # 외칼상어, 쌍칼상어
			if r <= 3
				i_id = 108 # 상어의핵
			elsif r <= 15
				i_id = 97 # 상어의심장
			end
		when 157 # 해파리수하
			i_id = []
			if r <= 5 
				i_id.push(99) # 해파리의 심장
			end
			if r <= 4 and $game_switches[378] == true # 용궁 전략문서 얻기
				i_id.push(98) # 전략문서
			end
			
			#-----------#
			#--- 일본 ----#
			#-----------#
		when 172 # 아귀
			if r <= 30 
				i_id = 111 # 희귀호박
			end
		when 173, 174, 175 # 백발귀, 적발귀, 녹발귀
			if r <= 40 
				i_id = 39 # 호박
			elsif r <= 70
				i_id = 40 # 진호박
			end
		when 176 # 백향
			if r <= 35 
				i_id = 111 # 희귀호박
			end
		when 177 # 하선녀
			if r <= 20 
				i_id = 113 # 하선녀의실타래
			end
		when 178, 179 # 단선녀, 파선녀
			if r <= 40 
				i_id = 39 # 호박
			elsif r <= 70
				i_id = 40 # 진호박
			end
		when 180 # 견귀
			if r <= 30 
				i_id = 112 # 희귀진호박
			end
		when 181 # 맹오
			if r <= 40 
				i_id = 39 # 호박
			elsif r <= 70
				i_id = 40 # 진호박
			end
		when 182 # 문위
			if r <= 40 
				i_id = 39 # 호박
			elsif r <= 70
				i_id = 40 # 진호박
			elsif r <= 90
				i_id = 45 # 불의 결정
			end
		when 183..185 # 욘,바,나주겐
			if r <= 40 
				i_id = 39 # 호박
			elsif r <= 70
				i_id = 40 # 진호박
			end
		when 194 # 문려
			if r <= 40 
				i_id = 112 # 희귀진호박
			elsif r <= 90
				i_id = 45 # 불의 결정
			end
		when 186 # 무사
			if r <= 45 
				i_id = 112 # 희귀진호박
			end
		when 187..188 # 선월, 이광
			if r <= 40 
				i_id = 39 # 호박
			elsif r <= 70
				i_id = 40 # 진호박
			end
		when 189 # 주마관
			if r <= 70 
				i_id = 112 # 희귀진호박
			end
		when 190 # 망령
			if r <= 5 
				i_id = 110 # 도깨비가죽
			end
		when 191 # 유성지
			if r <= 60 
				i_id = 114 # 유성지의보패
			end
		when 192 # 해골왕
			if r <= 60 
				i_id = 109 # 해골왕의뼈
			end
		when 193 # 파괴왕
			if r <= 60 
				i_id = 115 # 순수의강철
			end
		when 195 # 이가닌자 병
			if r <= 3 
				i_id = 120 # 검조각
			end
		when 196 # 이가닌자 수
			if r <= 3 
				i_id = 118 # 수리검
			end
		when 197 # 이가닌자 마
			if r <= 3
				i_id = 116 # 이가닌자의 독
			end
		when 198 # 이가닌자 영
			if r <= 3 
				i_id = 117 # 흑룡철심
			end
		when 199 # 이가닌자 화
			if r <= 3 
				i_id = 119 # 이가닌자의 보패
			end
			
			#------------------#
			#--------중국--------#
			#------------------#
		when 202, 205, 209 # 청인묘, 청염유, 청기린
			if r <= 30 
				i_id = 126 # 청색구슬조각
			end
		when 203, 206, 210 # 자인묘, 자염유, 자기린
			if r <= 30 
				i_id = 127 # 자색구슬조각
			end
		when 204, 207, 211, 223, 227 # 인묘, 염유장군, 흑마기린, 동괴성, 뇌신'태
			if r <= 50 
				i_id = 136 # 녹색구슬조각
			elsif r <= 100
				i_id = 137 # 갈색구슬조각
			end
		when 208 # 염유왕
			if r <= 50 
				i_id = 129 # 갈색보주
			end	
		when 212 # 기린왕
			if r <= 50 
				i_id = 130 # 자색보주
			end		
		when 213, 214 # 청악어, 자악어
			if r <= 10 
				i_id = 128 # 악어의피
			end
		when 215 # 악어왕
			if r <= 50 
				i_id = 131 # 녹색보주
			end
		when 216 # 연청산소
			if r <= 30
				i_id = 126 # 청색구슬조각
			end	
		when 217 # 연자산소
			if r <= 30 
				i_id = 127 # 자색구슬조각
			end	
		when 218 # 청산소괴
			if r <= 30 
				i_id = 126 # 청색구슬조각
			end	
		when 219 # 황산소괴
			if r <= 30 
				i_id = 127 # 자색구슬조각
			end	
		when 220 # 산소괴왕
			if r <= 60
				i_id = 133 # 동지패
			end	
		when 221 # 청괴성
			if r <= 30 
				i_id = 126 # 청색구슬조각
			end	
		when 222 # 자괴성
			if r <= 30 
				i_id = 127 # 자색구슬조각
			end	
		when 224 # 괴성왕
			if r <= 30 
				i_id = 132 # 청색보주
			end	
		when 225 # 뇌신'청
			if r <= 30 
				i_id = 126 # 청색구슬조각
			end	
		when 226 # 뇌신'자
			if r <= 30 
				i_id = 127 # 자색구슬조각
			end	
		when 228 # 뇌신'왕
			if r <= 60 
				i_id = 134 # 동인패
			end	
		when 229 # 연청천구
			if r <= 30 
				i_id = 136 # 녹색구슬조각
			end	
		when 230 # 연자천구
			if r <= 30 
				i_id = 137 # 갈색구슬조각
			end	
		when 231 # 천구왕
			if r <= 60
				i_id = 135 # 동천패
			end	
		end
		
		if i_id != 0
			if i_id.is_a?(Array)
				for i in i_id
					보관이벤트(i.to_i).moveto(e.event.x, e.event.y)
					Network::Main.socket.send "<drop_create>#{$game_map.map_id},#{i.to_i},#{e.event.x},#{e.event.y}</drop_create>\n"
					Network::Main.socket.send "<map_item>#{$game_map.map_id},#{i.to_i},#{e.event.x},#{e.event.y}</map_item>\n"
				end
			else
				보관이벤트(i_id).moveto(e.event.x, e.event.y)
				Network::Main.socket.send "<drop_create>#{$game_map.map_id},#{i_id},#{e.event.x},#{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id},#{i_id},#{e.event.x},#{e.event.y}</map_item>\n"
			end
		end
	end
end
