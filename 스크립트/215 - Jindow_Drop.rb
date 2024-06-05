#==============================================================================
# ■ Jindow_Drop
#------------------------------------------------------------------------------
#   돈, 아이템 버리기
#------------------------------------------------------------------------------
class Jindow_Drop < Jindow
	def initialize(type1, type2, id) # 돈/아이템, 타입, 아이디
		$game_system.se_play($data_system.decision_se)
		자동저장
		super(0, 0, 150, 50)
		self.name = ""
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
		
		@item_name = ""
		if type1 == 0 # 돈
			@text.bitmap.draw_text(0, 0, 40, 32, "액수 : ")
			@item_name = "금전"
		else
			@text.bitmap.draw_text(0, 0, 40, 32, "개수 : ")
			@item_name = case @type2
			when 0 then $data_items[@item_id].name
			when 1 then $data_weapons[@item_id].name
			when 2 then $data_armors[@item_id].name
			end
		end
		
		self.name = "#{@item_name} 버리기"
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
				num = [num, $game_party.gold.to_i].min
				$game_party.lose_gold(num)
				create_moneys(num, x, y)
				$console.write_line("#{@item_name} #{num}전을 버렸습니다.")
				num = $game_party.gold
			else
				if !$Abs_item_data.is_trade_ok(@item_id, @type2)
					$console.write_line("버릴 수 없는 물건입니다.")
					return
				end
				
				method = case @type2
				when 0 then :item
				when 1 then :weapon
				when 2 then :armor
				end
				
				num = [num, $game_party.send("#{method.to_s}_number", @item_id)].min 
				$game_party.send("lose_#{method.to_s}", @item_id, num)
				create_drops(@type2, @item_id, x, y, num)
				$console.write_line("#{@item_name} #{num}개를 버렸습니다.")
				num = $game_party.send("#{method.to_s}_number", @item_id)
			end
			
			$game_system.se_play("줍기")
			Hwnd.dispose(self) if num <= 0
		end
	end
end
