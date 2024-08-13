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
	class Enemy_Bars < Sprite
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
			super(v)
			@enemy = enemy
			@old_hp = 0
			@old_x = 0
			@old_y = 0
			
			@tesp = RPG::Cache.character(@enemy.event.character_name, @enemy.event.character_hue)
			if ABS_ENEMY_HP[@enemy.id] != nil and ABS_ENEMY_HP[@enemy.id][1] == 1
				self.bitmap = Bitmap.new(HP_WIDTH_BOSS, HP_HEIGHT_BOSS)
				@ch = 0
				@cw = HP_WIDTH_BOSS / 2
			else
				self.bitmap = Bitmap.new(HP_WIDTH, HP_HEIGHT)
				@ch = 0
				@cw = HP_WIDTH / 2
			end
			
			update    
		end
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			#First move it
			@old_x = @enemy.event.screen_x - @cw
			@old_y = @enemy.event.screen_y - @ch
			self.x = @old_x
			self.y = @old_y
			#HP Bar Check
			return if @old_hp == @enemy.hp
			self.bitmap.clear
			@old_hp = @enemy.hp
			
			#Show the bar
			if ABS_ENEMY_HP[@enemy.id] != nil and ABS_ENEMY_HP[@enemy.id][1] == 1
				draw_gradient_bar2(0, 0, @enemy.hp, @enemy.maxhp, HP_WIDTH_BOSS, HP_HEIGHT_BOSS)
			else
				draw_gradient_bar2(0, 0, @enemy.hp, @enemy.maxhp, HP_WIDTH, HP_HEIGHT)
			end
		end  
		#--------------------------------------------------------------------------
		# * Something Changed?
		#--------------------------------------------------------------------------
		def something_changed?
			return dispose unless @enemy 
			return dispose if @enemy.dead?
			return dispose unless @enemy.event_id 
			return dispose unless $ABS.enemies[@enemy.event_id]
				
			return true if @old_hp != @enemy.hp
			return true if @old_x != @enemy.event.screen_x - @cw
			return true if @old_y != @enemy.event.screen_y - @ch
			return false
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
		def draw_gradient_bar2(x, y, min, max, width = nil, height = nil)
			return if max == 0
			percent = min / max.to_f if max != 0
			back = Bitmap.new(width, height)
			back.fill_rect(back.rect, Color.new(0, 0, 0, 175)) # 꽉찬 네모
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
	end
	
	class NetPartyHP_Bars < Sprite
		#--------------------------------------------------------------------------
		# * Constants Bar Types and Hues for parameters and parameter names
		#--------------------------------------------------------------------------
		HP_BAR = "014-Reds01"
		# leave this alone if you don't know what you are doing
		OUTLINE = 1
		BORDER = 1
		HP_WIDTH = 35         # WIDTH of the HP Bar
		HP_HEIGHT = 6         # Height of the HP Bar
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(netPlayer, v)
			super(v)
			@netPlayer = netPlayer
			@old_hp = -1
			@old_x = -1
			@old_y = -1
			self.bitmap = Bitmap.new(HP_WIDTH, HP_HEIGHT)
			#~ @tesp = RPG::Cache.character(@netPlayer.character_name, @netPlayer.character_hue)
			#~ @ch = @tesp.height / 4 + 20
			#~ @cw = 15
			@ch = 0
			update    
		end
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			#First move it
			@old_x = @netPlayer.screen_x - 15
			@old_y = @netPlayer.screen_y - @ch
			self.x = @old_x
			self.y = @old_y
			#HP Bar Check
			return if @old_hp == @netPlayer.hp
			self.bitmap.clear
			@old_hp = @netPlayer.hp
			#Show the bar
			draw_gradient_bar(0,0,@netPlayer.hp,@netPlayer.maxhp,HP_BAR,HP_WIDTH,HP_HEIGHT)
		end  
		#--------------------------------------------------------------------------
		# * Something Changed?
		#--------------------------------------------------------------------------
		def something_changed?
			if (@netPlayer.map_id != $game_map.map_id) or (Network::Main.mapplayers[@netPlayer.netid] == nil)
				@netPlayer.bar_showing = false
				return dispose 
			end
			
			self.visible = (!@netPlayer.is_transparency) or ($net_party_manager.party_members.include?(@netPlayer.name.to_s))
			
			return true if @old_hp != @netPlayer.hp.to_i
			return true if @old_x != @netPlayer.event.screen_x - 15
			return true if @old_y != @netPlayer.event.screen_y - @ch
			return false
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
		def draw_gradient_bar(x, y, min, max, file, width = nil, height = nil, hue = 0, back = "Back", back2 = "Back2")
			bar = RPG::Cache.gradient(file, hue)
			back = RPG::Cache.gradient(back)
			back2 = RPG::Cache.gradient(back2)
			cx = BORDER
			cy = BORDER
			dx = OUTLINE
			dy = OUTLINE
			zoom_x = width != nil ? width : back.width
			zoom_y = height != nil ? height : back.height
			percent = min / max.to_f if max != 0
			percent = 0 if max == 0
			back_dest_rect = Rect.new(x,y,zoom_x,zoom_y)
			back2_dest_rect = Rect.new(x+dx,y+dy,zoom_x -dx*2,zoom_y-dy*2)
			bar_dest_rect = Rect.new(x+cx,y+cy,zoom_x * percent-cx*2,zoom_y-cy*2)
			back_source_rect = Rect.new(0,0,back.width,back.height)
			back2_source_rect = Rect.new(0,0,back2.width,back2.height)
			bar_source_rect = Rect.new(0,0,bar.width* percent,bar.height)
			self.bitmap.stretch_blt(back_dest_rect, back, back_source_rect)
			self.bitmap.stretch_blt(back2_dest_rect, back2, back2_source_rect)
			self.bitmap.stretch_blt(bar_dest_rect, bar, bar_source_rect)
		end  
	end
	
	class NetPartyMP_Bars < Sprite
		#--------------------------------------------------------------------------
		# * Constants Bar Types and Hues for parameters and parameter names
		#--------------------------------------------------------------------------
		HP_BAR = "013-Blues01"
		# leave this alone if you don't know what you are doing
		OUTLINE = 1
		BORDER = 1
		HP_WIDTH = 35         # WIDTH of the HP Bar
		HP_HEIGHT = 6         # Height of the HP Bar
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		def initialize(netPlayer, v)
			super(v)
			@netPlayer = netPlayer
			@old_hp = -1
			@old_x = -1
			@old_y = -1
			self.bitmap = Bitmap.new(HP_WIDTH, HP_HEIGHT)
			#~ @temp = RPG::Cache.character(@netPlayer.character_name, @netPlayer.character_hue)
			#~ @ch = @temp.height / 4 + 20
			#~ @cw = 15
			@ch = 0
			update    
		end
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			#First move it
			@old_x = @netPlayer.screen_x - 15
			@old_y = @netPlayer.screen_y + HP_HEIGHT
			self.x = @old_x
			self.y = @old_y
			#HP Bar Check
			return if @old_hp == @netPlayer.sp
			self.bitmap.clear
			@old_hp = @netPlayer.sp
			#Show the bar
			draw_gradient_bar(0,0,@netPlayer.sp,@netPlayer.maxsp,HP_BAR,HP_WIDTH,HP_HEIGHT)
		end  
		#--------------------------------------------------------------------------
		# * Something Changed?
		#--------------------------------------------------------------------------
		def something_changed?
			if (@netPlayer.map_id != $game_map.map_id) or (Network::Main.mapplayers[@netPlayer.netid] == nil)
				@netPlayer.bar_showing = false
				return dispose 
			end
			
			self.visible = (!@netPlayer.is_transparency) or ($net_party_manager.party_members.include?(@netPlayer.name.to_s))			
			return true if @old_hp != @netPlayer.sp.to_i
			return true if @old_x != @netPlayer.event.screen_x - 15
			return true if @old_y != @netPlayer.event.screen_y + HP_HEIGHT
			return false
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
		def draw_gradient_bar(x, y, min, max, file, width = nil, height = nil, hue = 0, back = "Back", back2 = "Back2")
			bar = RPG::Cache.gradient(file, hue)
			back = RPG::Cache.gradient(back)
			back2 = RPG::Cache.gradient(back2)
			cx = BORDER
			cy = BORDER
			dx = OUTLINE
			dy = OUTLINE
			zoom_x = width != nil ? width : back.width
			zoom_y = height != nil ? height : back.height
			percent = min / max.to_f if max != 0
			percent = 0 if max == 0
			back_dest_rect = Rect.new(x,y,zoom_x,zoom_y)
			back2_dest_rect = Rect.new(x+dx,y+dy,zoom_x -dx*2,zoom_y-dy*2)
			bar_dest_rect = Rect.new(x+cx,y+cy,zoom_x * percent-cx*2,zoom_y-cy*2)
			back_source_rect = Rect.new(0,0,back.width,back.height)
			back2_source_rect = Rect.new(0,0,back2.width,back2.height)
			bar_source_rect = Rect.new(0,0,bar.width* percent,bar.height)
			self.bitmap.stretch_blt(back_dest_rect, back, back_source_rect)
			self.bitmap.stretch_blt(back2_dest_rect, back2, back2_source_rect)
			self.bitmap.stretch_blt(bar_dest_rect, bar, bar_source_rect)
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
			#Get Enemies
			for e in $ABS.enemies.values
				e.bar_showing = false
			end
			
			@netPlayers_hp = {}
			@netPlayers_sp = {}
			#Get netplayers
			for player in Network::Main.mapplayers.values
				player.bar_showing = false
			end
			mrmo_hpeny_scene_map_main_draw
		end
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			#Get Enemies
			for e in $ABS.enemies.values
				next if e == nil
				#if in screen
				if $ABS.in_range?($game_player, e.event, 14)
					next if e.bar_showing
					
					@enemys_hp[e.event.id] = Enemy_Bars.new(e, @spriteset.viewport3)
					e.bar_showing = true
					
				elsif e.bar_showing and @enemys_hp[e.event.id] != nil
					@enemys_hp[e.event.id].dispose if !@enemys_hp[e.event.id].disposed?
					@enemys_hp[e.event.id] = nil
					e.bar_showing = false
				end
			end
			
			#Update HP BARS
			for bars in @enemys_hp.values
				next if bars == nil or bars.disposed?
				bars.update
			end
			
			
			#Get net Players
			for player in Network::Main.mapplayers.values
				next if player == nil
				
				if @netPlayers_hp[player.netid] == nil
					if player.bar_showing
						player.bar_showing = false 
					end
				end
				
				#if in screen
				if player.in_range?(14)
					player.bar_showing = true
					next if player.bar_showing and @netPlayers_hp[player.netid] != nil
					@netPlayers_hp[player.netid] = NetPartyHP_Bars.new(player, @spriteset.viewport3)
						
					next if player.bar_showing and @netPlayers_sp[player.netid] != nil
					@netPlayers_sp[player.netid] = NetPartyMP_Bars.new(player, @spriteset.viewport3)
					
				elsif player.bar_showing and @netPlayers_hp[player.netid] != nil
					player.bar_showing = false
					@netPlayers_hp[player.netid].dispose if !@netPlayers_hp[player.netid].disposed?
					@netPlayers_hp[player.netid] = nil
					
					@netPlayers_sp[player.netid].dispose if !@netPlayers_sp[player.netid].disposed?
					@netPlayers_sp[player.netid] = nil
				end
			end
			
			#Update HP BARS
			for bars in @netPlayers_hp.values
				next if bars == nil or bars.disposed?
				bars.update
			end
			
			#Update sp BARS
			for bars in @netPlayers_sp.values
				next if bars == nil or bars.disposed?
				bars.update
			end
			
			mrmo_hpeny_scene_map_update
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