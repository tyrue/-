class Jindow_NetPlayer_Info < Jindow
	def initialize(myid, name)
		super(0, 0, 200, 180)
		self.name = "#{name} 상태 정보"
		@head = true
		@mark = true
		@drag = true
		@close = true
		@route = "Graphics/Jindow/" + @skin + "/Window/"
		
		@netPlayer = Network::Main.players[myid]
		actor = @netPlayer
		self.refresh("NetPlayer_Info")
		self.x = Mouse.x - self.max_width / 2
		self.y = Mouse.y - self.max_height / 2
				
		# 장비 비트맵
		@equip = []
		@armor_id = [
			@netPlayer.weapon_id, 
			@netPlayer.armor2_id,
			@netPlayer.armor3_id,
			@netPlayer.armor1_id,
			@netPlayer.armor4_id
		]
		
		@armor_name = [
			"무기",
			"투구",
			"갑옷",
			"보조",
			"반지"
		] 
		
		@armor = []
		@armor_n = []
		@armor_i = []
		
		itemwin_mid = Bitmap.new(@route + "itemwin_mid")
		for i in 0..4
			@equip[i] = Sprite.new(self)
			@equip[i].bitmap = Bitmap.new(@route + "item_win")
			@equip[i].bitmap.blt(1, 1, itemwin_mid, itemwin_mid.rect)
			@equip[i].y = 125
			@equip[i].x = 36 * (i)
			
			@armor_n[i] = Sprite.new(self)
			@armor_n[i].bitmap = Bitmap.new(145, 20)
			@armor_n[i].x = 36 * i
			@armor_n[i].y = 105
			@armor_n[i].bitmap.font.size = 12
			@armor_n[i].bitmap.font.color.set(0, 0, 0, 255)
			@armor_n[i].bitmap.draw_text(0, 0, 145, 20, @armor_name[i], 0)
			
			if @armor_id[i] != 0 and @armor_id[i] != nil
				if i == 0
					@armor_i[i] = J::Item.new(self).refresh(@armor_id[i], 1)
				else
					@armor_i[i] = J::Item.new(self).refresh(@armor_id[i], 2)
				end
				@armor_i[i].y = 125
				@armor_i[i].x = 36 * i
			end
		end
		
		# 캐릭터 비트맵
		@character = Sprite.new(self)
		@character.bitmap = Bitmap.new(@route + "character_win")
		@character.y = 10
		
		@actor = Sprite.new(self)
		@character_name = actor.character_name
		bitmap = Bitmap.new("Graphics/Characters/#{@character_name}")
		
		draw_actor(actor, @character)
		
		cw = bitmap.width / 4
		ch = bitmap.height / 4
		@actor.bitmap = Bitmap.new(cw, ch)
		
		# 상태 비트맵
		@state = []
		@state_name = [
			"이름: " + actor.name,
			"레벨: " + actor.level.to_s,
			"직업: " + actor.pci,
			"체력: " + actor.hp.to_s + "/" + actor.maxhp.to_s,
			"마력: " + actor.sp.to_s + "/" + actor.maxsp.to_s
		]
		
		for i in 0...@state_name.length
			@state[i] = Sprite.new(self)
			@state[i].bitmap = Bitmap.new(145, 20)
			if i <= 4
				@state[i].x = 80
				@state[i].y = 15 * i
			else
				@state[i].x = 220
				@state[i].y = 90 + 15 * (i - 7)
			end
			
			@state[i].bitmap.font.size = 12
			@state[i].bitmap.font.color.set(0, 0, 0, 255)
			@state[i].bitmap.draw_text(0, 0, 145, 20, @state_name[i], 0)
		end
		
		@guild = Sprite.new(self)
		@guild.bitmap = Bitmap.new(180, 20)
		@actor_guild = $guild
	end
	
	def update
		self.x != 242
		self.y != 132
		super
		actor = @netPlayer
		
		@state_name2 = [
			"이름: " + actor.name,
			"레벨: " + actor.level.to_s,
			"직업: " + actor.pci,
			"체력: " + actor.hp.to_s + "/" + actor.maxhp.to_s,
			"마력: " + actor.sp.to_s + "/" + actor.maxsp.to_s
		]
		
		for i in 0...@state_name2.length
			if @state_name[i] != @state_name2[i]
				@state[i].dispose
				@state[i] = Sprite.new(self)
				@state[i].bitmap = Bitmap.new(145, 20)
				if i <= 6
					@state[i].x = 80
					@state[i].y = 15 * i
				else
					@state[i].x = 177
					@state[i].y = 90 + 15 * (i - 7)
				end
				@state[i].bitmap.font.size = 12
				@state[i].bitmap.font.color.set(0, 0, 0, 255)
				@state[i].bitmap.draw_text(0, 0, 145, 20, @state_name2[i], 0)
				@state_name[i] = @state_name2[i]
			end
		end
		
		
		@armor_id2 = [
			@netPlayer.weapon_id, 
			@netPlayer.armor2_id,
			@netPlayer.armor3_id,
			@netPlayer.armor1_id,
			@netPlayer.armor4_id
		]
		
		equip_change = false
		
		for i in 0..4
			if @armor_id[i] != @armor_id2[i]
				equip_change = true
				@armor_id[i] = @armor_id2[i]
				@armor_i[i] ? (@armor_i[i].dispose; @armor_i[i] = nil) : 0
				if @armor_id[i] != 0 and @armor_id[i] != nil
					if i == 0
						@armor_i[i] = J::Item.new(self).refresh(@armor_id[i], 1)
					else
						@armor_i[i] = J::Item.new(self).refresh(@armor_id[i], 2)
					end
					@armor_i[i].y = 125
					@armor_i[i].x = 36 * i
				end
			end
		end
		
		if equip_change
			# 캐릭터 비트맵
			@character = Sprite.new(self)
			@character.bitmap = Bitmap.new(@route + "character_win")
			@character.y = 10
			
			@actor = Sprite.new(self)
			@character_name = actor.character_name
			draw_actor(actor, @character)
			
			bitmap = Bitmap.new("Graphics/Characters/#{@character_name}")
			
			cw = bitmap.width / 4
			ch = bitmap.height / 4
			@actor.bitmap = Bitmap.new(cw, ch)
		end
	end
	
	def draw_actor(actor, character)
		@s.dispose if @s != nil
		@s = Sprite.new(self)
		bmp = RPG::Cache.character(actor.character_name, actor.character_hue)
		bitmap = Bitmap.new(bmp.width, bmp.height)
		src_rect = Rect.new(0, 0, bmp.width, bmp.height)
		
		# Setup actor equipment
		equips = actor.equip_char_array
		
		# If character fits the size
		if equips.size > 0 and bmp.width == 236 and bmp.height == 236
			size = equips.size -1
			for i in 0..size
				next if equips[i] == false or equips[i][0] == false or equips[i][0] == nil
				bmp2 = RPG::Cache.character(equips[i][0], equips[i][1].to_i)
				bitmap.blt(0, 0, bmp2, src_rect, 255)
			end
		else
			bitmap.blt(0, 0, bmp, src_rect, 255)
		end
		
		cw = bitmap.width / 4
		ch = bitmap.height / 4
		src_rect = Rect.new(0, 0, cw, ch)
		
		@s.bitmap = Bitmap.new(cw, ch)
		@s.bitmap.blt(0, 0, bitmap, src_rect)
		@s.x = (character.width - @s.width) / 2
		@s.y = character.height - @s.height - 10 + character.y
	end	
end