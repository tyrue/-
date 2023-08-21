

#============================================================================== 
# 　　◆ 소지수 한계 돌파 － item_maximum◆ 
#------------------------------------------------------------------------------ 
# 　아이템을 가질 수 있는 수를99이상으로 하는 스크립트입니다 
#============================================================================== 
# ★ 커스터마이즈 항목 ★ 
#============================================================================== 

#아이템의 소지수 
$item_maximum = 800 
#소지수의 자리수 
$item_maximum_place = 3 

# 특정 아이템 개수 제한
ITEM_LIMIT_NUM = {}
ITEM_LIMIT_NUM[146] = 1 # 정화비서
ITEM_LIMIT_NUM[163] = 5 # 일본주막비서
ITEM_LIMIT_NUM[217] = 5 # 고균도주막비서

#============================================================================== 
# ■ Game_Party 
#------------------------------------------------------------------------------ 
# 　파티를 취급하는 클래스입니다. 골드나 아이템등의 정보가 포함됩니다. 이 쿠 
# 라스의 인스턴스는 $game_party 으로 참조됩니다. 
#============================================================================== 

class Game_Party 
	#-------------------------------------------------------------------------- 
	# ● 골드의 증가 (감소) 
	#    n : 금액 
	#-------------------------------------------------------------------------- 
	def gain_gold(n) 
		#-------------------------------------------------------------------------- 
		@gold = [[@gold + n, 0].max, 999999999999].min
		$console.write_line("금전 #{-n}전 감소. 현재 #{@gold}전") if $global_x >= 30 and n < 0
		$console.write_line("금전 #{n}전 증가. 현재 #{@gold}전") if $global_x >= 30 and n > 0
		자동저장
	end 
	#-------------------------------------------------------------------------- 
	# ● 아이템의 증가 (감소) 
	# item_id : 아이템 ID 
	# n : 개수 
	#-------------------------------------------------------------------------- 
	def gain_item(item_id, n) 
		# 해시의 개수 데이터를 갱신 
		limit_num = ITEM_LIMIT_NUM[item_id] != nil ? ITEM_LIMIT_NUM[item_id] : $item_maximum
		
		if item_id > 0 
			@items[item_id] = [[item_number(item_id) + n, 0].max, limit_num].min
			$console.write_line("#{$data_items[item_id].name}을(를) #{n}개 획득. 현재 #{$game_party.item_number(item_id)}개") if $global_x >= 30 and n > 0
			$console.write_line("#{$data_items[item_id].name}을(를) #{-n}개 소모. 현재 #{$game_party.item_number(item_id)}개") if $global_x >= 30 and n < 0
			자동저장
			
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 무기의 증가 (감소) 
	# weapon_id : 무기 ID 
	# n : 개수 
	#-------------------------------------------------------------------------- 
	def gain_weapon(weapon_id, n) 
		# 해시의 개수 데이터를 갱신 
		if weapon_id > 0 
			@weapons[weapon_id] = [[weapon_number(weapon_id) + n, 0].max, $item_maximum].min 
			$console.write_line("#{$data_weapons[weapon_id].name}을(를) #{n}개 획득. 현재 #{$game_party.weapon_number(weapon_id)}개") if $global_x >= 30 and n > 0
			$console.write_line("#{$data_weapons[weapon_id].name}을(를) #{-n}개 소모. 현재 #{$game_party.weapon_number(weapon_id)}개") if $global_x >= 30 and n < 0
			자동저장
			
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 방어용 기구의 증가 (감소) 
	# armor_id : 방어용 기구 ID 
	# n : 개수 
	#-------------------------------------------------------------------------- 
	def gain_armor(armor_id, n) 
		# 해시의 개수 데이터를 갱신 
		if armor_id > 0 
			@armors[armor_id] = [[armor_number(armor_id) + n, 0].max, $item_maximum].min 
			$console.write_line("#{$data_armors[armor_id].name}을(를) #{n}개 획득. 현재 #{$game_party.armor_number(armor_id)}개") if $global_x >= 30 and n > 0
			$console.write_line("#{$data_armors[armor_id].name}을(를) #{-n}개 소모. 현재 #{$game_party.armor_number(armor_id)}개") if $global_x >= 30 and n < 0
			자동저장
		end 
	end
	
end 

#------------------------------------------------------------------------------- 

#============================================================================== 
# ■ Window_Item 
#------------------------------------------------------------------------------ 
# 　아이템 화면 , 배틀 화면에서 , 소지 아이템의 일람을 표시하는 윈도우입니다. 
#============================================================================== 

