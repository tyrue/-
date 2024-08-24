#----------------------------------------------------------------------------------
# 진도우 퀘스트 창
#----------------------------------------------------------------------------------
QUEST_DATA = {}
# id는 퀘스트 스위치 : 클라이언트에서 직접 확인해서 넣기
# 부여성
QUEST_DATA[10] = {
	"title" => "나무꾼에게 짚 건네주기", 						# 퀘스트 제목
	"region" => "부여성",						# 퀘스트 위치
	"requester" => "나무꾼", 				# 의뢰자 이름
	"body" => [
		"나무꾼에게 짚을 구해 건네주자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 41, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 117
}

QUEST_DATA[11] = {
	"title" => "고통속의 사슴을 구해주기", 						# 퀘스트 제목
	"region" => "부여성 사슴굴5",						# 퀘스트 위치
	"requester" => "고통속의사슴", 				# 의뢰자 이름
	"body" => [
		"고통속의 사슴을 고통에서 해방시켜주자",
	],			# 퀘스트 내용
	"item_data" => [[0, 43, 1]],
	"close_switch" => 122
}

QUEST_DATA[118] = {
	"title" => "나무꾼에게 나무 해주기", 						# 퀘스트 제목
	"region" => "부여성 강가",						# 퀘스트 위치
	"requester" => "나무꾼", 				# 의뢰자 이름
	"body" => [
		"강가의 좋은나무를 쇠도끼로 열심히 때리자",
	],			# 퀘스트 내용
	
	"close_switch" => 120
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

# 극지방
QUEST_DATA[56] = {
	"title" => "청룡의 시련", 						# 퀘스트 제목
	"region" => "극지방",						# 퀘스트 위치
	"requester" => "청룡", 				# 의뢰자 이름
	"body" => [
		"청룡에게 강함을 증명하기 위해",
		"청녹용과 얼음검을 제물로 가져오자."
	],			# 퀘스트 내용
	"item_data" => [[1, 124, 3], [0, 58, 10]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 57,
}

QUEST_DATA[57] = {
	"title" => "청룡의 시련2", 						# 퀘스트 제목
	"region" => "극지방",						# 퀘스트 위치
	"requester" => "청룡", 				# 의뢰자 이름
	"body" => [
		"청룡의 시련을 통과하고 강함을 증명했다.",
		"청룡에게 보상을 받아가자",
	],			# 퀘스트 내용
	"close_switch" => 58,
}


# 고균도
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

QUEST_DATA[129] = {
	"title" => "고균도 제사장의 부탁1", 						# 퀘스트 제목
	"region" => "고균도",						# 퀘스트 위치
	"requester" => "고균도제사장", 				# 의뢰자 이름
	"body" => [
		"제사장에게 수리검을 전해주자"
	],			# 퀘스트 내용
	"item_data" => [[0, 44, 15]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 130
}

QUEST_DATA[130] = {
	"title" => "고균도 제사장의 부탁2", 						# 퀘스트 제목
	"region" => "고균도",						# 퀘스트 위치
	"requester" => "고균도제사장", 				# 의뢰자 이름
	"body" => [
		"제사장에게 말을 다시 걸어보자"
	],			# 퀘스트 내용
	"close_switch" => 131
}

QUEST_DATA[131] = {
	"title" => "고균도 제사장의 부탁3", 						# 퀘스트 제목
	"region" => "고균도",						# 퀘스트 위치
	"requester" => "고균도제사장", 				# 의뢰자 이름
	"body" => [
		"부여성 누군가가 수리검에 적힌 암호를 풀 수 있다고 한다.",
		"암호를 풀고 제사장에게 전해주자."
	],			# 퀘스트 내용
	"close_switch" => 132
}

QUEST_DATA[132] = {
	"title" => "고균도 제사장의 부탁4", 						# 퀘스트 제목
	"region" => "고균도",						# 퀘스트 위치
	"requester" => "고균도제사장", 				# 의뢰자 이름
	"body" => [
		"해독된 수리검을 제사장에게 전해주자."
	],			# 퀘스트 내용
	"item_data" => [[0, 46, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 133
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
	"title" => "[반복]우선녀의 용왕님 건강식 만들기", 						# 퀘스트 제목
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
	"close_switch" => 370,
	"close_or_switch" => [369],
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
	"title" => "[반복]심판의낫 만들기1", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "용왕", 				# 의뢰자 이름
	"body" => [
		"심판의낫 재료를 구해서 용왕님께 부탁드리자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 120, 5], [0, 121, 5]],			# [[필요한 아이템 타입, id, 필요개수], ...]
}


# 일본
QUEST_DATA[408] = {
	"title" => "천을 만드는 소녀", 						# 퀘스트 제목
	"region" => "일본",						# 퀘스트 위치
	"requester" => "천을 만드는 소녀", 				# 의뢰자 이름
	"body" => [
		"좋은 천을 만들 재료를 구해다주자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 152, 5]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 409
}

# 환상의섬


# 중국
QUEST_DATA[255] = {
	"title" => "압록강 정화하기", 						# 퀘스트 제목
	"region" => "압록강",						# 퀘스트 위치
	"requester" => "수선도사", 				# 의뢰자 이름
	"body" => [
		"악어로 더럽혀진 압록강을 악어의피로 정화하자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 190, 3]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 256
}

QUEST_DATA[458] = {
	"title" => "[반복]수집가의 의뢰", 						# 퀘스트 제목
	"region" => "대방성",						# 퀘스트 위치
	"requester" => "수집가", 				# 의뢰자 이름
	"body" => [
		"약재로 소문난 인묘의 발톱을 구해다주자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 196, 50]],			# [[필요한 아이템 타입, id, 필요개수], ...]
}

QUEST_DATA[459] = {
	"title" => "유리항아리1", 						# 퀘스트 제목
	"region" => "현도성",						# 퀘스트 위치
	"requester" => "현도성 주민", 				# 의뢰자 이름
	"body" => [
		"귀한 유리 항아리를 구해다주자",
		"유리 장인은 현도성 서쪽에 있다는 소문이 있다.",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 199, 1]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 460
}

QUEST_DATA[461] = {
	"title" => "유리 장인의 부탁", 						# 퀘스트 제목
	"region" => "현도성",						# 퀘스트 위치
	"requester" => "현도성 유리장인", 				# 의뢰자 이름
	"body" => [
		"유리의 재료인 모래주머니를 구하자",
		"모래주머니는 염유한테 얻을 수 있다",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 198, 50]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 462
}

QUEST_DATA[463] = {
	"title" => "어머니의 부탁", 						# 퀘스트 제목
	"region" => "장안성",						# 퀘스트 위치
	"requester" => "장안성 어머니", 				# 의뢰자 이름
	"body" => [
		"기린에게 나오는 약초를 구해다주자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 197, 50]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 464
}

QUEST_DATA[452] = {
	"title" => "[반복]더운날에는 역시 얼음", 						# 퀘스트 제목
	"region" => "현도성",						# 퀘스트 위치
	"requester" => "현도성 농부", 				# 의뢰자 이름
	"body" => [
		"더운날에 고생하는 농부에게 얼음을 가져다주자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 103, 50]],			# [[필요한 아이템 타입, id, 필요개수], ...]
}

QUEST_DATA[454] = {
	"title" => "심장은 몸에 좋은 보약", 						# 퀘스트 제목
	"region" => "장안성",						# 퀘스트 위치
	"requester" => "장안성 노인", 				# 의뢰자 이름
	"body" => [
		"용궁에서 얻을 수 있는 심장이 보약으로 소문났다",
		"몸이 아픈 노인에게 보약을 가져다주자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 140, 20], [0, 142, 20]],			# [[필요한 아이템 타입, id, 필요개수], ...]
	"close_switch" => 455
}
# 기타


class Jindow_Quest < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 150, 300)
		setup_window_properties
		@quest_data = organize_quest_data
		display_quests
	end
	
	def setup_window_properties
		self.name = "임무 목록"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.x = 50
		self.y = 100
		self.refresh "Quest"
	end
	
	def organize_quest_data
		quest_data = {}
		
		QUEST_DATA.each do |quest_d|
			sw_id, q_data = quest_d[0].to_i, quest_d[1]
			next unless $game_switches[sw_id]
			next if quest_closed?(q_data)
			
			region = q_data["region"] || "기타"
			quest_data[region] ||= []
			title = q_data["title"] || "임무"
			quest_data[region] << [J::Button.new(self).refresh(120, title), q_data]
		end
		
		quest_data
	end
	
	def quest_closed?(q_data)
		return true if q_data["close_switch"] && $game_switches[q_data["close_switch"]]
		
		if q_data["close_or_switch"]
			return q_data["close_or_switch"].any? { |sw| $game_switches[sw] }  
		end
		return false
	end
	
	def display_quests
		start_x, start_y, margin = 5, 5, 5
		
		@quest_data.each_with_index do |(region, q_data), i|
			create_region_label(region, start_x, start_y, i)
			start_y = arrange_quest_buttons(q_data, start_x + 10, start_y + 20, margin)
			start_y += 15
		end
	end
	
	def create_region_label(region, start_x, start_y, index)
		@region_txt ||= []
		@region_txt[index] = Sprite.new(self)
		region_label = @region_txt[index]
		region_label.bitmap = Bitmap.new(100, 20)
		region_label.x = start_x
		region_label.y = start_y
		region_label.bitmap.font.size = 12
		region_label.bitmap.font.alpha = 3
		region_label.bitmap.font.beta = 1
		region_label.bitmap.font.color.set(255, 255, 255, 255)
		region_label.bitmap.font.gamma.set(0, 0, 0, 255)
		region_label.bitmap.draw_text(0, 0, region_label.width, region_label.height, region, 0)
	end
	
	def arrange_quest_buttons(q_data, start_x, start_y, margin)
		q_data.each do |button, _|
			button.x = start_x
			button.y = start_y
			start_y = button.y + button.height + margin
		end
		start_y
	end
	
	def update
		super
		handle_quest_clicks
	end
	
	def handle_quest_clicks
		@quest_data.each_value do |q_data|
			q_data.each do |button, datas|
				next unless button.click
				
				Hwnd.dispose("Quest_Detail")
				temp = Jindow_Quest_Detail.new(datas)
				temp.x = self.x + self.width
				temp.y = self.y				
			end
		end
	end
end
