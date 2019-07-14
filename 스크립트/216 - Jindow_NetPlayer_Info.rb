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
		self.refresh("NetPlayer_Info")
		self.x = 41
		self.y = 105
		self.x = Mouse.x + self.side_width + 5
		self.y = Mouse.y + self.side_height + 5
		if self.x + self.max_width > 640
			self.x = 640 - self.max_width
		elsif self.x < 0
			self.x = self.side_width
		end
		if self.y + self.max_height > 480
			self.y = 480 - self.max_height
		elsif self.y < 0
			self.y = self.side_height
		end
		
		@equip_1 = Sprite.new(self)
		@equip_2 = Sprite.new(self)
		@equip_3 = Sprite.new(self)
		@equip_4 = Sprite.new(self)
		@equip_5 = Sprite.new(self)
		
		@equip_1.bitmap = Bitmap.new(@route + "item_win")
		@equip_2.bitmap = Bitmap.new(@route + "item_win")
		@equip_3.bitmap = Bitmap.new(@route + "item_win")
		@equip_4.bitmap = Bitmap.new(@route + "item_win")
		@equip_5.bitmap = Bitmap.new(@route + "item_win")
		
		itemwin_mid = Bitmap.new(@route + "itemwin_mid")
		
		@equip_1.bitmap.blt(1, 1, itemwin_mid, itemwin_mid.rect)
		@equip_2.bitmap.blt(1, 1, itemwin_mid, itemwin_mid.rect)
		@equip_3.bitmap.blt(1, 1, itemwin_mid, itemwin_mid.rect)
		@equip_4.bitmap.blt(1, 1, itemwin_mid, itemwin_mid.rect)
		@equip_5.bitmap.blt(1, 1, itemwin_mid, itemwin_mid.rect)
		
		@equip_1.y = 125    
		@equip_2.x = 36
		@equip_2.y = 125    
		@equip_3.x = 72
		@equip_3.y = 125    
		@equip_4.x = 108
		@equip_4.y = 125
		@equip_5.x = 144
		@equip_5.y = 125    
		
		@weapon_id = @netPlayer.weapon_id
		if @weapon_id != 0
			@weapon = J::Item.new(self).refresh(@weapon_id, 1)
			@weapon.y = 125
		end
		@armor1_id = @netPlayer.armor1_id
		if @armor1_id != 0
			@armor1 = J::Item.new(self).refresh(@armor1_id, 2)
			@armor1.x = 108
			@armor1.y = 125
		end
		@armor2_id = @netPlayer.armor2_id
		if @armor2_id != 0
			@armor2 = J::Item.new(self).refresh(@armor2_id, 2)
			@armor2.x = 36
			@armor2.y = 125
		end
		@character = Sprite.new(self)
		@character.bitmap = Bitmap.new(@route + "character_win")
		@armor3_id = @netPlayer.armor3_id
		if @armor3_id != 0
			@armor3 = J::Item.new(self).refresh(@armor3_id, 2)
			@armor3.x = 72
			@armor3.y = 125
		end
		@armor4_id = @netPlayer.armor4_id
		if @armor4_id != 0
			@armor4 = J::Item.new(self).refresh(@armor4_id, 2)
			@armor4.x = 144
			@armor4.y = 125
		end
		
		@equip = [@weapon, @armor1, @armor2, @armor3, @armor4]
		@actor = Sprite.new(self)
		actor = @netPlayer
		@character_name = actor.character_name
		bitmap = Bitmap.new("Graphics/Characters/#{@character_name}")
		
		cw = bitmap.width / 4
		ch = bitmap.height / 4
		@actor.bitmap = Bitmap.new(cw, ch)
		@actor.bitmap.blt(0, 0, bitmap, @actor.bitmap.rect)
		@actor.x = @character.x + (@character.width / 2 - @actor.width / 2)
		@actor.y = @character.height - @actor.height - 10
		
		@name = Sprite.new(self)
		@name.bitmap = Bitmap.new(@character.width, 20)
		@name.x = 70
		@name.bitmap.font.size = 12
		@name.bitmap.font.color.set(0, 0, 0, 255)
		@name.bitmap.draw_text(0, 0, @character.width, 20, "이름: " + @netPlayer.name, 1)
		
		@level = Sprite.new(self)
		@level.bitmap = Bitmap.new(180, 20)
		@level.x = 75
		@level.bitmap.font.size = 12
		@level.bitmap.font.color.set(0, 0, 0, 255)
		@level.bitmap.draw_text(0, 0, 180, 20, "레벨: " + actor.level.to_s, 1)
		@level_s = actor.level.to_s
		
		@job = Sprite.new(self)
		@job.bitmap = Bitmap.new(100, 20)
		@job.x = 69
		@job.y = 15
		@job.bitmap.font.size = 12
		@job.bitmap.font.color.set(0, 0, 0, 255)
		@job.bitmap.draw_text(0, 0, 100, 20, "직업: " + actor.pci, 1)
		@job_s = actor.pci
		
		@hp = Sprite.new(self)
		@hp.bitmap = Bitmap.new(180, 20)
		@hp.x = 50
		@hp.y = 30
		@hp.bitmap.font.size = 12
		@hp.bitmap.font.color.set(0, 0, 0, 255)
		@hp.bitmap.draw_text(0, 0, 180, 20, "체력: " + actor.hp.to_s + "/" + actor.maxhp.to_s, 1)
		@hp_s = actor.hp.to_s
		@maxhp_s = actor.maxhp.to_s
		
		@mp = Sprite.new(self)
		@mp.bitmap = Bitmap.new(180, 20)
		@mp.x = 90
		@mp.y = 45
		@mp.bitmap.font.size = 12
		@mp.bitmap.font.color.set(0, 0, 0, 255)
		@mp.bitmap.draw_text(0, 0, 180, 20, "마력: " + actor.sp.to_s + "/" + actor.maxsp.to_s, 0)
		@mp_s = actor.sp.to_s
		@maxmp_s = actor.maxsp.to_s
		
		@guild = Sprite.new(self)
		@guild.bitmap = Bitmap.new(180, 20)
		
		@equip_name1 = Sprite.new(self)
		@equip_name1.bitmap = Bitmap.new(100, 20)
		@equip_name1.y = 105
		@equip_name1.bitmap.font.size = 12
		@equip_name1.bitmap.font.color.set(0, 0, 0, 255)
		@equip_name1.bitmap.draw_text(0, 0, 100, 20, "무기", 0)
		
		@equip_name2 = Sprite.new(self)
		@equip_name2.bitmap = Bitmap.new(100, 20)
		@equip_name2.x = 36
		@equip_name2.y = 105
		@equip_name2.bitmap.font.size = 12
		@equip_name2.bitmap.font.color.set(0, 0, 0, 255)
		@equip_name2.bitmap.draw_text(0, 0, 100, 20, "투구", 0)
		
		@equip_name3 = Sprite.new(self)
		@equip_name3.bitmap = Bitmap.new(100, 20)
		@equip_name3.x = 72
		@equip_name3.y = 105
		@equip_name3.bitmap.font.size = 12
		@equip_name3.bitmap.font.color.set(0, 0, 0, 255)
		@equip_name3.bitmap.draw_text(0, 0, 100, 20, "갑옷", 0)
		
		@equip_name4 = Sprite.new(self)
		@equip_name4.bitmap = Bitmap.new(100, 20)
		@equip_name4.x = 108
		@equip_name4.y = 105
		@equip_name4.bitmap.font.size = 12
		@equip_name4.bitmap.font.color.set(0, 0, 0, 255)
		@equip_name4.bitmap.draw_text(0, 0, 100, 20, "보조", 0)
		
		@equip_name5 = Sprite.new(self)
		@equip_name5.bitmap = Bitmap.new(100, 20)
		@equip_name5.x = 144
		@equip_name5.y = 105
		@equip_name5.bitmap.font.size = 12
		@equip_name5.bitmap.font.color.set(0, 0, 0, 255)
		@equip_name5.bitmap.draw_text(0, 0, 100, 20, "반지", 0)
	end
	
	def update
		self.x != 242
		self.y != 132
		super
		actor = @netPlayer
		
		if @job_s != actor.pci
			@job.dispose
			@job = Sprite.new(self)
			@job.bitmap = Bitmap.new(100, 20)
			@job.x = 69
			@job.y = 15
			@job.bitmap.font.size = 12
			@job.bitmap.font.color.set(0, 0, 0, 255)
			@job.bitmap.draw_text(0, 0, 100, 20, "직업: " + actor.pci, 1)
			@job_s = actor.pci
		end
		
		if @hp_s != actor.hp.to_s or @maxhp_s != actor.maxhp.to_s
			@hp.dispose
			@hp = Sprite.new(self)
			@hp.bitmap = Bitmap.new(180, 20)
			@hp.x = 50
			@hp.y = 30
			@hp.bitmap.font.size = 12
			@hp.bitmap.font.color.set(0, 0, 0, 255)
			@hp.bitmap.draw_text(0, 0, 180, 20, "체력: " + actor.hp.to_s + "/" + actor.maxhp.to_s, 1)
			@hp_s = actor.hp.to_s
			@maxhp_s = actor.maxhp.to_s
		end
		
		if @mp_s != actor.sp.to_s or @maxmp_s != actor.maxsp.to_s
			@mp.dispose
			@mp = Sprite.new(self)
			@mp.bitmap = Bitmap.new(180, 20)
			@mp.x = 90
			@mp.y = 45
			@mp.bitmap.font.size = 12
			@mp.bitmap.font.color.set(0, 0, 0, 255)
			@mp.bitmap.draw_text(0, 0, 180, 20, "마력: " + actor.sp.to_s + "/" + actor.maxsp.to_s, 0)
			@mp_s = actor.sp.to_s
			@maxmp_s = actor.maxsp.to_s
		end
		
		if @character_name != actor.character_name
			@actor.dispose
			@actor = Sprite.new(self)
			bitmap = Bitmap.new("Graphics/Characters/" + actor.character_name)
			@character_name = actor.character_name
			cw = bitmap.width / 4
			ch = bitmap.height / 4
			@actor.bitmap = Bitmap.new(cw, ch)
			@actor.bitmap.blt(0, 0, bitmap, @actor.bitmap.rect)
			@actor.x = @character.x + (@character.width / 2 - @actor.width / 2)
			@actor.y = @character.height - @actor.height - 10
		end
		
		if @actor_name != @netPlayer.name
			@name.dispose
			@name = Sprite.new(self)
			@name.bitmap = Bitmap.new(@character.width, 20)
			@name.x = 70
			@name.bitmap.font.size = 12
			@name.bitmap.font.color.set(0, 0, 0, 255)
			@name.bitmap.draw_text(0, 0, @character.width, 20, "이름: " + @netPlayer.name, 1)
			@actor_name = @netPlayer.name
		end
		
		if @actor_level != actor.level
			@level.dispose
			@level = Sprite.new(self)
			@level.bitmap = Bitmap.new(100, 20)
			@level.x = 120
			@level.bitmap.font.size = 12
			@level.bitmap.font.color.set(0, 0, 0, 255)
			@level.bitmap.draw_text(0, 0, 100, 20, "레벨: " + @netPlayer.level.to_s, 1)
			@actor_level = actor.level
		end
		
		if @weapon_id != @netPlayer.weapon_id
			@weapon_id = @netPlayer.weapon_id
			@weapon ? (@weapon.dispose; @weapon = nil) : 0
			if @weapon_id != 0
				@weapon = J::Item.new(self).refresh(@weapon_id, 1)
				@weapon.y = 125
			end
		end
		
		if @armor1_id != @netPlayer.armor1_id
			@armor1_id = @netPlayer.armor1_id
			@armor1 ? (@armor1.dispose; @armor1 = nil) : 0
			if @armor1_id != 0
				@armor1 = J::Item.new(self).refresh(@armor1_id, 2)
				@armor1.x = 108
				@armor1.y = 125
			end
		end
		
		if @armor2_id != @netPlayer.armor2_id
			@armor2_id = @netPlayer.armor2_id
			@armor2 ? (@armor2.dispose; @armor2 = nil) : 0
			if @armor2_id != 0
				@armor2 = J::Item.new(self).refresh(@armor2_id, 2)
				@armor2.x = 36
				@armor2.y = 125
			end
		end
		
		if @armor3_id != @netPlayer.armor3_id
			@armor3_id = @netPlayer.armor3_id
			@armor3 ? (@armor3.dispose; @armor3 = nil) : 0
			if @armor3_id != 0
				@armor3 = J::Item.new(self).refresh(@armor3_id, 2)
				@armor3.x = 72
				@armor3.y = 125
			end
		end
		
		if @armor4_id != @netPlayer.armor4_id
			@armor4_id = @netPlayer.armor4_id
			@armor4 ? (@armor4.dispose; @armor4 = nil) : 0
			if @armor4_id != 0
				@armor4 = J::Item.new(self).refresh(@armor4_id, 2)
				@armor4.x = 144
				@armor4.y = 125
			end
		end
		
		
	end
end