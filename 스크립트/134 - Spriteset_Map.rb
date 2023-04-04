#============================================================================
# ■ Spriteset Map
#============================================================================

class Spriteset_Map
	#--------------------------------------------------------------------------
	alias net_spr_spriteset_map_init_characters init_characters
	alias net_spr_spriteset_map_dispose dispose
	alias net_spr_spriteset_map_update update
	alias net_spr_spriteset_map_update_character_sprites update_character_sprites
	#--------------------------------------------------------------------------
	attr_accessor :network_sprites
	attr_accessor :charsprite
	#--------------------------------------------------------------------------
	# * Object Initialization
	#--------------------------------------------------------------------------
	def init_characters
		net_spr_spriteset_map_init_characters
		@network_sprites = {}
		for sprite in Network::Main.mapplayers.values
			next if sprite == nil
			next if sprite.netid.to_i ==  Network::Main.id.to_i
			next if sprite.character_name == nil or sprite.character_name == ""
			next if sprite.map_id != $game_map.map_id
			nsprite = Sprite_NetCharacter.new(@viewport1, sprite.netid.to_i, sprite)
			@network_sprites[sprite.netid.to_i] = nsprite
		end
	end
	#--------------------------------------------------------------------------
	def dispose
		# Network Sprites
		for nsprite in @network_sprites.values
			nsprite.dispose if nsprite != nil and not nsprite.disposed?
		end
		@charsprite.dispose if @charsprite != nil and not @charsprite.disposed?
		net_spr_spriteset_map_dispose
	end
	#--------------------------------------------------------------------------
	# * Updates the Sprites
	#--------------------------------------------------------------------------
	def update
		if $game_temp.spriteset_refresh == true
			$game_temp.spriteset_refresh = false
			# Network Sprites
			for nsprite in @network_sprites.values
				nsprite.dispose if nsprite != nil and not nsprite.disposed?
			end
			@network_sprites = {}
			for sprite in Network::Main.mapplayers.values
				next if sprite == nil
				next if sprite.netid.to_i ==  Network::Main.id.to_i
				next if sprite.character_name == nil or sprite.character_name == ""
				next if sprite.map_id != $game_map.map_id
				nsprite = Sprite_NetCharacter.new(@viewport1, sprite.netid.to_i, sprite)
				@network_sprites[sprite.netid.to_i] = nsprite
			end
		end
		net_spr_spriteset_map_update
	end
	#--------------------------------------------------------------------------
	# * Updates the Character Sprites
	#--------------------------------------------------------------------------
	def update_character_sprites
		net_spr_spriteset_map_update_character_sprites
		for nsprite in @network_sprites.values
			nsprite.update
		end
	end
end
