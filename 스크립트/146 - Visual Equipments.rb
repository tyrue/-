if User_Edit::VISUAL_EQUIP_ACTIVE
	#----------------------------------------------------------------------------
	# ** Game_Actor
	#----------------------------------------------------------------------------
	class Game_Actor < Game_Battler
		attr_accessor :body
		#--------------------------------------------------------------------------
		DEFAULT_ACTOR_BODY = ['Nada', 'Nada', 'Nada', 'Nada']
		#--------------------------------------------------------------------------
		alias geso_visual_actor_init initialize
		def initialize(actor_id)
			geso_visual_actor_init(actor_id)
			@body = DEFAULT_ACTOR_BODY[actor_id]
			@trans_sw = false
		end
	end
	#----------------------------------------------------------------------------
	# ** Game_Event
	#----------------------------------------------------------------------------
	class Game_Event < Game_Character
		attr_reader :page
	end
	
	#--------------------------------------------------------------------------
	# Determines the order the equips are draw
	#--------------------------------------------------------------------------
	def actor_equip_id(i, actor)
		return if actor == nil
		case i
		when 0 then return actor.armor3_id # 갑옷
		when 1 then return actor.armor2_id # 투구
		when 2 then return actor.weapon_id # 무기
		when 3 then return actor.armor1_id # 방패
		when 4 then return actor.armor4_id # 보조
		end
	end
	
	#--------------------------------------------------------------------------
	def equip_char_array(actor)
		equips = []
		for i in 0..4
			item = equip_character(i, actor_equip_id(i, actor))
			equips.push(item) unless item == false
		end
		return equips
	end
	
	#----------------------------------------------------------------------------
	# ** Sprite_Character
	#----------------------------------------------------------------------------
	class Sprite_Character < RPG::Sprite
		#--------------------------------------------------------------------------
		alias geso_visual_equip_sprite_char_init initialize
		alias geso_visual_equip_sprite_char_update update
		
		def initialize(viewport, character = nil)
			@equips_id = [0, 0, 0, 0, 0]
			@old_trans = -2
			set_actor(character)
			geso_visual_equip_sprite_char_init(viewport, character)
		end
		
		#--------------------------------------------------------------------------
		def set_actor(character)
			@actor = $game_party.actors[0] if character.is_a?(Game_Player)
			@actor = @character if character.is_a?(Game_NetPlayer)
			return unless @actor
			
			(0..4).each do |i| 
				@equips_id[i] = actor_equip_id(i, @actor) 
			end
		end
		
		#--------------------------------------------------------------------------
		def update
			if @actor != nil
				super
				update_character_bitmap 
				update_sprite_properties
			else
				geso_visual_equip_sprite_char_update
			end
		end
		
		def update_character_bitmap
			return if !character_graphics_changed?
			
			update_character_properties
			if @tile_id >= 384
				set_tile_bitmap
			else
				set_character_bitmap
			end
		end
		
		#--------------------------------------------------------------------------
		def character_graphics_changed?
			return true if @tile_id != @character.tile_id 
			return true if @character_name != @character.character_name 
			return true if @character_hue != @character.character_hue 
			return true if check_equips_changed 
			return true if check_transparency_changed
			return false
		end
		
		#--------------------------------------------------------------------------
		def check_equips_changed
			equips_changed = false
			(0..4).each do |i|
				if @equips_id[i] != actor_equip_id(i, @actor)
					@equips_id[i] = actor_equip_id(i, @actor)
					equips_changed = true
				end
			end
			$game_temp.common_event_id = 2 if equips_changed # 둔갑 커맨드 이벤트 처리
			return equips_changed
		end
		
		#--------------------------------------------------------------------------
		def check_transparency_changed
			return false if @old_trans == $state_trans
			
			@old_trans = $state_trans
			return true
		end
		
		def update_character_properties
			@is_trans = $state_trans ? 125 : 255
			@tile_id = @character.tile_id
			@character_name = @character.character_name
			@character_hue = @character.character_hue
		end
		
		def set_tile_bitmap
			self.bitmap = RPG::Cache.tile($game_map.tileset_name, @tile_id, @character_hue)
			self.src_rect.set(0, 0, 32, 32)
			self.ox = 16
			self.oy = 32
		end
		
		#--------------------------------------------------------------------------
		def set_character_bitmap			
			equips = equip_char_array(@actor)
			self.bitmap.dispose unless self.bitmap.nil?
			
			bmp = RPG::Cache.character(@character_name, @character_hue)
			self.bitmap = Bitmap.new(bmp.width, bmp.height)
			src_rect = Rect.new(0, 0, bmp.width, bmp.height)
			
			blit_default_character(bmp, src_rect)
			if equips.size > 0 && bmp.width == 236 && bmp.height == 236
				blit_equipment(equips, src_rect)	
			end
			
			@cw = bitmap.width / 4
			@ch = bitmap.height / 4
			self.ox = @cw / 2
			self.oy = @ch
		end
		
		def blit_equipment(equips, src_rect)
			equips.each do |equip|
				next if equip.nil? || equip[0].nil?
				bmp2 = RPG::Cache.character(equip[0], equip[1].to_i)
				self.bitmap.blt(0, 0, bmp2, src_rect, 255)
			end
		end
		
		def blit_default_character(bmp, src_rect)
			self.bitmap.blt(0, 0, bmp, src_rect, 255)
		end
		
		#--------------------------------------------------------------------------
		def update_sprite_properties
			self.visible = !@character.transparent
			if @tile_id == 0
				sx = @character.pattern * @cw
				sy = (@character.direction - 2) / 2 * @ch
				self.src_rect.set(sx, sy, @cw, @ch)
			end
			self.x = @character.screen_x
			self.y = @character.screen_y
			self.z = @character.screen_z(@ch)
			self.opacity = @is_trans
			self.blend_type = @character.blend_type
			self.bush_depth = @character.bush_depth
		end
	end
	
	class Sprite_NetCharacter < Sprite_Character 
		def update_character_properties
			super
			@is_trans = transparency_value
		end
		
		def transparency_value
			return 255 if !@character.is_transparency
			return 125 if $net_party_manager.is_party_member?(@character.name.to_s)
			return 0
		end
		
		#--------------------------------------------------------------------------
		def check_transparency_changed
			return false if @old_trans == @character.is_transparency
			
			@old_trans = @character.is_transparency
			return true
		end
	end
end  