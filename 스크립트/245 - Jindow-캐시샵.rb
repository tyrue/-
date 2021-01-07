#----------------------------------------------------------------------------------
# *캐시 시스템  
# 제작자: 흑부엉
#----------------------------------------------------------------------------------
class Jindow_cashshop < Jindow
	
	#정보 설정
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 400, 400)
		self.name = "캐시샵"
		@head = true
		@drag = true
		@close = true
		self.refresh "cashshop"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@cash1 = Sprite.new(self)   
		@cash1.bitmap = Bitmap.new("Graphics/icons/두루마리")
		@cash1.y = 60
		@cash2 = Sprite.new(self)   
		@cash2.bitmap = Bitmap.new("Graphics/icons/034-Item03")
		@cash2.y = 152
		@cash3 = Sprite.new(self)  
		@cash3.bitmap = Bitmap.new("Graphics/icons/삿갓머리")
		@cash3.y = 245
		texts = []    
		text = Sprite.new(self)
		for i in 0...texts.size
			text.bitmap.draw_text(10, i * 19, self.width, 32, texts[i])
		end
		text.bitmap = Bitmap.new(self.width, 500)
		cash = $game_variables[213]
		text.bitmap.draw_text(3, 10, self.width, 32, "내 캐시 잔액 :" + "#{cash}")
		
		# 세계후두루마리 
		text.bitmap.font.color.set(0, 0, 0, 255)
		text.bitmap.draw_text(0, 35, self.width, 32, "*세계후두루마리(소모성 아이탬)")
		text.bitmap.font.color.set(0, 0, 0, 255)
		text.bitmap.draw_text(240, 35, self.width, 32, "*가격 : 50 Cash")
		text.bitmap.font.color.set(0, 0, 0, 255)
		text.bitmap.draw_text(43, 57, self.width, 32, "설명 : 접속중인 사람들에게 모두 들리게 해주는 아이탬이다.")
		
		# 하급 보물상자
		text.bitmap.font.color.set(0, 0, 0, 255)
		text.bitmap.draw_text(0, 118, self.width, 32, "*최고급보물상자(소모성 아이탬)")
		
		text.bitmap.draw_text(240, 118, self.width, 32, "*가격 : 300 Cash")   
		
		text.bitmap.draw_text(43, 142, self.width, 32, "설명 : 무엇이 나올지 모르는 보물상자이다")
		
		
		# 삿갓머리
		text.bitmap.font.color.set(0, 0, 0, 255)
		text.bitmap.draw_text(0, 211, self.width, 32, "*삿갓머리화서(소모성 아이탬)")
		
		text.bitmap.draw_text(240, 211, self.width, 32, "*가격 : 2000 Cash")     
		
		text.bitmap.draw_text(43, 235, self.width, 32, "설명 : 머리를 삿갓을 쓴 상태로 변경시켜주는 화서이다")
		
		
		#선택지 
		@a = J::Button.new(self).refresh(80, "구매하기")
		@b = J::Button.new(self).refresh(80, "닫기")
		@c = J::Button.new(self).refresh(80, "구매하기")
		@d = J::Button.new(self).refresh(80, "구매하기")
		@a.y = 95
		@b.x = 170
		@b.y = 380
		@c.y = 190
		@d.y = 285
		
		
	end
	
	def update
		super
		if @a.click  #세계후두루마리
			$game_system.se_play($data_system.decision_se)
			if $game_variables[213] >= 50
				$game_variables[213] -= 50
				$game_party.gain_item(91, 1)
				Hwnd.dispose(self)
				Jindow_cashshop.new
				Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
					["아이탬을 구매에 성공하였습니다."],
					["확인"], ["Hwnd.dispose(self)"], "캐시구매")
			else
				Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
					["캐시 잔액이 부족합니다."],
					["확인"], ["Hwnd.dispose(self)"], "캐시구매")
			end
			
			
		elsif @b.click  #닫기
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			
			
		elsif @c.click  #하급보물상자
			$game_system.se_play($data_system.decision_se)
			if $game_variables[213] >= 300
				$game_variables[213] -= 300
				$game_party.gain_item(92, 1)
				Hwnd.dispose(self)
				Jindow_cashshop.new
				Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
					["아이탬을 구매에 성공하였습니다."],
					["확인"], ["Hwnd.dispose(self)"], "캐시구매")
			else
				Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
					["캐시 잔액이 부족합니다."],
					["확인"], ["Hwnd.dispose(self)"], "캐시구매")
			end
			
			
		elsif @d.click  #삿갓머리화서
			$game_system.se_play($data_system.decision_se)
			if $game_variables[213] >= 2000
				$game_variables[213] -= 2000
				$game_party.gain_item(98, 1)
				Hwnd.dispose(self)
				Jindow_cashshop.new
				Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
					["아이탬을 구매에 성공하였습니다."],
					["확인"], ["Hwnd.dispose(self)"], "캐시구매")
			else
				Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
					["캐시 잔액이 부족합니다."],
					["확인"], ["Hwnd.dispose(self)"], "캐시구매")
			end
		end
	end
end









