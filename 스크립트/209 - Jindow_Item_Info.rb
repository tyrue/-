#==============================================================================
# ■ Jindow_Item_Info
#------------------------------------------------------------------------------
#   아이템 정보
#------------------------------------------------------------------------------
class Jindow_Item_Info < Jindow
	def initialize(item_id, type, item_hwnd = nil)
		super(0, 0, 200, 480)
		self.name = "아이템 정보"
		@head = true
		@mark = true
		@drag = true
		@close = true
		
		height = 0
		
		@item_id = item_id
		@type = type
		@item_num = 0
		@item_data = nil
		@item_hwnd = item_hwnd
		check = nil
		
		case type
		when 0
			@item_data = $data_items[item_id]
			@item_num = $game_party.item_number(@item_id)
		when 1
			@item_data = $data_weapons[item_id]
			@item_num = $game_party.weapon_number(@item_id)
			check = Equip_Job_Type::EQUIP_JOB_WEAPON[@item_data.id]
		when 2
			@item_data = $data_armors[item_id]
			@item_num = $game_party.armor_number(@item_id)
			check = Equip_Job_Type::EQUIP_JOB_ARMOR[@item_data.id]
		end
		
		# 아이템 아이콘 위치
		@route = "Graphics/Jindow/" + @skin + "/Window/"
		@icon_route = "Graphics/Icons/"
		@item_win = Sprite.new(self)
		@icon = Sprite.new(self)
		@icon.bitmap = Bitmap.new(@icon_route + @item_data.icon_name)
		@item_win.bitmap = Bitmap.new(@route + "item_win2")
		@icon.x = @item_win.width / 2 - @icon.width / 2
		@icon.y = @item_win.height / 2 - @icon.height / 2
		
		height += @item_win.height
		
		# 아이템 이름 표시
		@item_name = Sprite.new(self)
		@item_name.bitmap = Bitmap.new(160, 15)
		@item_name.x = @item_win.x + @item_win.width + 5
		@item_name.y = 5
		@item_name.bitmap.font.size = 14
		@item_name.bitmap.font.alpha = 3
		@item_name.bitmap.font.beta = 1
		@item_name.bitmap.font.color.set(255, 255, 255, 255) 
		@item_name.bitmap.font.gamma.set(0, 0, 0, 255) 
		@item_name.bitmap.draw_text(0, 0, @item_name.width, @item_name.height, @item_data.name)
		
		@equip = Sprite.new(self)
		@equip.bitmap = Bitmap.new(80, 50)
		@equip.bitmap.font.size = 14
		@equip.bitmap.font.alpha = 1
		@equip.x = @item_name.x
		@equip.y = @item_name.y + @item_name.height
		
		if $Abs_item_data.is_trade_ok(@item_id, @type)
			@equip.bitmap.font.color.set(0, 128, 0, 255)
			@equip.bitmap.draw_text(0, 0, @equip.width, @equip.height, "[교환 가능]", 0)
		else
			@equip.bitmap.font.color.set(128, 0, 0, 255)
			@equip.bitmap.draw_text(0, 0, @equip.width, @equip.height, "[교환 불가]", 0)
		end
		
		if type != 0			
			if $game_party.actors[0].equippable?(@item_data)
				@equip.bitmap.font.color.set(0, 128, 0, 255)
				@equip.bitmap.draw_text(0, 15, @equip.width, @equip.height, "[착용 가능]", 0)
			else
				@equip.bitmap.font.color.set(128, 0, 0, 255)
				@equip.bitmap.draw_text(0, 15, @equip.width, @equip.height, "[착용 불가]", 0)
			end
		end
		
		if check != nil
			if check[1] >= 1
				@txt_degree = Sprite.new(self)
				@txt_degree.x = @equip.x
				@txt_degree.y = @equip.y
				@txt_degree.bitmap = Bitmap.new(80, 14)
				@txt_degree.bitmap.font.size = 14
				@txt_degree.bitmap.font.alpha = 1
				@txt_degree.bitmap.font.color.set(0, 0, 0, 255)
				@txt_degree.bitmap.draw_text(0, 0, @txt_degree.width, @txt_degree.height, "#{check[1]}차 승급 이상", 0)
			end
		end
		
		if type == 0
			# 여기다가 단축키 지정 진도우 버튼 넣으면 되나
			@button_key = J::Button.new(self).refresh(60, "단축키 지정")
			@button_key.x = @equip.x
			@button_key.y = @equip.y
		end
		
		if @item_hwnd == "Inventory" 
			# 버리기 버튼 표시
			@drop_button = J::Button.new(self).refresh(60, "버리기")
			@drop_button.x = @equip.x + @equip.width
			@drop_button.y = @equip.y
			
			# 여러개 버리기 버튼 표시
			@drop_button2 = J::Button.new(self).refresh(60, "여러개 버리기")
			@drop_button2.x = @drop_button.x
			@drop_button2.y = @drop_button.y + @drop_button.height
		end
		
		@description = Sprite.new(self)
		@description.y = @equip.y + @equip.height
		
		if @item_data.description != ""
			bitmap = Bitmap.new(self.width, 480)
			bitmap.font.size = 14
			w = 0
			h = bitmap.font.size * 2
			for i in @item_data.description.scan(/./)
				rect = bitmap.text_size(i)
				w += rect.width
				if w > self.width
					w = 0	
					h += bitmap.font.size
				end
			end
			
			@description.bitmap = Bitmap.new(self.width, h)
			@description.bitmap.font.color.set(255, 255, 255, 255)
			@description.bitmap.font.alpha = 3
			@description.bitmap.font.beta = 1
			@description.bitmap.font.gamma.set(0, 0, 0, 255)
			@description.bitmap.font.size = 14
			
			w = 0
			h = 0
			for i in @item_data.description.scan(/./)
				rect = bitmap.text_size(i)
				if w + rect.width > self.width
					h += rect.height
					w = 0
				end
				@description.bitmap.draw_text(w, h, rect.width, rect.height, i)
				w += rect.width
			end
		end
		
		@detail = Sprite.new(self)
		@detail.y = @description.y + @description.height
		
		item_attributes = [
			{ :name => "체력", :value => (@item_data.recover_hp rescue nil), :rate => false, :recover => true},
			{ :name => "마력", :value => (@item_data.recover_sp rescue nil), :rate => false, :recover => true},
			{ :name => "체력", :value => (@item_data.recover_hp_rate rescue nil), :rate => true, :recover => true},
			{ :name => "마력", :value => (@item_data.recover_sp_rate rescue nil), :rate => true, :recover => true},
			
			{ :name => "공격력", :value => (@item_data.atk rescue nil), :rate => false },
			{ :name => "물리방어력", :value => (@item_data.pdef rescue nil), :rate => false },
			{ :name => "마법방어력", :value => (@item_data.mdef rescue nil), :rate => false },
			{ :name => "힘", :value => (@item_data.str_plus rescue nil), :rate => false },
			{ :name => "손재주", :value => (@item_data.dex_plus rescue nil), :rate => false },
			{ :name => "민첩", :value => (@item_data.agi_plus rescue nil), :rate => false },
			{ :name => "지력", :value => (@item_data.int_plus rescue nil), :rate => false },
			{ :name => "체력", :value => (@item_data.hp_plus rescue nil), :rate => false },
			{ :name => "마력", :value => (@item_data.sp_plus rescue nil), :rate => false },
			{ :name => "회피력", :value => (@item_data.eva rescue nil), :rate => false }
		]
		
		h = 0
		margin = 3
		item_attributes.each do |attr|
			next if attr[:value] == nil
			next if attr[:value] == 0
			
			h += bitmap.text_size(attr[:value].to_s).height + margin
		end
		
		@detail.bitmap = Bitmap.new(self.width, (h == 0 ? 1 : h))
		@detail.bitmap.font.size = 14
		@detail.bitmap.font.alpha = 2
		@detail.bitmap.font.color.set(128, 128, 128, 255)
		@detail.bitmap.font.gamma.set(0, 0, 0, 255)
		
		h = 0
		item_attributes.each do |attr|
			next if attr[:value] == nil
			next if attr[:value] == 0
			
			label = "#{attr[:name]} +#{attr[:value]}"
			label += "%" if attr[:rate]
			label += " 회복" if attr[:recover]
			
			rect = @detail.bitmap.text_size(label)
			@detail.bitmap.draw_text(0, h, self.width, rect.height, label)
			h += rect.height + margin
		end
		
		self.height = @detail.y + @detail.height + 10
		self.window_ini
		self.refresh("Item_Info")
	end
	
	def check_item_num_zero
		case @type
		when 0
			@item_num = $game_party.item_number(@item_id)
		when 1
			@item_num = $game_party.weapon_number(@item_id)
		when 2
			@item_num = $game_party.armor_number(@item_id)
		end
		return @item_num <= 0
	end
	
	def drop_one_item
		x = $game_player.x
		y = $game_player.y
		if @type == 0
			$game_party.lose_item(@item_id, 1)
		elsif @type == 1
			$game_party.lose_weapon(@item_id, 1)
		else
			$game_party.lose_armor(@item_id, 1)
		end 
		
		$console.write_line("#{@item_data.name}를 버렸습니다.")
		create_drops(@type, @item_id, x, y, 1)
		$game_system.se_play("줍기")
	end
	
	def update
		super
		if @drop_button != nil and @drop_button.click
			if !$Abs_item_data.is_trade_ok(@item_id, @type)
				$console.write_line("버릴 수 없는 물건입니다.")
				return
			end
			
			Hwnd.dispose(self) if check_item_num_zero
			drop_one_item
			Hwnd.dispose(self) if check_item_num_zero
			return
		end
		
		if @drop_button2 != nil and @drop_button2.click
			if !$Abs_item_data.is_trade_ok(@item_id, @type)
				$console.write_line("버릴 수 없는 물건입니다.")
				return
			end
			
			Hwnd.dispose(self) if check_item_num_zero
			
			if @item_num == 1
				drop_one_item
			else
				Hwnd.dispose("Item_Drop") if Hwnd.include?("Item_Drop")
				Jindow_Drop.new(1, @type, @item_id) # 아이템 버림
			end
			
			Hwnd.dispose(self)
			return
		end
		
		if @button_key != nil and @button_key.click
			Hwnd.dispose("Keyset_menu") if Hwnd.include?("Keyset_menu")
			Jindow_Keyset_menu.new(@item_id, @type)
		end
	end
end
