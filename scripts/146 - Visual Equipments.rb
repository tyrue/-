#==============================================================================
# ■ Visual Equipment
#------------------------------------------------------------------------------
# Geso Chisku
# Tradotto da ZeroTheQueen
# Versione 3
# 14.02.06
#==============================================================================
# CHE FA 'STO SCRIPT?
# - Mostra l'equipaggiamento del giocatore sulla mappa
# - Mostra l'equipaggiamenti degli NPC negli eventi su mappa
# - Compatibile con il caterpilliar script e l' SBABS
# - Mostra l'equipaggiamento in finestre
#------------------------------------------------------------------------------
# LAVORI FUTURI
# - Compatibilità con il Guillaume multi-equip
# - Compatibilita con il gioco online
# - Compatibilità con chara di diverse dimensioni
# - Compatibilità con ombre e riflessi (questo sarà duro da fare)
#------------------------------------------------------------------------------
# BUGS
# - Non funziona con script per ombre o riflessi
#------------------------------------------------------------------------------
# FAI LA GRAFICA PER IL TUO EQUIPAGGIAMENTO
# - Tutte le immagini devono essere grandi 128 x 192 
# - Per i personaggi principali fai solo ila testa con capelli e occhi
# - Usa i template per non sbagliare
#------------------------------------------------------------------------------
# SETTA LO SCRIPT PER IL TUO GIOCO
# Per settare il corpo dei templates, cerca "DEFAULT_ACTOR_BODY"
#
# Per settare la grafica di un equipaggiamento cerca "def equip_character"
#
# Per aggiungere equipaggiamento ad un evento, scrivi questi commenti nelle sue istruzioni:
#  Comment: Visual Equipment
#  Comment: Body [charset] [hue]
#  Comment: Armor [charset] [hue]
#  Comment: Helmet [charset] [hue]
#  Comment: Weapon [charset] [hue]
#  Comment: Accessory [charset] [hue]
#  Comment: Shield [charset] [hue]
# Cambia [charset]con il nome dell'equip o con "none"
# e [hue] con la tinta, la tinta di default è 0
#==============================================================================
#------------------------------------------------------------------------------
# * SDK Log Script
#------------------------------------------------------------------------------
=begin
if User_Edit::VISUAL_EQUIP_ACTIVE
SDK.log('Visual Equipment', 'Geso Chisku', 2, '14.02.06')
#------------------------------------------------------------------------------
# * Begin SDK Enable Test
#------------------------------------------------------------------------------
if SDK.state('Visual Equipment') == true
  #----------------------------------------------------------------------------
  # ** Game_Actor
  #----------------------------------------------------------------------------
  class Game_Actor < Game_Battler
    attr_accessor :body
    #--------------------------------------------------------------------------
    DEFAULT_ACTOR_BODY = [
    'body-male'
    ]
    #--------------------------------------------------------------------------
    alias geso_visual_actor_init initialize
    def initialize(actor_id)
      geso_visual_actor_init(actor_id)
      @body = DEFAULT_ACTOR_BODY[actor_id]
    end
    #--------------------------------------------------------------------------
    def equip_char_array
      equips = []
      item = equip_character(0, actor_equip_id(0, self))
      equips.push(item) unless item == false
#     equips.push(["body-male",0])
#     equips.push(["head_#{@capelli}",0])
       equips.push([@character_name, @character_hue])     
