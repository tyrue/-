#----------------------------------------------------------------------------------
# *데미지 표시 창
# 제작자: 크랩훕흐
#----------------------------------------------------------------------------------
class Jindow_Damage_Set < Jindow
	
	#정보 설정
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 200, 200)
		self.name = "데미지 표시 설정"
		@head = true
		@drag = true
		@close = true
		self.refresh "set_damage_view"
		
		# 버튼 텍스트
		@button_txt = [
			"기본",
			"????",
		]
		
		@button = []
		for i in 0...@button_txt.size
			@button.push(J::Button.new(self).refresh(60, @button_txt[i].to_s))
			@button[i].x = 20
			@button[i].y = (@button[i].height + 10) * i + 10
		end
		
		self.width = @button[@button.size - 1].x + @button[@button.size - 1].width + 40
		self.height = @button[@button.size - 1].y + @button[@button.size - 1].height + 10
		
		self.x = 640 / 2 - self.max_width / 2
		self.y = 480 / 2 - self.max_height / 2
		self.refresh "set_damage_view"
	end
	
	def update
		super
		
		i = 0
		for b in @button
			if b.click
				$game_variables[60] = i.to_i
				$console.write_line("데미지 설정 : #{b.command}(으)로 변경하였습니다.")
			end
			i += 1
		end
	end
end

