#==============================================================================
# ** Event Text Display
#==============================================================================
# Created By: ÁØµ¹
# Modified By: SephirothSpawn
# Modified By: Me™
# Version 2.1
# 2006-03-04
#==============================================================================
# * Instructions :
#
#  ~ Creating Event With Test Display
#   - Put a Comment on the Page With
#   [CD____]
#   - Place Text to Be Displayed in the Blank
#------------------------------------------------------------------------------
# * Customization :
#
#  ~ NPC Event Colors
#   - Event_Color = Color
#
#  ~ Player Event Color
#   - Player_Color = Color
#
#  ~ Player Text
#   - Player_Text = text_display *
#
#  ~ text_display
#   - 'Name', 'Class', 'Level', 'Hp', 'Sp'
#==============================================================================

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
		Event_Color = Color.new(0, 200, 0)
		Player_Color = Color.new(255, 255, 255)
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
		#--------------------------------------------------------------------------
		# * Alias Listings
		#--------------------------------------------------------------------------
		alias seph_characterdisplay_gevent_refresh refresh
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			# Original Refresh Method
			seph_characterdisplay_gevent_refresh
			# Checks to see if display text
			# If the name contains CD, it takes the rest of the name as the text
			unless @list.nil?
				for i in 0...@list.size
					if @list[i].code == 108
						@list[i].parameters[0].dup.gsub!(/\[[Cc][Dd](.+?)\]/) do
							@text_display = [$1, Event_Color]
						end
					end
				end
			end
			@text_display = nil if @erased
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
		# * Create Display Sprite
		#--------------------------------------------------------------------------
		def create_display_sprite(args)
			# Creates Display Bitmap
			bitmap = Bitmap.new(160, 24)
			# Draws Text Shadow
			bitmap.font.draw_shadow = false  if bitmap.font.respond_to?(:draw_shadow)
			bitmap.font.color = Color.new(0, 0, 0)
			bitmap.draw_text(1, 1, 160, 24, args[0], 1)
			# Changes Font Color
			bitmap.font.color = args[1]
			# Draws Text
			bitmap.draw_text(0, 0, 160, 24, args[0], 1)
			# Creates Display Text Sprite
			@_text_display = Sprite.new(self.viewport)
			@_text_display.bitmap = bitmap
			@_text_display.ox = 80
			@_text_display.oy = 24
			@_text_display.x = self.x
			@_text_display.y = self.y - self.oy / 2 - 24
			@_text_display.z = 30001
			@_text_display.visible = self.visible #true
		end
		#--------------------------------------------------------------------------
		# * Dispose Display Sprite
		#--------------------------------------------------------------------------
		def dispose_display_text
			@_text_display.dispose unless @_text_display.nil?
		end
		#--------------------------------------------------------------------------
		# * Update Display Sprite
		#--------------------------------------------------------------------------
		def update_display_text
			unless @character.text_display.nil?
				create_display_sprite(@character.text_display) if @_text_display.nil?
				@_text_display.x = self.x
				@_text_display.y = self.y - self.oy / 2 - 24
			else
				dispose_display_text unless @_text_display.nil?
			end
		end
	end
	#--------------------------------------------------------------------------
	# * End SDK Enable Test
	#--------------------------------------------------------------------------
end