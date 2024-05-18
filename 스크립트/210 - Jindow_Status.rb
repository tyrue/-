#==============================================================================
# ■ Jindow_Status
#------------------------------------------------------------------------------
#   캐릭터 정보 창
#------------------------------------------------------------------------------
class Jindow_Status < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 400, 180)
		self.name = "상태 정보"
		@head, @mark, @drag, @close = true, true, true, true
		@route = "Graphics/Jindow/" + @skin + "/Window/"
		
		self.refresh("Status")
		self.x, self.y = 41, 105
		
		@actor = $game_party.actors[0]
		
		setup_equipment
		setup_character
		setup_status
		setup_stats
	end
	
	def setup_equipment
		@equip = []
		@armor_id = [
			@actor.weapon_id, 
			@actor.armor2_id,
			@actor.armor3_id,
			@actor.armor1_id,
			@actor.armor4_id
		]
		@armor_name = ["무기", "투구", "갑옷", "보조", "반지"]
		@armor, @armor_n, @armor_i = [], [], []
		
		itemwin_mid = Bitmap.new(@route + "itemwin_mid")
		(0..4).each do |i|
			setup_single_equip(i, itemwin_mid)
		end
	end
	
	def setup_single_equip(i, itemwin_mid)
		@armor_n[i] = Sprite.new(self)
		@armor_n[i].bitmap = Bitmap.new(100, 20)
		@armor_n[i].x, @armor_n[i].y = 36 * i, 115
		@armor_n[i].bitmap.font.size = 12
		@armor_n[i].bitmap.font.color.set(0, 0, 0, 255)
		@armor_n[i].bitmap.draw_text(0, 0, 100, 20, @armor_name[i], 0)
		
		@equip[i] = Sprite.new(self)
		@equip[i].bitmap = Bitmap.new(@route + "item_win")
		@equip[i].bitmap.blt(1, 1, itemwin_mid, itemwin_mid.rect)
		@equip[i].x, @equip[i].y = @armor_n[i].x, @armor_n[i].y + 20
		
		if @armor_id[i] != 0
			@armor_i[i] = J::Item.new(self).refresh(@armor_id[i], i == 0 ? 1 : 2)
			@armor_i[i].x, @armor_i[i].y = @equip[i].x, @equip[i].y 
		end
	end
	
	def setup_character
		@character = Sprite.new(self)
		@character.bitmap = Bitmap.new(@route + "character_win")
		@character.y = 10
		
		draw_actor(@actor, @character)
	end
	
	def setup_status
		@state = []
		@state_name = generate_state_names(@actor)
		@state_name.each_with_index do |name, i|
			@state[i] = Sprite.new(self)
			@state[i].bitmap = Bitmap.new(180, 20)
			if i <= 6
				@state[i].x, @state[i].y = 80, 15 * i
			else
				@state[i].x, @state[i].y = 245, 100 + 15 * (i - 7)
			end
			@state[i].bitmap.font.size = 12
			@state[i].bitmap.font.color.set(0, 0, 0, 255)
			@state[i].bitmap.draw_text(0, 0, 180, 20, name, 0)
		end
	end
	
	def generate_state_names(actor)
		[
			"이름: " + actor.name,
			"레벨: " + actor.level.to_s,
			"직업: " + actor.class_name,
			"체력: " + change_number_unit(actor.hp.to_s) + "/" + change_number_unit(actor.maxhp.to_s),
			"마력: " + change_number_unit(actor.sp.to_s) + "/" + change_number_unit(actor.maxsp.to_s),
			"경험치: " + change_number_unit(actor.exp.to_s) + "/" + change_number_unit(actor.exp_list[actor.level + 1].to_s),
			"금전: " + change_number_unit($game_party.gold.to_s),
			"공격력: " + actor.base_atk.to_s,
			"물리 방어력: " + actor.base_pdef.to_s,
			"마법 방어력: " + actor.base_mdef.to_s,
			"회피율: " + actor.base_eva.to_s
		]
	end
	
	def setup_stats
		@guild = Sprite.new(self)
		@guild.bitmap = Bitmap.new(180, 20)
		@actor_guild = $guild
		
		@stat = Sprite.new(self)
		@stat.bitmap = Bitmap.new(100, 20)
		@stat.x = 210
		@stat.bitmap.font.size = 12
		@stat.bitmap.font.color.set(0, 0, 0, 255)
		@stat.bitmap.draw_text(0, 0, 100, 20, "능력치: ", 1)
		
		@state2_name = ["힘", "손재주", "민첩", "지력"]
		@state2_v = [
			@actor.str,
			@actor.dex,
			@actor.agi,
			@actor.int
		]
		
		@state_plus = setup_stat_bonuses
		setup_stat_boxes
	end
	
	def setup_stat_bonuses
		stats = [0, 0, 0, 0]
		weapons_and_armors = [
			$data_weapons[@actor.weapon_id],
			$data_armors[@actor.armor1_id],
			$data_armors[@actor.armor2_id],
			$data_armors[@actor.armor3_id],
			$data_armors[@actor.armor4_id]
		]
		
		weapons_and_armors.each do |item|
			next unless item
			
			stats[0] += item.str_plus
			stats[1] += item.dex_plus
			stats[2] += item.agi_plus
			stats[3] += item.int_plus
		end
		return stats
	end
	
	def setup_stat_boxes
		@state2, @state2_2, @state2_3 = [], [], []
		(0..3).each do |i|
			@state2[i] = J::Text_Box.new(self).set("tb_2", 2).refresh(44, 0)
			@state2[i].x, @state2[i].y = 245, 14 * (i + 1) + 5
			@state2[i].font.alpha = 1
			@state2[i].bitmap.font.size = 12
			@state2[i].bitmap.font.color.set(0, 0, 0, 255)
			@state2[i].bitmap.draw_text(0, 0, @state2[i].width, @state2[i].height, @state2_name[i], 1)
			
			@state2_2[i] = J::Text_Box.new(self).set("tb_2", 2).refresh(36, 0)
			@state2_2[i].x, @state2_2[i].y = @state2[i].x + @state2[i].width - 1, @state2[i].y
			@state2_2[i].font.alpha = 1
			@state2_2[i].bitmap.font.size = 12
			@state2_2[i].bitmap.font.color.set(0, 0, 255, 255)
			@state2_2[i].bitmap.draw_text(0, 0, @state2_2[i].width, @state2_2[i].height, "(+" + @state_plus[i].to_s + ")", 1)
			
			@state2_3[i] = J::Text_Box.new(self).set("tb_2", 2).refresh(36, 0)
			@state2_3[i].x, @state2_3[i].y = @state2_2[i].x + @state2_2[i].width - 1, @state2_2[i].y
			@state2_3[i].font.alpha = 1
			@state2_3[i].bitmap.font.size = 12
			@state2_3[i].bitmap.font.color.set(0, 0, 0, 255)
			@state2_3[i].bitmap.draw_text(0, 0, @state2_3[i].width, @state2_3[i].height, @state2_v[i].to_s, 1)
		end
	end
	
	def update
		check_position
		super
		refresh_status(@actor)
		refresh_stats(@actor)
		refresh_equipment(@actor)
	end
	
	def check_position
		self.x != 242
		self.y != 132
	end
	
	def refresh_status(actor)
		new_status = generate_state_names(actor)
		new_status.each_with_index do |state, i|
			if @state_name[i] != state
				refresh_state_sprite(i, state)
				@state_name[i] = state
			end
		end
	end
	
	def refresh_state_sprite(index, state)
		@state[index].dispose
		@state[index] = Sprite.new(self)
		@state[index].bitmap = Bitmap.new(180, 20)
		@state[index].x = index <= 6 ? 80 : 245
		@state[index].y = index <= 6 ? 15 * index : 100 + 15 * (index - 7)
		@state[index].bitmap.font.size = 12
		@state[index].bitmap.font.color.set(0, 0, 0, 255)
		@state[index].bitmap.draw_text(0, 0, 180, 20, state, 0)
	end
	
	def refresh_stats(actor)
		new_stats = setup_stat_bonuses
		new_stat_values = [actor.str, actor.dex, actor.agi, actor.int]
		
		(0..3).each do |i|
			refresh_single_stat(i, new_stats[i], new_stat_values[i])
		end
	end
	
	def refresh_single_stat(index, new_stat_plus, new_stat_value)
		if @state_plus[index] != new_stat_plus
			refresh_stat_bonus(index, new_stat_plus)
			@state_plus[index] = new_stat_plus
		end
		if @state2_v[index] != new_stat_value
			refresh_stat_value(index, new_stat_value)
			@state2_v[index] = new_stat_value
		end
	end
	
	def refresh_stat_bonus(index, new_stat_plus)
		@state2_2[index].dispose
		@state2_2[index] = J::Text_Box.new(self).set("tb_2", 2).refresh(36, 0)
		@state2_2[index].x = @state2[index].x + @state2[index].width - 1
		@state2_2[index].y = @state2[index].y
		@state2_2[index].font.alpha = 1
		@state2_2[index].bitmap.font.size = 12
		@state2_2[index].bitmap.font.color.set(0, 0, 255, 255)
		@state2_2[index].bitmap.draw_text(0, 0, @state2_2[index].width, @state2_2[index].height, "(+" + new_stat_plus.to_s + ")", 1)
	end
	
	def refresh_stat_value(index, new_stat_value)
		@state2_3[index].dispose
		@state2_3[index] = J::Text_Box.new(self).set("tb_3", 2).refresh(34, 0)
		@state2_3[index].x = @state2_2[index].x + @state2_2[index].width - 1
		@state2_3[index].y = @state2[index].y
		@state2_3[index].font.alpha = 1
		@state2_3[index].bitmap.font.size = 12
		@state2_3[index].bitmap.font.color.set(0, 0, 0, 255)
		@state2_3[index].bitmap.draw_text(0, 1, @state2_3[index].width - 5, @state2_3[index].height, new_stat_value.to_s, 2)
	end
	
	def refresh_equipment(actor)
		check_item_double_click
		
		new_armor_ids = [
			actor.weapon_id,
			actor.armor2_id,
			actor.armor3_id,
			actor.armor1_id,
			actor.armor4_id
		]
		
		equip_change = false
		new_armor_ids.each_with_index do |new_id, i|
			if @armor_id[i] != new_id
				equip_change = true
				refresh_single_equipment(i, new_id)
				@armor_id[i] = new_id
			end
		end
		
		draw_actor(actor, @character) if equip_change
	end
	
	def check_item_double_click
		arr = [0, 2, 3, 1, 4]
		(0..4).each do |i|
			next unless @armor_i[i]
			next unless @armor_i[i].double_click
			
			$game_party.actors[0].equip(arr[i], 0)
			Audio.se_play("Audio/SE/장", $game_variables[13])
		end
	end
	
	def refresh_single_equipment(index, new_id)
		@armor_i[index].dispose if @armor_i[index] != nil
		@armor_i[index] = nil
		return if new_id.zero?
		
		@armor_i[index] = J::Item.new(self).refresh(new_id, index == 0 ? 1 : 2)
		@armor_i[index].y = 135
		@armor_i[index].x = 36 * index
	end
		
	def draw_actor(actor, character)
		@s.dispose if @s != nil
		@s = Sprite.new(self)
		
		bmp = RPG::Cache.character(actor.character_name, actor.character_hue)
		bitmap = Bitmap.new(bmp.width, bmp.height)
		src_rect = Rect.new(0, 0, bmp.width, bmp.height)
		
		# Setup actor equipment
		equips = equip_char_array(actor)
		bitmap.blt(0, 0, bmp, src_rect, 255)
		# If character fits the size
		if equips.size > 0 && bmp.width == 236 && bmp.height == 236
			blit_equipment(equips, src_rect, bitmap)
		end
		
		cw = bitmap.width / 4
		ch = bitmap.height / 4
		src_rect = Rect.new(0, 0, cw, ch)
		
		@s.bitmap = Bitmap.new(cw, ch)
		@s.bitmap.blt(0, 0, bitmap, src_rect)
		@s.x = (character.width - @s.width) / 2
		@s.y = character.height - @s.height - 10 + character.y
	end
	
	def blit_equipment(equips, src_rect, bitmap)
		equips.each do |equip|
			next if equip.nil? || equip[0].nil?
			bmp2 = RPG::Cache.character(equip[0], equip[1].to_i)
			bitmap.blt(0, 0, bmp2, src_rect, 255)
		end
	end
end