#     if self.is_a?(Game_Player)
#      equips.push(["body-male",0])
#      equips.push(["head_#{$game_party.actors[0].capelli}",0])
#     end      
      for i in 0..5
        item = equip_character(i, actor_equip_id(i, self))
        equips.push(item) unless item == false
      end
      return equips
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
    case i
    when 0 # Body
      return 0
    when 1 # Body
      return actor.armor3_id
    when 2 # Weapon
      return actor.weapon_id
    when 3 # Helmet
      return actor.armor2_id
    when 4 # Accessory
      return actor.armor4_id
    when 5 # Shield
      return actor.armor1_id
    end
  end
  #----------------------------------------------------------------------------
  # ** Sprite_Character
  #----------------------------------------------------------------------------
  class Sprite_Character < RPG::Sprite
    #--------------------------------------------------------------------------
    alias geso_visual_equip_sprite_char_init initialize
    def initialize(viewport, character = nil)
      if character.is_a?(Game_Player)
        @actor = $game_party.actors[0]
      elsif SDK.state('SBABS') == true and character.is_a?(Game_Ally)
        @actor = $game_party.actors[character.actor_id]
      elsif SDK.state('Caterpillar') == true and character.is_a?(Game_Party_Actor)
        @actor = character.actor
      else
        @actor = nil
      end
      @equips_id = [0, 0, 0, 0, 0]
      geso_visual_equip_sprite_char_init(viewport, character)
    end
    #--------------------------------------------------------------------------
    def equip_changed?
      if SDK.state('Caterpillar') == true
        if @character.is_a?(Game_Party_Actor)
          if @character.actor != @actor
            @actor = @character.actor
            return true
          end
        end
      end
      if SDK.state('SBABS') == true
        if @character.is_a?(Game_Ally)
          if $game_party.actors[@character.actor_id] != @actor
            return true
          end
        end
      end
      if @character.is_a?(Game_Player)
        if $game_party.actors[0] != @actor
          @actor = $game_party.actors[0]
          return true
        end
      elsif @character.is_a?(Game_Event)
        if @page != @character.page
          @page = @character.page
          return true
        end
        return false
      end
      if @actor == nil
        return false
      end
      for i in 0..5
        return true if @equips_id[i] != actor_equip_id(i, @actor)
      end
      return false
    end
    #--------------------------------------------------------------------------
    def adv_update
      @character_name = ''
      update
    end
    #--------------------------------------------------------------------------
    def update
      # If character is a event
      super
      # If tile ID, file name, hue or equipment are different from current ones
      if @tile_id != @character.tile_id or
         @character_name != @character.character_name or
         @character_hue != @character.character_hue or
         equip_changed?
        # Remember tile ID, file name and hue
        @tile_id = @character.tile_id
        @character_name = @character.character_name
        @character_hue = @character.character_hue
        # If tile ID value is valid
        if @tile_id >= 384
          self.bitmap = RPG::Cache.tile($game_map.tileset_name,
            @tile_id, @character.character_hue)
          self.src_rect.set(0, 0, 32, 32)
          self.ox = 16
          self.oy = 32
        # If tile ID value is invalid
        else
          equips = []
          # If handling a event
          if @character.is_a?(Game_Event) == true
            # Check for comment input
            parameters = SDK.event_comment_input(@character, 6, 'Visual Equipment')
            if parameters.nil?
              equips.push([@character_name, @character_hue])
            else
              for i in 0..5
                item = parameters[i].split
                hue = item.size > 2 ? item[2] : 0
                equips.push([item[1], hue]) if item[1] != 'none'
                if i == 1
                  equips.push([@character_name, @character_hue])
                end
              end
            end
          # If handling the player
          elsif @actor != nil
            equips = @actor.equip_char_array
          end
          # Dispose old bitmap
          self.bitmap.dispose unless self.bitmap == nil
          # Draws the character bitmap
          bmp = RPG::Cache.character(@character_name, @character_hue)
          self.bitmap = Bitmap.new(bmp.width, bmp.height)
          src_rect = Rect.new(0, 0, bmp.width, bmp.height)
                 
          # If character fits the size
          if equips.size > 0 and bmp.width == 128 and bmp.height == 192
            size = equips.size -1
            for i in 0..size
              next if equips[i] == false or equips[i][0] == false or equips[i][0] == nil
              bmp2 = RPG::Cache.character(equips[i][0], equips[i][1].to_i)
              self.bitmap.blt(0, 0, bmp2, src_rect, 255)
            end            
          else
            src_rect = Rect.new(0, 0, bmp.width, bmp.height)
            self.bitmap.blt(0, 0, bmp, src_rect, 255)
          end
          @cw = bitmap.width / 4
          @ch = bitmap.height / 4
          self.ox = @cw / 2
          self.oy = @ch
        end
      end
      # Set visible situation
      self.visible = (not @character.transparent)
      # If graphic is character
      if @tile_id == 0
        # Set rectangular transfer
        sx = @character.pattern * @cw
        sy = (@character.direction - 2) / 2 * @ch
        self.src_rect.set(sx, sy, @cw, @ch)
      end
      # Set sprite coordinates
      self.x = @character.screen_x
      self.y = @character.screen_y
      self.z = @character.screen_z(@ch)
      # Set opacity level, blend method, and bush depth
      self.opacity = @character.opacity
      self.blend_type = @character.blend_type
      self.bush_depth = @character.bush_depth
      # Animation
      if @character.animation_id != 0
        animation = $data_animations[@character.animation_id]
        animation(animation, true)
        @character.animation_id = 0
      end
    end
    #--------------------------------------------------------------------------
  end
  #----------------------------------------------------------------------------
  # ** Window_Base
  #----------------------------------------------------------------------------
  class Window_Base < Window
    #--------------------------------------------------------------------------
    def draw_actor_graphic(actor, x, y)
      bmp = RPG::Cache.character(actor.character_name, actor.character_hue)
      bitmap = Bitmap.new(bmp.width, bmp.height)
      src_rect = Rect.new(0, 0, bmp.width, bmp.height)
      
      # Setup actor equipment
      equips = actor.equip_char_array
      
      # If character fits the size
      if equips.size > 0 and bmp.width == 128 and bmp.height == 192
        size = equips.size -1
        for i in 0..size
          next if equips[i] == false or equips[i][0] == false or equips[i][0] == nil
          bmp2 = RPG::Cache.character(equips[i][0], equips[i][1].to_i)
          bitmap.blt(0, 0, bmp2, src_rect, 255)
        end
      else
        bitmap.blt(0, 0, bmp, src_rect, 255)
      end
          
      cw = bitmap.width / 4
      ch = bitmap.height / 4
      src_rect = Rect.new(0, 0, cw, ch)
      self.contents.blt(x - cw / 2, y - ch, bitmap, src_rect)
    end
  end
