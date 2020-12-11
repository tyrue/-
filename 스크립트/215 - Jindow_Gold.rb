#==============================================================================
# ■ Jindow_Gold
#------------------------------------------------------------------------------
#   돈 버리기
#   제작자 : 이실로드(cjsrltjd10)
#------------------------------------------------------------------------------
class Jindow_Gold < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 150, 50)
		self.name = "돈 버리기"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh "Gold_Drop"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		@gold = Sprite.new(self)
		@gold.y = 0
		@gold.bitmap = Bitmap.new(40, 32)
		@gold.bitmap.font.color.set(0, 0, 0, 255)
		@gold.bitmap.draw_text(0, 0, 40, 32, "액수 : ")
		@gold_type = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
		@a = J::Button.new(self).refresh(45, "확인")
		@a.x = self.width - 92
		@a.y = 25
	end
	
	def update
		super
		if @a.click
			$game_system.se_play($data_system.decision_se)
			@gold_type.bluck = false
			gold = @gold_type.result
			if gold.to_i <= $game_party.gold.to_i
				for i in 1..99
					if $Drop[i] == nil
						gold_index = i
						break
					end
				end
				$game_party.lose_gold(gold.to_i)
				Network::Main.socket.send "<Drop>#{gold_index},0,0,#{$game_map.map_id},#{$game_player.x},#{$game_player.y},#{gold}</Drop>\n"
				Hwnd.dispose(self)
			else
				$console.write_line("금전이 부족합니다")
			end
		end
	end
end
