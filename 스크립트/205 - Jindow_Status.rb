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
		@weapon_id = $game_party.actors[0].weapon_id
		if @weapon_id != 0
			@weapon = J::Item.new(self).refresh(@weapon_id, 1)
			@weapon.y = 125
		end
		@armor1_id = $game_party.actors[0].armor1_id
		if @armor1_id != 0
			@armor1 = J::Item.new(self).refresh(@armor1_id, 2)
			@armor1.x = 108
			@armor1.y = 125
		end
		@armor2_id = $game_party.actors[0].armor2_id
		if @armor2_id != 0
			@armor2 = J::Item.new(self).refresh(@armor2_id, 2)
			@armor2.x = 36
			@armor2.y = 125
		end
		@character = Sprite.new(self)
		@character.bitmap = Bitmap.new(@route + "character_win")
		@armor3_id = $game_party.actors[0].armor3_id
		if @armor3_id != 0
			@armor3 = J::Item.new(self).refresh(@armor3_id, 2)
			@armor3.x = 72
			@armor3.y = 125
		end
		@armor4_id = $game_party.actors[0].armor4_id
		if @armor4_id != 0
			@armor4 = J::Item.new(self).refresh(@armor4_id, 2)
			@armor4.x = 144
			@armor4.y = 125
		end
		@equip = [@weapon, @armor1, @armor2, @armor3, @armor4]
		@actor = Sprite.new(self)
		actor = $game_party.actors[0]
		bitmap = Bitmap.new("Graphics/Characters/무그래픽")
		@character_name = actor.character_name
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
		@name.bitmap.draw_text(0, 0, @character.width, 20, "이름: " + $game_party.actors[0].name, 1)
		@level = Sprite.new(self)
		@level.bitmap = Bitmap.new(180, 20)
		@level.x = 75
		@level.bitmap.font.size = 12
		@level.bitmap.font.color.set(0, 0, 0, 255)
		@level.bitmap.draw_text(0, 0, 180, 20, "레벨: " + actor.level.to_s, 1)
		@job = Sprite.new(self)
		@job.bitmap = Bitmap.new(100, 20)
		@job.x = 69
		@job.y = 15
		@job.bitmap.font.size = 12
		@job.bitmap.font.color.set(0, 0, 0, 255)
		@job.bitmap.draw_text(0, 0, 100, 20, "직업: " + actor.class_name, 1)
		
		@hp = Sprite.new(self)
		@hp.bitmap = Bitmap.new(180, 20)
		@hp.x = 50
		@hp.y = 30
		@hp.bitmap.font.size = 12
		@hp.bitmap.font.color.set(0, 0, 0, 255)
		@hp.bitmap.draw_text(0, 0, 180, 20, "체력: " + actor.hp.to_s + "/" + actor.maxhp.to_s, 1)
		
		@mp = Sprite.new(self)
		@mp.bitmap = Bitmap.new(180, 20)
		@mp.x = 90
		@mp.y = 45
		@mp.bitmap.font.size = 12
		@mp.bitmap.font.color.set(0, 0, 0, 255)
		@mp.bitmap.draw_text(0, 0, 180, 20, "마력: " + actor.sp.to_s + "/" + actor.maxsp.to_s, 0)
		
		@exp = Sprite.new(self)
		@exp.bitmap = Bitmap.new(100, 20)
		@exp.x = 70
		@exp.y = 60
		@exp.bitmap.font.size = 12
		@exp.bitmap.font.color.set(0, 0, 0, 255)
		@exp.bitmap.draw_text(0, 0, 100, 20, "경험치: " + $game_party.actors[0].exp.to_s, 1)
		
		@gold = Sprite.new(self)
		@gold.bitmap = Bitmap.new(180, 20)
		@gold.x = 90
		@gold.y = 75
		@gold.bitmap.font.size = 12
		@gold.bitmap.font.color.set(0, 0, 0, 255)
		@gold.bitmap.draw_text(0, 0, 180, 20, "금전: " + $game_party.gold.to_s, 0)
		@guild = Sprite.new(self)
		@guild.bitmap = Bitmap.new(180, 20)
		
		
		@attack = Sprite.new(self)
		@attack.bitmap = Bitmap.new(130, 30)
		@attack.x = 177
		@attack.y = 90
		@attack.bitmap.font.size = 12
		@attack.bitmap.font.color.set(0, 0, 0, 255)
		@attack.bitmap.draw_text(0, 0, 130, 20, "물리 공격력: " + $game_party.actors[0].base_atk.to_s, 1)
		@defense = Sprite.new(self)
		@defense.bitmap = Bitmap.new(130, 30)
		@defense.x = 177
		@defense.y = 105
		@defense.bitmap.font.size = 12
		@defense.bitmap.font.color.set(0, 0, 0, 255)
		@defense.bitmap.draw_text(0, 0, 130, 20, "물리 방어력: " + $game_party.actors[0].base_pdef.to_s, 1)
		@magic_defense = Sprite.new(self)
		@magic_defense.bitmap = Bitmap.new(130, 30)
		@magic_defense.x = 177
		@magic_defense.y = 120
		@magic_defense.bitmap.font.size = 12
		@magic_defense.bitmap.font.color.set(0, 0, 0, 255)
		@magic_defense.bitmap.draw_text(0, 0, 130, 20, "마법 방어력: " + $game_party.actors[0].base_mdef.to_s, 1)
		@eva = Sprite.new(self)
		@eva.bitmap = Bitmap.new(130, 30)
		@eva.x = 168
		@eva.y = 135
		@eva.bitmap.font.size = 12
		@eva.bitmap.font.color.set(0, 0, 0, 255)
		@eva.bitmap.draw_text(0, 0, 130, 20, "회피율: " + $game_party.actors[0].base_eva.to_s, 1)
		
		
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
		
		@stat = Sprite.new(self)
		@stat.bitmap = Bitmap.new(100, 20)
		@stat.x = 180
		@stat.bitmap.font.size = 12
		@stat.bitmap.font.color.set(0, 0, 0, 255)
		@stat.bitmap.draw_text(0, 0, 100, 20, "능력치: ", 1)
		
		@actor_name = $game_party.actors[0].name
		@actor_level = actor.level
		@actor_gold = $game_party.gold
		@actor_pride = $game_variables[50]
		@actor_job = $game_party.actors[0].class_name
		@actor_guild = $guild
		
		@text3 = J::Text_Box.new(self)
		@text3.set("tb_2", 2).refresh(44, 0)
		@text3.x = 215
		@text3.y = 20
		@text3.font.alpha = 1
		@text3.bitmap.font.size = 12
		@text3.bitmap.font.color.set(0, 0, 0, 255)
		@text3.bitmap.draw_text(0, 0, @text3.width, @text3.height, "힘", 1)
		@text3_2 = J::Text_Box.new(self)
		@text3_2.set("tb_2", 2).refresh(36, 0)
		@text3_2.x = @text3.x + @text3.width - 1
		@text3_2.y = @text3.y
		@text3_2.font.alpha = 1
		@text3_2.bitmap.font.size = 12
		@text3_2.bitmap.font.color.set(0, 0, 255, 255)
		n = 0
		weapon = $data_weapons[actor.weapon_id]
		armor1 = $data_armors[actor.armor1_id]
		armor2 = $data_armors[actor.armor2_id]
		armor3 = $data_armors[actor.armor3_id]
		armor4 = $data_armors[actor.armor4_id]
		n += (weapon != nil and actor.weapon_id != 0) ? weapon.str_plus : 0
		n += (armor1 != nil and actor.armor1_id != 0) ? armor1.str_plus : 0
		n += (armor2 != nil and actor.armor2_id != 0) ? armor2.str_plus : 0
		n += (armor3 != nil and actor.armor3_id != 0) ? armor3.str_plus : 0
		n += (armor4 != nil and actor.armor4_id != 0) ? armor4.str_plus : 0
		@text3_2.bitmap.draw_text(0, 0, @text3_2.width, @text3_2.height, "(+" + n.to_s + ")", 1)
		@str_plus = n
		@text3_3 = J::Text_Box.new(self)
		@text3_3.set("tb_3", 2).refresh(34, 0)
		@text3_3.x = @text3_2.x + @text3_2.width - 1
		@text3_3.y = @text3.y
		@text3_3.font.alpha = 1
		@text3_3.bitmap.font.size = 12
		@text3_3.bitmap.font.color.set(0, 0, 0, 255)
		@text3_3.bitmap.draw_text(0, 1, @text3_3.width - 5, @text3_3.height, actor.str.to_s, 2)
		@str = actor.str
		@text4 = J::Text_Box.new(self)
		@text4.set("tb_2", 2).refresh(44, 0)
		@text4.x = @text3.x
		@text4.y = @text3.y + @text3.height + 1
		@text4.font.alpha = 1
		@text4.bitmap.font.size = 12
		@text4.bitmap.font.color.set(0, 0, 0, 255)
		@text4.bitmap.draw_text(0, 0, @text4.width, @text4.height, "손재주", 1)
		@text4_2 = J::Text_Box.new(self)
		@text4_2.set("tb_2", 2).refresh(36, 0)
		@text4_2.x = @text4.x + @text4.width - 1
		@text4_2.y = @text3.y + @text3.height + 1
		@text4_2.font.alpha = 1
		@text4_2.bitmap.font.size = 12
		@text4_2.bitmap.font.color.set(0, 0, 255, 255)
		n = 0
		n += (weapon != nil and actor.weapon_id != 0) ? weapon.dex_plus : 0
		n += (armor1 != nil and actor.armor1_id != 0) ? armor1.dex_plus : 0
		n += (armor2 != nil and actor.armor2_id != 0) ? armor2.dex_plus : 0
		n += (armor3 != nil and actor.armor3_id != 0) ? armor3.dex_plus : 0
		n += (armor4 != nil and actor.armor4_id != 0) ? armor4.dex_plus : 0
		@text4_2.bitmap.draw_text(0, 1, @text4_2.width, @text4_2.height, "(+" + n.to_s + ")", 1)
		@dex_plus = n
		@text4_3 = J::Text_Box.new(self)
		@text4_3.set("tb_3", 2).refresh(34, 0)
		@text4_3.x = @text4_2.x + @text4_2.width - 1
		@text4_3.y = @text3.y + @text3.height + 1
		@text4_3.font.alpha = 1
		@text4_3.bitmap.font.size = 12
		@text4_3.bitmap.font.color.set(0, 0, 0, 255)
		@text4_3.bitmap.draw_text(0, 1, @text4_3.width - 5, @text4_3.height, actor.dex.to_s, 2)
		@dex = actor.dex
		@text5 = J::Text_Box.new(self)
		@text5.set("tb_2", 2).refresh(44, 0)
		@text5.x = @text3.x
		@text5.y = @text4.y + @text4.height + 1
		@text5.font.alpha = 1
		@text5.bitmap.font.size = 12
		@text5.bitmap.font.color.set(0, 0, 0, 255)
		@text5.bitmap.draw_text(0, 0, @text5.width, @text5.height, "민첩", 1)
		@text5_2 = J::Text_Box.new(self)
		@text5_2.set("tb_2", 2).refresh(36, 0)
		@text5_2.x = @text5.x + @text5.width - 1
		@text5_2.y = @text4.y + @text4.height + 1
		@text5_2.font.alpha = 1
		@text5_2.bitmap.font.size = 12
		@text5_2.bitmap.font.color.set(0, 0, 255, 255)
		n = 0
		n += (weapon != nil and actor.weapon_id != 0) ? weapon.agi_plus : 0
		n += (armor1 != nil and actor.armor1_id != 0) ? armor1.agi_plus : 0
		n += (armor2 != nil and actor.armor2_id != 0) ? armor2.agi_plus : 0
		n += (armor3 != nil and actor.armor3_id != 0) ? armor3.agi_plus : 0
		n += (armor4 != nil and actor.armor4_id != 0) ? armor4.agi_plus : 0
		@text5_2.bitmap.draw_text(0, 1, @text5_2.width, @text5_2.height, "(+" + n.to_s + ")", 1)
		@agi_plus = n
		@text5_3 = J::Text_Box.new(self)
		@text5_3.set("tb_3", 2).refresh(34, 0)
		@text5_3.x = @text5_2.x + @text5_2.width - 1
		@text5_3.y = @text4.y + @text4.height + 1
		@text5_3.font.alpha = 1
		@text5_3.bitmap.font.size = 12
		@text5_3.bitmap.font.color.set(0, 0, 0, 255)
		@text5_3.bitmap.draw_text(0, 1, @text5_3.width - 5, @text5_3.height, actor.agi.to_s, 2)
		@agi = actor.agi
		@text6 = J::Text_Box.new(self)
		@text6.set("tb_2", 2).refresh(44, 0)
		@text6.x = @text3.x
		@text6.y = @text5.y + @text5.height + 1
		@text6.font.alpha = 1
		@text6.bitmap.font.size = 12
		@text6.bitmap.font.color.set(0, 0, 0, 255)
		@text6.bitmap.draw_text(0, 0, @text6.width, @text6.height, "마법력", 1)
		@text6_2 = J::Text_Box.new(self)
		@text6_2.set("tb_2", 2).refresh(36, 0)
		@text6_2.x = @text6.x + @text6.width - 1
		@text6_2.y = @text5.y + @text5.height + 1
		@text6_2.font.alpha = 1
		@text6_2.bitmap.font.size = 12
		@text6_2.bitmap.font.color.set(0, 0, 255, 255)
		n = 0
		n += (weapon != nil and actor.weapon_id != 0) ? weapon.int_plus : 0
		n += (armor1 != nil and actor.armor1_id != 0) ? armor1.int_plus : 0
		n += (armor2 != nil and actor.armor2_id != 0) ? armor2.int_plus : 0
		n += (armor3 != nil and actor.armor3_id != 0) ? armor3.int_plus : 0
		n += (armor4 != nil and actor.armor4_id != 0) ? armor4.int_plus : 0
		@text6_2.bitmap.draw_text(0, 1, @text6_2.width, @text6_2.height, "(+" + n.to_s + ")", 1)
		@int_plus = n
		@text6_3 = J::Text_Box.new(self)
		@text6_3.set("tb_3", 2).refresh(34, 0)
		@text6_3.x = @text6_2.x + @text6_2.width - 1
		@text6_3.y = @text5.y + @text5.height + 1
		@text6_3.font.alpha = 1
		@text6_3.bitmap.font.size = 12
		@text6_3.bitmap.font.color.set(0, 0, 0, 255)
		@text6_3.bitmap.draw_text(0, 1, @text6_3.width - 5, @text6_3.height, actor.int.to_s, 2)
		@int = actor.int
	end
	
	def update
		self.x != 242
		self.y != 132
		super
		actor = $game_party.actors[0]
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
		if @actor_name != $game_party.actors[0].name
			@name.dispose
			@name = Sprite.new(self)
			@name.bitmap = Bitmap.new(@character.width, 20)
			@name.x = 70
			@name.bitmap.font.size = 12
			@name.bitmap.font.color.set(0, 0, 0, 255)
			@name.bitmap.draw_text(0, 0, @character.width, 20, "이름: " + $game_party.actors[0].name, 1)
			@actor_name = $game_party.actors[0].name
		end
		if @actor_level != actor.level
			@level.dispose
			@level = Sprite.new(self)
			@level.bitmap = Bitmap.new(100, 20)
			@level.x = 120
			@level.bitmap.font.size = 12
			@level.bitmap.font.color.set(0, 0, 0, 255)
			@level.bitmap.draw_text(0, 0, 100, 20, "레벨: " + $game_party.actors[0].level.to_s, 1)
			@actor_level = actor.level
		end
		weapon = $data_weapons[actor.weapon_id]
		armor1 = $data_armors[actor.armor1_id]
		armor2 = $data_armors[actor.armor2_id]
		armor3 = $data_armors[actor.armor3_id]
		armor4 = $data_armors[actor.armor4_id]
		n = 0
		n += (weapon != nil and actor.weapon_id != 0) ? weapon.str_plus : 0
		n += (armor1 != nil and actor.armor1_id != 0) ? armor1.str_plus : 0
		n += (armor2 != nil and actor.armor2_id != 0) ? armor2.str_plus : 0
		n += (armor3 != nil and actor.armor3_id != 0) ? armor3.str_plus : 0
		n += (armor4 != nil and actor.armor4_id != 0) ? armor4.str_plus : 0
		if @str_plus != n
			@text3_2.dispose
			@text3_2 = J::Text_Box.new(self)
			@text3_2.set("tb_2", 2).refresh(36, 0)
			@text3_2.x = @text3.x + @text3.width - 1
			@text3_2.y = @level.y + @level.height + 1
			@text3_2.font.alpha = 1
			@text3_2.bitmap.font.size = 12
			@text3_2.bitmap.font.color.set(0, 0, 255, 255)
			@text3_2.bitmap.draw_text(0, 1, @text3_2.width, @text3_2.height, "(+" + n.to_s + ")", 1)
			@str_plus = n
		end
		if @str != actor.str
			@text3_3.dispose
			@text3_3 = J::Text_Box.new(self)
			@text3_3.set("tb_3", 2).refresh(54, 0)
			@text3_3.x = @text3_2.x + @text3_2.width - 1
			@text3_3.y = @level.y + @level.height + 1
			@text3_3.font.alpha = 1
			@text3_3.bitmap.font.size = 12
			@text3_3.bitmap.font.color.set(0, 0, 0, 255)
			@text3_3.bitmap.draw_text(0, 1, @text3_3.width - 5, @text3_3.height, actor.str.to_s, 2)
			@str = actor.str
		end
		n = 0
		n += (weapon != nil and actor.weapon_id != 0) ? weapon.dex_plus : 0
		n += (armor1 != nil and actor.armor1_id != 0) ? armor1.dex_plus : 0
		n += (armor2 != nil and actor.armor2_id != 0) ? armor2.dex_plus : 0
		n += (armor3 != nil and actor.armor3_id != 0) ? armor3.dex_plus : 0
		n += (armor4 != nil and actor.armor4_id != 0) ? armor4.dex_plus : 0
		if @dex_plus != n
			@text4_2.dispose
			@text4_2 = J::Text_Box.new(self)
			@text4_2.set("tb_2", 2).refresh(36, 0)
			@text4_2.x = @text4.x + @text4.width - 1
			@text4_2.y = @text3.y + @text3.height + 1
			@text4_2.font.alpha = 1
			@text4_2.bitmap.font.size = 12
			@text4_2.bitmap.font.color.set(0, 0, 255, 255)
			@text4_2.bitmap.draw_text(0, 1, @text4_2.width, @text4_2.height, "(+" + n.to_s + ")", 1)
			@dex_plus = n
		end
		if @dex != actor.dex
			@text4_3.dispose
			@text4_3 = J::Text_Box.new(self)
			@text4_3.set("tb_3", 2).refresh(54, 0)
			@text4_3.x = @text4_2.x + @text4_2.width - 1
			@text4_3.y = @text3.y + @text3.height + 1
			@text4_3.font.alpha = 1
			@text4_3.bitmap.font.size = 12
			@text4_3.bitmap.font.color.set(0, 0, 0, 255)
			@text4_3.bitmap.draw_text(0, 1, @text4_3.width - 5, @text4_3.height, actor.dex.to_s, 2)
			@dex = actor.dex
		end
		n = 0
		n += (weapon != nil and actor.weapon_id != 0) ? weapon.agi_plus : 0
		n += (armor1 != nil and actor.armor1_id != 0) ? armor1.agi_plus : 0
		n += (armor2 != nil and actor.armor2_id != 0) ? armor2.agi_plus : 0
		n += (armor3 != nil and actor.armor3_id != 0) ? armor3.agi_plus : 0
		n += (armor4 != nil and actor.armor4_id != 0) ? armor4.agi_plus : 0
		if @agi_plus != n
			@text5_2.dispose
			@text5_2 = J::Text_Box.new(self)
			@text5_2.set("tb_2", 2).refresh(36, 0)
			@text5_2.x = @text5.x + @text5.width - 1
			@text5_2.y = @text4.y + @text4.height + 1
			@text5_2.font.alpha = 1
			@text5_2.bitmap.font.size = 12
			@text5_2.bitmap.font.color.set(0, 0, 255, 255)
			@text5_2.bitmap.draw_text(0, 1, @text5_2.width, @text5_2.height, "(+" + n.to_s + ")", 1)
			@agi_plus = n
		end
		if @agi != actor.agi
			@text5_3.dispose
			@text5_3 = J::Text_Box.new(self)
			@text5_3.set("tb_3", 2).refresh(54, 0)
			@text5_3.x = @text5_2.x + @text5_2.width - 1
			@text5_3.y = @text4.y + @text4.height + 1
			@text5_3.font.alpha = 1
			@text5_3.bitmap.font.size = 12
			@text5_3.bitmap.font.color.set(0, 0, 0, 255)
			@text5_3.bitmap.draw_text(0, 1, @text5_3.width - 5, @text5_3.height, actor.agi.to_s, 2)
			@agi = actor.agi
		end
		n = 0
		n += (weapon != nil and actor.weapon_id != 0) ? weapon.int_plus : 0
		n += (armor1 != nil and actor.armor1_id != 0) ? armor1.int_plus : 0
		n += (armor2 != nil and actor.armor2_id != 0) ? armor2.int_plus : 0
		n += (armor3 != nil and actor.armor3_id != 0) ? armor3.int_plus : 0
		n += (armor4 != nil and actor.armor4_id != 0) ? armor4.int_plus : 0
		if @int_plus != n
			@text6_2.dispose
			@text6_2 = J::Text_Box.new(self)
			@text6_2.set("tb_2", 2).refresh(36, 0)
			@text6_2.x = @text6.x + @text6.width - 1
			@text6_2.y = @text5.y + @text5.height + 1
			@text6_2.font.alpha = 1
			@text6_2.bitmap.font.size = 12
			@text6_2.bitmap.font.color.set(0, 0, 255, 255)
			@text6_2.bitmap.draw_text(0, 1, @text6_2.width, @text6_2.height, "(+" + n.to_s + ")", 1)
			@int_plus = n
		end
		if @int != actor.int
			@text6_3.dispose
			@text6_3 = J::Text_Box.new(self)
			@text6_3.set("tb_3", 2).refresh(54, 0)
			@text6_3.x = @text6_2.x + @text6_2.width - 1
			@text6_3.y = @text5.y + @text5.height + 1
			@text6_3.font.alpha = 1
			@text6_3.bitmap.font.size = 12
			@text6_3.bitmap.font.color.set(0, 0, 0, 255)
			@text6_3.bitmap.draw_text(0, 1, @text6_3.width - 5, @text6_3.height, actor.int.to_s, 2)
			@int = actor.int
		end
		if @weapon and @weapon.double_click
			$game_party.actors[0].equip(0, 0)
			Audio.se_play("Audio/SE/장")
		elsif @armor1 and @armor1.double_click
			$game_party.actors[0].equip(1, 0)
			Audio.se_play("Audio/SE/장")
		elsif @armor2 and @armor2.double_click
			$game_party.actors[0].equip(2, 0)
			Audio.se_play("Audio/SE/장")
		elsif @armor3 and @armor3.double_click
			$game_party.actors[0].equip(3, 0)
			Audio.se_play("Audio/SE/장")
		elsif @armor4 and @armor4.double_click
			$game_party.actors[0].equip(4, 0)
			Audio.se_play("Audio/SE/장")
		end
		if @weapon_id != $game_party.actors[0].weapon_id
			@weapon_id = $game_party.actors[0].weapon_id
			@weapon ? (@weapon.dispose; @weapon = nil) : 0
			if @weapon_id != 0
				@weapon = J::Item.new(self).refresh(@weapon_id, 1)
				@weapon.y = 125
			end
		end
		if @armor1_id != $game_party.actors[0].armor1_id
			@armor1_id = $game_party.actors[0].armor1_id
			@armor1 ? (@armor1.dispose; @armor1 = nil) : 0
			if @armor1_id != 0
				@armor1 = J::Item.new(self).refresh(@armor1_id, 2)
				@armor1.x = 108
				@armor1.y = 125
			end
		end
		if @armor2_id != $game_party.actors[0].armor2_id
			@armor2_id = $game_party.actors[0].armor2_id
			@armor2 ? (@armor2.dispose; @armor2 = nil) : 0
			if @armor2_id != 0
				@armor2 = J::Item.new(self).refresh(@armor2_id, 2)
				@armor2.x = 36
				@armor2.y = 125
			end
		end
		if @armor3_id != $game_party.actors[0].armor3_id
			@armor3_id = $game_party.actors[0].armor3_id
			@armor3 ? (@armor3.dispose; @armor3 = nil) : 0
			if @armor3_id != 0
				@armor3 = J::Item.new(self).refresh(@armor3_id, 2)
				@armor3.x = 72
				@armor3.y = 125
			end
		end
		if @armor4_id != $game_party.actors[0].armor4_id
			@armor4_id = $game_party.actors[0].armor4_id
			@armor4 ? (@armor4.dispose; @armor4 = nil) : 0
			if @armor4_id != 0
				@armor4 = J::Item.new(self).refresh(@armor4_id, 2)
				@armor4.x = 144
				@armor4.y = 125
			end
		end
	end
end