#end

  #----------------------------------------------------------------------------
  # ** Sprite_Character
  #----------------------------------------------------------------------------
  class Sprite_NetCharacter < RPG::Sprite
    #--------------------------------------------------------------------------
    alias geso_visual_equip_sprite_char_init initialize
    def initialize(viewport, id,character = nil)
      @actor = @character
      @equips_id = [0, 0, 0, 0, 0]
      geso_visual_equip_sprite_char_init(viewport, id,character)
      if User_Edit::VISUAL_EQUIP_ACTIVE == true
      @chat_text_display.ox = 80
      @chat_text_display.oy = -40
      @chat_text_display.x = self.x
      @chat_text_display.y = self.y - self.oy / 2 - 24
      end
    end
    #--------------------------------------------------------------------------
    def equip_changed?
      @actor = @character
      if @actor == nil
        return false
      end
      for i in 0..5
        return true if @equips_id[i] != actor_equip_id(i, @actor)
      end
      return false
    end
    #--------------------------------------------------------------------------
    def adv_update
      @character_name = ''
      update
    end
    #--------------------------------------------------------------------------
    def update
      # If character is a event
      super
      # If tile ID, file name, hue or equipment are different from current ones
      if @tile_id != @character.tile_id or
         @character_name != @character.character_name or
         @character_hue != @character.character_hue or
         equip_changed?
        # Remember tile ID, file name and hue
        @tile_id = @character.tile_id
        @character_name = @character.character_name
        @character_hue = @character.character_hue
        # If tile ID value is valid
        if @tile_id >= 384
          self.bitmap = RPG::Cache.tile($game_map.tileset_name,
            @tile_id, @character.character_hue)
          self.src_rect.set(0, 0, 32, 32)
          self.ox = 16
          self.oy = 32
         # Animation
         update_ani if @character.animation_id != 0
         if @character.damage_show != nil
         damage(@character.damage_show, @character.show_critical)
         @character.show_demage(nil, false)
         end
         # Name Sprite
         @_text_display.x = self.x
         @_text_display.y = self.y - self.oy / 2 - 24
    
          # If tile ID value is invalid
        else
          equips = []
          # If handling a event
          if @character.is_a?(Game_Event) == true
            # Check for comment input
            parameters = SDK.event_comment_input(@character, 6, 'Visual Equipment')
            if parameters.nil?
              equips.push([@character_name, @character_hue])
            else
              for i in 0..5
                item = parameters[i].split
                hue = item.size > 2 ? item[2] : 0
                equips.push([item[1], hue]) if item[1] != 'none'
                if i == 1
                  equips.push([@character_name, @character_hue])
                end
              end
            end
          # If handling the player
          elsif @actor != nil
            equips = @actor.equip_char_array
          end
          # Dispose old bitmap
          self.bitmap.dispose unless self.bitmap == nil
          
          
          # Draws the character bitmap
          bmp = RPG::Cache.character(@character_name, @character_hue)
          self.bitmap = Bitmap.new(bmp.width, bmp.height)
          src_rect = Rect.new(0, 0, bmp.width, bmp.height)
               
          # If character fits the size
          if equips.size > 0 and bmp.width == 128 and bmp.height == 192
            size = equips.size -1
            for i in 0..size
              next if equips[i] == false or equips[i][0] == false or equips[i][0] == nil
              bmp2 = RPG::Cache.character(equips[i][0], equips[i][1].to_i)
              self.bitmap.blt(0, 0, bmp2, src_rect, 255)
            end            
          else
            src_rect = Rect.new(0, 0, bmp.width, bmp.height)
            self.bitmap.blt(0, 0, bmp, src_rect, 255)
          end
          @cw = bitmap.width / 4
          @ch = bitmap.height / 4
          self.ox = @cw / 2
          self.oy = @ch
        end
      end
      # Set visible situation
      self.visible = (not @character.transparent)
      # If graphic is character
      if @tile_id == 0
        # Set rectangular transfer
        sx = @character.pattern * @cw
        sy = (@character.direction - 2) / 2 * @ch
        self.src_rect.set(sx, sy, @cw, @ch)
      end
      # Set sprite coordinates
      self.x = @character.screen_x
      self.y = @character.screen_y
      self.z = @character.screen_z(@ch)
      # Set opacity level, blend method, and bush depth
      self.opacity = @character.opacity
      self.blend_type = @character.blend_type
      self.bush_depth = @character.bush_depth
      # Animation
      if @character.animation_id != 0
        animation = $data_animations[@character.animation_id]
        animation(animation, true)
        @character.animation_id = 0
      end
    
      # Animation
       update_ani if @character.animation_id != 0
         if @character.damage_show != nil
         damage(@character.damage_show, @character.show_critical)
         @character.show_demage(nil, false)
         end
         # Name Sprite
         @_text_display.x = self.x
         @_text_display.y = self.y - self.oy / 2 - 24
         
    end
    #--------------------------------------------------------------------------
  end
