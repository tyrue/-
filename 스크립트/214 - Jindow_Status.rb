#==============================================================================
# ■ Jindow_Status
#------------------------------------------------------------------------------
#   캐릭터 정보 창
#------------------------------------------------------------------------------
class Jindow_Status < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 350, 180)
		self.name = "상태 정보"
		@head = true
		@mark = true
		@drag = true
		@close = true
		@route = "Graphics/Jindow/" + @skin + "/Window/"
		
		self.refresh("Status")
		self.x = 41
		self.y = 105
		
		# 장비 비트맵
		@equip = []
		@armor_id = [
			$game_party.actors[0].weapon_id, 
			$game_party.actors[0].armor2_id,
			$game_party.actors[0].armor3_id,
			$game_party.actors[0].armor1_id,
			$game_party.actors[0].armor4_id
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
			@armor_n[i].bitmap = Bitmap.new(100, 20)
			@armor_n[i].x = 36 * i
			@armor_n[i].y = 105
			@armor_n[i].bitmap.font.size = 12
			@armor_n[i].bitmap.font.color.set(0, 0, 0, 255)
			@armor_n[i].bitmap.draw_text(0, 0, 100, 20, @armor_name[i], 0)
			
			if @armor_id[i] != 0
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
		actor = $game_party.actors[0]
		@character_name = actor.character_name
		bitmap = Bitmap.new("Graphics/Characters/#{@character_name}")
		
		cw = bitmap.width / 4
		ch = bitmap.height / 4
		@actor.bitmap = Bitmap.new(cw, ch)
		@actor.bitmap.blt(0, 0, bitmap, @actor.bitmap.rect)
		@actor.x = @character.x + (@character.width / 2 - @actor.width / 2)
		@actor.y = @character.height - @actor.height - 10 + @character.y
		
		# 상태 비트맵
		@state = []
		@state_name = [
			"이름: " + actor.name,
			"레벨: " + actor.level.to_s,
			"직업: " + actor.class_name,
			"체력: " + actor.hp.to_s + "/" + actor.maxhp.to_s,
			"마력: " + actor.sp.to_s + "/" + actor.maxsp.to_s,
			"경험치: " + actor.exp.to_s,
			"금전: " + $game_party.gold.to_s,
			
			"물리 공격력: " + actor.base_atk.to_s,
			"물리 방어력: " + actor.base_pdef.to_s,
			"마법 방어력: " + actor.base_mdef.to_s,
			"회피율: " + actor.base_eva.to_s
		]
		
		for i in 0..10
			@state[i] = Sprite.new(self)
			@state[i].bitmap = Bitmap.new(180, 20)
			if i <= 6
				@state[i].x = 80
				@state[i].y = 15 * i
			else
				@state[i].x = 220
				@state[i].y = 90 + 15 * (i - 7)
			end
			
			@state[i].bitmap.font.size = 12
			@state[i].bitmap.font.color.set(0, 0, 0, 255)
			@state[i].bitmap.draw_text(0, 0, 180, 20, @state_name[i], 0)
		end
		
		@guild = Sprite.new(self)
		@guild.bitmap = Bitmap.new(180, 20)
		@actor_guild = $guild
		
		@stat = Sprite.new(self)
		@stat.bitmap = Bitmap.new(100, 20)
		@stat.x = 180
		@stat.bitmap.font.size = 12
		@stat.bitmap.font.color.set(0, 0, 0, 255)
		@stat.bitmap.draw_text(0, 0, 100, 20, "능력치: ", 1)
		
		@state2 = []
		@state2_2 = []
		@state2_3 = []	
		
		@state2_name = [
			"힘",
			"손재주",
			"민첩",
			"지력"
		]
		@state2_v = [
			actor.str,
			actor.dex,
			actor.agi,
			actor.int
		]
		
		@state_plus = [] # 힘, 손재주, 민첩, 지력
		@weapon = $data_weapons[actor.weapon_id]
		@armor1 = $data_armors[actor.armor1_id]
		@armor2 = $data_armors[actor.armor2_id]
		@armor3 = $data_armors[actor.armor3_id]
		@armor4 = $data_armors[actor.armor4_id]
		for i in 0..3
			n = 0
			case i
			when 0
				n += (@weapon != nil and actor.weapon_id != 0) ? @weapon.str_plus : 0
				n += (@armor1 != nil and actor.armor1_id != 0) ? @armor1.str_plus : 0
				n += (@armor2 != nil and actor.armor2_id != 0) ? @armor2.str_plus : 0
				n += (@armor3 != nil and actor.armor3_id != 0) ? @armor3.str_plus : 0
				n += (@armor4 != nil and actor.armor4_id != 0) ? @armor4.str_plus : 0
			when 1
				n += (@weapon != nil and actor.weapon_id != 0) ? @weapon.dex_plus : 0
				n += (@armor1 != nil and actor.armor1_id != 0) ? @armor1.dex_plus : 0
				n += (@armor2 != nil and actor.armor2_id != 0) ? @armor2.dex_plus : 0
				n += (@armor3 != nil and actor.armor3_id != 0) ? @armor3.dex_plus : 0
				n += (@armor4 != nil and actor.armor4_id != 0) ? @armor4.dex_plus : 0
			when 2
				n += (@weapon != nil and actor.weapon_id != 0) ? @weapon.agi_plus : 0
				n += (@armor1 != nil and actor.armor1_id != 0) ? @armor1.agi_plus : 0
				n += (@armor2 != nil and actor.armor2_id != 0) ? @armor2.agi_plus : 0
				n += (@armor3 != nil and actor.armor3_id != 0) ? @armor3.agi_plus : 0
				n += (@armor4 != nil and actor.armor4_id != 0) ? @armor4.agi_plus : 0
			when 3
				n += (@weapon != nil and actor.weapon_id != 0) ? @weapon.int_plus : 0
				n += (@armor1 != nil and actor.armor1_id != 0) ? @armor1.int_plus : 0
				n += (@armor2 != nil and actor.armor2_id != 0) ? @armor2.int_plus : 0
				n += (@armor3 != nil and actor.armor3_id != 0) ? @armor3.int_plus : 0
				n += (@armor4 != nil and actor.armor4_id != 0) ? @armor4.int_plus : 0
			end
			@state_plus[i] = n
		end
		
		for i in 0..3
			@state2[i] = J::Text_Box.new(self)
			@state2[i].set("tb_2", 2).refresh(44, 0)
			@state2[i].x = 215
			@state2[i].y = 14 * (i + 1) + 5
			@state2[i].font.alpha = 1
			@state2[i].bitmap.font.size = 12
			@state2[i].bitmap.font.color.set(0, 0, 0, 255)
			@state2[i].bitmap.draw_text(0, 0, @state2[i].width, @state2[i].height, @state2_name[i], 1)
			
			@state2_2[i] = J::Text_Box.new(self)
			@state2_2[i].set("tb_2", 2).refresh(36, 0)
			@state2_2[i].x = @state2[i].x + @state2[i].width - 1
			@state2_2[i].y = @state2[i].y
			@state2_2[i].font.alpha = 1
			@state2_2[i].bitmap.font.size = 12
			@state2_2[i].bitmap.font.color.set(0, 0, 255, 255)
			@state2_2[i].bitmap.draw_text(0, 0, @state2_2[i].width, @state2_2[i].height, "(+" + @state_plus[i].to_s + ")", 1)
			
			@state2_3[i] = J::Text_Box.new(self)
			@state2_3[i].set("tb_3", 2).refresh(34, 0)
			@state2_3[i].x = @state2_2[i].x + @state2_2[i].width - 1
			@state2_3[i].y = @state2[i].y
			@state2_3[i].font.alpha = 1
			@state2_3[i].bitmap.font.size = 12
			@state2_3[i].bitmap.font.color.set(0, 0, 0, 255)
			@state2_3[i].bitmap.draw_text(0, 1, @state2_3[i].width - 5, @state2_3[i].height, @state2_v[i].to_s, 2)
		end
	end
	
	def update
		self.x != 242
		self.y != 132
		super
		actor = $game_party.actors[0]
		
		@state_name2 = [
			"이름: " + actor.name,
			"레벨: " + actor.level.to_s,
			"직업: " + actor.class_name,
			"체력: " + actor.hp.to_s + "/" + actor.maxhp.to_s,
			"마력: " + actor.sp.to_s + "/" + actor.maxsp.to_s,
			"경험치: " + actor.exp.to_s,
			"금전: " + $game_party.gold.to_s,
			
			"물리 공격력: " + actor.base_atk.to_s,
			"물리 방어력: " + actor.base_pdef.to_s,
			"마법 방어력: " + actor.base_mdef.to_s,
			"회피율: " + actor.base_eva.to_s
		]
		
		for i in 0..10
			if @state_name[i] != @state_name2[i]
				@state[i].dispose
				@state[i] = Sprite.new(self)
				@state[i].bitmap = Bitmap.new(180, 20)
				if i <= 6
					@state[i].x = 80
					@state[i].y = 15 * i
				else
					@state[i].x = 177
					@state[i].y = 90 + 15 * (i - 7)
				end
				@state[i].bitmap.font.size = 12
				@state[i].bitmap.font.color.set(0, 0, 0, 255)
				@state[i].bitmap.draw_text(0, 0, 180, 20, @state_name2[i], 0)
				@state_name[i] = @state_name2[i]
			end
		end
		
		@state_plus2 = [] # 힘, 손재주, 민첩, 지력
		@state2_v2 = [
			actor.str,
			actor.dex,
			actor.agi,
			actor.int
		]
		@weapon = $data_weapons[actor.weapon_id]
		@armor1 = $data_armors[actor.armor1_id]
		@armor2 = $data_armors[actor.armor2_id]
		@armor3 = $data_armors[actor.armor3_id]
		@armor4 = $data_armors[actor.armor4_id]
		for i in 0..3
			n = 0
			case i
			when 0
				n += (@weapon != nil and actor.weapon_id != 0) ? @weapon.str_plus : 0
				n += (@armor1 != nil and actor.armor1_id != 0) ? @armor1.str_plus : 0
				n += (@armor2 != nil and actor.armor2_id != 0) ? @armor2.str_plus : 0
				n += (@armor3 != nil and actor.armor3_id != 0) ? @armor3.str_plus : 0
				n += (@armor4 != nil and actor.armor4_id != 0) ? @armor4.str_plus : 0
			when 1
				n += (@weapon != nil and actor.weapon_id != 0) ? @weapon.dex_plus : 0
				n += (@armor1 != nil and actor.armor1_id != 0) ? @armor1.dex_plus : 0
				n += (@armor2 != nil and actor.armor2_id != 0) ? @armor2.dex_plus : 0
				n += (@armor3 != nil and actor.armor3_id != 0) ? @armor3.dex_plus : 0
				n += (@armor4 != nil and actor.armor4_id != 0) ? @armor4.dex_plus : 0
			when 2
				n += (@weapon != nil and actor.weapon_id != 0) ? @weapon.agi_plus : 0
				n += (@armor1 != nil and actor.armor1_id != 0) ? @armor1.agi_plus : 0
				n += (@armor2 != nil and actor.armor2_id != 0) ? @armor2.agi_plus : 0
				n += (@armor3 != nil and actor.armor3_id != 0) ? @armor3.agi_plus : 0
				n += (@armor4 != nil and actor.armor4_id != 0) ? @armor4.agi_plus : 0
			when 3
				n += (@weapon != nil and actor.weapon_id != 0) ? @weapon.int_plus : 0
				n += (@armor1 != nil and actor.armor1_id != 0) ? @armor1.int_plus : 0
				n += (@armor2 != nil and actor.armor2_id != 0) ? @armor2.int_plus : 0
				n += (@armor3 != nil and actor.armor3_id != 0) ? @armor3.int_plus : 0
				n += (@armor4 != nil and actor.armor4_id != 0) ? @armor4.int_plus : 0
			end
			@state_plus2[i] = n
		end
		
		for i in 0..3
			if @state_plus[i] != @state_plus2[i]
				@state2_2[i].dispose
				@state2_2[i] = J::Text_Box.new(self)
				@state2_2[i].set("tb_2", 2).refresh(36, 0)
				@state2_2[i].x = @state2[i].x + @state2[i].width - 1
				@state2_2[i].y = @state2[i].y
				@state2_2[i].font.alpha = 1
				@state2_2[i].bitmap.font.size = 12
				@state2_2[i].bitmap.font.color.set(0, 0, 255, 255)
				@state2_2[i].bitmap.draw_text(0, 0, @state2_2[i].width, @state2_2[i].height, "(+" + @state_plus2[i].to_s + ")", 1)
				@state_plus[i] = @state_plus2[i]
			end
			if @state2_v[i] != @state2_v2[i]
				@state2_v[i] = @state2_v2[i]
				@state2_3[i].dispose
				@state2_3[i] = J::Text_Box.new(self)
				@state2_3[i].set("tb_3", 2).refresh(34, 0)
				@state2_3[i].x = @state2_2[i].x + @state2_2[i].width - 1
				@state2_3[i].y = @state2[i].y
				@state2_3[i].font.alpha = 1
				@state2_3[i].bitmap.font.size = 12
				@state2_3[i].bitmap.font.color.set(0, 0, 0, 255)
				@state2_3[i].bitmap.draw_text(0, 1, @state2_3[i].width - 5, @state2_3[i].height, @state2_v[i].to_s, 2)
			end
		end
		
		@armor_id2 = [
			$game_party.actors[0].weapon_id, 
			$game_party.actors[0].armor2_id,
			$game_party.actors[0].armor3_id,
			$game_party.actors[0].armor1_id,
			$game_party.actors[0].armor4_id
		]
		
		for i in 0..4
			if @armor_id[i] != @armor_id2[i]
				@armor_id[i] = @armor_id2[i]
				@armor_i[i] ? (@armor_i[i].dispose; @armor_i[i] = nil) : 0
				if @armor_id[i] != 0
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
		
		# 0, 2, 3, 1, 4
		if @armor_i[0] and @armor_i[0].double_click
			$game_party.actors[0].equip(0, 0)
			Audio.se_play("Audio/SE/장")
		end
		if @armor_i[1] and @armor_i[1].double_click
			$game_party.actors[0].equip(2, 0)
			Audio.se_play("Audio/SE/장")
		end
		if @armor_i[2] and @armor_i[2].double_click
			$game_party.actors[0].equip(3, 0)
			Audio.se_play("Audio/SE/장")
		end
		if @armor_i[3] and @armor_i[3].double_click
			$game_party.actors[0].equip(1, 0)
			Audio.se_play("Audio/SE/장")
		end
		if @armor_i[4] and @armor_i[4].double_click
			$game_party.actors[0].equip(4, 0)
			Audio.se_play("Audio/SE/장")
		end
				
	end
end
