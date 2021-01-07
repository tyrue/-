#==============================================================================
# ■ Jindow_Guild_Create
#------------------------------------------------------------------------------
# 　제작 : 흑부엉
#   수정 : 크랩훕흐 2020/7/30
#==============================================================================

class Jindow_bigsay < Jindow
	#--------------------------------------------------------------------------
	# ● 메인 처리
	#--------------------------------------------------------------------------
	
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 300, 50)
		self.name = "세계후"
		@head = true
		@drag = true
		@close = true
		
		self.refresh "bigsay"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		@bigsay_s = Sprite.new(self)
		@bigsay_s.y = 0
		@bigsay_s.bitmap = Bitmap.new(40, 32)
		@bigsay_s.bitmap.font.color.set(0, 0, 0, 255)
		@bigsay_s.bitmap.draw_text(0, 0, 40, 32, "할말:")
		
		@type_bigsay = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
		@a = J::Button.new(self).refresh(45, "사용하기")
		@a.x = @bigsay_s.x + 50
		@a.y = 25
		
		@b = J::Button.new(self).refresh(45, "취소")
		@b.x = @a.x + 45
		@b.y = @a.y
		
		$cbig = 1
	end
	#--------------------------------------------------------------------------
	# ● 프레임 갱신
	#--------------------------------------------------------------------------
	def update
		super
		if @a.click
			$game_system.se_play($data_system.decision_se)
			간단메세지("[세계후] #{$game_party.actors[0].name} : #{@type_bigsay.result}")
			$chat.write("[세계후] #{$game_party.actors[0].name} : #{@type_bigsay.result}", COLOR_BIGSAY)
			Network::Main.socket.send("<bigsay>#{$game_party.actors[0].name},#{@type_bigsay.result}</bigsay>\n")
			$game_party.lose_item(91, 1)
			$cbig = 0
			Hwnd.dispose(self)
		elsif @b.click
			Hwnd.dispose(self)
		end
	end
end
