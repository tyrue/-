class TradeManager
	attr_accessor :player_name 
	attr_accessor :max_size
	attr_accessor :trader
	
	def initialize
		@player_name = $game_party.actors[0].name
		@max_size = 5
	end
	
	def trade_invite(target)
		@trader = target
		Network::Main.send_with_tag("trade_invite", "#{target}")
	end
	
	def trade_addItem(item)
		data = {
			"id" => item.id,
			"num" => item.num,
			"type" => item.type,
		}
		
		message = data.map { |key, value| "#{key}:#{value}" }.join("|")
		Network::Main.send_with_tag("trade_addItem", "#{message}")
		
		trade_window = Hwnd.include?("Trade", 1)
		return unless trade_window
		trade_window.add_item(item)
	end
	
	def addItem_trader(data)
		trade_window = Hwnd.include?("Trade", 1)
		return unless trade_window

		item = Trade_Data.new
		item.type = data["type"].to_i
		item.id = data["id"].to_i
		item.num = data["num"].to_i
		trade_window.add_item(item, 1)
	end
	
	def removeItem(index)
		Network::Main.send_with_tag("trade_removeItem", "#{index}")
		trade_window = Hwnd.include?("Trade", 1)
		return unless trade_window
		
		trade_window.remove_item(index)
	end
	
	def removeItem_trader(index)
		trade_window = Hwnd.include?("Trade", 1)
		return unless trade_window
		
		trade_window.remove_item(index, 1)
	end
	
	def trade_ready()
		Network::Main.send_with_tag("trade_ready")
	end
	
	def trade_cancel()
		Network::Main.send_with_tag("trade_cancel") if trader != nil
	end
	
	def trade_end()
		self.initial_set
		Hwnd.dispose("Trade")
	end
	
	def trade_decide(trader)
		@trader = trader
		dialog_text = ["'#{@trader}'님께서 교환 신청을 하셨습니다. 수락 하시겠습니까?"]
		
		accept_script = <<-SCRIPT
		$trade_manager.trade_accept();
		Hwnd.dispose(self);
		SCRIPT
		
		decline_script = <<-SCRIPT
		$trade_manager.trade_refuse();
		Hwnd.dispose(self);
		SCRIPT
		
		Jindow_Dialog.new(
			"교환 신청",
			dialog_text,
			[["예", accept_script], ["아니오", decline_script]]
		)
	end
	
	def trade_accept()
		Network::Main.send_with_tag("trade_accept")
	end
	
	def trade_refuse()
		Network::Main.send_with_tag("trade_refuse")
		self.initial_set
	end
	
	def trade_success(data)
		trade_window = Hwnd.include?("Trade", 1)
		return unless trade_window
		trade_window.trade_success()
		self.trade_end
	end
	
	def initial_set
		trader = nil
	end
end

class Trade_Data
	attr_accessor :id
	attr_accessor :type
	attr_accessor :num
end