#----------------------------------------------------------------------------------
# 진도우 퀘스트 창
#----------------------------------------------------------------------------------
QUEST_DATA = {}
# id는 퀘스트 스위치 : 클라이언트에서 직접 확인해서 넣기
# 부여성
QUEST_DATA[0] = {
	"title" => "나무꾼에게 짚 건네주기", 						# 퀘스트 제목
	"region" => "부여성",						# 퀘스트 위치
	"requester" => "나무꾼", 				# 의뢰자 이름
	"body" => [
		"나무꾼에게 짚을 구해 건네주자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 41, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 117
}

QUEST_DATA[0] = {
	"title" => "나무꾼에게 나무 해주기", 						# 퀘스트 제목
	"region" => "부여성 강가",						# 퀘스트 위치
	"requester" => "나무꾼", 				# 의뢰자 이름
	"body" => [
		"나무꾼에게 쇠도끼를 받아 나무를 해오자",
	],			# 퀘스트 내용
	
	"close_switch" => 118
}

QUEST_DATA[118] = {
	"title" => "나무꾼에게 나무 해주기2", 						# 퀘스트 제목
	"region" => "부여성 강가",						# 퀘스트 위치
	"requester" => "나무꾼", 				# 의뢰자 이름
	"body" => [
		"강가의 좋은나무를 쇠도끼로 열심히 때리자",
	],			# 퀘스트 내용
	
	"close_switch" => 120
}

QUEST_DATA[0] = {
	"title" => "고통속의 사슴을 구해주기", 						# 퀘스트 제목
	"region" => "부여성 사슴굴5",						# 퀘스트 위치
	"requester" => "고통속의사슴", 				# 의뢰자 이름
	"body" => [
		"고통속의 사슴을 고통에서 해방시켜주자",
	],			# 퀘스트 내용
	"item_data" => [[0, 43, 1]],
	"close_switch" => 122
}

QUEST_DATA[275] = {
	"title" => "친구 안부 묻기1", 						# 퀘스트 제목
	"region" => "부여성",						# 퀘스트 위치
	"requester" => "여행자", 				# 의뢰자 이름
	"body" => [
		"고균도에 여행중인 여행자의 친구에게 안부를 묻자"
	],			# 퀘스트 내용
	"close_switch" => 276
}

QUEST_DATA[276] = {
	"title" => "친구 안부 묻기2", 						# 퀘스트 제목
	"region" => "고균도",						# 퀘스트 위치
	"requester" => "여행자", 				# 의뢰자 이름
	"body" => [
		"부여성의 여행자에게 안부를 전해주자"
	],			# 퀘스트 내용
	"close_switch" => 277
}


QUEST_DATA[300] = {
	"title" => "제비 도와주기", 						# 퀘스트 제목
	"region" => "부여성",						# 퀘스트 위치
	"requester" => "제비", 				# 의뢰자 이름
	"body" => [
		"배고픈 제비에게 도토리를 구해주자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 3, 30]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 301
}

QUEST_DATA[328] = {
	"title" => "조리부의 부탁", 						# 퀘스트 제목
	"region" => "고균도",						# 퀘스트 위치
	"requester" => "조리부", 				# 의뢰자 이름
	"body" => [
		"부여성의 도깨비굴 장쇠에게 두루마리를 전해주자"
	],			# 퀘스트 내용
	"close_switch" => 329
}

QUEST_DATA[329] = {
	"title" => "장쇠의 부탁", 						# 퀘스트 제목
	"region" => "부여성",						# 퀘스트 위치
	"requester" => "장쇠", 				# 의뢰자 이름
	"body" => [
		"고균도의 조리부에게 장쇠의 두루마리를 전해주자"
	],			# 퀘스트 내용
	"close_switch" => 330
}

# 승급
QUEST_DATA[141] = {
	"title" => "청웅환 가져오기", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"고균도에서 청웅의환을 가져오자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 51, 50]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 142
}

QUEST_DATA[142] = {
	"title" => "불의결정 가져오기", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"승급을 위해 불의결정을 가져오자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 37, 5]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 143
}

QUEST_DATA[147] = {
	"title" => "수화룡의 비늘 가져오기", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"승급을 위해 수, 화룡의 비늘을 가져오자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 52, 1], [0, 53, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 150
}

QUEST_DATA[152] = {
	"title" => "주작/백호의 인정 받기", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"승급을 위해 주작/백호를 잡아 전리품을 습득하자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 54, 1], [0, 55, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 155
}

QUEST_DATA[355] = {
	"title" => "4차 승급의 길(1) : 팔괘", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"12지신의 왕들에게 괘를 모아 팔괘를 만들자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 114, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 356
}

QUEST_DATA[356] = {
	"title" => "4차 승급의 길(2) : 청룡/현무", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"청룡과 현무의 보옥을 얻어오자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 117, 1], [0, 118, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 357
}

QUEST_DATA[357] = {
	"title" => "4차 승급의 길 마지막 : 반고", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"세상에 혼돈을 불러오는 반고를 사냥하자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 119, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 358
}

# 용궁
QUEST_DATA[398] = {
	"title" => "용궁정화1", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "좌선녀", 				# 의뢰자 이름
	"body" => [
		"한두고개 어딘가에서 용궁정화의 단서를 구하자!",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 146, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 399
}

QUEST_DATA[399] = {
	"title" => "용궁정화2", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "좌선녀", 				# 의뢰자 이름
	"body" => [
		"일본의 숲의장인에게 숯의정화를 구하자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 147, 5]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 400
}

QUEST_DATA[376] = {
	"title" => "우선녀의 용왕님 건강식 만들기", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "우선녀", 				# 의뢰자 이름
	"body" => [
		"용왕님께 건강식을 만들기 위한 재료를 구해주자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 134, 1], [0, 135, 1], [0, 136, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
}

QUEST_DATA[361] = {
	"title" => "복어장군 잡기", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"복어장군을 잡아 반란의 정보를 캐내자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 130, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 385
}

QUEST_DATA[362] = {
	"title" => "게장군 잡기", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"게장군을 잡아 반란의 정보를 더 캐내자",
	],			# 퀘스트 내용
	
	"close_switch" => 363
}

QUEST_DATA[363] = {
	"title" => "게장군 잡기2", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"게장군을 잡았으니 용왕님께 보고하자",
	],			# 퀘스트 내용
	
	"close_switch" => 389
}

QUEST_DATA[364] = {
	"title" => "문어장군 잡기", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"험상궂은 생김새의 문어장군을 잡아오자",
	],			# 퀘스트 내용
	
	"close_switch" => 365
}

QUEST_DATA[365] = {
	"title" => "문어장군 잡기2", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"문어장군의 결백을 증명하기 위해 다문창을 용왕님께 전달하자",
	],			# 퀘스트 내용
	
	"close_switch" => 391
}

QUEST_DATA[366] = {
	"title" => "해마장군 잡기", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"해마장군을 쓰러트려 주력부대의 혼란을 야기시키자",
	],			# 퀘스트 내용
	
	"close_switch" => 367
}

