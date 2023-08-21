#==============================================================================
# ■ Jindow_Shop
#------------------------------------------------------------------------------
#   상점 진도우화
#------------------------------------------------------------------------------
class Jindow_Shop < Jindow
	def initialize(shopData, eventId) # 상점 데이터, 이벤트 아이디
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 220, 300)
		@head = true
		@mark = true
		@drag = true
		@close = true
		@event = $game_map.events[eventId]
		
		self.name = @event.sprite_id != nil ? @event.sprite_id : "상점"
		self.refresh "Shop_Window"
		self.x = (640 - self.max_width) / 2
		self.y = (480 - self.max_height) / 2
		
		@data = []
		for goods_item in shopData
			item_id = goods_item[1]
			case goods_item[0]
			when 0
				next if $data_items[item_id] == nil  
				next if $data_items[item_id].name == ""
				@data.push(J::Item.new(self).set(true).refresh(item_id, 0)) 
			when 1
				next if $data_weapons[item_id] == nil  
				next if $data_weapons[item_id].name == ""
				@data.push(J::Item.new(self).set(true).refresh(item_id, 1)) 
			when 2
				next if $data_armors[item_id] == nil  
				next if $data_armors[item_id].name == ""
				@data.push(J::Item.new(self).set(true).refresh(item_id, 2)) 
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
		@helloText.bitmap = Bitmap.new(self.width - (@eventBitmap.x + @eventBitmap.width + 10), 60)
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
		
		count = 0
		for i in @data
			if i.is_a?(J::Item)
				i.x = (count % @line_count) * (i.width + @item_margin)
				i.y = (count / @line_count) * (i.height + @item_margin) + (@helloText.y + @helloText.height + 5)
				count += 1
			end
		end
		
		@itemText = Sprite.new(self)
		@itemText.bitmap = Bitmap.new(self.width, @data[@data.size - 1].y + 40)
		@itemText.bitmap.font.size = 12
		@itemText.bitmap.font.color.set(0, 0, 0, 255)
		
		for i in @data
			x = i.x + i.width + 5
			@itemText.bitmap.draw_text(x, i.y, 60, 30, i.item.name.to_s)
			@itemText.bitmap.draw_text(130, i.y, 60, 30, i.item.price.to_s + "전", 2)
		end
		
	end
	
	def update
		super
		for i in @item
			i.item? ? 0 : next
			i.double_click ? 0 : next
			i.double_click = false
			Hwnd.include?("Shop_Num_Window") ? Hwnd.dispose("Shop_Num_Window") : 0
			Jindow_Shop_Num.new(i.item, i.type, 0)
		end
	end
end