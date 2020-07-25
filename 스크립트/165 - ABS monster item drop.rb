class MrMo_ABS
	#--------------------------------------------------------------------------
	# * 아이템의 처리
	#--------------------------------------------------------------------------
	def take_item(type, id, num) # 아이템의 종류(무기, 방어구, 아이템), id, 개수
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
		end
		$console.write_line("#{item.name} #{num}개 획득, 현재 #{n}개")
		
		eid = $game_variables[218]
		ex = $game_variables[215]
		ey = $game_variables[216]
		
		Network::Main.socket.send "<drop_del>#{$game_map.map_id} #{eid}</drop_del>\n"
		Network::Main.socket.send "<del_item>#{$game_map.map_id} #{eid} #{ex} #{ey} </del_item>\n"
	end
	
	
	
	#--------------------------------------------------------------------------
	# * 몬스터마다의 템 줄 확률 설정
	#--------------------------------------------------------------------------
	def drop_enemy(e)
		#Get Enemy
		#enemy = $data_enemies[id[1].to_i]
		#p "e : #{e.id.to_i} mapid : #{$game_map.map_id} x : #{e.event.x} y : #{e.event.y}"
		r = rand(100)
		i_id = 0
		case e.id.to_i
		when 1 # 토끼
			if r <= 80 
				i_id = 13 # 토끼 고기
			elsif r <= 90
				i_id = 36 # 토끼 화서
			end	
		when 2 # 다람쥐
			if r <= 80 
				i_id = 12 # 도토리
			elsif r <= 90
				i_id = 35 # 다람쥐 화서
			end
		when 3 # 암사슴
			if r <= 70 
				i_id = 14 # 사슴고기
			end
		when 4 # 숫사슴
			if r <= 50 
				i_id = 15 # 녹용
			end
		when 5 # 늑대
			if r <= 40 
				i_id = 38 # 100전
			end
		when 6 # 소
			if r <= 60 
				i_id = 17 # 쇠고기
			end
		when 7 # 돼지
			if r <= 70 
				i_id = 16 # 돼지고기
			end
		when 8 # 쥐
			if r <= 70 
				i_id = 41 # 쥐고기
			end
		when 9 # 병든쥐
			if r <= 70 
				i_id = 41 # 쥐고기
			elsif r <= 90
				i_id = 38 # 100전
			end
		when 10 # 시궁창쥐
			if r <= 30 
				i_id = 38 # 100전 
			end
		when 11 # 박쥐
			if r <= 60 
				i_id = 42 # 박쥐고기
			end
		when 12 # 보라박쥐
			if r <= 60 
				i_id = 42 # 박쥐고기
			elsif r <= 80 
				i_id = 38 # 100전 
			end
		when 13 # 평웅
			if r <= 70 
				i_id = 19 # 웅담
			end
		when 14 # 진웅
			if r <= 10 
				i_id = 20 # 지력의 투구 1
			end
		when 15 # 호랑이
			if r <= 50
				i_id = 18 # 호랑이고기
			end
		when 16 # 평호
			if r <= 70 
				i_id = 18 # 호랑이고기
			end
		when 17 # 진호
			if r <= 40 
				i_id = 18 # 호랑이고기
			elsif r <= 90
				i_id = 20 # 지력의투구1
			end
		when 21 # 산돼지
			if r <= 60 
				i_id = 21 # 산돼지고기
			elsif r <= 80
				i_id = 23 # 돼지의 뿔
			end
		when 22 # 숲돼지
			if r <= 60
				i_id = 22 # 숲돼지고기
			elsif r <= 80
				i_id = 23 # 돼지의 뿔
			end
		when 23 # 주홍사슴
			if r <= 80 
				i_id = 14 # 사슴고기
			end
		when 25 # 흑/백순록
			if r <= 80 
				i_id = 15 # 녹용
			end
		when 26 # 자호
			if r <= 60 
				i_id = 37 # 짙은호랑이고기
			end
		when 27, 28 # 천자호, 구자호
			if r <= 60 
				i_id = 37 # 짙은호랑이고기
			elsif r <= 80
				i_id = 38 # 100전
			end
		when 29 # 적호
			if r <= 30 
				i_id = 37 # 짙은호랑이고기
			elsif r <= 50
				i_id = 38 # 100전
			elsif r <= 70
				i_id = 63 # 철도
			end
		when 30, 31 # 해골, 날쌘해골
			if r <= 60 
				i_id = 39 # 호박
			end
		when 32, 33 # 자해골, 흑해골
			if r <= 50 
				i_id = 40 # 진호박
			end
		when 34, 35 # 달걀귀신, 몽달귀신
			if r <= 70 
				i_id = 40 # 진호박
			end
		when 39 # 불귀신
			if r <= 60 
				i_id = 40 # 진호박
			elsif r <= 80
				i_id = 44 # 불의 혼
			elsif r <= 90
				i_id = 45 # 불의 결정
			end
		when 38 # 짚단
			if r <= 70 
				i_id = 48 # 짚단
			end
		when 40 # 자생원
			if r <= 90 
				i_id = 49 # 200전
			end
		when 41 # 청자다람쥐
			if r <= 10 
				i_id = 56 # 작은보물상자
			elsif r <= 15
				i_id = 57 # 고급보물상자
			elsif r <= 16
				i_id = 121 # 최고급보물상자
			end
		when 47, 48 # 도깨비, 불도깨비
			if r <= 40 
				i_id = 39 # 호박
			elsif r <= 60
				i_id = 40 # 진호박
			end
		when 49 # 고래
			if r <= 30 
				i_id = 56 # 작은보물상자
			elsif r <= 90
				i_id = 57 # 고급보물상자
			elsif r <= 95
				i_id = 121 # 최고급보물상자
			end
		when 50 # 녹웅객
			if r <= 60 
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
			if r <= 60 and $game_switches[141] == true # 승급 퀘스트
				i_id = 52 # 청웅의 환
			end
			if r <= 62 
				i_id = 51 # 낡은 수리검
			end
		when 58 # 수룡
			if r <= 98 
				i_id = 60 # 용의비늘
			elsif r <= 99
				i_id = 62 # 수룡의비늘
			end
		when 59 # 화룡
			if r <= 98 
				i_id = 60 # 용의비늘
			elsif r <= 99
				i_id = 61 # 화룡의비늘
			end
		when 60 # 청비
			if r <= 40 
				i_id = 53 # 갈색시약
			end
		when 61 # 주작
			if r <= 100 
				i_id = 68 # 주작의 깃
			end
		when 62 # 백호
			if r <= 100
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
			if r <= 30 
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
		when 106 # 뱀
			if r <= 60 
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
			elsif r <= 17
				i_id = 76 # 현랑부
			end
		when 117 # 범천
			if r <= 10 
				i_id = 40 # 진호박
			elsif r <= 15
				i_id = 44 # 불의 혼
			elsif r <= 17
				i_id = 77 # 백화검
			end
		when 118 # 범수
			if r <= 10 
				i_id = 40 # 진호박
			elsif r <= 15
				i_id = 45 # 불의 결정
			elsif r <= 20
				i_id = 78 # 1만전
			end
		when 119 # 백호왕
			if r <= 20
				i_id = 102 # 크리스탈
			elsif r <= 40 
				i_id = 103 # 수정
			elsif r <= 90 
				i_id = 79 # 건괘
			end
		when 120 # 용왕용마
			if r <= 40 
				i_id = 40 # 진호박
			end
		when 121 # 새끼용
			if r <= 5
				i_id = 104 # 은나무가지
			elsif r <= 40 
				i_id = 40 # 진호박
			end
		when 123 # 뱀왕
			if r <= 40 
				i_id = 80 # 곤괘
			end
		when 124 # 쥐왕
			if r <= 40 
				i_id = 81 # 감괘
			end
		when 125 # 양왕
			if r <= 3 
				i_id = 82 # 리괘
			end
		when 126 # 돼지왕
			if r <= 40 
				i_id = 83 # 진괘
			end
		when 127 # 말왕
			if r <= 3
				i_id = 84 # 선괘
			end
		when 128 # 원숭이왕
			if r <= 40 
				i_id = 85 # 태괘
			end
		when 129 # 개왕
			if r <= 3
				i_id = 86 # 간괘
			end
		when 132 # 건룡
			if r <= 70
				i_id = 105 # 건룡의어금니
			else
				i_id = 104 # 은나무가지
			end
		when 133 # 감룡
			if r <= 70
				i_id = 106 # 감룡의어금니
			else
				i_id = 104 # 은나무가지
			end	
		when 134 # 진룡
			if r <= 70
				i_id = 107 # 진룡의어금니
			else
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
			if r <= 6 and $game_switches[378] == true # 용궁 전략문서 얻기
				i_id = 98 # 전략문서
			end
			if r <= 5 
				i_id = 99 # 해파리의 심장
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
			if r <= 10 
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
			if r <= 10 
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
				i_id = 126 # 청색구슬조각
			elsif r <= 100
				i_id = 127 # 자색구슬조각
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
			if r <= 15 
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
			if r <= 15 
				i_id = 134 # 동인패
			end	
		when 229 # 연청천구
			if r <= 30 
				i_id = 126 # 청색구슬조각
			end	
		when 230 # 연자천구
			if r <= 30 
				i_id = 127 # 자색구슬조각
			end	
		when 231 # 천구왕
			if r <= 15
				i_id = 135 # 동천패
			end	

		end
		if i_id != 0
			보관이벤트(i_id).moveto(e.event.x, e.event.y)
			Network::Main.socket.send "<drop_create>#{$game_map.map_id} #{i_id} #{e.event.x} #{e.event.y}</drop_create>\n"
			Network::Main.socket.send "<map_item>#{$game_map.map_id} #{i_id} #{e.event.x} #{e.event.y}</map_item>\n"
		end
	end
end