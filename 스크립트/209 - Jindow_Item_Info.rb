class Jindow_Item_Info < Jindow
	def initialize(item_id, type, item_hwnd = nil)
		super(0, 0, 200, 480)
		setup_window_properties
		setup_item_data(item_id, type)
		setup_item_display
		setup_buttons(item_hwnd) 
		setup_description
		setup_item_attributes
		finalize_window
	end
	
	def setup_window_properties
		self.name = "아이템 정보"
		@head, @mark, @drag, @close = true, true, true, true
	end
	
	def setup_item_data(item_id, type)
		@item_id, @type = item_id, type
		@item_num = case type
		when 0 then $game_party.item_number(item_id)
		when 1 then $game_party.weapon_number(item_id)
		when 2 then $game_party.armor_number(item_id)
		end
		@item_data = load_item_data
	end
	
	def load_item_data
		case @type
		when 0 then $data_items[@item_id]
		when 1 then $data_weapons[@item_id]
		when 2 then $data_armors[@item_id]
		end
	end
	
	def setup_item_display
		@route = "Graphics/Jindow/#{@skin}/Window/"
		@icon_route = "Graphics/Icons/"
		create_sprite(:item_win, @route + "item_win2")
		create_sprite(:icon, @icon_route + @item_data.icon_name)
		position_icon
		
		create_label_sprite(:item_name, @item_win.x + @item_win.width + 5, 5, @item_data.name)
		setup_equipment_status
	end
	
	def position_icon
		@icon.x = @item_win.width / 2 - @icon.width / 2
		@icon.y = @item_win.height / 2 - @icon.height / 2
	end
	
	def create_sprite(name, path)
		instance_variable_set("@#{name}", Sprite.new(self))
		instance_variable_get("@#{name}").bitmap = Bitmap.new(path)
	end
	
	def create_label_sprite(name, x, y, text)
		sprite = Sprite.new(self)
		sprite.bitmap = Bitmap.new(160, 15)
		sprite.x, sprite.y = x, y
		setup_font(sprite.bitmap.font)
		sprite.bitmap.draw_text(0, 0, sprite.width, sprite.height, text)
		instance_variable_set("@#{name}", sprite)
	end
	
	def setup_font(font)
		font.size = 14
		font.alpha = 3
		font.beta = 1
		font.color.set(255, 255, 255, 255)
		font.gamma.set(0, 0, 0, 255)
	end
	
	def setup_equipment_status
		@equip = Sprite.new(self)
		@equip.bitmap = Bitmap.new(80, 50)
		setup_font(@equip.bitmap.font)
		@equip.x = @item_name.x
		@equip.y = @item_name.y + @item_name.height
		
		trade_status
		equip_status if equip_job_type_required?
		degree_status if equip_job_type_required?
	end
	
	def trade_status
		sw = $Abs_item_data.is_trade_ok?(@item_id, @type)
		text = sw ? "[교환 가능]" : "[교환 불가]"
		color = sw ? [102, 255, 102, 255] : [255, 102, 102, 255]
		draw_text_on_sprite(@equip, 0, 0, text, color)
	end
	
	def equip_status
		sw = $game_party.actors[0].equippable?(@item_data)
		text = sw ? "[착용 가능]" : "[착용 불가]"
		color = sw ? [102, 255, 102, 255] : [255, 102, 102, 255]
		draw_text_on_sprite(@equip, 0, 15, text, color)
	end
	
	def degree_status
		check = @item_data.is_a?(RPG::Weapon) ? Equip_Job_Type::EQUIP_JOB_WEAPON[@item_data.id] : Equip_Job_Type::EQUIP_JOB_ARMOR[@item_data.id]
		return unless check && check[1] >= 1
		
		@txt_degree = Sprite.new(self)
		@txt_degree.x = @equip.x
		@txt_degree.y = @equip.y
		@txt_degree.bitmap = Bitmap.new(80, 14)
		setup_font(@txt_degree.bitmap.font)
		@txt_degree.bitmap.draw_text(0, 0, @txt_degree.width, @txt_degree.height, "#{check[1]}차 승급 이상", 0)
	end
	
	def draw_text_on_sprite(sprite, x, y, text, color)
		sprite.bitmap.font.color.set(*color)
		sprite.bitmap.draw_text(x, y, sprite.width, sprite.height, text)
	end
	
	def equip_job_type_required?
		@type == 1 || @type == 2
	end
	
	def setup_buttons(item_hwnd)
		return unless item_hwnd == "Inventory"
		
		@button_key = setup_button(@equip.x, @equip.y, "단축키 지정") if @type == 0 
		@drop_button = setup_button(@equip.x + @equip.width, @equip.y, "버리기")
		@drop_button2 = setup_button(@drop_button.x, @drop_button.y + @drop_button.height, "여러개 버리기")
		
		if $Abs_item_data.trade_state(@item_id, @type) == 1
			@trade_button = setup_button(@drop_button.x, @drop_button2.y + @drop_button2.height, "교환 불가 해제") if equip_job_type_required?
		end
	end
	
	def setup_button(x, y, text)
		button = J::Button.new(self).refresh(60, text)
		button.x, button.y = x, y
		button
	end
	
	def setup_description
		@description = Sprite.new(self)
		@description.y = @equip.y + @equip.height + 20
		return if @item_data.description.empty?
		
		bitmap = Bitmap.new(self.width, 480)
		bitmap.font.size = 14
		create_description_bitmap(bitmap)
	end
	
	def create_description_bitmap(bitmap)
		h = calculate_description_height(bitmap)
		@description.bitmap = Bitmap.new(self.width, h)
		setup_font(@description.bitmap.font)
		draw_description_text(bitmap)
	end
	
	def calculate_description_height(bitmap)
		w, h = 0, bitmap.font.size * 2
		@item_data.description.scan(/./) do |char|
			rect = bitmap.text_size(char)
			w += rect.width
			if w > self.width
				w = 0
				h += bitmap.font.size
			end
		end
		h
	end
	
	def draw_description_text(bitmap)
		w, h = 0, 0
		@item_data.description.scan(/./) do |char|
			rect = bitmap.text_size(char)
			if w + rect.width > self.width
				h += rect.height
				w = 0
			end
			@description.bitmap.draw_text(w, h, rect.width, rect.height, char)
			w += rect.width
		end
	end
	
	def setup_item_attributes
		@detail = Sprite.new(self)
		@detail.y = @description.y + @description.height
		draw_item_attributes
	end
	
	def draw_item_attributes
		item_attributes = gather_item_attributes
		h = calculate_attributes_height(item_attributes)
		@detail.bitmap = Bitmap.new(self.width, h.zero? ? 1 : h)
		setup_font(@detail.bitmap.font)
		draw_attributes_text(item_attributes)
	end
	
	def gather_item_attributes
		[
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
	end
	
	def calculate_attributes_height(attributes)
		margin = 3
		bitmap = Bitmap.new(self.width, 480)
		attributes.inject(0) do |sum, attr|
			sum + bitmap.text_size(attr[:value].to_s).height + margin
		end
	end
	
	def draw_attributes_text(attributes)
		h, margin = 0, 3
		attributes.each do |attr|
			next if attr[:value].nil? || attr[:value].zero?
			
			label = "#{attr[:name]} +#{attr[:value]}"
			label += "%" if attr[:rate]
			label += " 회복" if attr[:recover]
			rect = @detail.bitmap.text_size(label)
			@detail.bitmap.draw_text(0, h, self.width, rect.height, label)
			h += rect.height + margin
		end
	end
	
	def finalize_window
		self.height = @detail.y + @detail.height + 10
		self.window_ini
		self.refresh("Item_Info")
	end
	
	def check_item_num_zero
		@item_num = case @type
		when 0 then $game_party.item_number(@item_id)
		when 1 then $game_party.weapon_number(@item_id)
		when 2 then $game_party.armor_number(@item_id)
		end
		@item_num <= 0
	end
	
	def update
		super
		handle_drop_buttons
		handle_key_button
		handle_trade_button
	end
	
	def handle_drop_buttons
		handle_drop_button(@drop_button, method(:drop_one_item))
		handle_drop_button(@drop_button2, method(:drop_multiple_items))
	end
	
	def handle_drop_button(button, drop_method)
		return unless button
		return unless button.click
		
		unless $Abs_item_data.is_trade_ok?(@item_id, @type)
			return $console.write_line("버릴 수 없는 물건입니다.")
		end
		
		drop_method.call
		Hwnd.dispose(self) if check_item_num_zero		
	end
	
	def drop_one_item
		x, y = $game_player.x, $game_player.y
		
		$game_party.lose_item(@item_id, 1) if @type == 0
		$game_party.lose_weapon(@item_id, 1) if @type == 1
		$game_party.lose_armor(@item_id, 1) if @type == 2
		
		$console.write_line("#{@item_data.name}를 버렸습니다.")
		create_drops(@type, @item_id, x, y, 1)
		$game_system.se_play("줍기")
		$Abs_item_data.process_one_trade_switch(@item_id, @type)
	end
	
	def drop_multiple_items
		if @item_num == 1 || $Abs_item_data.check_trade_switch(@item_id, @type)
			drop_one_item
		else
			Hwnd.dispose("Item_Drop") if Hwnd.include?("Item_Drop")
			Jindow_Drop.new(1, @type, @item_id)
		end
	end
	
	def handle_key_button
		return unless @button_key
		return unless @button_key.click
		
		Hwnd.dispose("Keyset_menu") if Hwnd.include?("Keyset_menu")
		Jindow_Keyset_menu.new(@item_id, @type)
	end
	
	def handle_trade_button
		return unless @trade_button
		return unless @trade_button.click
		
		need_gold = change_number_unit(@item_data.price * 10)
		
		accept_script = <<-SCRIPT
		jindow = Hwnd.include?("Item_Info", 1)
		return unless jindow
		
		jindow.process_trade_unlock
		Hwnd.dispose(self)
		SCRIPT
		
		decline_script = <<-SCRIPT 
		Hwnd.dispose(self)
		SCRIPT
		
		Jindow_Dialog.new(
			"교환 불가 해제",
			
			[
				"해제 하시면 1회 교환 및 버리기가 가능합니다.",
				"해제하려면 #{need_gold}전이 필요합니다.",
				"해제 하시겠습니까?"
			],
			
			[
				["예", accept_script], 
				["아니오", decline_script]
			]
		)
	end
	
	def process_trade_unlock
		need_gold = @item_data.price * 10
		return $console.write_line("가지고 계신 금전이 부족합니다.") if $game_party.gold < need_gold
		
		$game_party.lose_gold(need_gold)
		$Abs_item_data.trade_switch(@item_id, @type, true)
		$console.write_line("1회 교환 가능해졌습니다.")
	end
end