class Window_Item < Window_Selectable 
	#-------------------------------------------------------------------------- 
	# ● 항목의 묘화 
	# index : 항목 번호 
	#-------------------------------------------------------------------------- 
	def draw_item(index) 
		item = @data[index] 
		case item 
		when RPG::Item 
			number = $game_party.item_number(item.id) 
		when RPG::Weapon 
			number = $game_party.weapon_number(item.id) 
		when RPG::Armor 
			number = $game_party.armor_number(item.id) 
		end 
		
		if item.is_a?(RPG::Item) and $game_party.item_can_use?(item.id) 
			self.contents.font.color = normal_color 
		else 
			self.contents.font.color = disabled_color 
		end 
		
		x = 4 + index % 2 * (288 + 32) 
		y = index / 2 * 32 
		rect = Rect.new(x, y, self.width / @column_max - 32, 32) 
		self.contents.fill_rect(rect, Color.new(0, 0, 0, 0)) 
		bitmap = RPG::Cache.icon(item.icon_name) 
		opacity = self.contents.font.color == normal_color ? 255 : 128 
		self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24), opacity) 
		self.contents.draw_text(x + 28, y, 212, 32, item.name, 0) 
		width = 24 + ($item_maximum_place - 2) * 12 
		x_i = x - width + 24 
		self.contents.draw_text(x_i + 240, y, 16, 32, ":", 1) 
		self.contents.draw_text(x_i + 256, y, width, 32, number.to_s, 2) 
	end 
end 

#------------------------------------------------------------------------------- 

#============================================================================== 
# ■ Window_ShopNumber 
#------------------------------------------------------------------------------ 
# 　숍 화면에서 , 구입 또는 매각하는 아이템의 개수를 입력하는 윈도우입니다. 
#============================================================================== 

class Window_ShopNumber < Window_Base 
	#-------------------------------------------------------------------------- 
	# ● 리프레쉬 
	#-------------------------------------------------------------------------- 
	def refresh 
		self.contents.clear 
		draw_item_name(@item, 4, 96) 
		self.contents.font.color = normal_color 
		width = 24 + ($item_maximum_place - 2) * 12 
		widths = 32 + ($item_maximum_place - 2) * 12 
		
		self.contents.draw_text(272 - width + 24, 96, 32, 32, "×") 
		self.contents.draw_text(308 - width + 24, 96, width, 32, @number.to_s, 2) 
		self.cursor_rect.set(304 - width + 24, 96, widths, 32) 
		
		# self.cursor_rect.set(304, 96, 32, 32) 
		# 합계 가격과 통화단위를 묘화 
		domination = $data_system.words.gold 
		cx = contents.text_size(domination).width 
		total_price = @price * @number 
		self.contents.font.color = normal_color 
		self.contents.draw_text(4, 160, 328-cx-2, 32, total_price.to_s, 2) 
		self.contents.font.color = system_color 
		self.contents.draw_text(332-cx, 160, cx, 32, domination, 2) 
	end 
	
	#-------------------------------------------------------------------------- 
	# ● 프레임 갱신 
	#-------------------------------------------------------------------------- 
	def update 
		super 
		if self.active 
			# 커서 오른쪽 (+1) 
			if Input.repeat?(Input::RIGHT) and @number < @max 
				$game_system.se_play($data_system.cursor_se) 
				@number += 1 
				refresh 
			end 
			# 커서왼쪽 (-1) 
			if Input.repeat?(Input::LEFT) and @number > 1 
				$game_system.se_play($data_system.cursor_se) 
				@number -= 1 
				refresh 
			end 
			# 커서상 (+10) 
			if Input.repeat?(Input::UP) and @number < @max 
				$game_system.se_play($data_system.cursor_se) 
				@number = [@number + 10, @max].min 
				refresh 
			end 
			# 커서하 (-10) 
			if Input.repeat?(Input::DOWN) and @number > 1 
				$game_system.se_play($data_system.cursor_se) 
				@number = [@number - 10, 1].max 
				refresh 
			end 
			# R(최대수) 
			if Input.repeat?(Input::R) and @number < @max 
				$game_system.se_play($data_system.cursor_se) 
				@number = @max 
				refresh 
			end 
			# L(1) 
			if Input.repeat?(Input::L) and @number > 1 
				$game_system.se_play($data_system.cursor_se) 
				@number = 1 
				refresh 
			end 
		end 
	end 
end 

#------------------------------------------------------------------------------- 

#============================================================================== 
# ■ Window_ShopStatus 
#------------------------------------------------------------------------------ 
# 　숍 화면에서 , 아이템의 소지수나 엑터의 장비를 표시하는 윈도우입니다. 
#============================================================================== 

