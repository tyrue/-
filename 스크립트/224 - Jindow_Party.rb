#==============================================================================
# ■ Jindow_Party
#------------------------------------------------------------------------------

class Jindow_Party < Jindow
	def initialize
		super(0, 0, 210, 110)
		self.name = "파티"
		@head = true
		@mark = true
		@drag = true
		self.refresh "Party"
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		a = ""
		if $party != nil
			for i in 0...$party.size
				a += $party[i].to_s + ","
			end
		else
			a = "없음"
		end
		@dialog = Sprite.new(self)
		@dialog.bitmap = Bitmap.new(210,110)
		@dialog.bitmap.font.color.set(0, 0, 0, 255)
		@dialog.bitmap.draw_text(0, 0, 200, 30, "파티명 : " + $party_name)
		@dialog.bitmap.draw_text(120, 0, 200, 30, "파티장 :" + $party_reader)
		@dialog.bitmap.draw_text(0, 20, 200, 30, "파티초대 입력:")
		@username = J::Type.new(self).refresh(80, 25, 90, 18)
		@dialog.bitmap.draw_text(0, 40, 230, 30, "파티원 : " + a)
		@Invite = J::Button.new(self).refresh(60, "파티 초대")
		@Leave = J::Button.new(self).refresh(60, "파티 탈퇴")
		@Cancel = J::Button.new(self).refresh(60, "취소")
		@Invite.y = 80
		@Leave.x = 70
		@Leave.y = 80
		@Cancel.x = 140
		@Cancel.y = 80
	end
	
	def update
		super
		@name = @username.result
		if @Leave.click
			if $party.include? ($game_party.actors[0].name + ".")
				Network::Main.socket.send "<party_remove>#{$party_name},#{$game_party.actors[0].name}</party_remove>\n"
			else
				$console.write_line("현재 가입 된 파티가 없습니다.")
			end
			
		elsif @Cancel.click
			Hwnd.dispose(self)
			
		elsif @Invite.click
			if $party_leader == $game_party.actors[0].name
				if $1.to_s != $game_party.actors[0].name
					if $party.size <= 8
						$console.write_line("'#{@name.to_s}'님에게 파티 초대 신청을 하셨습니다.")
						Network::Main.socket.send "<party_invite>#{@name.to_s},#{$party},#{$party_name},#{$party_leader}</party_invite>\n"
					else
						$console.write_line("파티 제한 인원 수를 넘었습니다.")
					end
				else
					$console.write_line("자기 자신에게 파티 초대를 할 수 없습니다.")
				end
			else
				$console.write_line("파티장이 아니라서 초대 할 수 없습니다")
			end
		end
	end
end

