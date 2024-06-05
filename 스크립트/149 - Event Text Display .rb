#------------------------------------------------------------------------------
# * SDK Log Script
#------------------------------------------------------------------------------
SDK.log('Event Text Display', 'SephirothSpawn', 2, '2006-03-04')
#------------------------------------------------------------------------------
# * Begin SDK Enable Test
#------------------------------------------------------------------------------
if SDK.state('Event Text Display') == true
	#==============================================================================
	# ** Game_Character
	#==============================================================================
	class Game_Character
		#--------------------------------------------------------------------------
		# * Dispaly Text Color (Event & Player)
		#--------------------------------------------------------------------------
		Event_Color = Color.new(180, 255, 180)
		Enemy_Color = Color.new(255, 87, 87)
		Item_Color = Color.new(180, 180, 255)
		Player_Color = Color.new(255, 255, 255)
		NetPlayer_Color = Color.new(250, 219, 150)
		#--------------------------------------------------------------------------
		# * Display Choices
		# ~ 'Name', 'Class', 'Level', 'Hp', 'Sp'
		#--------------------------------------------------------------------------
		Player_Text = 'Name'
		#--------------------------------------------------------------------------
		# * Public Instance Variables
		#--------------------------------------------------------------------------
		attr_accessor :text_display
	end
	
	#==============================================================================
	# ** Game_Event
	#==============================================================================
	class Game_Event < Game_Character 
		alias seph_characterdisplay_gevent_refresh refresh
		def name=(name)
			@event.name = name
		end
		
		def refresh 
			seph_characterdisplay_gevent_refresh 
			text = @event.name.dup 
			text.gsub!(/\[[Ii][Dd](.+?)\]/) do 
				@text_display = [$1, Event_Color]
				@text_display = [$1, Enemy_Color] if $ABS.enemies[event.id] != nil
				@text_display = [$1, Item_Color] if $Drop[id] != nil
			end 
			@text_display = nil if @erased 
			@text_display = nil if @character_name == "" 
		end 
	end 
	
	#==============================================================================
	# ** Game_Player
	#==============================================================================
	class Game_Player < Game_Character
		#--------------------------------------------------------------------------
		# * Alias Listings
		#--------------------------------------------------------------------------
		alias seph_characterdisplay_gplayer_refresh refresh
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			# Original Refresh Method
			seph_characterdisplay_gplayer_refresh
			# Gets First Actor
			for i in 0...$game_party.actors.size
				actor = $game_party.actors[i] 
			end
			# Determines Text
			case Player_Text
			when 'Name'
				txt = $game_party.actors[0].name 
			when 'Class'
				txt = actor.class_name
			when 'Level'
				txt = "Level: #{actor.level}"
			when 'Hp'
				txt = "HP: #{actor.hp} / #{actor.maxhp}"
			when 'Sp'
				txt = "SP: #{actor.sp} / #{actor.maxsp}"
			else
				txt = ''
			end
			# Creates Text Display
			@text_display = [txt, Player_Color]
		end
	end
	
	class Game_NetPlayer < Game_Character
		alias seph_character_display_netplayer_refresh refresh
		
		def refresh(data)
			seph_character_display_netplayer_refresh(data)
			@text_display = [@name, NetPlayer_Color]
		end
	end
	
	
	#==============================================================================
	# ** Sprite_Character
	#==============================================================================
	class Sprite_Character < RPG::Sprite
		#--------------------------------------------------------------------------
		# * Alias Listings
		#--------------------------------------------------------------------------
		alias seph_characterdisplay_scharacter_update update
		#--------------------------------------------------------------------------
		# * Frame Update
		#--------------------------------------------------------------------------
		def update
			# Original update Method
			seph_characterdisplay_scharacter_update
			# Character Display Update Method
			update_display_text
		end
		#--------------------------------------------------------------------------
		# * Update Display Sprite
		#--------------------------------------------------------------------------
		def update_display_text
			unless @character.text_display.nil?
				create_display_sprite(@character.text_display) if @_text_display.nil?
				@_text_display.x = self.x
				@_text_display.y = self.y - self.oy
				@_text_display.y = self.y - self.oy + 10 if @character.is_a?(Game_Player)
			else
				dispose_display_text unless @_text_display.nil?
			end
		end
		
		def toggle_id
			return if @_text_display == nil or @_text_display.disposed?
			if $game_variables[11] == 0
				@_text_display.visible = false 
			else
				@_text_display.visible = true
			end
		end
		
		#--------------------------------------------------------------------------
		# * Create Display Sprite
		#--------------------------------------------------------------------------
		def create_display_sprite(args)
			bitmap = Bitmap.new(160, 20)
			bitmap.font.name = "맑은 고딕"
			bitmap.font.size = 15
			bitmap.font.color = args[1]
			bitmap.draw_frame_text(0, 0, 160, 15, args[0], 1)
			
			# Creates Display Text Sprite
			@_text_display = Sprite.new(self.viewport)
			@_text_display.bitmap = bitmap
			@_text_display.ox = 80
			@_text_display.oy = 20
			@_text_display.x = self.x
			@_text_display.y = self.y - self.oy
			@_text_display.z = 1000
			@_text_display.visible = self.visible #true
		end
		#--------------------------------------------------------------------------
		# * Dispose Display Sprite
		#--------------------------------------------------------------------------
		def dispose_display_text
			unless @_text_display.nil?
				@_text_display.dispose
				@_text_display = nil
			end
		end
	end
	
	class Sprite_NetCharacter < Sprite_Character 
		#--------------------------------------------------------------------------
		# * Disposes Text
		#--------------------------------------------------------------------------
		def dispose
			@_text_display.dispose
			@_text_display = nil
			super
		end
		
		#--------------------------------------------------------------------------
		# * Creates Display Text Sprite
		#--------------------------------------------------------------------------
		def create_display_sprite(args)
			bitmap = Bitmap.new(160, 100)
			draw_text(bitmap, args)
			
			@_text_display = Sprite.new(self.viewport)
			@_text_display.bitmap = bitmap
			@_text_display.ox = 80
			@_text_display.oy = 24
			@_text_display.z = 30000
			@_text_display.visible = self.visible
		end
		
		#--------------------------------------------------------------------------
		# * Draws Text on Bitmap
		#--------------------------------------------------------------------------
		def draw_text(bitmap, args)
			font_size = 15
			bitmap.font.name = "맑은 고딕"
			bitmap.font.size = font_size
			bitmap.font.color = Color.new(0, 0, 0)
			bitmap.draw_text(1, 1, bitmap.width, font_size, "Lv: #{@level}", 1)
			
			bitmap.font.color = Color.new(255, 255, 255)
			bitmap.draw_text(0, 0, bitmap.width, font_size, "Lv: #{@level}", 1)
			
			bitmap.font.color = Color.new(-204, 0, 204)
			bitmap.draw_text(0, 0, bitmap.width, font_size, @character.guild.to_s, 1)
			
			bitmap.font.color = args[1]
			bitmap.draw_frame_text(0, font_size, bitmap.width, font_size, @name.to_s, 1)
		end
		
		#--------------------------------------------------------------------------
		# * Update Display Sprite
		#--------------------------------------------------------------------------
		def update_display_text
			unless @character.text_display.nil?
				create_display_sprite(@character.text_display) if @_text_display.nil?
				update_visibility
				@_text_display.x = self.x
				@_text_display.y = self.y - self.oy / 2 - 24
			else
				dispose_display_text unless @_text_display.nil?
			end
		end
		
		#--------------------------------------------------------------------------
		# * Updates visibility based on transparency
		#--------------------------------------------------------------------------
		def update_visibility
			ok = $net_party_manager.is_party_member?(@character.name)
			self.visible = @character.is_transparency ? ok : true
			@_text_display.visible = @character.is_transparency ? ok : true
		end
	end
	
	#--------------------------------------------------------------------------
	# * End SDK Enable Test
	#--------------------------------------------------------------------------
	class Spriteset_Map
		def toggle_id
			$game_variables[11] = $game_variables[11] == 0 ? 1 : 0
			
			for sprite in @character_sprites
				sprite.toggle_id
			end
		end
	end
end


