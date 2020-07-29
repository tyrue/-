#==============================================================================
# ■ Jindow_ShopSells
#==============================================================================
class Jindow_Trade2 < Jindow
	attr_accessor :is_ok
	
	def initialize(id, type, number)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 150, 60)
		self.name = "갯수 입력"
		@head = true
		@drag = true
		@close = true
		
		self.refresh "Trade2"
		self.x = 366
		self.y = 306
		
		@item_id = id
		@type = type
		@number = number
		@username4_s = Sprite.new(self)
		@username4_s.y = 0
		@username4_s.bitmap = Bitmap.new(40, 32)
		@username4_s.bitmap.font.color.set(0, 0, 0, 255)
		@username4_s.bitmap.draw_text(0, 0, 40, 32, "개수")
		
		$is_ok = false
		
		@type_sells = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
		
		@a = J::Button.new(self).refresh(45, "확인")
		@b = J::Button.new(self).refresh(45, "취소")
		@a.x = self.width - 92
		@a.y = 25
		@b.x = self.width - 45
		@b.y = 25
	end
	#--------------------------------------------------------------------------
	# ● 프레임 갱신
	#--------------------------------------------------------------------------
	def update
		super
		if @a.click
			$game_system.se_play($data_system.decision_se)
			@type_sells.bluck = false
			@sell = @type_sells.result
			
			if @sell.to_i == 0
				$console.write_line("개수는 한 개 이상 정할수 있습니다.")
				return
			end 
			
			@is_ok = false
			if @type == 0 and $game_party.item_number(@item_id.to_i) >= @sell.to_i
				@is_ok = true
			elsif @type == 1 and $game_party.weapon_number(@item_id.to_i) >= @sell.to_i
				@is_ok = true
			elsif @type == 2 and $game_party.armor_number(@item_id.to_i) >= @sell.to_i
				@is_ok = true
			else
				$console.write_line("소지하고 있는것 보다 개수가 많습니다.")
			end
			
			if @is_ok
				$trade_num += 1
				$item_number[@number] = Jindow_Trade_Data.new
				$item_number[@number].id = @item_id
				$item_number[@number].type = @type
				$item_number[@number].amount = @sell.to_i
				Hwnd.dispose(self)
			end
			
		elsif @b.click
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
		end
	end
end

