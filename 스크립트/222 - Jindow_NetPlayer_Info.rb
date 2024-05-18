class Jindow_NetPlayer_Info < Jindow
	ARMOR_SLOTS = ["무기", "투구", "갑옷", "보조", "반지"].freeze
	ARMOR_TYPE_MAP = { 0 => 1, 1 => 2, 2 => 2, 3 => 2, 4 => 2 }.freeze
	
	def initialize(myid, name)
		super(0, 0, 260, 180)
		setup_window("#{name} 상태 정보")
		@netPlayer = Network::Main.players[myid]
		self.x = Mouse.x - self.max_width / 2
		self.y = Mouse.y - self.max_height / 2
		
		setup_armor
		setup_character_sprite
		setup_state_sprites
		setup_guild_sprite
	end
	
	def setup_window(window_name)
		self.name = window_name
		@head = true
		@mark = true
		@drag = true
		@close = true
		@route = "Graphics/Jindow/" + @skin + "/Window/"
		self.refresh("NetPlayer_Info")
	end
	
	def setup_armor
		itemwin_mid = Bitmap.new(@route + "itemwin_mid")
		@armor_sprites = []
		@armor_name_sprites = []
		@armor_icons = []
		@ids = [
			@netPlayer.weapon_id,
			@netPlayer.armor2_id,
			@netPlayer.armor3_id,
			@netPlayer.armor1_id,
			@netPlayer.armor4_id
		]
		
		(0..4).each do |i|
			setup_armor_slot(i, itemwin_mid)
		end
	end
	
	def setup_armor_slot(index, itemwin_mid)
		@armor_sprites[index] = Sprite.new(self)
		@armor_sprites[index].bitmap = Bitmap.new(@route + "item_win")
		@armor_sprites[index].bitmap.blt(1, 1, itemwin_mid, itemwin_mid.rect)
		@armor_sprites[index].y = 125
		@armor_sprites[index].x = 36 * index
		
		name_sprite = Sprite.new(self)
		name_sprite.bitmap = Bitmap.new(145, 20)
		name_sprite.bitmap.font.size = 12
		name_sprite.bitmap.font.color.set(0, 0, 0, 255)
		name_sprite.bitmap.draw_text(0, 0, 145, 20, ARMOR_SLOTS[index], 0)
		name_sprite.x = 36 * index
		name_sprite.y = 105
		@armor_name_sprites[index] = name_sprite
		
		armor_id = @ids[index]
		
		return if armor_id == 0
		
		armor_type = ARMOR_TYPE_MAP[index]
		armor_icon = J::Item.new(self).refresh(armor_id, armor_type)
		armor_icon.x = 36 * index
		armor_icon.y = 125
		@armor_icons[index] = armor_icon
	end
	
	def setup_character_sprite
		@character = Sprite.new(self)
		@character.bitmap = Bitmap.new(@route + "character_win")
		@character.y = 10
		
		@actor = Sprite.new(self)
		character_name = @netPlayer.character_name
		equips = equip_char_array(@netPlayer)
		bitmap = Bitmap.new("Graphics/Characters/#{character_name}")
		bmp = RPG::Cache.character(character_name, @netPlayer.character_hue)
		
		cw = bitmap.width / 4
		ch = bitmap.height / 4
		src_rect = Rect.new(0, 0, cw, ch)
		bitmap.blt(0, 0, bmp, src_rect, 255)
		
		if equips.size > 0 and bmp.width == 236 and bmp.height == 236
			for equip in equips
				next unless equip
				next unless equip[0]
				
				bmp2 = RPG::Cache.character(equip[0], equip[1].to_i)
				bitmap.blt(0, 0, bmp2, src_rect, 255)
			end	
		end
		
		@actor.bitmap = Bitmap.new(cw, ch)
		@actor.bitmap.blt(0, 0, bitmap, src_rect)
		@actor.x = (@character.width - @actor.bitmap.width) / 2
		@actor.y = @character.height - @actor.bitmap.height - 10 + @character.y
	end
	
	def setup_state_sprites
		@state_labels = [
			"이름: #{@netPlayer.name}",
			"레벨: #{@netPlayer.level}",
			"직업: #{@netPlayer.pci}",
			"체력: #{change_number_unit(@netPlayer.hp)}/#{change_number_unit(@netPlayer.maxhp)}",
			"마력: #{change_number_unit(@netPlayer.sp)}/#{change_number_unit(@netPlayer.maxsp)}"
		]
		
		@state_sprites = []
		
		@state_labels.each_with_index do |label, index|
			sprite = Sprite.new(self)
			sprite.bitmap = Bitmap.new(145, 20)
			sprite.bitmap.font.size = 12
			sprite.bitmap.font.color.set(0, 0, 0, 255)
			sprite.bitmap.draw_text(0, 0, 145, 20, label, 0)
			
			if index <= 4
				sprite.x = 80
				sprite.y = 15 * index
			else
				sprite.x = 220
				sprite.y = 90 + 15 * (index - 7)
			end
			
			@state_sprites << sprite
		end
	end
	
	def setup_guild_sprite
		@guild = Sprite.new(self)
		@guild.bitmap = Bitmap.new(180, 20)
	end
	
	def update
		super
		update_state_sprites
		update_armor
	end
	
	def update_state_sprites
		new_labels = [
			"이름: #{@netPlayer.name}",
			"레벨: #{@netPlayer.level}",
			"직업: #{@netPlayer.pci}",
			"체력: #{change_number_unit(@netPlayer.hp)}/#{change_number_unit(@netPlayer.maxhp)}",
			"마력: #{change_number_unit(@netPlayer.sp)}/#{change_number_unit(@netPlayer.maxsp)}"
		]
		
		new_labels.each_with_index do |label, index|
			next if @state_labels[index] == label
			@state_labels[index] = label
			sprite = @state_sprites[index]
			sprite.bitmap.clear
			sprite.bitmap.draw_text(0, 0, 145, 20, label, 0)
		end
	end
	
	def update_armor
		new_armor_ids = [
			@netPlayer.weapon_id,
			@netPlayer.armor2_id,
			@netPlayer.armor3_id,
			@netPlayer.armor1_id,
			@netPlayer.armor4_id
		]
		
		sw = false
		new_armor_ids.each_with_index do |armor_id, index|
			next if @ids[index] == armor_id
			@ids[index] = armor_id
			sw = true
			
			if @armor_icons[index] != nil
				@armor_icons[index].dispose
				@armor_icons[index] = nil
			end
			
			next if armor_id == 0
			armor_type = ARMOR_TYPE_MAP[index]
			armor_icon = J::Item.new(self).refresh(armor_id, armor_type)
			armor_icon.y = 125
			armor_icon.x = 36 * index
			@armor_icons[index] = armor_icon				
		end
		
		setup_character_sprite if sw
	end
end
