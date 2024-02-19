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
	
	"item_data" => [[0, 41, 1]]			# [[필요한 아이템 타입, id, 필요개수], ...]
}

QUEST_DATA[275] = {
	"title" => "친구 안부 묻기1", 						# 퀘스트 제목
	"region" => "부여성",						# 퀘스트 위치
	"requester" => "여행자", 				# 의뢰자 이름
	"body" => [
		"고균도에 여행중인 여행자의 친구에게 안부를 묻자"
	],			# 퀘스트 내용
}

QUEST_DATA[276] = {
	"title" => "친구 안부 묻기2", 						# 퀘스트 제목
	"region" => "고균도",						# 퀘스트 위치
	"requester" => "여행자", 				# 의뢰자 이름
	"body" => [
		"부여성의 여행자에게 안부를 전해주자"
	],			# 퀘스트 내용
}


QUEST_DATA[300] = {
	"title" => "제비 도와주기", 						# 퀘스트 제목
	"region" => "부여성",						# 퀘스트 위치
	"requester" => "제비", 				# 의뢰자 이름
	"body" => [
		"배고픈 제비에게 도토리를 구해주자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 3, 30]]			# [[필요한 아이템 타입, id, 필요개수], ...]
}

QUEST_DATA[329] = {
	"title" => "장쇠의 부탁", 						# 퀘스트 제목
	"region" => "부여성",						# 퀘스트 위치
	"requester" => "장쇠", 				# 의뢰자 이름
	"body" => [
		"고균도의 조리부에게 장쇠의 두루마리를 전해주자"
	],			# 퀘스트 내용
}

# 승급
QUEST_DATA[141] = {
	"title" => "청웅환 가져오기", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"고균도에서 청웅의환을 가져오자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 51, 50]]			# [[필요한 아이템 타입, id, 필요개수], ...]
}

QUEST_DATA[142] = {
	"title" => "불의결정 가져오기", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"승급을 위해 불의결정을 가져오자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 37, 5]]			# [[필요한 아이템 타입, id, 필요개수], ...]
}

QUEST_DATA[147] = {
	"title" => "수화룡의 비늘 가져오기", 						# 퀘스트 제목
	"region" => "왕궁",						# 퀘스트 위치
	"requester" => "대대로", 				# 의뢰자 이름
	"body" => [
		"승급을 위해 수, 화룡의 비늘을 가져오자"
	],			# 퀘스트 내용
	
	"item_data" => [[0, 52, 1], [0, 53, 1]]			# [[필요한 아이템 타입, id, 필요개수], ...]
}


# 용궁
QUEST_DATA[398] = {
	"title" => "용궁정화1", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "좌선녀", 				# 의뢰자 이름
	"body" => [
		"한두고개 어딘가에서 용궁정화의 단서를 구하자!",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 146, 1]]			# [[필요한 아이템 타입, id, 필요개수], ...]
}

QUEST_DATA[399] = {
	"title" => "용궁정화2", 						# 퀘스트 제목
	"region" => "용궁",						# 퀘스트 위치
	"requester" => "좌선녀", 				# 의뢰자 이름
	"body" => [
		"일본의 숲의장인에게 숯의정화를 구하자",
	],			# 퀘스트 내용
	
	"item_data" => [[0, 147, 5]]			# [[필요한 아이템 타입, id, 필요개수], ...]
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
			next if sw_id != 0 and !$game_switches[sw_id]
			q_data = quest_d[1]
			
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