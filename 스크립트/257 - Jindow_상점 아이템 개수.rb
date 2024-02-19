#==============================================================================
# ■ Jindow_Shop_Num
#------------------------------------------------------------------------------
#   아이템 개수
#------------------------------------------------------------------------------
class Jindow_Shop_Num < Jindow
	def initialize(item, type, menu = 0) # 아이템, 타입, 메뉴
		$game_system.se_play($data_system.decision_se)
		자동저장
		super(0, 0, 170, 50)
		@data = item
		@menu = menu
		@type = type
		self.name = @data.name
		self.name += @menu == 0 ? " 구매" : " 판매"
		
		@head = true
		@mark = true
		@drag = true
		@close = true
		
		self.refresh "Shop_Num_Window"
		self.x = (640 - self.max_width) * 3 / 4
		self.y = (480 - self.max_height) * 3 / 4
		
		pos_in_mouse
		
		@totalPriceText = Sprite.new(self)
		@totalPriceText.bitmap = Bitmap.new(150, 20)
		@totalPriceText.bitmap.font.size = 12
		@totalPriceText.bitmap.font.color.set(0, 0, 0, 255)
		@totalPriceText.bitmap.draw_text(0, 0, @totalPriceText.width, @totalPriceText.height, "총 0전")
		@totalPriceText.x = 5
		@totalPriceText.y = 5
		
		@input = J::Type.new(self).refresh(0, 0, self.width - 60, 16)
		@input.x = 5
		@input.y = @totalPriceText.y + @totalPriceText.height + 1
		@input.set("1") if @type != 0 # 일반 아이템
		@input.view
		@input.bluck = true
		
		@a = J::Button.new(self).refresh(45, "확인")
		@a.x = @input.x + @input.width + 5
		@a.y = @input.y
		
		@max_num = 0
		self.checkMaxNum
		
		@oldInputText = ""
		@totalPrice = 0
		
		
	end
	
	def checkMaxNum
		case @menu
		when 0 # 구매
			if @type == 0 # 일반 아이템
				@max_num = $item_maximum - $game_party.item_number(@data.id)
			elsif @type == 1 # 무기
				@max_num = $item_maximum - $game_party.weapon_number(@data.id)
			else # 장비
				@max_num = $item_maximum - $game_party.armor_number(@data.id)
			end
			
			@totalPrice = @max_num * @data.price
			if $game_party.gold < @totalPrice
				@max_num = $game_party.gold / @data.price
			end
			
			if @max_num == 0
				$console.write_line("더 이상 구매할 수 없습니다.")
				Hwnd.dispose(self)
				return
			end
			
		when 1
			if @type == 0 # 일반 아이템
				@max_num = $game_party.item_number(@data.id)
			elsif @type == 1 # 무기
				@max_num = $game_party.weapon_number(@data.id)
			else # 장비
				@max_num = $game_party.armor_number(@data.id)
			end
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
			
			@totalPrice = @menu == 0 ? num * @data.price : num * (@data.price / 2)
			
			@totalPriceText.bitmap.clear
			@totalPriceText.bitmap.font.size = 12
			@totalPriceText.bitmap.font.color.set(0, 0, 0, 255)
			@totalPriceText.bitmap.draw_text(0, 0, @totalPriceText.width, @totalPriceText.height, "총 #{change_number_unit(@totalPrice)}전")
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
			
			@totalPrice = num * @data.price
			@totalPrice = @menu == 0 ? @totalPrice : @totalPrice / 2
			
			case @menu
			when 0 # 구매
				if @totalPrice > $game_party.gold
					$console.write_line("금전이 부족합니다.")
					return
				else
					$game_party.lose_gold(@totalPrice)
					if @type == 0 # 일반 아이템
						$game_party.gain_item(@data.id, num)
					elsif @type == 1 # 무기
						$game_party.gain_weapon(@data.id, num)
					else # 장비
						$game_party.gain_armor(@data.id, num)
					end
					Hwnd.dispose(self)
					return
				end
			when 1 # 판매
				if @type == 0 # 일반 아이템
					$game_party.lose_item(@data.id, num)
				elsif @type == 1 # 무기
					$game_party.lose_weapon(@data.id, num)
				else # 장비
					$game_party.lose_armor(@data.id, num)
				end
				$game_party.gain_gold(@totalPrice)
				
				
				Hwnd.dispose(self)
				return 
			end
		end
	end
end