class Window_ShopStatus < Window_Base 
	#-------------------------------------------------------------------------- 
	# ● 리프레쉬 
	#-------------------------------------------------------------------------- 
	def refresh 
		self.contents.clear 
		if @item == nil 
			return 
		end 
		case @item 
		when RPG::Item 
			number = $game_party.item_number(@item.id) 
		when RPG::Weapon 
			number = $game_party.weapon_number(@item.id) 
		when RPG::Armor 
			number = $game_party.armor_number(@item.id) 
		end 
		self.contents.font.color = system_color 
		self.contents.draw_text(4, 0, 200, 32, "가지고 있는 수") 
		self.contents.font.color = normal_color 
		width = 36 + ($item_maximum_place - 2) * 16 
		self.contents.draw_text(204 - width + 36, 0, width, 32, number.to_s, 2) 
		if @item.is_a?(RPG::Item) 
			return 
		end 
		# 장비품 추가 정보 
		for i in 0...$game_party.actors.size 
			# 엑터를 취득 
			actor = $game_party.actors[i] 
			# 장비 가능하면 통상 문자색에 , 불가능하면 무효 문자색으로 설정 
			if actor.equippable?(@item) 
				self.contents.font.color = normal_color 
			else 
				self.contents.font.color = disabled_color 
			end 
			# 엑터의 이름을 묘화 
			self.contents.draw_text(4, 64 + 64 * i, 120, 32, actor.name) 
			# 현재의 장비품을 취득 
			if @item.is_a?(RPG::Weapon) 
				item1 = $data_weapons[actor.weapon_id] 
			elsif @item.kind == 0 
				item1 = $data_armors[actor.armor1_id] 
			elsif @item.kind == 1 
				item1 = $data_armors[actor.armor2_id] 
			elsif @item.kind == 2 
				item1 = $data_armors[actor.armor3_id] 
			else 
				item1 = $data_armors[actor.armor4_id] 
			end 
			# 장비 가능한 경우 
			if actor.equippable?(@item) 
				# 무기의 경우 
				if @item.is_a?(RPG::Weapon) 
					atk1 = item1 != nil ? item1.atk : 0 
					atk2 = @item != nil ? @item.atk : 0 
					change = atk2 - atk1 
				end 
				# 방어용 기구의 경우 
				if @item.is_a?(RPG::Armor) 
					pdef1 = item1 != nil ? item1.pdef : 0 
					mdef1 = item1 != nil ? item1.mdef : 0 
					pdef2 = @item != nil ? @item.pdef : 0 
					mdef2 = @item != nil ? @item.mdef : 0 
					change = pdef2 - pdef1 + mdef2 - mdef1 
				end 
				# 파라미터의 변화치를 묘화 
				self.contents.draw_text(124, 64 + 64 * i, 112, 32, sprintf("%+d", change), 2) 
			end 
			# 아이템을 묘화 
			if item1 != nil 
				x = 4 
				y = 64 + 64 * i + 32 
				bitmap = RPG::Cache.icon(item1.icon_name) 
				opacity = self.contents.font.color == normal_color ? 255 : 128 
				self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24), opacity) 
				self.contents.draw_text(x + 28, y, 212, 32, item1.name) 
			end 
		end 
	end 
end 

#------------------------------------------------------------------------------- 

#============================================================================== 
# ■ Window_ShopSell 
#------------------------------------------------------------------------------ 
# 　숍 화면에서 , 매각을 위해서(때문에) 소지 아이템의 일람을 표시하는 윈도우입니다. 
#============================================================================== 

class Window_ShopSell < Window_Selectable 
	#-------------------------------------------------------------------------- 
	# ● 항목의 묘화 
	# index : 항목 번호 
	#-------------------------------------------------------------------------- 
	def draw_item(index) 
		item = @data[index] 
		case item 
		when RPG::Item 
			number = $game_party.item_number(item.id) 
		when RPG::Weapon 
			number = $game_party.weapon_number(item.id) 
		when RPG::Armor 
			number = $game_party.armor_number(item.id) 
		end 
		# 매각 가능하면 통상 문자색에 , 그렇지 않으면 무효 문자색으로 설정 
		if item.price > 0 
			self.contents.font.color = normal_color 
		else 
			self.contents.font.color = disabled_color 
		end 
		x = 4 + index % 2 * (288 + 32) 
		y = index / 2 * 32 
		rect = Rect.new(x, y, self.width / @column_max - 32, 32) 
		self.contents.fill_rect(rect, Color.new(0, 0, 0, 0)) 
		bitmap = RPG::Cache.icon(item.icon_name) 
		opacity = self.contents.font.color == normal_color ? 255 : 128 
		self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24), opacity) 
		self.contents.draw_text(x + 28, y, 212, 32, item.name, 0) 
		width = 24 + ($item_maximum_place - 2) * 12 
		x_i = x - width + 24 
		self.contents.draw_text(x_i + 240, y, 16, 32, ":", 1) 
		self.contents.draw_text(x_i + 256, y, width, 32, number.to_s, 2) 
	end 
end 


#==============================================================================
# ** Window_ShopBuy
#------------------------------------------------------------------------------
#  This window displays buyable goods on the shop screen.
#==============================================================================