QUEST_DATA[367] = {
	"title" => "해마장군 잡기2", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"해마병사 군대를 소탕하자",
	],			# 퀘스트 내용
	
	"monster_data" => [[149, 60]],			# [[잡아야하는 몬스터 id, 수], ...]
	"close_switch" => 392
}

QUEST_DATA[368] = {
	"title" => "인어장군 잡기", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"반란의 주동자를 알기 위해 인어장군을 잡아오자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 132, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 370
}

QUEST_DATA[370] = {
	"title" => "인어장군 잡기2", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"알 수 없는 문자로 되어 있는 내통문서를 번역해오자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 132, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 369
}

QUEST_DATA[369] = {
	"title" => "인어장군 잡기3", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"번역된 내통문서를 용왕님께 전달하자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 132, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 386
}

QUEST_DATA[371] = {
	"title" => "상어장군 잡기", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"반란군의 돌격대장 상어장군을 사로잡자",
	],			# 퀘스트 내용
	
	"monster_data" => [[156, 1]],			
	"close_switch" => 372
}

QUEST_DATA[372] = {
	"title" => "상어장군 잡기2", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"상어장군을 잡았으니 용왕님께 인도하자",
	],			# 퀘스트 내용
	
	"close_switch" => 374
}

QUEST_DATA[374] = {
	"title" => "상어장군 잡기3", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"이번엔 진짜 상어장군을 잡아오자",
	],			# 퀘스트 내용
	
	"monster_data" => [[156, 1]],			
	"close_switch" => 373
}

