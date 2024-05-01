if User_Edit::VISUAL_EQUIP_ACTIVE
	
	class Sprite_NetCharacter < RPG::Sprite
		@@body = "Nada"
		
		alias global_ve_initialize initialize
		def initialize(viewport, id, character = nil)
			@equips_id = [0, 0, 0, 0, 0]
			global_ve_initialize(viewport, id, character)
			@actor = @character
		end
		
		def equip_char_array
			equips = []
			equips.push([@@body, 0])
			item = equip_character(0, net_actor_equip_id(0, self))
			equips.push(item) unless item == false
			equips.push([@character.character_name, @character_hue])
			for i in 1..4
				item = equip_character(i, net_actor_equip_id(i, self))
				equips.push(item) unless item == false
			end
			return equips
		end
		
		def update_tile
			@tile_id = @character.tile_id
			@character_name = @character.character_name
			@character_hue = @character.character_hue
			if @tile_id >= 384
				self.bitmap = RPG::Cache.tile($game_map.tileset_name, @tile_id, @character.character_hue)
				self.src_rect.set(0, 0, 32, 32)
				self.ox = 16
				self.oy = 32
			else
				equips = []
				equips = equip_char_array
				
				self.bitmap.dispose unless self.bitmap == nil
				bmp = RPG::Cache.character(@character_name, @character_hue)
				self.bitmap = Bitmap.new(bmp.width, bmp.height)
				src_rect = Rect.new(0, 0, bmp.width, bmp.height)
				if equips.size > 0 and bmp.width == 236 and bmp.height == 236 # 사람 캐릭터
					size = equips.size -1
					for i in 0..size
						next if equips[i] == false or equips[i][0] == false or equips[i][0] == nil
						bmp2 = RPG::Cache.character(equips[i][0], equips[i][1].to_i)
						
						t_val = 255
						if @character.is_transparency # 투명임
							ok = $net_party_manager.party_members.include? @character.name.to_s
							t_val = ok ? 125 : 0
						end
						self.bitmap.blt(0, 0, bmp2, src_rect, t_val)
					end
				else # 둔갑임
					t_val = 255
					if @character.is_transparency # 투명?
						ok = $net_party_manager.party_members.include? @character.name.to_s
						t_val = ok ? 125 : 0
					end
					self.bitmap.blt(0, 0, bmp, src_rect, t_val)
				end
				
				@cw = bitmap.width / 4
				@ch = bitmap.height / 4
				self.ox = @cw / 2
				self.oy = @ch
			end
		end
		
		def net_actor_equip_id(i, actor)
			case i
				# tem que prestar atenção no script Game_NetActor
			when 0 # Body
				return @character.armor2_id
			when 1 # Helmet
				return @character.armor3_id
			when 2 # Weapon
				return @character.weapon_id
			when 3 # Accessory
				return @character.armor2_id
			when 4 # Shield
				return @character.armor1_id
			end
		end
		
	end
	
	class Game_NetPlayer
		@@body = "Nada"
		def equip_char_array
			equips = []
			equips.push([@@body, 0])
			item = equip_character(0, net_actor_equip_id(0, self))
			equips.push(item) unless item == false
			equips.push([@character_name, @character_hue])
			for i in 1..4
				item = equip_character(i, net_actor_equip_id(i, self))
				equips.push(item) unless item == false
			end
			return equips
		end
		
		def net_actor_equip_id(i, actor)
			case i
				# tem que prestar atenção no script Game_NetActor
			when 0 # Body
				return @armor2_id
			when 1 # Helmet
				return @armor3_id
			when 2 # Weapon
				return @weapon_id
			when 3 # Accessory
				return @armor2_id
			when 4 # Shield
				return @armor1_id
			end
		end
		
		def new_equip?
			if @ove[0] != @weapon_id
				@ove = [@weapon_id, @armor1_id, @armor2_id, @armor3_id, @armor4_id]
				return true
			elsif @ove[1] != @armor1_id
				@ove = [@weapon_id, @armor1_id, @armor2_id, @armor3_id, @armor4_id]
				return true
			elsif @ove[2] != @armor2_id
				@ove = [@weapon_id, @armor1_id, @armor2_id, @armor3_id, @armor4_id]
				return true
			elsif @ove[3] != @armor3_id
				@ove = [@weapon_id, @armor1_id, @armor2_id, @armor3_id, @armor4_id]
				return true
			elsif @ove[4] != @armor4_id
				@ove = [@weapon_id, @armor1_id, @armor2_id, @armor3_id, @armor4_id]
				return true
			end
			return false
		end
	end
	
end