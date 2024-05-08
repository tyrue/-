class Jindow_Trade < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 320, 260)
		setup_trade_window
		setup_trade_components
		setup_inventory_mode
	end
	
	def setup_trade_window
		self.name = "교환"
		@head = @mark = @drag = true
		self.refresh("Trade")
		self.x = 56
		self.y = 95
	end
	
	def setup_trade_components
		@route = "Graphics/Jindow/" + @skin + "/Window/"
		@icon = "Graphics/Icons/"
		@trade_manager = $trade_manager
		@check_trade_success = false
		@my_money = 0
		@trader_money = 0
		
		setup_item_lists
		setup_item_slots
		setup_trade_messages
		setup_trade_buttons
	end
	
	def setup_item_lists
		@my_items = Array.new(@trade_manager.max_size)
		@my_items_slot = []
		@my_items_sprite = Array.new(@trade_manager.max_size)
		@my_slot_text = Array.new(@trade_manager.max_size)
		@my_pos = [self.width / 2, 20]
		
		@trader_items = Array.new(@trade_manager.max_size)
		@trader_items_slot = []
		@trader_items_sprite = Array.new(@trade_manager.max_size)
		@trader_slot_text = Array.new(@trade_manager.max_size)
		@trader_pos = [0, 20]
	end
	
	def setup_item_slots
		(0...@trade_manager.max_size).each do |i|
			@my_items_slot << create_item_slot(@my_pos[0], @my_pos[1] + 27 * (i + 1))
			@trader_items_slot << create_item_slot(@trader_pos[0], @trader_pos[1] + 27 * (i + 1))
		end
	end
	
	def create_item_slot(x, y)
		sprite = Sprite.new(self)
		sprite.bitmap = Bitmap.new(@route + "item_win")
		sprite.x = x
		sprite.y = y
		sprite
	end
	
	def setup_trade_messages
		setup_warning_message
		setup_trade_names
		setup_money_input
	end
	
	def setup_warning_message
		@dialog = create_text_sprite("교환 중에 게임을 종료하지 마세요! 아이템이 사라질 수 있습니다.")
	end
	
	def create_text_sprite(text)
		sprite = Sprite.new(self)
		sprite.bitmap = Bitmap.new(self.width, self.height)
		sprite.bitmap.font.color = Color.new(0, 0, 0, 255)
		sprite.bitmap.draw_text(0, 0, self.width, 30, text)
		sprite
	end
	
	def setup_trade_names
		@dialog.bitmap.draw_text(@my_pos[0], @my_pos[1], 200, 30, $game_party.actors[0].name) 
		@dialog.bitmap.draw_text(@trader_pos[0], @trader_pos[1], 200, 30, @trade_manager.trader) 
	end
	
	def setup_money_input
		@player_money = J::Type.new(self).refresh(@my_items_slot.last.x + 40, @my_items_slot.last.y + 30, 60, 18)
		@money = J::Button.new(self).refresh(40, "입력")
		@money.x = @player_money.x + @player_money.width + 10
		@money.y = @player_money.y
	end
	
	def setup_trade_buttons
		@trade_button = J::Button.new(self).refresh(40, "교환")
		@trade_button.x = self.width / 2 - @trade_button.width
		@trade_button.y = @money.y + 30
		
		@cancel_button = J::Button.new(self).refresh(40, "취소")
		@cancel_button.x = @trade_button.x + @trade_button.width + 10
		@cancel_button.y = @trade_button.y
		
		self.height = @cancel_button.y + 40
		self.refresh("Trade")
	end
	
	def setup_inventory_mode
		return unless $j_inven
		
		$j_inven.show
		$j_inven.setMode(1)
	end
	
	# 아이템 추가
	def add_item(item, type = 0)
		case type
		when 0  # 내 아이템 추가
			if item.type == 3
				draw_money_text(item.num, type)
			else
				add_item_to_list(@my_items, @my_items_sprite, @my_slot_text, item, @my_items_slot)
			end
		when 1  # 상대 아이템 추가
			if item.type == 3
				draw_money_text(item.num, type)
			else
				add_item_to_list(@trader_items, @trader_items_sprite, @trader_slot_text, item, @trader_items_slot)
			end
		end
	end
	
	# 아이템을 리스트에 추가
	def add_item_to_list(item_list, sprite_list, text_list, item, slot_list)
		i = item_list.index(nil)
		item_list[i] = item
		
		sprite_list[i] = J::Item.new(self).refresh(item.id, item.type)
		sprite_list[i].x = slot_list[i].x
		sprite_list[i].y = slot_list[i].y
		
		text = "#{sprite_list[i].item.name} #{item.num}개"
		text_list[i] = create_text_sprite(text)
		text_list[i].x = sprite_list[i].x + sprite_list[i].width
		text_list[i].y = sprite_list[i].y
	end
	
	# 금전 텍스트 그리기
	def draw_money_text(money, type)
		x = @trader_pos[0]
		y = @player_money.y
		if type == 0
			@player_money.visible = false
			@money.visible = false
			
			x = @player_money.x
			@my_money = money
		else
			@trader_money = money
		end
		@dialog.bitmap.draw_text(x, y, 200, 30, "#{money}전")
	end
	
	# 아이템 제거
	def remove_item(index, type = 0)
		item_lists = {
			0 => [@my_items, @my_items_sprite, @my_slot_text],
			1 => [@trader_items, @trader_items_sprite, @trader_slot_text]
		}
		
		item_list, sprite_list, text_list = item_lists[type]
		item_list[index] = nil
		
		if sprite_list[index]
			sprite_list[index].dispose
			sprite_list[index] = nil
		end
		
		if text_list[index]
			text_list[index].bitmap.clear
			text_list[index].dispose
			text_list[index] = nil
		end
	end
	
	def trade_success()
		gain_traded_items()
		lose_my_items()
		@check_trade_success = true
		Hwnd.dispose(self)
	end
	
	def gain_traded_items
		@trader_items.each do |item|
			next unless item
			id = item.id.to_i
			type = item.type.to_i
			num  = item.num.to_i
			
			case type
			when 0 then $game_party.gain_item(id, num)
			when 1 then $game_party.gain_weapon(id, num)
			when 2 then $game_party.gain_armor(id, num)
			end
		end
		$game_party.gain_gold(@trader_money) if @trader_money > 0
	end
	
	def lose_my_items
		@my_items.each do |item|
			next unless item
			id = item.id.to_i
			type = item.type.to_i
			num  = item.num.to_i
			
			case type
			when 0 then $game_party.lose_item(id, num)
			when 1 then $game_party.lose_weapon(id, num)
			when 2 then $game_party.lose_armor(id, num)
			end
		end
		$game_party.lose_gold(@my_money) if @my_money > 0
	end
	
	def dispose
		@trade_manager.trade_cancel if !@check_trade_success
		
		if $j_inven
			$j_inven.setMode(0) 
			$j_inven.hide
		end
		super
	end
	
	def update
		super
		handle_item_remove
		handle_trade_ready 
		handle_money_transaction 
		
		Hwnd.dispose(self) if @cancel_button.click
	end
	
	def handle_item_remove
		@my_items_sprite.each_with_index do |item, i|
			next unless item.item?
			next unless item.double_click
			
			item.double_click = false
			@trade_manager.removeItem(i)
		end
	end
	
	def handle_trade_ready
		return unless @trade_button.click
		
		@trade_manager.trade_ready() 
	end
	
	def handle_money_transaction
		return unless @money.click
		
		money = @player_money.result.to_i
		return $console.write_line("1 이상의 금전을 입력하세요.") if money <= 0
		return $console.write_line("가지고 계신 금전이 부족합니다.") if $game_party.gold < money
		
		handle_valid_money_transaction(money)
	end
	
	def handle_valid_money_transaction(money)
		data = Trade_Data.new
		data.id = 0
		data.type = 3
		data.num = money
		
		@trade_manager.trade_addItem(data)
	end
end