QUEST_DATA[373] = {
	"title" => "상어장군 잡기4", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"이번엔 진짜 상어장군을 잡았으니 용왕님께 인도하자",
	],			# 퀘스트 내용
	
	"close_switch" => 393
}

QUEST_DATA[375] = {
	"title" => "해파리장군 잡기", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"반란의 주모자를 알기 위해 해파리장군을 잡자",
	],			# 퀘스트 내용
	
	"monster_data" => [[158, 1]],			
	"close_switch" => 377
}

QUEST_DATA[377] = {
	"title" => "해파리장군 잡기2", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"해파리장군을 잡았으니 용왕님께 보고하자",
	],			# 퀘스트 내용
	
	"close_switch" => 378
}

QUEST_DATA[378] = {
	"title" => "해파리장군 잡기3", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"해파리수하를 사냥해서 전략문서 나머지 부분을 얻어오자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 141, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 387
}

QUEST_DATA[379] = {
	"title" => "거북장군 잡기", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"반란의 주동자 거북장군을 쓰러트리고 여의주를 찾아오자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 143, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 380
}

QUEST_DATA[381] = {
	"title" => "거북장군 잡기3", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"도망친 거북장군을 다시 잡아오자",
	],			# 퀘스트 내용
	
	"monster_data" => [[159, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 382
}

QUEST_DATA[382] = {
	"title" => "거북장군 잡기4", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"거북장군 소탕 결과를 용왕님께 보고하자",
	],			# 퀘스트 내용
	
	"close_switch" => 388
}

QUEST_DATA[395] = {
	"title" => "심판의낫 만들기1", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"심판의낫 재료를 구해서 용왕님께 부탁드리자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 120, 3], [0, 121, 3]],			# [[필요한 아이템 타입, id, 필요개수], ...]
}

class Jindow_Quest < Jindow
	
	def initialize()
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 150, 300)
		self.name = "임무 목록"
		@head = true
		@mark = true
		@drag = true
		@close = true
		
		self.x = 50
		self.y = 100
		self.refresh "Quest"
		
		@quest_data = {}
		
		for quest_d in QUEST_DATA
			sw_id = quest_d[0]
			q_data = quest_d[1]
			
			next if sw_id != 0 and !$game_switches[sw_id]
			
			if q_data["close_switch"] != nil
				next if $game_switches[q_data["close_switch"]]
			end
			
			region = q_data["region"] != nil ? q_data["region"] : "기타"
			@quest_data[region] = [] if @quest_data[region] == nil
			
			title = q_data["title"] != nil ? q_data["title"] : "없음"
			@quest_data[region].push([J::Button.new(self).refresh(120, title), q_data])
		end
		
		start_x = 5
		start_y = 5
		margin = 5
		i = 0
		@region_txt = []
		for data in @quest_data
			region = data[0]
			q_data = data[1]
			
			@region_txt[i] = Sprite.new(self)
			@region_txt[i].bitmap = Bitmap.new(100, 20)
			@region_txt[i].x = start_x
			@region_txt[i].y = start_y
			@region_txt[i].bitmap.font.size = 12
			@region_txt[i].bitmap.font.color.set(0, 0, 0, 255)
			@region_txt[i].bitmap.draw_text(0, 0, @region_txt[i].width, @region_txt[i].height, region, 0)
			
			start_y = @region_txt[i].y + @region_txt[i].height + margin
			
			for data2 in q_data
				button = data2[0]
				button.x = start_x + 10
				button.y = start_y
				
				start_y = button.y + button.height + margin
			end
			
			start_y += 15
			i += 1
		end
	end
	
	def update
		super
		for data in @quest_data
			q_data = data[1]
			for data2 in q_data
				button = data2[0]
				datas = data2[1]
				if button.click					
					Hwnd.dispose("Quest_Detail")
					temp = Jindow_Quest_Detail.new(datas)
					temp.x = self.x + self.width
					temp.y = self.y
				end
			end
		end
	end
	
end