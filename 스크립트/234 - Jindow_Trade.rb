#==============================================================================
# ■ Jindow_Trade
#------------------------------------------------------------------------------
class Jindow_Trade < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 240, 150)
		self.name = "교환"
		@head = true
		@mark = true
		@drag = true
		self.refresh("Trade")
		self.x = 56
		self.y = 95
		@route = "Graphics/Jindow/" + @skin + "/Window/"
		@icon = "Graphics/Icons/"
		@dialog = Sprite.new(self)
		@dialog.bitmap = Bitmap.new(240, 150)
		@dialog.bitmap.font.color.set(0, 0, 0, 255)
		@dialog.bitmap.draw_text(0, 5, 200, 30, $game_party.actors[0].name) 
		@dialog.bitmap.draw_text(0, 70, 200, 30, $trade_player) 
		@dialog.bitmap.draw_text(40, 35, 200, 30, "금전 : ")
		@dialog.bitmap.draw_text(40, 100, 200, 30, "금전 : ")
		
		@player_money = J::Type.new(self).refresh(74, 40, 60, 18)
		@money = J::Button.new(self).refresh(40, "입력")
		@money.x = 138
		@money.y = 39
		
		@dialog1 = Sprite.new(self)
		@dialog1.bitmap = Bitmap.new(240, 150)
		@dialog1.bitmap.draw_text(40, 100, 200, 30, @money1.to_s)
		
		@equip_1 = Sprite.new(self)
		@equip_2 = Sprite.new(self)
		@equip_1.bitmap = Bitmap.new(@route + "item_win")
		@equip_2.bitmap = Bitmap.new(@route + "item_win")
		@equip_1.y = 35
		@equip_2.y = 100
		@a = J::Button.new(self).refresh(40, "교환")
		@a.x = 125
		@a.y = 120
		@b = J::Button.new(self).refresh(40, "취소")
		@b.x = 175
		@b.y = 120
		Jindow_Inventory.new if not Hwnd.include?("Inventory")
	end
	
	def update
		super
		@trade_money = @player_money.result
		if @money1.to_i != $trade_player_money.to_i
			@money1 = $trade_player_money.to_i
			@dialog1.bitmap.clear
			@dialog1.bitmap.draw_text(40, 175, 200, 30, @money1.to_s)
		end
		if $trade_item[1] == 1 and @item1 == nil or @item1 == ""
			id = $item_number[1].id
			@item1_text = Sprite.new(self)
			@item1_text.bitmap = Bitmap.new(240, 200)
			@item1_text.bitmap.font.color.set(0, 0, 0, 255)
			case $item_number[1].type
			when 0
				@item1 = J::Item.new(self).refresh($data_items[id].id, 0)
				@item1.y = 35
				
				@item1_text.bitmap.draw_text(0, 60, 200, 30, $data_items[$item_number[1].id].name) 
				@item1_text.bitmap.draw_text(30, 50, 200, 30, "#{$item_number[1].amount.to_s} 개")
				Network::Main.socket.send "<trade_item>#{$trade_player},#{$item_number[1].id},#{$item_number[1].amount},0</trade_item>\n"
			when 1
				@item1 = J::Item.new(self).refresh($data_weapons[id].id, 1)
				@item1.y = 35
				
				@item1_text.bitmap.draw_text(0, 60, 200, 30, $data_weapons[$item_number[1].id].name) 
				@item1_text.bitmap.draw_text(30, 50, 200, 30, "#{$item_number[1].amount.to_s} 개")
				Network::Main.socket.send "<trade_item>#{$trade_player},#{$item_number[1].id},#{$item_number[1].amount},1</trade_item>\n"
			when 2
				@item1 = J::Item.new(self).refresh($data_armors[id].id, 2)
				@item1.y = 35
				
				@item1_text.bitmap.draw_text(0, 60, 200, 30, $data_armors[$item_number[1].id].name) 
				@item1_text.bitmap.draw_text(30, 50, 200, 30, "#{$item_number[1].amount.to_s} 개")
				Network::Main.socket.send "<trade_item>#{$trade_player},#{$item_number[1].id},#{$item_number[1].amount},2</trade_item>\n"
			end
		elsif $trade_item[2] == 1 and @item2 == nil or @item2 == ""
			id = $item_number[2].id
			@item2_text = Sprite.new(self)
			@item2_text.bitmap = Bitmap.new(240, 200)
			@item2_text.bitmap.font.color.set(0, 0, 0, 255)
			
			case $item_number[2].type
			when 0
				@item2 = J::Item.new(self).refresh($data_items[id].id, 0)
				@item2.y = 100
				
				@item2_text.bitmap.draw_text(0, 125, 200, 30, $data_items[$item_number[2].id].name) 
				@item2_text.bitmap.draw_text(30, 115, 200, 30, "#{$item_number[2].amount.to_s} 개")
			when 1
				@item2 = J::Item.new(self).refresh($data_weapons[id].id, 1)
				@item2.y = 100
				
				@item2_text.bitmap.draw_text(0, 125, 200, 30, $data_weapons[$item_number[2].id].name) 
				@item2_text.bitmap.draw_text(30, 115, 200, 30, "#{$item_number[2].amount.to_s} 개")
			when 2
				@item2 = J::Item.new(self).refresh($data_armors[id].id, 2)
				@item2.y = 100
				
				@item2_text.bitmap.draw_text(0, 125, 200, 30, $data_armors[$item_number[2].id].name) 
				@item2_text.bitmap.draw_text(30, 115, 200, 30, "#{$item_number[2].amount.to_s} 개")
			end
		end
		if $trade1_ok == 1 and $trade2_ok == 1
			$console.write_line ("[교환]:교환이 성사 되었습니다.")
			$game_variables[1003] = 0
			for i in 1..2
				if i >= 2
					case $item_number[i].type
					when 0
						$game_party.gain_item($item_number[i].id.to_i, $item_number[i].amount.to_i)
					when 1
						$game_party.gain_weapon($item_number[i].id.to_i, $item_number[i].amount.to_i)
					when 2
						$game_party.gain_armor($item_number[i].id.to_i, $item_number[i].amount.to_i)
					end
				else
					case $item_number[i].type
					when 0
						$game_party.lose_item($item_number[i].id.to_i, $item_number[i].amount.to_i)
					when 1
						$game_party.lose_weapon($item_number[i].id.to_i, $item_number[i].amount.to_i)
					when 2
						$game_party.lose_armor($item_number[i].id.to_i, $item_number[i].amount.to_i)
					end
				end
			end
			$nowtrade = 0
			$game_party.lose_gold(@trade_money.to_i)
			$game_party.gain_gold($trade_player_money.to_i)
			$trade_item.clear
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
			Network::Main.socket.send "<trade_fail>#{$trade_player},#{$game_party.actors[0].name}</trade_fail>\n"
		elsif @money.click
			if $game_party.gold.to_i >= @trade_money.to_i
				@money.visible = false
				@player_money.visible = false
				@dialog.bitmap.draw_text(80, 35, 200, 30, @trade_money.to_s)
				Network::Main.socket.send "<trade_money>#{$trade_player},#{@trade_money.to_i}</trade_money>\n"
				$game_variables[1003] = 0
			else
				$console.write_line("가지고 계신 금전이 부족합니다")
			end
		end
	end
end