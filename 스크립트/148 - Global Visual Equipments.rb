#~ if User_Edit::VISUAL_EQUIP_ACTIVE
	
	#~ class Sprite_NetCharacter < Sprite_Character 
		#~ @@body = "Nada"
		#~ alias global_ve_initialize initialize
		
		#~ def initialize(viewport, id, character = nil)
			#~ @equips_id = [0, 0, 0, 0, 0]
			#~ global_ve_initialize(viewport, id, character)
			#~ @actor = @character
		#~ end
		
		#~ def equip_char_array
			#~ equips = []
			#~ equips.push([@@body, 0])
			#~ equips.push([@character.character_name, @character_hue])
			#~ (0..4).each do |i|
				#~ item = equip_character(i, net_actor_equip_id(i))
				#~ equips.push(item) unless item == false
			#~ end
			#~ equips.compact
		#~ end
		
		#~ def update_character_bitmap
			#~ update_character_properties
			#~ if @tile_id >= 384
				#~ set_tile_bitmap
			#~ else
				#~ set_character_bitmap
			#~ end
			#~ @character.equip_change = false
		#~ end
		
		#~ def update_character_properties
			#~ @tile_id = @character.tile_id
			#~ @character_name = @character.character_name
			#~ @character_hue = @character.character_hue
		#~ end
		
		#~ def set_tile_bitmap
			#~ self.bitmap = RPG::Cache.tile($game_map.tileset_name, @tile_id, @character_hue)
			#~ self.src_rect.set(0, 0, 32, 32)
			#~ self.ox = 16
			#~ self.oy = 32
		#~ end
		
		#~ def set_character_bitmap
			#~ equips = equip_char_array
			#~ self.bitmap.dispose unless self.bitmap.nil?
			#~ bmp = RPG::Cache.character(@character_name, @character_hue)
			#~ self.bitmap = Bitmap.new(bmp.width, bmp.height)
			#~ src_rect = Rect.new(0, 0, bmp.width, bmp.height)
			
			#~ if equips.size > 0 && bmp.width == 236 && bmp.height == 236
				#~ blit_equipment(equips, src_rect)
			#~ else
				#~ blit_default_character(bmp, src_rect)
			#~ end
			
			#~ @cw = bitmap.width / 4
			#~ @ch = bitmap.height / 4
			#~ self.ox = @cw / 2
			#~ self.oy = @ch
		#~ end
		
		#~ def blit_equipment(equips, src_rect)
			#~ equips.each do |equip|
				#~ next if equip.nil? || equip[0].nil?
				#~ bmp2 = RPG::Cache.character(equip[0], equip[1].to_i)
				#~ t_val = @character.is_transparency ? transparency_value : 255
				#~ self.bitmap.blt(0, 0, bmp2, src_rect, t_val)
			#~ end
		#~ end
		
		#~ def blit_default_character(bmp, src_rect)
			#~ t_val = @character.is_transparency ? transparency_value : 255
			#~ self.bitmap.blt(0, 0, bmp, src_rect, t_val)
		#~ end
		
		#~ def transparency_value
			#~ $net_party_manager.party_members.include?(@character.name.to_s) ? 125 : 0
		#~ end
		
		#~ def net_actor_equip_id(i)
			#~ case i
			#~ when 0 then @character.armor2_id
			#~ when 1 then @character.armor3_id
			#~ when 2 then @character.weapon_id
			#~ when 3 then @character.armor2_id
			#~ when 4 then @character.armor1_id
			#~ end
		#~ end
	#~ end
	
	#~ class Game_NetPlayer
		#~ @@body = "Nada"
		
		#~ def equip_char_array
			#~ equips = []
			#~ equips.push([@@body, 0])
			#~ equips.push(equip_character(0, net_actor_equip_id(0)))
			#~ equips.push([@character_name, @character_hue])
			#~ (1..4).each do |i|
				#~ item = equip_character(i, net_actor_equip_id(i))
				#~ equips.push(item) unless item == false
			#~ end
			#~ equips.compact
		#~ end
		
		#~ def net_actor_equip_id(i)
			#~ case i
			#~ when 0 then @armor2_id
			#~ when 1 then @armor3_id
			#~ when 2 then @weapon_id
			#~ when 3 then @armor2_id
			#~ when 4 then @armor1_id
			#~ end
		#~ end
		
		#~ def new_equip?
			#~ return true if @ove[0] != @weapon_id
			#~ [1, 2, 3, 4].any? do |i|
				#~ changed = @ove[i] != instance_variable_get("@armor#{i}_id")
				#~ return true if changed
			#~ end
			
			#~ return false
		#~ end
	#~ end
	
#~ end