# 코인 샾 데이터[id] = [
#	[상점 코인 아이템 타입, 아이템 id], 
#	[
#		[판매 할 아이템 타입, id, 개수, 필요 아이템 개수...], 
#		...
#	]
#]

COIN_SHOP_DATA = {}
COIN_SHOP_DATA[1] = [ # 용궁 증표 상점
	[0, 84], 
	[
		[0, 40, 1, 2], # 용궁의 바닷물
		[0, 37, 1, 1], # 불의결정
		[0, 63, 1, 8], # 부활시약
		[0, 81, 1, 2], # 속도시약
		[0, 99, 1, 2], # 호박의결정
		[0, 100, 1, 2], # 진호박의결정
		[0, 101, 2, 2], # 단단한녹용
		[0, 116, 1, 7], # 황금호박
		[0, 38, 1, 3], # 작은보물상자
		
		[1, 130, 1, 60], # 뇌령진도
		[2, 44, 1, 60], # 황혼의활복
	]
] 

COIN_SHOP_DATA[2] = [ # 주몽 증표 상점
	[0, 85], 
	[
		[0, 37, 3, 1], # 불의결정
		[0, 63, 1, 3], # 부활시약
		[0, 81, 1, 1], # 속도시약
		[0, 99, 1, 1], # 호박의결정
		[0, 100, 1, 1], # 진호박의결정
		[0, 103, 25, 1], # 얼음
		[0, 116, 1, 3], # 황금호박
		[0, 120, 1, 15], # 크리스탈
		[0, 121, 1, 15], # 수정
		[0, 122, 1, 10], # 은나무가지
		[0, 39, 1, 5], # 고급보물상자
		[1, 130, 1, 25], # 뇌령진도
		[2, 44, 1, 25], # 황혼의활복
	]
] 

COIN_SHOP_DATA[3] = [ # 현무 증표 상점
	[0, 86], 
	[
		[0, 37, 8, 1], # 불의결정
		[0, 63, 1, 1], # 부활시약
		[0, 81, 3, 1], # 속도시약
		[0, 99, 3, 1], # 호박의결정
		[0, 100, 3, 1], # 진호박의결정
		[0, 120, 1, 5], # 크리스탈
		[0, 121, 1, 5], # 수정
		[0, 122, 1, 3], # 은나무가지
		[0, 92, 1, 10], # 최고급보물상자
		
		[0, 201, 1, 5], # 대지의토템
		[0, 202, 1, 5], # 바람의토템
		[0, 203, 1, 5], # 번개의토템
		[0, 204, 1, 5], # 화염의토템
		[0, 213, 1, 15], # 정령의결정
		[0, 206, 1, 25], # 자연의인'상
		[0, 207, 1, 25], # 자연의인'하
	]
] 