#------------------------------------------------------------------------------
# * End SDK Enable Test
#------------------------------------------------------------------------------
end
=end
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
		end
		#--------------------------------------------------------------------------
		def equip_char_array
			equips = []
			equips.push([@body, 0])
			item = equip_character(0, actor_equip_id(0, self))
			equips.push(item) unless item == false
			equips.push([@character_name, @character_hue])
			for i in 1..4
				item = equip_character(i, actor_equip_id(i, self))
				equips.push(item) unless item == false
			end
			return equips
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
		case i
		when 0 # Body
			return actor.armor2_id
		when 1 # Helmet
			return actor.armor3_id
		when 2 # Weapon
			return actor.weapon_id
		when 3 # Accessory
			return actor.armor2_id
		when 4 # Shield
			return actor.armor1_id
		end
	end
	#----------------------------------------------------------------------------
	# ** Sprite_Character
	#----------------------------------------------------------------------------
	class Sprite_Character < RPG::Sprite
		#--------------------------------------------------------------------------
		alias geso_visual_equip_sprite_char_init initialize
		def initialize(viewport, character = nil)
			if character.is_a?(Game_Player)
				@actor = $game_party.actors[0]
			elsif SDK.state('SBABS') == true and character.is_a?(Game_Ally)
				@actor = $game_party.actors[character.actor_id]
			elsif SDK.state('Caterpillar') == true and character.is_a?(Game_Party_Actor)
				@actor = character.actor
			else
				@actor = nil
			end
			@equips_id = [0, 0, 0, 0, 0]
			geso_visual_equip_sprite_char_init(viewport, character)
		end
		#--------------------------------------------------------------------------
		def equip_changed?
			if SDK.state('Caterpillar') == true
				if @character.is_a?(Game_Party_Actor)
					if @character.actor != @actor
						@actor = @character.actor
						return true
					end
				end
			end
			if SDK.state('SBABS') == true
				if @character.is_a?(Game_Ally)
					if $game_party.actors[@character.actor_id] != @actor
						return true
					end
				end
			end
			if @character.is_a?(Game_Player)
				if $game_party.actors[0] != @actor
					@actor = $game_party.actors[0]
					return true
				end
			elsif @character.is_a?(Game_Event)
				if @page != @character.page
					@page = @character.page
					return true
				end
				return false
			end
			if @actor == nil
				return false
			end
			for i in 0..4
				return true if @equips_id[i] != actor_equip_id(i, @actor)
			end
			return false
		end
		#--------------------------------------------------------------------------
		def adv_update
			@character_name = ''
			update
		end
		#--------------------------------------------------------------------------
		def update
			# If character is a event
			super
			# If tile ID, file name, hue or equipment are different from current ones
			if @tile_id != @character.tile_id or
				@character_name != @character.character_name or
				@character_hue != @character.character_hue or
				equip_changed?
				# Remember tile ID, file name and hue
				@tile_id = @character.tile_id
				@character_name = @character.character_name
				@character_hue = @character.character_hue
				# If tile ID value is valid
				if @tile_id >= 384
					self.bitmap = RPG::Cache.tile($game_map.tileset_name,
						@tile_id, @character.character_hue)
					self.src_rect.set(0, 0, 32, 32)
					self.ox = 16
					self.oy = 32
					# If tile ID value is invalid
				else
					equips = []
					# If handling a event
					if @character.is_a?(Game_Event) == true
						# Check for comment input
						parameters = SDK.event_comment_input(@character, 6, 'Visual Equipment')
						if parameters.nil?
							equips.push([@character_name, @character_hue])
						else
							for i in 0..5
								item = parameters[i].split
								hue = item.size > 2 ? item[2] : 0
								equips.push([item[1], hue]) if item[1] != 'none'
								if i == 1
									equips.push([@character_name, @character_hue])
								end
							end
						end
						# If handling the player
					elsif @actor != nil
						equips = @actor.equip_char_array
					end
					# Dispose old bitmap
					self.bitmap.dispose unless self.bitmap == nil
					# Draws the character bitmap
					bmp = RPG::Cache.character(@character_name, @character_hue)
					self.bitmap = Bitmap.new(bmp.width, bmp.height)
					src_rect = Rect.new(0, 0, bmp.width, bmp.height)
					# If character fits the size
					if equips.size > 0 and bmp.width == 236 and bmp.height == 236
						size = equips.size -1
						for i in 0..size
							next if equips[i] == false or equips[i][0] == false or equips[i][0] == nil
							bmp2 = RPG::Cache.character(equips[i][0], equips[i][1].to_i)
							self.bitmap.blt(0, 0, bmp2, src_rect, 255)
						end
					else
						src_rect = Rect.new(0, 0, bmp.width, bmp.height)
						self.bitmap.blt(0, 0, bmp, src_rect, 255)
					end
					@cw = bitmap.width / 4
					@ch = bitmap.height / 4
					self.ox = @cw / 2
					self.oy = @ch
				end
			end
			# Set visible situationw
			self.visible = (not @character.transparent)
			# If graphic is character
			if @tile_id == 0
				# Set rectangular transfer
				sx = @character.pattern * @cw
				sy = (@character.direction - 2) / 2 * @ch
				self.src_rect.set(sx, sy, @cw, @ch)
			end
			# Set sprite coordinates
			self.x = @character.screen_x
			self.y = @character.screen_y
			self.z = @character.screen_z(@ch)
			# Set opacity level, blend method, and bush depth
			self.opacity = @character.opacity
			self.blend_type = @character.blend_type
			self.bush_depth = @character.bush_depth
			# Animation
			if @character.animation_id != 0
				animation = $data_animations[@character.animation_id]
				animation(animation, true)
				@character.animation_id = 0
			end
		end
		#--------------------------------------------------------------------------
	end
	#----------------------------------------------------------------------------
	# ** Window_Base
	#----------------------------------------------------------------------------
	class Window_Base < Window
		#--------------------------------------------------------------------------
		def draw_actor_graphic(actor, x, y)
			bmp = RPG::Cache.character(actor.character_name, actor.character_hue)
			bitmap = Bitmap.new(bmp.width, bmp.height)
			src_rect = Rect.new(0, 0, bmp.width, bmp.height)
			
			# Setup actor equipment
			equips = actor.equip_char_array
			
			# If character fits the size
			if equips.size > 0 and bmp.width == 236 and bmp.height == 236
				size = equips.size -1
				for i in 0..size
					next if equips[i] == false or equips[i][0] == false or equips[i][0] == nil
					bmp2 = RPG::Cache.character(equips[i][0], equips[i][1].to_i)
					bitmap.blt(0, 0, bmp2, src_rect, 255)
				end
			else
				bitmap.blt(0, 0, bmp, src_rect, 255)
			end
			
			cw = bitmap.width / 4
			ch = bitmap.height / 4
			src_rect = Rect.new(0, 0, cw, ch)
			self.contents.blt(x - cw / 2, y - ch, bitmap, src_rect)
		end
	end
	
end  