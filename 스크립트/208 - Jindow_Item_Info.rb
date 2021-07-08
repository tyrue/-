#==============================================================================
# ■ Jindow_Item_Info
#------------------------------------------------------------------------------
#   아이템 정보
#------------------------------------------------------------------------------
class Jindow_Item_Info < Jindow
	def initialize(item_id, type)
		super(0, 0, 200, 480)
		self.name = "아이템 정보"
		@head = true
		@mark = true
		@drag = true
		@close = true
		
		height = 0
		
		@item_id = item_id
		@type = type
		item = nil
		case type
		when 0
			item = $data_items[item_id]
		when 1
			item = $data_weapons[item_id]
		when 2
			item = $data_armors[item_id]
		end
		
		@route = "Graphics/Jindow/" + @skin + "/Window/"
		@icon_route = "Graphics/Icons/"
		@item_win = Sprite.new(self)
		@icon = Sprite.new(self)
		@icon.bitmap = Bitmap.new(@icon_route + item.icon_name)
		@item_win.bitmap = Bitmap.new(@route + "item_win2")
		@icon.x = @item_win.width / 2 - @icon.width / 2
		@icon.y = @item_win.height / 2 - @icon.height / 2
		
		height += @item_win.height
		
		@item_name = Sprite.new(self)
		@item_name.bitmap = Bitmap.new(160, 15)
		@item_name.x = @item_win.x + @item_win.width + 5
		@item_name.y = 5
		@item_name.bitmap.font.size = 14
		@item_name.bitmap.font.alpha = 3
		@item_name.bitmap.font.beta = 1
		@item_name.bitmap.font.color.set(255, 255, 255, 255) 
		@item_name.bitmap.font.gamma.set(0, 0, 0, 255) 
		@item_name.bitmap.draw_text(0, 0, @item_name.width, @item_name.height, item.name)
					
		@equip = Sprite.new(self)
		@equip.bitmap = Bitmap.new(80, 50)
		@equip.bitmap.font.size = 14
		@equip.bitmap.font.alpha = 1
		@equip.x = @item_name.x
		@equip.y = @item_name.y
		
		if $Abs_item_data.is_trade_ok(@item_id)
			@equip.bitmap.font.color.set(0, 128, 0, 255)
			@equip.bitmap.draw_text(0, 0, @equip.width, @equip.height, "[교환 가능]", 0)
		else
			@equip.bitmap.font.color.set(128, 0, 0, 255)
			@equip.bitmap.draw_text(0, 0, @equip.width, @equip.height, "[교환 불가]", 0)
		end
		
		if type != 0			
			if $game_party.actors[0].equippable?(item)
				@equip.bitmap.font.color.set(0, 128, 0, 255)
				@equip.bitmap.draw_text(0, 15, @equip.width, @equip.height, "[착용 가능]", 0)
			else
				@equip.bitmap.font.color.set(128, 0, 0, 255)
				@equip.bitmap.draw_text(0, 15, @equip.width, @equip.height, "[착용 불가]", 0)
			end
		end
		
		if type == 0
			# 여기다가 단축키 지정 진도우 버튼 넣으면 되나
			@button_key = J::Button.new(self).refresh(60, "단축키 지정")
			@button_key.x = @equip.x + @equip.width
			@button_key.y = @equip.y + 14
		end
		
		@description = Sprite.new(self)
		@description.y = @equip.y + @equip.height
		
		if item.description != ""
			height += 10
			bitmap = Bitmap.new(self.width, 480)
			bitmap.font.size = 14
			w = 0
			h = 0
			for i in item.description.scan(/./)
				rect = bitmap.text_size(i)
				if w + rect.width > self.width
					w = 0
					h += rect.height
				else
					w += rect.width
				end
			end
			
			@description.bitmap = Bitmap.new(self.width, h + bitmap.font.size * 3)
			@description.bitmap.font.color.set(255, 255, 255, 255)
			@description.bitmap.font.alpha = 3
			@description.bitmap.font.beta = 1
			@description.bitmap.font.gamma.set(0, 0, 0, 255)
			@description.bitmap.font.size = 14
			
			height += h + bitmap.font.size + 5
			w = 0
			h = 0
			for i in item.description.scan(/./)
				rect = bitmap.text_size(i)
				if w + rect.width > self.width
					h += rect.height
					w = 0
					@description.bitmap.draw_text(w, h, rect.width, rect.height, i)
					w += rect.width
				else
					@description.bitmap.draw_text(w, h, rect.width, rect.height, i)
					w += rect.width
				end
			end
		end
		
		@detail = Sprite.new(self)
		@detail.y = height
		
		h = 0
		case type
		when 0
			item.recover_hp != 0 ? (h += bitmap.text_size(item.recover_hp.to_s).height) : 0
			item.recover_sp != 0 ? (h += bitmap.text_size(item.recover_sp.to_s).height) : 0
			item.recover_hp_rate != 0 ? (h += bitmap.text_size(item.recover_hp_rate.to_s).height) : 0
			item.recover_sp_rate != 0 ? (h += bitmap.text_size(item.recover_sp_rate.to_s).height) : 0
		when 1
			item.atk != 0 ? (h += bitmap.text_size(item.atk.to_s).height) : 0
			item.pdef != 0 ? (h += bitmap.text_size(item.pdef.to_s).height) : 0
			item.mdef != 0 ? (h += bitmap.text_size(item.mdef.to_s).height) : 0
			item.str_plus != 0 ? (h += bitmap.text_size(item.str_plus.to_s).height) : 0
			item.dex_plus != 0 ? (h += bitmap.text_size(item.dex_plus.to_s).height) : 0
			item.agi_plus != 0 ? (h += bitmap.text_size(item.agi_plus.to_s).height) : 0
			item.int_plus != 0 ? (h += bitmap.text_size(item.int_plus.to_s).height) : 0
		when 2
			item.pdef != 0 ? (h += bitmap.text_size(item.pdef.to_s).height) : 0
			item.mdef != 0 ? (h += bitmap.text_size(item.mdef.to_s).height) : 0
			item.eva != 0 ? (h += bitmap.text_size(item.eva.to_s).height) : 0
			item.str_plus != 0 ? (h += bitmap.text_size(item.str_plus.to_s).height) : 0
			item.dex_plus != 0 ? (h += bitmap.text_size(item.dex_plus.to_s).height) : 0
			item.agi_plus != 0 ? (h += bitmap.text_size(item.agi_plus.to_s).height) : 0
			item.int_plus != 0 ? (h += bitmap.text_size(item.int_plus.to_s).height) : 0
		end
		
		@detail.bitmap = Bitmap.new(self.width, (h == 0 ? 1 : h))
		@detail.bitmap.font.size = 14
		@detail.bitmap.font.alpha = 2
		@detail.bitmap.font.color.set(128, 128, 128, 255)
		@detail.bitmap.font.gamma.set(0, 0, 0, 255)
		height += (h == 0 ? 1 : h)
		h = 0
		
		case type # 일반 아이템
		when 0
			if item.recover_hp != 0
				rect = @detail.bitmap.text_size(item.recover_hp.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "체력 " + item.recover_hp.to_s + "회복")
				h += rect.height
			end
			if item.recover_sp != 0
				rect = @detail.bitmap.text_size(item.recover_sp.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "마력 " + item.recover_sp.to_s + "회복")
				h += rect.height
			end
			if item.recover_hp_rate != 0
				rect = @detail.bitmap.text_size(item.recover_hp_rate.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "체력 " + item.recover_hp_rate.to_s + "%회복")
				h += rect.height
			end
			if item.recover_sp_rate != 0
				rect = @detail.bitmap.text_size(item.recover_sp_rate.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "마력 " + item.recover_sp_rate.to_s + "%회복")
				h += rect.height
			end
			
		when 1 # 무기
			if item.atk != 0
				rect = @detail.bitmap.text_size(item.atk.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "공격력 + " + item.atk.to_s)
				h += rect.height
			end
			if item.pdef != 0
				rect = @detail.bitmap.text_size(item.pdef.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "물리방어력 + " + item.pdef.to_s)
				h += rect.height
			end
			if item.mdef != 0
				rect = @detail.bitmap.text_size(item.mdef.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "마법방어력 + " + item.mdef.to_s)
				h += rect.height
			end      
			if item.str_plus != 0
				rect = @detail.bitmap.text_size(item.str_plus.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "힘 + " + item.str_plus.to_s)
				h += rect.height
			end
			if item.dex_plus != 0
				rect = @detail.bitmap.text_size(item.dex_plus.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "손재주 + " + item.dex_plus.to_s)
				h += rect.height
			end
			if item.agi_plus != 0
				rect = @detail.bitmap.text_size(item.agi_plus.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "민첩 + " + item.agi_plus.to_s)
				h += rect.height
			end
			if item.int_plus != 0
				rect = @detail.bitmap.text_size(item.int_plus.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "지력 + " + item.int_plus.to_s)
				h += rect.height
			end
			
		when 2 # 방어구
			if item.pdef != 0
				rect = @detail.bitmap.text_size(item.pdef.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "물리방어력 + " + item.pdef.to_s)
				h += rect.height
			end
			if item.mdef != 0
				rect = @detail.bitmap.text_size(item.mdef.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "마법방어력 + " + item.mdef.to_s)
				h += rect.height
			end
			if item.eva != 0
				rect = @detail.bitmap.text_size(item.eva.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "회피력 + " + item.eva.to_s)
				h += rect.height
			end
			if item.str_plus != 0
				rect = @detail.bitmap.text_size(item.str_plus.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "힘 + " + item.str_plus.to_s)
				h += rect.height
			end
			if item.dex_plus != 0
				rect = @detail.bitmap.text_size(item.dex_plus.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "손재주 + " + item.dex_plus.to_s)
				h += rect.height
			end
			if item.agi_plus != 0
				rect = @detail.bitmap.text_size(item.agi_plus.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "민첩 + " + item.agi_plus.to_s)
				h += rect.height
			end
			if item.int_plus != 0
				rect = @detail.bitmap.text_size(item.int_plus.to_s)
				@detail.bitmap.draw_text(0, h, self.width, rect.height, "지력 + " + item.int_plus.to_s)
				h += rect.height
			end
		end
		
		self.height = height + 22
		self.refresh("Item_Info")
	end
	
	def update
		super
		if @button_key != nil and @button_key.click
			if not Hwnd.include?("Keyset_menu")
				Jindow_Keyset_menu.new(@item_id, @type)
			else
				Hwnd.dispose("Keyset_menu")
				Jindow_Keyset_menu.new(@item_id, @type)
			end
		end
	end
end