#==============================================================================
# ■ Jindow_Shop_Coin
#------------------------------------------------------------------------------
#   코인 상점 진도우화
#------------------------------------------------------------------------------
class Jindow_Shop_Coin < Jindow
	def initialize(shopId, eventId) # 상점 데이터 id, 이벤트 아이디
		Hwnd.include?("Shop_Window_Coin") ? Hwnd.dispose("Shop_Window_Coin") : 0
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 260, 330)
		@head = true
		@mark = true
		@drag = true
		@close = true
		@event = $game_map.events[eventId]
		
		self.name = @event.sprite_id != nil ? @event.sprite_id : "상점"
		self.refresh "Shop_Window_Coin"
		self.x = (640 - self.max_width) / 5
		self.y = (480 - self.max_height) / 2
		
		shopData = COIN_SHOP_DATA[shopId]
		coinData = shopData[0]
		itemData = shopData[1]
		
		@coin = J::Item.new(self).set(true).refresh(coinData[1], coinData[0])
		
		@data = []
		@data2 = []
		for goods_item in itemData
			type = goods_item[0]
			item_id = goods_item[1]
			num = goods_item[2]
			price = goods_item[3]
			
			case type
			when 0
				next if $data_items[item_id] == nil  
				next if $data_items[item_id].name == ""
				@data.push(J::Item.new(self).set(true).refresh(item_id, 0)) 
				@data2.push([num, price])
			when 1
				next if $data_weapons[item_id] == nil  
				next if $data_weapons[item_id].name == ""
				@data.push(J::Item.new(self).set(true).refresh(item_id, 1)) 
				@data2.push([num, price])
			when 2
				next if $data_armors[item_id] == nil  
				next if $data_armors[item_id].name == ""
				@data.push(J::Item.new(self).set(true).refresh(item_id, 2)) 
				@data2.push([num, price])
			end
		end
		
		return if @data.size == 0
		
		# 캐릭터 비트맵
		bmp = RPG::Cache.character(@event.character_name, @event.character_hue)
		
		cw = bmp.width / 4
		ch = bmp.height / 4
		
		sx = @event.pattern * cw
		sy = (@event.direction - 2) / 2 * ch
		src_rect = Rect.new(sx, sy, cw, ch)
		
		@eventBitmap = Sprite.new(self)
		@eventBitmap.bitmap = Bitmap.new(cw, ch)
		@eventBitmap.bitmap.blt(0, 0, bmp, src_rect)
		@eventBitmap.x = 5
		@eventBitmap.y = 10
		
		@helloText = Sprite.new(self)
		@helloText.bitmap = Bitmap.new(self.width - (@eventBitmap.x + @eventBitmap.width + 10), @eventBitmap.y + @eventBitmap.height)
		@helloText.bitmap.font.size = 12
		@helloText.bitmap.font.color.set(0, 0, 0, 255)
		@helloText.x = @eventBitmap.x + @eventBitmap.width + 5
		@helloText.y = @eventBitmap.y
		txt = "제가 파는 물건들입니다. 그림과 가격도 함께 드리니 잘 생각해주시고 골라주세요."
		
		w = 0
		h = 0
		for i in txt.scan(/./)
			rect = @helloText.bitmap.text_size(i)
			if w + rect.width > @helloText.width
				h += rect.height
				w = 0
				@helloText.bitmap.draw_text(w, h, rect.width, rect.height, i)
				w += rect.width
			else
				@helloText.bitmap.draw_text(w, h, rect.width, rect.height, i)
				w += rect.width
			end
		end
		
		@line_count = 1
		@item_margin = 10
		
		@coin.x = self.width - @coin.width - @item_margin - 40
		@coin.y = @helloText.y + @helloText.height - @coin.height - @item_margin
		
		@coinText = Sprite.new(self)
		@coinText.bitmap = Bitmap.new(60, 60)
		@coinText.bitmap.font.size = 12
		@coinText.bitmap.font.color.set(0, 0, 0, 255)
		@haveNum = 0
		case @coin.type
		when 0
			@haveNum = $game_party.item_number(@coin.item.id)
		when 1
			@haveNum = $game_party.weapon_number(@coin.item.id)
		when 2
			@haveNum = $game_party.armor_number(@coin.item.id)
		end
		@coinText.bitmap.draw_text(0, 0, 60, 30, "#{@haveNum} 개")
		@coinText.x = @coin.x + @coin.width + 5
		@coinText.y = @coin.y
		
		@item_y = [(@eventBitmap.y + @eventBitmap.height), (@coin.y + @coin.height)].max
		count = 0
		for i in @data
			if i.is_a?(J::Item)
				i.x = (count % @line_count) * (i.width + @item_margin)
				i.y = (count / @line_count) * (i.height + @item_margin) + (@item_y + 5)
				count += 1
			end
		end
		
		@itemText = Sprite.new(self)
		@itemText.bitmap = Bitmap.new(self.width + 20, @data[@data.size - 1].y + 40)
		@itemText.bitmap.font.size = 12
		@itemText.bitmap.font.color.set(0, 0, 0, 255)
		
		idx = 0
		for i in @data
			x = i.x + i.width + 5
			@itemText.bitmap.draw_text(x, i.y, 80, 30, i.item.name.to_s)
			@itemText.bitmap.draw_text(130, i.y, 60, 30, @data2[idx][0].to_s + "개")
			@itemText.bitmap.draw_text(180, i.y, 60, 30, "<=")
			@itemText.bitmap.draw_text(180, i.y, 60, 30, @data2[idx][1].to_s + "개", 2)
			idx += 1
		end
		
		# 인벤토리 판매 
		if $j_inven != nil
			$j_inven.show
			$j_inven.setMode(2)
			
			$j_inven.x = 350
			$j_inven.y = 95
		end
	end
	
	def dispose
		$game_temp.message_proc.call if $game_temp.message_proc != nil
		if $j_inven != nil
			$j_inven.setMode(0) 
			$j_inven.hide
		end
		super
	end
	
	
	def update
		super
		idx = -1
		for i in @data
			idx += 1
			i.item? ? 0 : next
			i.double_click ? 0 : next
			i.double_click = false
			Hwnd.include?("Shop_Coin_Num_Window") ? Hwnd.dispose("Shop_Coin_Num_Window") : 0
			Jindow_Shop_Coin_Num.new(@coin, @data2[idx], i)
		end
		
		checkNum = 0
		case @coin.type
		when 0
			checkNum = $game_party.item_number(@coin.item.id)
		when 1
			checkNum = $game_party.weapon_number(@coin.item.id)
		when 2
			checkNum = $game_party.armor_number(@coin.item.id)
		end
		
		if checkNum != @haveNum
			@haveNum = checkNum
			@coinText.bitmap.clear
			@coinText.bitmap = Bitmap.new(60, 60)
			@coinText.bitmap.font.size = 12
			@coinText.bitmap.font.color.set(0, 0, 0, 255)
			@coinText.bitmap.draw_text(0, 0, 60, 30, "#{@haveNum} 개")
			@coinText.x = @coin.x + @coin.width + 5
			@coinText.y = @coin.y
		end
	end
end

