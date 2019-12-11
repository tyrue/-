class MrMo_ABS
	#--------------------------------------------------------------------------
	# * 몬스터마다의 템 줄 확률 설정
	#--------------------------------------------------------------------------
	def drop_enemy(e)
		#Get Enemy
		#enemy = $data_enemies[id[1].to_i]
		#p "e : #{e.id.to_i} mapid : #{$game_map.map_id} x : #{e.event.x} y : #{e.event.y}"
		r = rand(100)
		case e.id.to_i
		when 1 # 토끼
			if r <= 80 
				# 토끼 고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 13 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 13 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 90
				# 토끼 화서
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 36 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 36 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true	
		when 2 # 다람쥐
			if r <= 80 
				# 도토리
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 12 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 12 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 90
				# 다람쥐 화서
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 35 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 35 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 3 # 암사슴
			if r <= 70 
				# 사슴고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 14 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 14 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 4 # 숫사슴
			if r <= 50 
				# 녹용
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 15 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 15 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 5 # 늑대
			if r <= 40 
				# 100전
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 6 # 소
			if r <= 60 
				# 쇠고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 17 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 17 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 7 # 돼지
			if r <= 70 
				# 돼지고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 16 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 16 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 8 # 쥐
			if r <= 70 
				# 쥐고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 41 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 41 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 9 # 병든쥐
			if r <= 70 
				# 쥐고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 41 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 41 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 90
				# 100전
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 10 # 시궁창쥐
			if r <= 30 
				# 100전 
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 11 # 박쥐
			if r <= 60 
				# 박쥐고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 42 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 42 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 12 # 보라박쥐
			if r <= 60 
				# 박쥐고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 42 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 42 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 80 
				# 100전 
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 13 # 평웅
			if r <= 70 
				# 웅담
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 19 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 19 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 14 # 진웅
			if r <= 10 
				# 지력의 투구 1
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 20 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 20 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 15 # 호랑이
			if r <= 50
				# 호랑이고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 18 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 18 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 16 # 평호
			if r <= 70 
				# 호랑이고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 18 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 18 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 17 # 진호
			if r <= 40 
				# 호랑이고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 18 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 18 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 90
				# 지력의투구1
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 20 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 20 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 21 # 산돼지
			if r <= 60 
				# 산돼지고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 21 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 21 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 80
				# 돼지의 뿔
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 23 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 23 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 22 # 숲돼지
			if r <= 60
				# 숲돼지고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 22 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 22 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 80
				# 돼지의 뿔
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 23 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 23 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 23 # 주홍사슴
			if r <= 80 
				# 사슴고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 14 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 14 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 25 # 흑/백순록
			if r <= 80 
				# 녹용
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 15 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 15 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 26 # 자호
			if r <= 60 
				# 짙은호랑이고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 37 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 37 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 27, 28 # 천자호, 구자호
			if r <= 60 
				# 짙은호랑이고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 37 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 37 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 80
				# 100전
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 29 # 적호
			if r <= 30 
				# 짙은호랑이고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 37 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 37 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 50
				# 100전
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 70
				# 철도
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 63 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 63 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 30, 31 # 해골, 날쌘해골
			if r <= 60 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 32, 33 # 자해골, 흑해골
			if r <= 50 
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 34, 35 # 달걀귀신, 몽달귀신
			if r <= 70 
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 39 # 불귀신
			if r <= 60 
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 80
				# 불의 혼
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 44 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 44 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 90
				# 불의 결정
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 45 #{e.event.x} #{e.event.y}</drop_create>\n"				
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 45 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 38 # 짚단
			if r <= 70 
				# 짚단
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 48 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 48 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 40 # 자생원
			if r <= 90 
				# 200전
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 49 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 49 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 41 # 청자다람쥐
			if r <= 10 
				# 작은보물상자
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 56 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 56 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 15
				# 고급보물상자
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 57 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 57 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 16
				# 최고급보물상자
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 121 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 121 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 47, 48 # 도깨비, 불도깨비
			if r <= 40 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 60
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 49 # 고래
			if r <= 30 
				# 작은보물상자
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 56 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 56 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 90
				# 고급보물상자
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 57 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 57 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 95
				# 최고급보물상자
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 121 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 121 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 50 # 녹웅객
			if r <= 60 
				# 낡은 수리검
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 51 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 51 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 51 # 흑여우
			if r <= 40 
				# 여우고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 43 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 43 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 52, 53 # 서여우, 백여우
			if r <= 60 
				# 여우고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 43 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 43 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 80
				# 100전
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 38 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 54 # 불여우
			if r <= 60 
				# 여우고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 43 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 43 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 55 # 전갈
			if r <= 30 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 56 # 전갈장
			if r <= 30 
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 57 # 청웅객
			if r <= 60 and $game_switches[141] == true # 승급 퀘스트
				# 청웅의 환
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 52 #{e.event.x} #{e.event.y}</drop_create>\n"
			end
			
			if r <= 62 
				# 낡은 수리검
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 51 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 51 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			
			return true
		when 58 # 수룡
			if r <= 98 
				# 용의비늘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 60 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 60 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 99
				# 수룡의비늘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 62 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 62 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 59 # 화룡
			if r <= 98 
				# 용의비늘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 60 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 60 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 99
				# 화룡의비늘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 61 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 61 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 60 # 청비
			if r <= 40 
				# 갈색시약
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 53 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 53 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 61 # 주작
			if r <= 100 
				# 주작의 깃
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 68 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 68 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 62 # 백호
			if r <= 100
				# 백호의 발톱
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 69 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 69 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 75 # 청진웅
			if r <= 50 
				# 지력의 투구1
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 20 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 20 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 76 # 청순록
			if r <= 20 
				# 녹용
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 15 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 15 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 40
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 60
				# 비철단도
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 47 #{e.event.x} #{e.event.y}</drop_create>\n"	
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 47 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 77 # 청산숲돼지
			if r <= 80 
				# 청산돼지뿔
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 50 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 50 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 78 # 마령해골
			if r <= 10 
				# 불의 영혼봉
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 64 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 64 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 20
				# 흑철중검
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 66 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 66 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 30
				# 영혼죽장
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 122 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 122 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 40
				# 흑월도
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 125 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 125 #{e.event.x} #{e.event.y}</map_item>\n"	
			end
			return true
		when 79 # 청철해골
			if r <= 15 
				# 불의 영혼봉
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 64 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 64 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 30
				# 흑철중검
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 66 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 66 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 45
				# 영혼죽장
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 122 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 122 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 60
				# 흑월도
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 125 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 125 #{e.event.x} #{e.event.y}</map_item>\n"	
			end
			return true
		when 80 # 청명도깨비
			if r <= 15
				# 도깨비 부적
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 67 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 67 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 81 # 현랑전갈
			if r <= 10 
				# 영혼마령봉
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 124 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 124 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 20
				# 현철중검
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 65 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 65 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 30
				# 해골죽장
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 101 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 101 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 40
				# 야월도
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 123 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 123 #{e.event.x} #{e.event.y}</map_item>\n"	
			end
			return true
		when 82 # 구미호
			if r <= 40 
				# 쇠조각
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 58 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 58 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 83 # 불구미호
			if r <= 40 
				# 수정의조각
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 59 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 59 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 85 # 녹비
			if r <= 20 
				# 초록시약
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 54 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 54 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 86 # 용
			if r <= 30 
				# 용의비늘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 60 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 60 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 100 # 일본세작
			if r <= 40 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 70
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 101 # 일본세작대장
			if r <= 40 
				# 황금호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 87 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 87 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 102 # 반고
			if r <= 100
				# 반고의심장
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 90 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 90 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 104 # 왕구렁이
			if r <= 30 
				# 힘의투구1
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 100 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 100 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 106 # 뱀
			if r <= 60 
				# 뱀고기
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 72 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 72 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			return true
		when 107 # 적비
			if r <= 20 
				# 빨간시약
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 55 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 55 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			end
		when 108 # 겁살수
			if r <= 30 
				# 빨간시약
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 55 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 55 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			elsif r <= 40
				# 일월대도
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 70 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 70 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			end
		when 109 # 눈괴물
			if r <= 60 
				# 얼음
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 71 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 71 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			end
		when 110 # 북극사슴
			if r <= 60 
				# 얼음
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 71 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 71 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			elsif r <= 70
				# 녹용
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 15 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 15 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			end
		when 111 # 산적왕
			if r <= 40 
				# 빨간시약
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 55 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 55 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			elsif r <= 50
				# 일월대도
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 70 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 70 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			elsif r <= 55
				# 도깨비방망이
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 73 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 73 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			elsif r <= 59
				# 여명의도복
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 74 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 74 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			elsif r <= 64
				# 산적왕의 칼
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 75 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 75 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			end
		when 112 # 청룡
			if r <= 100
				# 청룡의 보옥
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 88 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 88 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			end
		when 113 # 현무
			if r <= 100
				# 현무의 보옥
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 89 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 89 #{e.event.x} #{e.event.y}</map_item>\n"
				return true
			end	
			
		when 116 # 범증
			if r <= 10 
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 15
				# 불의 혼
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 44 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 44 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 20
				# 현랑부
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 76 #{e.event.x} #{e.event.y}</drop_create>\n"				
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 76 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 117 # 범천
			if r <= 10 
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 15
				# 불의 혼
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 44 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 44 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 19
				# 백화검
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 77 #{e.event.x} #{e.event.y}</drop_create>\n"				
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 77 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 118 # 범수
			if r <= 10 
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 15
				# 불의 결정
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 45 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 45 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 20
				# 1만전
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 78 #{e.event.x} #{e.event.y}</drop_create>\n"				
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 78 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			
			# 12지신
		when 119 # 백호왕
			if r <= 20
				# 크리스탈
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 102 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 102 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 40 
				# 수정
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 103 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 103 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			if r <= 90 
				# 건괘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 79 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 79 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 120 # 용왕용마
			if r <= 40 
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 121 # 새끼용
			if r <= 5
				# 은나무가지
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 104 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 104 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 40 
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 123 # 뱀왕
			if r <= 40 
				# 곤괘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 80 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 80 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 124 # 쥐왕
			if r <= 40 
				# 감괘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 81 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 81 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 125 # 양왕
			if r <= 4 
				# 리괘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 82 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 82 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 126 # 돼지왕
			if r <= 40 
				# 진괘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 83 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 83 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 127 # 말왕
			if r <= 4
				# 선괘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 84 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 84 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 128 # 원숭이왕
			if r <= 40 
				# 태괘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 85 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 85 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 129 # 개왕
			if r <= 4
				# 간괘
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 86 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 86 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 132 # 건룡
			if r <= 70
				# 건룡의어금니
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 105 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 105 #{e.event.x} #{e.event.y}</map_item>\n"
			else
				# 은나무가지
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 104 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 104 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 133 # 감룡
			if r <= 70
				# 감룡의어금니
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 106 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 106 #{e.event.x} #{e.event.y}</map_item>\n"
			else
				# 은나무가지
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 104 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 104 #{e.event.x} #{e.event.y}</map_item>\n"
			end	
		when 134 # 진룡
			if r <= 70
				# 진룡의어금니
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 107 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 107 #{e.event.x} #{e.event.y}</map_item>\n"
			else
				# 은나무가지
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 104 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 104 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			
			#-----------#
			#-----용궁---#
			#-----------#
		when 141, 142 # 복돌, 복순
			if r <= 20
				# 복어의심장
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 94 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 94 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 145 # 사산게
			if r <= 5
				# 게집게
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 92 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 92 #{e.event.x} #{e.event.y}</map_item>\n"
			else r <= 10
				# 게등껍질
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 93 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 93 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 148 # 해마
			if r <= 2
				# 해마꼬리
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 91 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 91 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 149 # 해마병사
			if r <= 20
				# 해마의심장
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 95 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 95 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 151, 152 # 고양인어, 이쁜이인어
			if r <= 20
				# 인어의심장
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 96 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 96 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 154, 155 # 외칼상어, 쌍칼상어
			if r <= 3
				# 상어의핵
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 108 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 108 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 15
				# 상어의심장
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 97 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 97 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 157 # 해파리수하
			if r <= 10 and $game_switches[378] == true # 용궁 전략문서 얻기
				# 전략문서
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 98 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 98 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			if r <= 5 
				# 해파리의 심장
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 99 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 99 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			
			#-----------#
			#--- 일본 ----#
			#-----------#
		when 172 # 아귀
			if r <= 30 
				# 희귀호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 111 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 111 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 173, 174, 175 # 백발귀, 적발귀, 녹발귀
			if r <= 40 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 70
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 176 # 백향
			if r <= 30 
				# 희귀호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 111 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 111 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 177 # 하선녀
			if r <= 10 
				# 하선녀의실타래
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 113 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 113 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 178, 179 # 단선녀, 파선녀
			if r <= 40 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 70
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 180 # 견귀
			if r <= 30 
				# 희귀진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 112 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 112 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 181 # 맹오
			if r <= 40 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 70
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 182 # 문위
			if r <= 40 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 70
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 90
				# 불의 결정
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 45 #{e.event.x} #{e.event.y}</drop_create>\n"				
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 45 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 183..185 # 욘,바,나주겐
			if r <= 40 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 70
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 194 # 문려
			if r <= 30 
				# 희귀진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 112 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 112 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 90
				# 불의 결정
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 45 #{e.event.x} #{e.event.y}</drop_create>\n"				
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 45 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 186 # 무사
			if r <= 40 
				# 희귀진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 112 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 112 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 187..188 # 선월, 이광
			if r <= 40 
				# 호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 39 #{e.event.x} #{e.event.y}</map_item>\n"
			elsif r <= 70
				# 진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 40 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 189 # 주마관
			if r <= 70 
				# 희귀진호박
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 112 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 112 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 190 # 망령
			if r <= 10 
				# 도깨비가죽
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 110 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 110 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 191 # 유성지
			if r <= 60 
				# 유성지의보패
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 114 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 114 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 192 # 해골왕
			if r <= 60 
				# 해골왕의뼈
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 109 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 109 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 193 # 파괴왕
			if r <= 60 
				# 순수의강철
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 115 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 115 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 195 # 이가닌자 병
			if r <= 3 
				# 검조각
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 120 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 120 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 196 # 이가닌자 수
			if r <= 3 
				# 수리검
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 118 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 118 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 197 # 이가닌자 마
			if r <= 3
				# 이가닌자의 독
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 116 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 116 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 198 # 이가닌자 영
			if r <= 3 
				# 흑룡철심
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 117 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 117 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 199 # 이가닌자 화
			if r <= 3 
				# 이가닌자의 보패
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 119 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 119 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			
			#------------------#
			#--------중국--------#
			#------------------#
		when 202 # 청인묘
			if r <= 30 
				# 청색구슬조각
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 126 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 126 #{e.event.x} #{e.event.y}</map_item>\n"
			end
		when 203 # 자인묘
			if r <= 30 
				# 자색구슬조각
				Network::Main.socket.send "<drop_create>#{$game_map.map_id} 127 #{e.event.x} #{e.event.y}</drop_create>\n"
				Network::Main.socket.send "<map_item>#{$game_map.map_id} 127 #{e.event.x} #{e.event.y}</map_item>\n"
			end
			
		end
	end
end