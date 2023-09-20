#==============================================================================
# ■ Jindow_Shop_Num
#------------------------------------------------------------------------------
#   아이템 개수
#------------------------------------------------------------------------------
class Jindow_Shop_Coin_Num < Jindow
	def initialize(coinData, data2, shopItem) # 필요 코인, 구매 물건 데이터, 구매 아이템
		$game_system.se_play($data_system.decision_se)
		자동저장
		super(0, 0, 170, 50)
		
		@coinType = coinData.type
		@coin = coinData.item
		
		@nums = data2[0]
		@price = data2[1]
		@dataType = shopItem.type
		@data = shopItem.item
		
		self.name = @data.name
		self.name += " 구매"
		
		@head = true
		@mark = true
		@drag = true
		@close = true
		
		self.refresh "Shop_Coin_Num_Window"
		self.x = (640 - self.max_width) * 3 / 4
		self.y = (480 - self.max_height) * 3 / 4
		
		pos_in_mouse
		
		@totalPriceText = Sprite.new(self)
		@totalPriceText.bitmap = Bitmap.new(150, 20)
		@totalPriceText.bitmap.font.size = 12
		@totalPriceText.bitmap.font.color.set(0, 0, 0, 255)
		@totalPriceText.bitmap.draw_text(0, 0, @totalPriceText.width, @totalPriceText.height, "#{@coin.name} 총 0개")
		@totalPriceText.x = 5
		@totalPriceText.y = 5
		
		@input = J::Type.new(self).refresh(0, 0, self.width - 60, 16)
		@input.x = 5
		@input.y = @totalPriceText.y + @totalPriceText.height + 1
		@input.set("1")
		@input.view
		@input.bluck = true
		
		@a = J::Button.new(self).refresh(45, "확인")
		@a.x = @input.x + @input.width + 5
		@a.y = @input.y
		
		@max_num = 0
		@have_num = 0
		
		case @coinType
		when 0
			@have_num = $game_party.item_number(@coin.id)
		when 1
			@have_num = $game_party.weapon_number(@coin.id)
		when 2
			@have_num = $game_party.armor_number(@coin.id)
		end
		
		self.checkMaxNum
		
		@oldInputText = ""
		@totalPrice = 0
	end
	
	def checkMaxNum
		case @dataType
		when 0
			@max_num = $item_maximum - $game_party.item_number(@data.id)
		when 1
			@max_num = $item_maximum - $game_party.weapon_number(@data.id)
		when 2
			@max_num = $item_maximum - $game_party.armor_number(@data.id)
		end
		
		@totalPrice = @max_num * @price
		if @have_num < @totalPrice
			@max_num = @have_num / @price
		end
			
		if @max_num == 0
			$console.write_line("더 이상 구매할 수 없습니다.")
			Hwnd.dispose(self)
			return
		end		
	end
	
	def update
		super
		self.checkMaxNum
		num = @input.result.to_i
		
		if num < 0
			num = 0 
			@input.set(num.to_s)
		end
		
		if num > @max_num
			num = @max_num
			@input.set(@max_num.to_s) 
		end
		
		if @oldInputText != @input.result
			@oldInputText = @input.result
			
			@totalPrice = num * @price
			
			@totalPriceText.bitmap.clear
			@totalPriceText.bitmap.font.size = 12
			@totalPriceText.bitmap.font.color.set(0, 0, 0, 255)
			@totalPriceText.bitmap.draw_text(0, 0, @totalPriceText.width, @totalPriceText.height, "#{@coin.name} 총 #{change_number_unit(@totalPrice)}개")
			@totalPriceText.x = 5
			@totalPriceText.y = 5
		end
		
		
		if @a.click or Key.trigger?(KEY_ENTER)# 확인
			$game_system.se_play($data_system.decision_se)
			@input.bluck = false
			
			if num <= 0
				$console.write_line("1 이상의 수를 입력하세요")
				return
			end
			
			@totalPrice = num * @price
			
			if @totalPrice > @have_num
				$console.write_line(@coin.name + "가 부족합니다.")
				return
			else
				case @coinType
				when 0 
					$game_party.lose_item(@coin.id, @totalPrice)
				when 1
					$game_party.lose_weapon(@coin.id, @totalPrice)
				when 2
					$game_party.lose_armor(@coin.id, @totalPrice)
				end
				
				case @dataType
				when 0 # 일반 아이템
					$game_party.gain_item(@data.id, num * @nums)
				when 1 # 무기
					$game_party.gain_weapon(@data.id, num * @nums)
				when 2 # 장비
					$game_party.gain_armor(@data.id, num * @nums)
				end
				Hwnd.dispose(self)
				return
			end
		end
	end
end
