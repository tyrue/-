#==============================================================================
# ** Enemy Bars
#------------------------------------------------------------------------------
# Mr.Mo "Muhammet Sivri"
# Version 1
# 10.16.06
#==============================================================================
#-------------------------------------------------------------------------------
# Begin SDK Enabled Check
#-------------------------------------------------------------------------------
if SDK.state("Mr.Mo's ABS")
	class BaseBar < Sprite
		#--------------------------------------------------------------------------
		# * Constants
		#--------------------------------------------------------------------------
		OUTLINE = 1
		BORDER = 1
		
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(entity, v, hp_width, hp_height)
			super(v)
			@entity = entity
			@old_hp = -1
			@old_x = -1
			@old_y = -1
			@hp_width = hp_width
			@hp_height = hp_height
			@ch = 0
			self.bitmap = Bitmap.new(@hp_width, @hp_height)
			update
		end
		
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			move_bar
			return if @old_hp == current_hp
			
			#self.bitmap.clear
			@old_hp = current_hp
			draw_gradient_bar(0, 0, current_hp, max_hp, @hp_width, @hp_height)
		end
		
		#--------------------------------------------------------------------------
		# * Move Bar
		#--------------------------------------------------------------------------
		def move_bar
			@old_x = screen_x
			@old_y = screen_y
			
			self.x = @old_x
			self.y = @old_y
		end
		
		#--------------------------------------------------------------------------
		# * Something Changed?
		#--------------------------------------------------------------------------
		def something_changed?
			return dispose if map_changed_or_entity_missing?
			
			self.visible = visible_condition
			
			return true if @old_hp != current_hp
			return true if @old_x != screen_x
			return true if @old_y != screen_y 
			false
		end
		
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			refresh if something_changed?
		end
		
		#--------------------------------------------------------------------------
		# * Draw Gradient Bar
		#--------------------------------------------------------------------------
		def draw_gradient_bar(x, y, min, max, width, height)
			return if max == 0
			
			percent = min / max.to_f if max != 0
			back = Bitmap.new(width, height)
			back.fill_rect(back.rect, Color.new(0, 0, 0, 150)) # 꽉찬 네모
			self.bitmap.stretch_blt(back.rect, back, back.rect)
			
			if (width * percent).to_i > 0 
				cx = BORDER
				cy = BORDER
				n = 2
				
				bar = Bitmap.new((width * percent).to_i, height)
				redVal = [(255 * (1 - percent) * n).to_i, 255].min
				greenVal = redVal >= 255 ? [(255 * percent * n / (n - 1)).to_i, 0].max : 255
				
				bar.fill_rect(bar.rect, Color.new(redVal, greenVal, 0, 255)) # 꽉찬 네모
				bar_dest_rect = Rect.new(cx, cy, (width * percent).to_i - cx * 2, height - cy * 2)
				self.bitmap.stretch_blt(bar_dest_rect, bar, bar.rect)
			end
		end
		
		#--------------------------------------------------------------------------
		# * Methods to be implemented by subclasses
		#--------------------------------------------------------------------------
		def current_hp; end
		def max_hp; end
		def screen_x; end
		def screen_y; end
		def x_offset; end
		def y_offset; end
		def bar_file; end
		def visible_condition; end
		def map_changed_or_entity_missing?; end
	end
	
	class Enemy_Bars < BaseBar
		#--------------------------------------------------------------------------
		# * Constants Bar Types and Hues for parameters and parameter names
		#--------------------------------------------------------------------------
		HP_BAR = "014-Reds01"
		# leave this alone if you don't know what you are doing
		OUTLINE = 1
		BORDER = 1
		HP_WIDTH = 40         # WIDTH of the HP Bar
		HP_HEIGHT = 7         # Height of the HP Bar
		HP_WIDTH_BOSS = 90         # WIDTH of the HP Bar
		HP_HEIGHT_BOSS = 15         # Height of the HP Bar
		
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(enemy, v)
			hp_width = boss?(enemy.id) ? HP_WIDTH_BOSS : HP_WIDTH
			hp_height = boss?(enemy.id) ? HP_HEIGHT_BOSS : HP_HEIGHT
			
			super(enemy, v, hp_width, hp_height)
			update    
		end
		
		def boss?(id)
			return (ABS_ENEMY_HP[id] && ABS_ENEMY_HP[id][1] == 1)
		end
		
		def current_hp
			@entity.hp
		end
		
		def max_hp
			@entity.maxhp
		end
		
		def screen_x
			@entity.event.screen_x + x_offset
		end
		
		def screen_y
			@entity.event.screen_y + y_offset
		end
		
		def x_offset
			-(@hp_width / 2)
		end
		
		def y_offset
			0
		end
		
		def bar_file
			HP_BAR
		end
		
		def visible_condition
			true
		end
		
		def map_changed_or_entity_missing?
			!@entity || @entity.dead? || !@entity.event_id || !$ABS.enemies[@entity.event_id]
		end
	end
	
	class NetPartyHP_Bars < BaseBar
		HP_BAR = "014-Reds01"
		HP_WIDTH = 35
		HP_HEIGHT = 6
		
		def initialize(netPlayer, v)
			super(netPlayer, v, HP_WIDTH, HP_HEIGHT)
		end
		
		private
		
		def current_hp
			@entity.hp
		end
		
		def max_hp
			@entity.maxhp
		end
		
		def screen_x
			@entity.screen_x + x_offset
		end
		
		def screen_y
			@entity.screen_y + y_offset
		end
		
		def x_offset
			-(@hp_width / 2)
		end
		
		def y_offset
			-@ch
		end
		
		def bar_file
			HP_BAR
		end
		
		def visible_condition
			!@entity.is_transparency || $net_party_manager.party_members.include?(@entity.name.to_s)
		end
		
		def map_changed_or_entity_missing?
			@entity.map_id != $game_map.map_id || Network::Main.mapplayers[@entity.netid].nil?
		end
	end
	
	class NetPartyMP_Bars < BaseBar
		HP_BAR = "013-Blues01"
		HP_WIDTH = 35
		HP_HEIGHT = 6
		
		def initialize(netPlayer, v)
			super(netPlayer, v, HP_WIDTH, HP_HEIGHT)
		end
		
		private
		
		def current_hp
			@entity.sp
		end
		
		def max_hp
			@entity.maxsp
		end
		
		def screen_x
			@entity.screen_x + x_offset
		end
		
		def screen_y
			@entity.screen_y + y_offset
		end
		
		def x_offset
			-(@hp_width / 2)
		end
		
		def y_offset
			-@ch + @hp_height
		end
		
		def bar_file
			HP_BAR
		end
		
		def visible_condition
			!@entity.is_transparency || $net_party_manager.party_members.include?(@entity.name.to_s)
		end
		
		def map_changed_or_entity_missing?
			if @entity.map_id != $game_map.map_id || Network::Main.mapplayers[@entity.netid].nil?
				@entity.bar_showing = false
				return true
			end
			return false
		end
	end
	
	
	#============================================================================
	# * Scene Map
	#============================================================================
	class Scene_Map
		#--------------------------------------------------------------------------
		alias mrmo_hpeny_scene_map_update update
		alias mrmo_hpeny_scene_map_main_draw main_draw
		#--------------------------------------------------------------------------
		# * Main Draw
		#--------------------------------------------------------------------------
		def main_draw
			@enemys_hp = {}
			@netPlayers_hp = {}
			@netPlayers_sp = {}
			@show_range = 12
			
			initialize_bars($ABS.enemies.values)
			initialize_bars(Network::Main.players.values)
			
			mrmo_hpeny_scene_map_main_draw
		end
		
		def initialize_bars(entities)
			entities.each { |entity| entity.bar_showing = false }
		end
		
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			#Get Enemies
			for e in $ABS.enemies.values
				next unless e 
				
				if $ABS.in_range?($game_player, e.event, @show_range)
					next if e.bar_showing
					
					@enemys_hp[e.event.id] = Enemy_Bars.new(e, @spriteset.viewport3)
					e.bar_showing = true
					
				elsif e.bar_showing and @enemys_hp[e.event.id] != nil
					@enemys_hp[e.event.id].dispose if !@enemys_hp[e.event.id].disposed?
					@enemys_hp[e.event.id] = nil
					e.bar_showing = false
				end
			end
			
			#Get net Players
			for player in Network::Main.mapplayers.values
				next unless player
				
				#if in screen
				if player.in_range?(@show_range)
					next if player.bar_showing
					
					@netPlayers_hp[player.netid] = NetPartyHP_Bars.new(player, @spriteset.viewport3)
					@netPlayers_sp[player.netid] = NetPartyMP_Bars.new(player, @spriteset.viewport3)
					player.bar_showing = true
					
				elsif player.bar_showing && @netPlayers_hp[player.netid] != nil
					@netPlayers_hp[player.netid].dispose if !@netPlayers_hp[player.netid].disposed?
					@netPlayers_hp[player.netid] = nil
					
					@netPlayers_sp[player.netid].dispose if !@netPlayers_sp[player.netid].disposed?
					@netPlayers_sp[player.netid] = nil
					
					player.bar_showing = false
				end
			end
			
			#Update HP BARS
			update_bars(@enemys_hp.values)
			update_bars(@netPlayers_hp.values)
			update_bars(@netPlayers_sp.values)
			
			mrmo_hpeny_scene_map_update
		end
		
		def update_bars(bars)
			bars.each do |bar|
				next if bar == nil or bar.disposed?
				bar.update
			end
		end
	end
	
	
	#============================================================================
	# * ABS Enemy
	#============================================================================
	class ABS_Enemy < Game_Battler
		#--------------------------------------------------------------------------
		attr_accessor :bar_showing
		#--------------------------------------------------------------------------
		alias mrmo_hpeny_abs_enemy_initialize initialize
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(enemy_id)
			mrmo_hpeny_abs_enemy_initialize(enemy_id)
			@bar_showing = false
		end
	end
	
	#============================================================================
	# * netPlayer
	#============================================================================
	class Game_NetPlayer < Game_Character
		#--------------------------------------------------------------------------
		attr_accessor :bar_showing
		#--------------------------------------------------------------------------
		alias mrmo_hpeny_abs_netPlayer_initialize initialize
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize
			mrmo_hpeny_abs_netPlayer_initialize
			@bar_showing = false
		end
	end
	
	#==============================================================================
	# ** Spriteset_Map
	#------------------------------------------------------------------------------
	#  This class brings together map screen sprites, tilemaps, etc.
	#  It's used within the Scene_Map class.
	#==============================================================================
	class Spriteset_Map
		attr_accessor :viewport3
	end
end