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
		super(0, 0, 260, 300)
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
		
		@line_count = 7
		@item_margin = 10
		
		@sort_button = J::Button.new(self).refresh(60, "정렬하기")
		@gold_drop_button = J::Button.new(self).refresh(60, "금전 버리기")
		
		@opacity = 255
		self.opacity = @opacity
		
		@data = {}
		@data[0] = [] # 아이템
		@data[1] = [] # 무기
		@data[2] = [] # 방어구
		
		for i in 1..$data_items.size
			@data[0].push(J::Item.new(self).set(true).refresh($data_items[i].id, 0)) if $data_items[i] != nil and $data_items[i].name != ""
		end
		
		for i in 1..$data_weapons.size
			@data[1].push(J::Item.new(self).set(true).refresh($data_weapons[i].id, 1)) if $data_weapons[i] != nil and $data_weapons[i].name != ""
		end
		
		for i in 1..$data_armors.size
			@data[2].push(J::Item.new(self).set(true).refresh($data_armors[i].id, 2)) if $data_armors[i] != nil and $data_armors[i].name != ""
		end
		
		for i in @item
			if i.is_a?(J::Item)
				i.offVisible
			end
		end
		
		@item.clear()
		sort
		
		self.width = @line_count * (@item_margin + @data[0][0].width)
		@sort_button.x = self.width - @sort_button.width - @gold_drop_button.width - 20
		@sort_button.y = 0
		
		@gold_drop_button.x = @sort_button.x + @sort_button.width + 10
		@gold_drop_button.y = @sort_button.y
		
		# 모드 : 기본 인벤토리, 교환 모드, 상점 판매 모드 등
		@mode = 0 
		
		self.window_ini
		self.refresh("Inventory")
	end
	
	def setMode(id)
		@mode = id
		case @mode
		when 0
			self.name = "아이템"
			self.change_name(@name)
			$console.write_line("기본 가방 상태")
		when 1
			self.name = "교환할 아이템을 더블 클릭하세요."
			self.change_name(@name)
			$console.write_line("교환 가방 상태")
		when 2
			self.name = "판매할 아이템을 더블 클릭하세요."
			self.change_name(@name)
			$console.write_line("상점 판매 가방 상태")
		end
	end
	
	def sort(id = 0)
		return if !@tog
		자동저장
		@item.push(@gold_drop_button) if !@item.include?(@gold_drop_button)
		@item.push(@sort_button) if !@item.include?(@sort_button)
		
		# 현재 아이템 개수에 따라 보여질지 없앨지 정함
		for d in @data
			for item in d[1]
				next if item == nil
				if item.num <= 0
					@item.delete(item) if @item.include?(item)
					item.offVisible 
				else
					@item.push(item) if !@item.include?(item)
				end
			end
		end
		
		temp_item = []
		temp_item[0] = []
		temp_item[1] = []
		temp_item[2] = []
		
		for i in 0..4
			temp_item[2].push([])
		end
		
		for i in @item
			i.visible = @tog
			next if !i.is_a?(J::Item)
			
			if i.type != 2
				temp_item[i.type].push(i)
			else
				temp_item[i.type][i.item.kind].push(i)
			end
		end
		
		count = 0
		idx = 0
		tempY = @gold_drop_button.y + @gold_drop_button.height + 5
		for temp in temp_item
			old_c = count
			
			for i in temp				
				if idx == 2 
					for ii in i
						ii.x = (count % @line_count) * (ii.width + @item_margin)
						ii.y = (count / @line_count) * (ii.height + @item_margin) + tempY
						count += 1
					end
					count += (count % @line_count) != 0 ? @line_count : 0
					count -= count % @line_count
					
				else
					i.x = (count % @line_count) * (i.width + @item_margin)
					i.y = (count / @line_count) * (i.height + @item_margin) + tempY
					count += 1
				end				
			end
			
			if old_c != count
				count += (count % @line_count) != 0 ? @line_count * 2 : @line_count
				count -= count % @line_count
			end
			idx += 1
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
		if @sort_button.click
			@sort_button.click = false
			$console.write_line("물품을 정리했습니다.")
			@item.clear()
			self.sort
		end
		
		if @gold_drop_button.click
			@gold_drop_button.click = false
			if $game_switches[296]
				$console.write_line("귀신은 할 수 없습니다.")
				return
			end
			
			Hwnd.dispose("Item_Drop") if Hwnd.include?("Item_Drop")
			Jindow_Drop.new(0, 0, 0) # 돈을 버림
		end
		
		for i in @item
			i.item? ? 0 : next
			i.double_click ? 0 : next
			i.double_click = false
			# 아이템 더블클릭시 이벤트 실행
			
			case @mode
			when 0
				itemUse(i)
			when 1 # 교환
				tradeCheck(i)
			when 2 # 상점
				shopSellItem(i)
			when 3 # 편지 보내기
				postItem(i)
			end
		end	
		super
	end	
	
	#-------#
	#아이템 사용#
	#-------#
	def itemUse(i)
		case i.type
		when 0 # 아이템
			return if !$game_party.actors[0].item_effect(i.item)
			
			$game_player.animation_id = i.item.animation1_id
			Network::Main.ani(Network::Main.id, i.item.animation1_id) 
			$game_party.lose_item(i.item.id, 1) if i.item.consumable
			$game_system.se_play(i.item.menu_se)
			$game_temp.common_event_id = i.item.common_event_id if i.item.common_event_id > 0
			
		when 1, 2 # 무기, 장비
			if $game_switches[296]
				$console.write_line("귀신은 할 수 없습니다.")
				return
			end
			
			if $game_party.actors[0].equippable?(i.item)
				kind = i.type == 1 ? 0 : i.item.kind + 1
				$game_party.actors[0].equip(kind, i.item.id)
				Audio.se_play("Audio/SE/장비", $game_variables[13])
			end
		end
	end
	
	#-------#
	#아이템 교환#
	#-------#
	def tradeCheck(i)
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
	
	#----------#
	#상점 아이템 판매#
	#----------#
	def shopSellItem(i)
		if i.item.price > 0
			Hwnd.include?("Shop_Num_Window") ? Hwnd.dispose("Shop_Num_Window") : 0
			Jindow_Shop_Num.new(i.item, i.type, 1) # 판매모드로 열기
		else
			$console.write_line("판매 불가 아이템입니다.")
		end
	end
	
	#--------#
	#아이템 보내기#
	#--------#
	def postItem(i)
		if $Abs_item_data.is_trade_ok(i.item.id, i.type)
			post_jin = Hwnd.include?("Post", 1)
			data = Jindow_Trade_Data.new
			data.id = i.item.id
			data.type = i.type
			data.amount = 1
			post_jin.set_data(data)
		else
			$console.write_line("[편지]: 교환 불가 아이템입니다.")
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
		
		if $game_party.item_number(item.id) <= 0
			$console.write_line("아이템이 없습니다.")
			return false
		end
		
		jindow_item_event(item)
		return true
	end
end