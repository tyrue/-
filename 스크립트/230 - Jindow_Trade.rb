#==============================================================================
# ■ Jindow_Trade
#------------------------------------------------------------------------------
$MAX_TRADE = 4
class Jindow_Trade < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 320, 200)
		self.name = "교환"
		
		@head = true
		@mark = true
		@drag = true
		self.refresh("Trade")
		self.x = 56
		self.y = 95
		
		@route = "Graphics/Jindow/" + @skin + "/Window/"
		@icon = "Graphics/Icons/"
		
		@p_m = [self.width / 2, 20]
		@p_y = [0, 20]
		@equip_1 = [] # 자신의 아이템 목록
		@equip_2 = [] # 상대방의 아이템 목록
		for i in 1..$MAX_TRADE
			@equip_1[i] = Sprite.new(self)
			@equip_1[i].bitmap = Bitmap.new(@route + "item_win")
			@equip_1[i].x = @p_m[0]
			@equip_1[i].y = @p_m[1] + 27 * i
			
			@equip_2[i] = Sprite.new(self)
			@equip_2[i].bitmap = Bitmap.new(@route + "item_win")
			@equip_2[i].x = @p_y[0]
			@equip_2[i].y = @p_y[1] + 27 * i
		end
		
		@dialog = Sprite.new(self)
		@dialog.bitmap = Bitmap.new(self.width, self.height)
		@dialog.bitmap.font.color.set(0, 0, 0, 255)
		@dialog.bitmap.draw_text(0, 0, self.width, 30, "교환 중에 게임을 종료하지 마세요! 아이템이 사라질 수 있습니다.")
		@dialog.bitmap.draw_text(@p_m[0], @p_m[1], 200, 30, $game_party.actors[0].name) 
		@dialog.bitmap.draw_text(@p_y[0], @p_y[1], 200, 30, $trade_player) 
		@dialog.bitmap.draw_text(@equip_1[@equip_1.size - 1].x, @equip_1[@equip_1.size - 1].y + 30, 200, 30, "금전 : ")
		@dialog.bitmap.draw_text(@equip_2[@equip_2.size - 1].x, @equip_2[@equip_2.size - 1].y + 30, 200, 30, "금전 : ")
		
		@player_money = J::Type.new(self).refresh(@equip_1[@equip_1.size - 1].x + 40, @equip_1[@equip_1.size - 1].y + 30, 60, 18)
		@money = J::Button.new(self).refresh(40, "입력")
		@money.x = @player_money.x + @player_money.width + 10
		@money.y = @player_money.y
		
		@dialog1 = Sprite.new(self)
		@dialog1.bitmap = Bitmap.new(240, 200)
		@dialog1.bitmap.draw_text(@equip_2[@equip_2.size - 1].x + 20, @player_money.y, 200, 30, @money1.to_s)
		
		@a = J::Button.new(self).refresh(40, "교환")
		@a.x = self.width / 2 - @a.width
		@a.y = @money.y + 30
		
		@b = J::Button.new(self).refresh(40, "취소")
		@b.x = @a.x + @a.width + 10
		@b.y = @a.y
		Jindow_Inventory.new if not Hwnd.include?("Inventory")
		
		$item_number = [] # 내 아이템
		@item_img = []
		@item_txt = []
		
		$item_number2 = [] # 상대방의 아이템
		@item_img2 = []
		@item_txt2 = []
		
		$trade_num = 1
		self.height = @b.y + 40
		self.refresh("Trade")
	end
	
	def self.trade_fail
		Network::Main.socket.send "<trade_fail>#{$trade_player}</trade_fail>\n"
		$console.write_line("교환이 취소 되었습니다.")
		
		for i in 1..$MAX_TRADE
			if $item_number[i] != nil
				case $item_number[i].type
				when 0
					$game_party.gain_item($item_number[i].id.to_i, $item_number[i].amount.to_i)
				when 1
					$game_party.gain_weapon($item_number[i].id.to_i, $item_number[i].amount.to_i)
				when 2
					$game_party.gain_armor($item_number[i].id.to_i, $item_number[i].amount.to_i)
				end				
			end
		end
		$game_party.gain_gold($trade_money.to_i)
		
		$trade1_ok = 0
		$trade2_ok = 0
		$trade_player_money = 0
		$trade_player = ""
		$nowtrade = 0
		$trade_money = 0
		Hwnd.dispose("Trade")
	end
	
	def update
		super
		if @money1.to_i != $trade_player_money.to_i # 상대방이 올린 돈
			@money1 = $trade_player_money.to_i
			@dialog1.bitmap.clear
			@dialog1.bitmap.font.color.set(0, 0, 0, 255)
			@dialog1.bitmap.draw_text(@equip_2[@equip_2.size - 1].x + 30, @player_money.y, 200, 30, @money1.to_s)
		end
		
		for i in 1..$MAX_TRADE
			# 내 아이템 확인
			if $item_number[i] != nil and $item_number[i].is_ok != true
				id = $item_number[i].id
				@item_txt[i] = Sprite.new(self)
				@item_txt[i].bitmap = Bitmap.new(self.width, self.height)
				@item_txt[i].bitmap.font.color.set(0, 0, 0, 255)
				
				case $item_number[i].type
				when 0
					$game_party.lose_item($item_number[i].id.to_i, $item_number[i].amount.to_i)
					@item_img[i] = J::Item.new(self).refresh($data_items[id].id, 0)
					@item_txt[i].bitmap.draw_text(@equip_1[i].x + 30, @equip_1[i].y, 200, 30, "#{$data_items[id].name} #{$item_number[i].amount.to_s}개") 
				when 1
					$game_party.lose_weapon($item_number[i].id.to_i, $item_number[i].amount.to_i)
					@item_img[i] = J::Item.new(self).refresh($data_weapons[id].id, 1)
					@item_txt[i].bitmap.draw_text(@equip_1[i].x + 30, @equip_1[i].y, 200, 30, "#{$data_weapons[id].name} #{$item_number[i].amount.to_s}개") 
				when 2
					$game_party.lose_armor($item_number[i].id.to_i, $item_number[i].amount.to_i)
					@item_img[i] = J::Item.new(self).refresh($data_armors[id].id, 2)
					@item_txt[i].bitmap.draw_text(@equip_1[i].x + 30, @equip_1[i].y, 200, 30, "#{$data_armors[id].name} #{$item_number[i].amount.to_s}개") 
				end
				
				@item_img[i].x = @equip_1[i].x
				@item_img[i].y = @equip_1[i].y
				Network::Main.socket.send "<trade_item>#{$trade_player},#{$item_number[i].id},#{$item_number[i].amount},#{$item_number[i].type},#{i}</trade_item>\n"
				$item_number[i].is_ok = true
			end
			
			# 상대방 아이템 확인
			if $item_number2[i] != nil and $item_number2[i].is_ok != true
				id = $item_number2[i].id
				@item_txt2[i] = Sprite.new(self)
				@item_txt2[i].bitmap = Bitmap.new(240, 200)
				@item_txt2[i].bitmap.font.color.set(0, 0, 0, 255)
				
				case $item_number2[i].type
				when 0
					@item_img2[i] = J::Item.new(self).refresh($data_items[id].id, 0)
					@item_txt2[i].bitmap.draw_text(@equip_2[i].x + 30, @equip_2[i].y, 200, 30, "#{$data_items[id].name} #{$item_number2[i].amount.to_s} 개")
				when 1
					@item_img2[i] = J::Item.new(self).refresh($data_weapons[id].id, 1)
					@item_txt2[i].bitmap.draw_text(@equip_2[i].x + 30, @equip_2[i].y, 200, 30, "#{$data_weapons[id].name} #{$item_number2[i].amount.to_s} 개")
				when 2
					@item_img2[i] = J::Item.new(self).refresh($data_armors[id].id, 2)
					@item_txt2[i].bitmap.draw_text(@equip_2[i].x + 30, @equip_2[i].y, 200, 30, "#{$data_armors[id].name} #{$item_number2[i].amount.to_s} 개")
				end
				@item_img2[i].x = @equip_2[i].x
				@item_img2[i].y = @equip_2[i].y
				
				$item_number2[i].is_ok = true
			end
		end
		
		if $trade1_ok == 1 and $trade2_ok == 1
			$console.write_line ("[교환]:교환이 성사 되었습니다.")
			for i in 1..$MAX_TRADE			
				if $item_number2[i] != nil
					case $item_number2[i].type
					when 0
						$game_party.gain_item($item_number2[i].id.to_i, $item_number2[i].amount.to_i)
					when 1
						$game_party.gain_weapon($item_number2[i].id.to_i, $item_number2[i].amount.to_i)
					when 2
						$game_party.gain_armor($item_number2[i].id.to_i, $item_number2[i].amount.to_i)
					end
				end			
			end
			$game_party.gain_gold($trade_player_money.to_i)
			
			$trade2_ok = 0
			$trade1_ok = 0
			
			$trade_player = ""
			$trade_player_money = 0
			$item_number.clear
			Hwnd.dispose("Trade")
		end
		
		if @a.click
			$trade1_ok = 1
			Network::Main.socket.send "<trade_okay>#{$trade_player}</trade_okay>\n"
			$console.write_line("거래에 확인하셨습니다.")
			$console.write_line("상대방도 확인시 거래가 성사됩니다.")
			$console.write_line("거래를 취소하시려면 취소 버튼을 눌러 주세요")
			
		elsif @b.click
			Jindow_Trade.trade_fail
			
		elsif @money.click
			money = @player_money.result.to_i
			if money <= 0
				$console.write_line("1 이상의 금전을 입력하세요.")
			elsif $game_party.gold.to_i >= $trade_money.to_i 
				@money.visible = false
				@player_money.visible = false
				$trade_money = money # 내가 올린 돈
				@dialog.bitmap.draw_text(@player_money.x, @player_money.y, 200, 30, $trade_money.to_s)
				Network::Main.socket.send "<trade_money>#{$trade_player},#{$trade_money.to_i}</trade_money>\n"
				$game_party.lose_gold($trade_money.to_i)
			else
				$console.write_line("가지고 계신 금전이 부족합니다")
			end
		end
	end
end