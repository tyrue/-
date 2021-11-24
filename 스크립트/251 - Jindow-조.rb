#----------------------------------------------------------------------------------
# *조합 창 
# 제작자: 크랩훕흐
#----------------------------------------------------------------------------------
class Jindow_craft < Jindow
	
	#정보 설정
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 200, 200)
		self.name = "조합창"
		@head = true
		@drag = true
		@close = true
		self.refresh "craft"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		# 버튼 텍스트
		@button_txt = [
			"추가",
			"삭제",
			"확인",
			"취소",
		]
		
		@button = []
		for i in 0...@button_txt.size
			@button.push(J::Button.new(self).refresh(self.width / @button_txt.size, @button_txt[i].to_s))
			@button[i].x = i * @button[i].width
			@button[i].y = self.height - @button[i].height - 10
		end
		
		# 조합할 아이템 데이터 저장
		@data = []
		self.refresh "craft"
	end
	
	def update
		super
		for b in @button
			if b.click
				case b.command
				when "추가"
					p 1
				when "삭제"
					p 2
				when "확인"
					p 3
				when "취소"
					p 4
					Hwnd.dispose(self)
				end
			end
		end
	end
end

