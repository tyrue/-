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
		
		setup_item_lists
		setup_item_slots
		setup_trade_messages
		setup_trade_buttons
	end
	
	def setup_item_lists
		@my_items = []
		@trader_items = []
		
		@my_items_sprite = []
		@trader_items_sprite = []
		
		@check_my_list = []
		@check_trader_list = []
		
		@my_pos = [self.width / 2, 20]
		@trader_pos = [0, 20]
		
		@my_items_slot = []
		@trader_items_slot = []
		
		@my_slot_text = []
		@trader_slot_text = []
	end
	
	def setup_item_slots
		(0...@trade_manager.max_size).each do |i|
			@my_items_slot << create_item_slot(@my_pos[0], @my_pos[1] + 27 * (i + 1))
			@trader_items_slot << create_item_slot(@trader_pos[0], @trader_pos[1] + 27 * (i + 1))
			
			@my_slot_text << create_slot_text(@my_pos[0], @my_pos[1] + 27 * (i + 1))
			@trader_slot_text << create_slot_text(@trader_pos[0], @trader_pos[1] + 27 * (i + 1))
		end
	end
	
	def create_item_slot(x, y)
		sprite = Sprite.new(self)
		sprite.bitmap = Bitmap.new(@route + "item_win")
		sprite.x = x
		sprite.y = y
		sprite
	end
	
	def create_slot_text(x, y)
		sprite = Sprite.new(self)
		sprite.bitmap = Bitmap.new(self.width, self.height)
		sprite.bitmap.font.color = Color.new(0, 0, 0, 255)
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
		@a = J::Button.new(self).refresh(40, "교환")
		@a.x = self.width / 2 - @a.width
		@a.y = @money.y + 30
		
		@b = J::Button.new(self).refresh(40, "취소")
		@b.x = @a.x + @a.width + 10
		@b.y = @a.y
		
		self.height = @b.y + 40
		self.refresh("Trade")
	end
	
	def setup_inventory_mode
		return unless $j_inven
		
		$j_inven.show
		$j_inven.setMode(1)
	end
	
	def add_item(item, type = 0) # 타입이 0이면 내거 아니면 상대방거
		case type
		when 0
			@my_items << item
			if item.type == 3
				@money.visible = false
				@player_money.visible = false
				@dialog.bitmap.draw_text(@player_money.x, @player_money.y, 200, 30, "#{item.num}전")
			else
				@my_items_sprite << J::Item.new(self).refresh(item.id, item.type)
			end
		when 1
			@trader_items << item
			if item.type == 3
				@dialog.bitmap.draw_text(@trader_pos[0], @player_money.y, 200, 30, "#{item.num}전")
			else
				@trader_items_sprite << J::Item.new(self).refresh(item.id, item.type)
			end
		end
	end
	
	def remove_item(index, type = 0) # 타입이 0이면 내거 아니면 상대방거
		case type
		when 0
			@my_items.delete_at(index)
			@my_items_sprite[index].dispose
			@my_items_sprite.delete_at(index) 
		when 1
			@trader_items.delete_at(index)
			@trader_items_sprite[index].dispose
			@trader_items_sprite.delete_at(index) 
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
			id = item.id.to_i
			type = item.type.to_i
			num  = item.num.to_i
			
			case type
			when 0
				$game_party.gain_item(id, num)
			when 1
				$game_party.gain_weapon(id, num)
			when 2
				$game_party.gain_armor(id, num)
			when 3
				$game_party.gain_gold(num)
			end
		end
	end
	
	def lose_my_items
		@my_items.each do |item|
			id = item.id.to_i
			type = item.type.to_i
			num  = item.num.to_i
			
			case type
			when 0
				$game_party.lose_item(id, num)
			when 1
				$game_party.lose_weapon(id, num)
			when 2
				$game_party.lose_armor(id, num)
			when 3
				$game_party.lose_gold(num)
			end
		end
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
		handle_check_change
		handle_trade_ready if @a.click
		handle_money_transaction if @money.click
		Hwnd.dispose(self) if @b.click
	end
	
	def handle_check_change
		return if (@my_items == @check_my_list) && (@trader_items == @check_trader_list)
		
		@check_my_list = Marshal.load(Marshal.dump(@my_items))
		@check_trader_list = Marshal.load(Marshal.dump(@trader_items))
		
		@my_items_sprite.each_with_index do |item, i|
			item.x = @my_items_slot[i].x
			item.y = @my_items_slot[i].y
			@my_slot_text[i].bitmap.draw_text(30, 0, 200, 30, "#{item.item.name} #{@my_items[i].num}개") 
		end
		
		@trader_items_sprite.each_with_index do |item, i|
			item.x = @trader_items_slot[i].x
			item.y = @trader_items_slot[i].y
			@trader_slot_text[i].bitmap.draw_text(30, 0, 200, 30, "#{item.item.name} #{@trader_items[i].num}개") 
		end
	end
	
	def handle_trade_ready
		@trade_manager.trade_ready()
	end
	
	def handle_money_transaction
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
