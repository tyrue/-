class Item_data
	attr_accessor :Trade_ban_item
	#Trade_ban_item.push(
	
	def initialize
		@Trade_ban_item = []
		# 가격이 0인 아이템들은 교환 불가 아이템
		
		if $data_items != nil
			for item in $data_items
				if item != nil
					@Trade_ban_item.push(item.id) if item.price <= 0 
				end
			end
		end
		
		# 교환불가 아이템 추가
		@Trade_ban_item.push(52) # 청룡의 비늘
		@Trade_ban_item.push(53) # 화룡의 비늘
		@Trade_ban_item.push(114) # 팔괘
		@Trade_ban_item.push(119) # 반고의 심장
		
	end
	
	# 교환 가능 아이템인가?
	def is_trade_ok(id)
		return !@Trade_ban_item.include?(id)
	end
end
