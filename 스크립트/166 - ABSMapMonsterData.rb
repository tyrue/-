#--------------------#
# 맵별로 몬스터 데이터 저장용
#--------------------#

# [[몬스터 id, 개수], []....]
MAP_MONSTER_DATA = {}
# 부여성
MAP_MONSTER_DATA[44] = [[63, 15]] # 흑해골굴1 : 황해골
MAP_MONSTER_DATA[45] = [[63, 15]] # 흑해골굴2 : 황해골

MAP_MONSTER_DATA[453] = [[64, 15], [65, 15]] # 인형굴1 : 목각인형, 양철인형
MAP_MONSTER_DATA[454] = [[64, 15], [65, 15], [66, 1]] # 인형굴1 : 목각인형, 양철인형, 인형술사

# 2차 승급 
MAP_MONSTER_DATA[72] = [[86, 22]] # 수룡의방 : 용
MAP_MONSTER_DATA[73] = [[86, 22]] # 화룡의방 : 용

# 3차 승급
MAP_MONSTER_DATA[79] = [[87, 15]] # 주작의방 : 수호주작
MAP_MONSTER_DATA[80] = [[88, 15]] # 백호의방 : 수호백호

# 4차 승급
MAP_MONSTER_DATA[200] = [[114, 7]] # 청룡의방 : 수호청룡
MAP_MONSTER_DATA[201] = [[103, 7]] # 현무의방 : 수호현무

# 한두고개
MAP_MONSTER_DATA[409] = [[1, 10], [2, 10], [7, 10], [106, 10]] # 한고개입구 : 다람쥐, 토끼, 돼지, 뱀
MAP_MONSTER_DATA[441] = [[262, 6], [263, 6], [264, 6], [265, 6]] # 한고개4 : 빨간토끼, 노란토끼, 초록토끼, 미친토끼
MAP_MONSTER_DATA[442] = [[262, 6], [263, 6], [264, 6], [265, 6]] # 한고개5 : 빨간토끼, 노란토끼, 초록토끼, 미친토끼
MAP_MONSTER_DATA[423] = [[275, 10], [276, 10], [277, 10], [278, 10], [279, 2]] # 세고개 : 힘의돼지, 민첩의돼지, 지력의돼지, 손재주의돼지, 돈돈돈
MAP_MONSTER_DATA[424] = [[280, 7], [281, 7], [282, 7], [283, 7], [284, 2]] # 네고개1 : 힘의뱀, 민첩의뱀, 지력의뱀, 손재주의뱀, 주사
MAP_MONSTER_DATA[425] = [[280, 7], [281, 7], [282, 7], [283, 7], [285, 2]] # 네고개2 : 힘의뱀, 민첩의뱀, 지력의뱀, 손재주의뱀, 력사
MAP_MONSTER_DATA[426] = [[280, 7], [281, 7], [282, 7], [283, 7], [286, 2]] # 네고개3 : 힘의뱀, 민첩의뱀, 지력의뱀, 손재주의뱀, 민사
MAP_MONSTER_DATA[427] = [[280, 7], [281, 7], [282, 7], [283, 7], [287, 2]] # 네고개4 : 힘의뱀, 민첩의뱀, 지력의뱀, 손재주의뱀, 지사
MAP_MONSTER_DATA[428] = [[280, 7], [281, 7], [282, 7], [283, 7], [288, 2]] # 네고개5 : 힘의뱀, 민첩의뱀, 지력의뱀, 손재주의뱀, 재사
MAP_MONSTER_DATA[429] = [[280, 7], [281, 7], [282, 7], [283, 7], [284, 1], [285, 1], [286, 1], [287, 1], [288, 1]] # 네고개6 : 힘의뱀, 민첩의뱀, 지력의뱀, 손재주의뱀, 주사, 력사, 민사, 지사, 재사
MAP_MONSTER_DATA[93] = [[280, 7], [281, 7], [282, 7], [283, 7], [284, 1], [285, 1], [286, 1], [287, 1], [288, 1]] # 네고개7 : 힘의뱀, 민첩의뱀, 지력의뱀, 손재주의뱀, 주사, 력사, 민사, 지사, 재사

MAP_MONSTER_DATA[430] = [[32, 1]] # 테스트용 : 

# 도삭산
MAP_MONSTER_DATA[432] = [[233, 7], [234, 7], [235, 7], [236, 8]] # 도삭산1 : 산신전사, 산신도사, 산신도적, 산신주술사
MAP_MONSTER_DATA[433] = [[233, 7], [234, 7], [235, 7], [236, 8]] # 도삭산2 : 산신전사, 산신도사, 산신도적, 산신주술사
MAP_MONSTER_DATA[434] = [[233, 7], [234, 7], [235, 7], [236, 8]] # 도삭산3 : 산신전사, 산신도사, 산신도적, 산신주술사
MAP_MONSTER_DATA[435] = [[233, 7], [234, 7], [235, 7], [236, 8]] # 도삭산4 : 산신전사, 산신도사, 산신도적, 산신주술사
MAP_MONSTER_DATA[436] = [[233, 7], [234, 7], [235, 7], [236, 8]] # 도삭산5 : 산신전사, 산신도사, 산신도적, 산신주술사
MAP_MONSTER_DATA[437] = [[233, 7], [234, 7], [235, 7], [236, 8]] # 도삭산6 : 산신전사, 산신도사, 산신도적, 산신주술사
MAP_MONSTER_DATA[438] = [[233, 7], [234, 7], [235, 7], [236, 8]] # 도삭산7 : 산신전사, 산신도사, 산신도적, 산신주술사
MAP_MONSTER_DATA[439] = [[233, 7], [234, 7], [235, 7], [236, 8]] # 도삭산 정상 : 산신전사, 산신도사, 산신도적, 산신주술사

# 환상의섬
#MAP_MONSTER_DATA[448] = [[41, 1]] # 가릉빈가 섬 : 가릉빈가

class MrMo_ABS
	def getMapMonsterData
		if MAP_MONSTER_DATA[$game_map.map_id] != nil
			for data in MAP_MONSTER_DATA[$game_map.map_id]
				id = data[0] if data[0] != nil
				num = data[1] if data[1] != nil
				create_abs_monsters(id, num)
			end
		end
	end
end