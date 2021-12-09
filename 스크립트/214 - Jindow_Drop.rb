#==============================================================================
# ■ Jindow_Drop
#------------------------------------------------------------------------------
#   돈, 아이템 버리기
#------------------------------------------------------------------------------
class Jindow_Drop < Jindow
	def initialize(type1, type2, id) # 돈/아이템, 타입, 아이디
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 150, 50)
		self.name = "버리기"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh "Item_Drop"
		self.x = 640 / 3 - self.max_width / 3
		self.y = 480 / 3 - self.max_height / 3
		
		@type1 = type1
		@type2 = type2
		@item_id = id
		
		@text = Sprite.new(self)
		@text.y = 0
		@text.bitmap = Bitmap.new(40, 32)
		@text.bitmap.font.color.set(0, 0, 0, 255)
		
		if type1 == 0 # 돈
			@text.bitmap.draw_text(0, 0, 40, 32, "액수 : ")
			self.name = "금전 버리기"
		else
			@text.bitmap.draw_text(0, 0, 40, 32, "개수 : ")
			temp = ""
			if @type2 == 0 # 일반 아이템
				temp = $data_items[@item_id].name
			elsif @type2 == 1 # 무기
				temp = $data_weapons[@item_id].name
			else # 장비
				temp = $data_armors[@item_id].name
			end
			self.name = "#{temp} 버리기"
		end
		
		@input = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
		@input.set("1")
		@input.view
		@input.bluck = false
		@a = J::Button.new(self).refresh(45, "확인")
		@a.x = self.width - 92
		@a.y = 25
		self.refresh "Item_Drop"
	end
	
	def update
		super
		if @a.click or Key.trigger?(KEY_ENTER)# 확인
			$game_system.se_play($data_system.decision_se)
			@input.bluck = false
			num = @input.result.to_i
			if num <= 0
				$console.write_line("1 이상의 수를 입력하세요")
				return
			end
			
			x = $game_player.x
			y = $game_player.y
			
			if @type1 == 0
				if num <= $game_party.gold.to_i
					$game_party.lose_gold(num)
					create_moneys(num, x, y)
					$console.write_line("금전 #{num}전을 버렸습니다.")
					
					Audio.se_play("Audio/SE/줍기", $game_variables[13])
					Network::Main.ani(Network::Main.id, 198)
					Hwnd.dispose(self)
				else
					$console.write_line("금전이 부족합니다")
				end
			else
				if !$Abs_item_data.is_trade_ok(@item_id, @type2)
					$console.write_line("버릴 수 없는 물건입니다.")
					return
				end
				
				if @type2 == 0 # 일반 아이템
					if num <= $game_party.item_number(@item_id)
						$game_party.lose_item(@item_id, num)
						$console.write_line("#{$data_items[@item_id].name} #{num}개를 버렸습니다.")
						create_drops(@type2, @item_id, x, y, num)
						
						Audio.se_play("Audio/SE/줍기", $game_variables[13])
						Network::Main.ani(Network::Main.id, 198)
						Hwnd.dispose(self)
					else
						$console.write_line("개수가 부족합니다")
						return
					end
				elsif @type2 == 1 # 무기
					if num <= $game_party.weapon_number(@item_id)
						$game_party.lose_weapon(@item_id, num)
						$console.write_line("#{$data_weapons[@item_id].name} #{num}개를 버렸습니다.")
						create_drops(@type2, @item_id, x, y, num)
						
						Audio.se_play("Audio/SE/줍기", $game_variables[13])
						Network::Main.ani(Network::Main.id, 198)
						Hwnd.dispose(self)
					else
						$console.write_line("개수가 부족합니다")
						return
					end
				else # 장비
					if num <= $game_party.armor_number(@item_id)
						$game_party.lose_armor(@item_id, num)
						$console.write_line("#{$data_armors[@item_id].name} #{num}개를 버렸습니다.")
						create_drops(@type2, @item_id, x, y, num)
						
						Audio.se_play("Audio/SE/줍기", $game_variables[13])
						Network::Main.ani(Network::Main.id, 198)
						Hwnd.dispose(self)
					else
						$console.write_line("개수가 부족합니다")
						return
					end
				end
			end
		end
	end
end
