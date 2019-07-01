#==============================================================================
# ■ Jindow_Inventory
#------------------------------------------------------------------------------
#   캐릭터 인벤토리 창
#------------------------------------------------------------------------------
class Jindow_Inventory < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 220, 150)
		self.name = "아이템"
		@head = true
		@mark = true
		@drag = true
		@close = true
		self.refresh("Inventory")
		self.x = 360
		self.y = 95
		sort
	end
	
	def sort
		@item.clear
		
		for i in 1..$data_items.size
			if $game_party.item_number(i) > 0
				if i != nil
					J::Item.new(self).set(true).refresh($data_items[i].id, 0)
				end
			end
		end
		for i in 1..$data_weapons.size
			if $game_party.weapon_number(i) > 0
				if i != nil
					J::Item.new(self).set(true).refresh($data_weapons[i].id, 1)
				end
			end
		end
		for i in 1..$data_armors.size
			if $game_party.armor_number(i) > 0
				if i != nil
					J::Item.new(self).set(true).refresh($data_armors[i].id, 2)
				end
			end
		end
		for i in @item
			i.x = (i.id % 6) * 36
			i.y = (i.id / 6) * 36 + 18
		end
	end	
	
	def update
		self.x != 205
		self.y != 162
		if not Hwnd.include?('Trade')
			for i in @item
				i.item? ? 0 : next
				i.double_click ? 0 : next
				case i.type
				when 0 # 아이템
					$game_party.actors[0].item_effect(i.item)
					$game_system.se_play(i.item.menu_se)
					if i.item.consumable
						$game_party.lose_item(i.item.id, 1)
						if  i.item.common_event_id > 0
							# Command event call reservation
							$game_temp.common_event_id = i.item.common_event_id
							# Play item use SE
							$game_system.se_play(i.item.menu_se)
						end
						if i.num <= 0
							id = i.id
							@item[id] = nil
							i.dispose
						end
					elsif i.item.common_event_id > 0
						# Command event call reservation
						$game_temp.common_event_id = i.item.common_event_id
						# Play item use SE
						$game_system.se_play(i.item.menu_se)
					end
					
				when 1 # 무기
					if $game_party.actors[0].equippable?(i.item)
						$game_party.actors[0].equip(0, i.item.id)
						Audio.se_play("Audio/SE/장비")
						
					end
				when 2 # 방어구
					if $game_party.actors[0].equippable?(i.item)
						$game_party.actors[0].equip(i.item.kind + 1, i.item.id)
						Audio.se_play("Audio/SE/장비")
						
					end
				end
				sort
			end
		else
			for i in @item
				i.item? ? 0 : next
				i.double_click ? 0 : next
				if $trade_item1 != 1
					check(i,1)
				elsif $trade_item2 != 1
					check(i,2)
				elsif $trade_item3 != 1
					check(i,3)
				elsif $trade_item4 != 1
					check(i,4)
				end
			end
		end
		# sort
		super
	end	
	
	def check(i,option)
		if $game_variables[1003] < 1
			Jindow_Trade2.new(i.item.id, i.type, option)
		else
			Hwnd.dispose("Trade2")
			$console.write_line("[교환]:더이상 아이탬을 올릴수 없습니다.")
		end
	end
end