class Window_ShopBuy < Window_Selectable
	#--------------------------------------------------------------------------
	# * Refresh
	#--------------------------------------------------------------------------
	def refresh
		if self.contents != nil
			self.contents.dispose
			self.contents = nil
		end
		@data = []
		for goods_item in @shop_goods
			case goods_item[0]
			when 0
				item = $data_items[goods_item[1]]
			when 1
				item = $data_weapons[goods_item[1]]
			when 2
				item = $data_armors[goods_item[1]]
			end
			if item != nil
				@data.push(item)
			end
		end
		@data.sort!{|a, b| a.price <=> b.price}
		
		# If item count is not 0, make a bit map and draw all items
		@item_max = @data.size
		if @item_max > 0
			self.contents = Bitmap.new(width - 32, row_max * 32)
			for i in 0...@item_max
				draw_item(i)
			end
		end
	end
	
	def draw_item(index)
		item = @data[index]
		# Get items in possession
		case item
		when RPG::Item
			number = $game_party.item_number(item.id)
		when RPG::Weapon
			number = $game_party.weapon_number(item.id)
		when RPG::Armor
			number = $game_party.armor_number(item.id)
		end
		
		limit_num = ITEM_LIMIT_NUM[item.id] != nil ? ITEM_LIMIT_NUM[item.id] : $item_maximum
		
		if item.price <= $game_party.gold and number < limit_num
			self.contents.font.color = normal_color
		else
			self.contents.font.color = disabled_color
		end
		
		x = 4
		y = index * 32
		rect = Rect.new(x, y, self.width - 32, 32)
		self.contents.fill_rect(rect, Color.new(0, 0, 0, 0))
		bitmap = RPG::Cache.icon(item.icon_name)
		opacity = self.contents.font.color == normal_color ? 255 : 128
		self.contents.blt(x, y + 4, bitmap, Rect.new(0, 0, 24, 24), opacity)
		self.contents.draw_text(x + 28, y, 212, 32, item.name, 0)
		self.contents.draw_text(x + 240, y, 88, 32, item.price.to_s, 2)
	end
end

#------------------------------------------------------------------------------- 

#============================================================================== 
# ■ Scene_Shop 
#------------------------------------------------------------------------------ 
# 　숍 화면의 처리를 실시하는 클래스입니다. 
#============================================================================== 

class Scene_Shop 
	#-------------------------------------------------------------------------- 
	# ● 프레임 갱신 (구입 윈도우가 액티브의 경우) 
	#-------------------------------------------------------------------------- 
	def update_buy 
		# 스테이터스 윈도우의 아이템을 설정 
		@status_window.item = @buy_window.item 
		# B 버튼이 밀렸을 경우 
		if Input.trigger?(Input::B) 
			# 캔슬 SE 을 연주 
			$game_system.se_play($data_system.cancel_se) 
			# 윈도우 상태를 초기 모드에 
			@command_window.active = true 
			@dummy_window.visible = true 
			@buy_window.active = false 
			@buy_window.visible = false 
			@status_window.visible = false 
			@status_window.item = nil 
			# 헬프 텍스트를 소거 
			@help_window.set_text("") 
			return 
		end 
		# C 버튼이 밀렸을 경우 
		if Input.trigger?(Input::C) 
			# 아이템을 취득 
			@item = @buy_window.item 
			# 아이템이 무효의 경우 , 또는 가격이 소지금보다 위의 경우 
			if @item == nil or @item.price > $game_party.gold 
				# 버저 SE 를 연주 
				$game_system.se_play($data_system.buzzer_se) 
				return 
			end 
			# 아이템의 소지수를 취득 
			case @item 
			when RPG::Item 
				number = $game_party.item_number(@item.id) 
			when RPG::Weapon 
				number = $game_party.weapon_number(@item.id) 
			when RPG::Armor 
				number = $game_party.armor_number(@item.id) 
			end 
			
			limit_num = ITEM_LIMIT_NUM[@item.id] != nil ? ITEM_LIMIT_NUM[@item.id] : $item_maximum
			# 벌써 99 개소 지키고 있는 경우 
			if number == limit_num
				# 버저 SE 를 연주 
				$game_system.se_play($data_system.buzzer_se) 
				return 
			end 
			
			# 결정 SE 을 연주 
			$game_system.se_play($data_system.decision_se) 
			# 최대 구입 가능 개수를 계산 
			max = @item.price == 0 ? limit_num : $game_party.gold / @item.price 
			max = [max, limit_num - number].min 
			# 윈도우 상태를 개수 입력 모드에 
			@buy_window.active = false 
			@buy_window.visible = false 
			@number_window.set(@item, max, @item.price) 
			@number_window.active = true 
			@number_window.visible = true 
		end 
	end 
end 