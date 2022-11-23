#==============================================================================
# ■ Jindow_Inventory
#------------------------------------------------------------------------------
#   캐릭터 인벤토리 창
#------------------------------------------------------------------------------
$trade_num = 1

class Jindow_Inventory < Jindow
	attr_reader :temp_sw
	def initialize
		자동저장
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 220, 200)
		self.name = "아이템"
		@head = true
		@mark = true
		@drag = true
		@close = true
		@tog = true
		@temp_sw = true
		
		self.x = 360
		self.y = 95
		@inventory_size = 100
		@margin = 10
		
		@gold_drop_button = J::Button.new(self).refresh(60, "금전 버리기")
		@gold_drop_button.x = self.width - @gold_drop_button.width - 10
		@gold_drop_button.y = 0
		
		@opacity = 255
		self.opacity = @opacity
		
		@data = []
		
		for i in 1..$data_items.size
			if $game_party.item_number(i) > 0 
				@data.push($data_items[i])
				J::Item.new(self).set(true).refresh($data_items[i].id, 0)
			end
		end
		
		for i in 1..$data_weapons.size
			if $game_party.weapon_number(i) > 0
				@data.push($data_weapons[i])
				J::Item.new(self).set(true).refresh($data_weapons[i].id, 1)
			end
		end
		
		for i in 1..$data_armors.size
			if $game_party.armor_number(i) > 0
				@data.push($data_armors[i])
				J::Item.new(self).set(true).refresh($data_armors[i].id, 2)
			end
		end
		
		sort
		self.refresh("Inventory")
	end
	
	def sort(id = 0)
		return if !@tog
		자동저장
		#~ # Add item
		for i in 1..$data_items.size
			if $game_party.item_number(i) > 0 and !@data.include?($data_items[i])
				@data.push($data_items[i]) 
				J::Item.new(self).set(true).refresh($data_items[i].id, 0)
			end
			
			if $game_party.item_number(i) <= 0 and @data.include?($data_items[i])
				@data.delete($data_items[i]) 
			end
		end
		
		for i in 1..$data_weapons.size
			if $game_party.weapon_number(i) > 0 and !@data.include?($data_weapons[i]) 
				@data.push($data_weapons[i])
				J::Item.new(self).set(true).refresh($data_weapons[i].id, 1)
			end
			
			if $game_party.weapon_number(i) <= 0 and @data.include?($data_weapons[i])
				@data.delete($data_weapons[i]) 
			end
		end
		
		for i in 1..$data_armors.size
			if $game_party.armor_number(i) > 0 and !@data.include?($data_armors[i])
				@data.push($data_armors[i])
				J::Item.new(self).set(true).refresh($data_armors[i].id, 2)
			end
			
			if $game_party.armor_number(i) <= 0 and @data.include?($data_armors[i])
				@data.delete($data_armors[i]) 
			end
		end
		
		for i in @item
			if i.is_a?(J::Item) and i.num == 0
				if i != nil and !i.disposed?
					i.visible = false
					i.dispose 
					@item.delete(i)
				end
			end
		end
		
		count = 0
		for i in @item
			if i.is_a?(J::Item)
				i.x = (count % 6) * 36
				i.y = (count / 6) * 36 + 18
				count += 1
			end
		end
	end	
	
	def hide
		super
		@tog = false
	end
	
	def show(val = @opacity)
		super
		@tog = true
		self.sort
	end
	
	def toggle
		if @tog
			hide
			@temp_sw = false
		else
			show(@opacity)
			@temp_sw = true
		end
	end
	
	
	def update
		return if !@tog
		
		if @gold_drop_button.click
			@gold_drop_button.click = false
			if $game_switches[296]
				$console.write_line("귀신은 할 수 없습니다.")
				return
			end
			if not Hwnd.include?("Item_Drop")
				Jindow_Drop.new(0, 0, 0) # 돈을 버림
			else
				Hwnd.dispose("Item_Drop")
				Jindow_Drop.new(0, 0, 0) # 돈을 버림
			end
		end
		
		if not Hwnd.include?('Trade')
			for i in @item
				i.item? ? 0 : next
				i.double_click ? 0 : next
				i.double_click = false
				# 아이템 더블클릭시 이벤트 실행
				case i.type
				when 0 # 아이템
					next if !$game_party.actors[0].item_effect(i.item)
					
					$game_player.animation_id = i.item.animation1_id
					Network::Main.ani(Network::Main.id, i.item.animation1_id) 
					$game_party.lose_item(i.item.id, 1) if i.item.consumable
					$game_system.se_play(i.item.menu_se)
					$game_temp.common_event_id = i.item.common_event_id if i.item.common_event_id > 0
					
				when 1 # 무기
					if $game_switches[296]
						$console.write_line("귀신은 할 수 없습니다.")
						return
					end
					
					if $game_party.actors[0].equippable?(i.item)
						$game_party.actors[0].equip(0, i.item.id)
						Audio.se_play("Audio/SE/장비", $game_variables[13])
					end
					
				when 2 # 방어구
					if $game_switches[296]
						$console.write_line("귀신은 할 수 없습니다.")
						return
					end
					
					if $game_party.actors[0].equippable?(i.item)
						$game_party.actors[0].equip(i.item.kind + 1, i.item.id)
						Audio.se_play("Audio/SE/장비", $game_variables[13])
					end
				end
			end	
			
		else # 교환창이 열린 상태인가?
			for i in @item
				i.item? ? 0 : next
				i.double_click ? 0 : next
				check(i)
				
			end
		end
				
		super
	end	
	
	def check(i)
		if $trade_num <= $MAX_TRADE
			if $Abs_item_data.is_trade_ok(i.item.id, i.type)
				Jindow_Trade2.new(i.item.id, i.type, $trade_num) 
			else
				$console.write_line("[교환]: 교환 불가 아이템입니다.")
			end
		else
			Hwnd.dispose("Trade2")
			$console.write_line("[교환]: 더이상 아이템을 올릴수 없습니다.")
		end		
	end
	
	def dispose2
		$game_system.se_play($data_system.cancel_se)
		toggle
	end
end


class Game_Battler
	alias jindow_item_event item_effect
	def item_effect(item)
		# 유저 죽음 스위치가 켜져있다면 패스
		if $game_switches[296]
			if item.id != 63 # 부활시약
				$console.write_line("귀신은 할 수 없습니다.")
				return false
			end
		end
		
		if (item.recover_hp > 0 or item.recover_hp_rate > 0) and ($game_party.actors[0].hp == $game_party.actors[0].maxhp)
			$console.write_line("이미 완전 회복된 상태 입니다.")
			return false
		end
		
		if (item.recover_sp > 0 or item.recover_sp_rate > 0) and ($game_party.actors[0].sp == $game_party.actors[0].maxsp)
			$console.write_line("이미 완전 회복된 상태 입니다.")
			return false
		end
		
		jindow_item_event(item)
		return true
	end
end