class Item_data
	attr_accessor :Trade_ban_item
	
	def initialize
		@Trade_ban_item = []
		@Trade_ban_weapon = []
		@Trade_ban_armor = []
		# 가격이 0인 아이템들은 교환 불가 아이템
		
		if $data_items != nil
			for item in $data_items
				if item != nil
					if item.name != "" and item.price <= 0
						#p item.name
						@Trade_ban_item.push(item.id) 
					end
				end
			end
		end
		
		if $data_weapons != nil
			for item in $data_weapons
				if item != nil
					if item.name != "" and item.price <= 0
						#p item.name
						@Trade_ban_weapon.push(item.id) 
					end
				end
			end
		end
		
		if $data_armors != nil
			for item in $data_armors
				if item != nil
					if item.name != "" and item.price <= 0
						#p item.name
						@Trade_ban_armor.push(item.id) 
					end
				end
			end
		end
				
		# 교환불가 아이템 추가
		@Trade_ban_item.push(52) # 청룡의 비늘
		@Trade_ban_item.push(53) # 화룡의 비늘
		@Trade_ban_item.push(114) # 팔괘
		@Trade_ban_item.push(119) # 반고의 심장
		@Trade_ban_item.push(163) # 일본주막비서
		@Trade_ban_item.push(217) # 고균도주막비서
		
		# 교환 불가 무기 추가
		
		# 교환 불가 장비 추가
	end
	
	# 교환 가능 아이템인가?
	def is_trade_ok(id, type)
		case type
		when 0 # 아이템
			return !@Trade_ban_item.include?(id)
		when 1 # 무기
			return !@Trade_ban_weapon.include?(id)
		when 2 # 장비
			return !@Trade_ban_armor.include?(id)
		end
	end
end
