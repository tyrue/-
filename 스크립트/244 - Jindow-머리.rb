#----------------------------------------------------------------------------------
# *캐시 시스템  
# 제작자: 흑부엉
#----------------------------------------------------------------------------------
class Jindow_hairct < Jindow
	
	#정보 설정
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 400, 400)
		self.name = "머리 관리"
		@head = true
		@drag = true
		@close = true
		self.refresh "hairct"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		
		@hair1 = Sprite.new(self)   
		@hair1.bitmap = Bitmap.new("Graphics/pictures/머리이미지1")
		@hair1.y = 0
		texts = []    
		text = Sprite.new(self)
		for i in 0...texts.size
			text.bitmap.draw_text(10, i * 19, self.width, 32, texts[i])
		end
		text.bitmap = Bitmap.new(self.width, 140)
		
		
		#선택지 
		@a = J::Button.new(self).refresh(80, "변경하기")
		@b = J::Button.new(self).refresh(80, "닫기")
		@c = J::Button.new(self).refresh(80, "변경하기")
		@d = J::Button.new(self).refresh(80, "변경하기")
		@a.y = 85
		@b.x = 170
		@b.y = 380
		@c.x = 105
		@c.y = 85
		@d.x = 210
		@d.y = 85    
		
	end
	
	def update
		super
		if @a.click   #  1번머리(기본 설정머리)
			$game_system.se_play($data_system.decision_se)
			if $game_variables[165] > 1000
				$game_party.actors[0].set_graphic("바람머리", 0, 0, 0)
				$scene = Scene_Map.new
				$chat.write ("머리가 변경되었습니다.", Color.new(65, 105, 0))           
				$game_party.lose_gold(1000)
				Hwnd.dispose(self)
				Network::Main.send_map
			else
				Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
					["금전이 부족합니다."],
					["확인"], ["Hwnd.dispose(self)"], "머리변겅")
				Hwnd.dispose(self)
			end
			
		elsif @b.click  # 닫기를 누른경우
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			
			
		elsif @c.click  # 2번머리
			$game_system.se_play($data_system.decision_se)
			if $game_variables[165] > 1000
				$game_party.lose_gold(1000)
				
				$game_party.actors[0].set_graphic("주인공", 0, 0, 0)
				$scene = Scene_Map.new
				$chat.write ("머리가 변경되었습니다.", Color.new(65, 105, 0))    
				Hwnd.dispose(self)
				Network::Main.send_map
			else
				Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
					["금전이 부족합니다."],
					["확인"], ["Hwnd.dispose(self)"], "머리변겅")
				Hwnd.dispose(self)
			end
			
			
		elsif @d.click  # 3번머리
			$game_system.se_play($data_system.decision_se)
			if $game_variables[165] > 1000
				$game_party.lose_gold(1000)
				Hwnd.dispose(self)
				
				$game_party.actors[0].set_graphic("바람세운머리", 0, 0, 0)
				$scene = Scene_Map.new
				$chat.write ("머리가 변경되었습니다.", Color.new(65, 105, 0))    
				Network::Main.send_map
			else
				Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 200,
					["금전이 부족합니다."],
					["확인"], ["Hwnd.dispose(self)"], "머리변겅")
				Hwnd.dispose(self)
			end
		end
	end
end









