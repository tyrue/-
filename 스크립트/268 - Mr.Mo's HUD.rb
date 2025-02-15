#==============================================================================
# ** HUD기능
#-------------------------------------------------------------------------------
# Begin SDK Enabled Check
#-------------------------------------------------------------------------------
if SDK.state("Mr.Mo's ABS")
	BAR_WIDTH = 70
	BAR_HEIGHT = 15
	#--------------------------------------------------------------------------
	# * Constants - MAKE YOUR EDITS HERE
	#--------------------------------------------------------------------------
	HP_X = 560            # X POS of the HP Bar
	HP_Y = 417              # Y POS of the HP Bar
	HP_WIDTH = BAR_WIDTH         # WIDTH of the HP Bar
	HP_HEIGHT = BAR_HEIGHT         # Height of the HP Bar
	#--------------------------------------------------------------------------
	SP_X = 560             # X POS of the SP Bar
	SP_Y = HP_Y + BAR_HEIGHT + 5             # Y POS of the SP Bar
	SP_WIDTH = BAR_WIDTH         # WIDTH of the SP Bar
	SP_HEIGHT = BAR_HEIGHT         # Height of the SP Bar
	#--------------------------------------------------------------------------
	EXP_X = 560           # X POS of the EXP Bar
	EXP_Y = SP_Y + BAR_HEIGHT + 5            # Y POS of the EXP Bar
	EXP_WIDTH = BAR_WIDTH        # WIDTH of the EXP Bar
	EXP_HEIGHT = BAR_HEIGHT        # Height of the EXP Bar
	#--------------------------------------------------------------------------
	STATES_SHOW = true    # Show states?
	STATES_X = 170        # States X display
	STATES_Y = 420        # States Y display
	#--------------------------------------------------------------------------
	HOTKEYS_SHOW = false  #Show hotkeys?
	HOTKEYS_X = 180       #Hotkeys X Display
	HOTKEYS_Y = 440      #Hotkeys Y Display
	#--------------------------------------------------------------------------
	SHOW_DASH = false      # Show dash bar?
	DASH_X = 95          # X POS of the DASH Bar
	DASH_Y = 430          # Y POS of the DASH Bar
	DASH_WIDTH = 55      # WIDTH of the DASH Bar
	DASH_HEIGHT = 5      # Height of the DASH Bar
	#--------------------------------------------------------------------------
	SHOW_SNEAK = false      # Show SNEAK bar?
	SNEAK_X = 95          # X POS of the SNEAK Bar
	SNEAK_Y = 445          # Y POS of the SNEAK Bar
	SNEAK_WIDTH = 55      # WIDTH of the SNEAK Bar
	SNEAK_HEIGHT = 5      # Height of the SNEAK Bar
	#--------------------------------------------------------------------------
	LOW_HP = 150          # What HP should the low HP icon be shown?
	#--------------------------------------------------------------------------
	HP_ITEMID = 1         # POTION ITEM ID
	SP_ITEMID = 4         # SP Increase Item ID
	#--------------------------------------------------------------------------
	CAN_TOGGLE = true
	TOGGLE_KEY = Input::Letters["E"]
	#--------------------------------------------------------------------------
	MINI_MAP = true       # Display Mini-Map?
	#--------------------------------------------------------------------------
	class Window_MrMo_HUD < Window_Base
		#--------------------------------------------------------------------------
		# * Object Initialization
		#--------------------------------------------------------------------------
		attr_accessor :pos
		def initialize
			super(-16, -16, 700, 700)
			#Record Old Data
			@actor = $game_party.actors[0]
			@old_hp = @actor.hp
			@old_sp = @actor.sp
			@old_exp = @actor.exp
			@level = @actor.level
			@hp_n = $game_party.item_number(HP_ITEMID)
			@sp_n = $game_party.item_number(SP_ITEMID)
			@gold_n = $game_party.gold
			@states = @actor.states.to_s
			@dash = $ABS.dash_min
			@sneak = $ABS.sneak_min
			#Create Bitmap
			self.contents = Bitmap.new(width - 32, height - 32)
			@pos = Sprite.new
			@pos.bitmap = Bitmap.new(100, 100)
			
			@pos.visible = self.visible
			@pos.x = 520
			@pos.y = 330
			@pos.z = 99999
			@pos.bitmap.font.color = normal_color
			@pos.bitmap.font.size = 12
			@pos.bitmap.draw_frame_text(0, 0, 640, 32, "좌표: [#{'%03d' % ($game_player.x + 1)}] [#{'%03d' % ($game_player.y + 1)}]")
			
			#Hide Window
			self.opacity = 0
			#Refresh
			refresh
		end
		#--------------------------------------------------------------------------
		# * Refresh
		#--------------------------------------------------------------------------
		def refresh
			self.contents.clear
			self.contents.font.color = system_color
			self.contents.font.color = normal_color
			self.contents.font.size = 12
			#Record new data
			@actor = $game_party.actors[0]
			@old_hp = @actor.hp
			@old_sp = @actor.sp
			@old_exp = @actor.exp
			@level = @actor.level
			@hp_n = $game_party.item_number(HP_ITEMID)
			@sp_n = $game_party.item_number(SP_ITEMID)
			@gold_n = $game_party.gold
			@states = @actor.states.to_s
			@dash = $ABS.dash_min
			@sneak = $ABS.sneak_min
			@mess1 = $game_switches[404]
			
			if @mess1 == true
				bitmap = RPG::Cache.picture("MessageBack")
				self.contents.blt(0, 0, bitmap, Rect.new(0, 0, 0, 160))
			end
			#Show the Pictures
			bitmap = RPG::Cache.picture("HUD Graphic")
			self.contents.blt(0, 0, bitmap, Rect.new(0, 0, 900, 900))
			#Show the HP Symbol
			self.contents.draw_frame_text(HP_X - 40, HP_Y - BAR_HEIGHT / 2, 640, 32, "체력")
			
			#Draw the HP BAR
			draw_gradient_bar(HP_X, HP_Y, @actor.hp, @actor.maxhp, HP_BAR, HP_WIDTH, HP_HEIGHT)
			self.contents.draw_frame_text(HP_X + 5, HP_Y - BAR_HEIGHT / 2, BAR_WIDTH, 32, change_number_unit(@actor.hp))
			
			#Show the SP Symbol
			self.contents.draw_frame_text(SP_X - 40, SP_Y - BAR_HEIGHT / 2, 640, 32, "마력")
			
			#Draw the SP Bar
			draw_gradient_bar(SP_X, SP_Y, @actor.sp, @actor.maxsp, SP_BAR, SP_WIDTH, SP_HEIGHT)
			self.contents.draw_frame_text(SP_X + 5, SP_Y - BAR_HEIGHT / 2, BAR_WIDTH, 32, change_number_unit(@actor.sp))
			
			#Show the EXP Symbol
			self.contents.draw_frame_text(EXP_X - 40, EXP_Y - BAR_HEIGHT / 2, 640, 32, "경험치")
			
			#Draw the EXP Bar
			min = @actor.level == 99 ? @actor.exp : @actor.now_exp
			max = @actor.level == 99 ? MAX_EXP : @actor.next_exp
			if @actor.level == 100
				min = 1
				max = 1
			end
			draw_gradient_bar(EXP_X, EXP_Y, min, max, EXP_BAR, EXP_WIDTH, EXP_HEIGHT)
			if @actor.level < 99
				self.contents.draw_frame_text(EXP_X + 5, EXP_Y - BAR_HEIGHT / 2, BAR_WIDTH, 32, change_number_unit(@actor.exp))
			else
				self.contents.draw_frame_text(EXP_X + 5, EXP_Y - BAR_HEIGHT / 2, BAR_WIDTH, 32, change_number_unit_han(@actor.exp))
			end
			
			
			#한글 좌표 위치
			ui_x = 520
			
			#Show Hero Icon
			self.contents.draw_frame_text(ui_x, 350, 640, 32, "이름:")
			self.contents.draw_frame_text(ui_x + 30, 350, 640, 32, @actor.name.to_s)
			#Show Level Icon
			self.contents.draw_frame_text(ui_x, 370, 640, 32, "레벨:")
			self.contents.draw_frame_text(ui_x + 30, 370, 640, 32, change_number_unit(@actor.level))
			#Show Gold Icon
			self.contents.draw_frame_text(ui_x, 390, 640, 32, "금전:")
			self.contents.draw_frame_text(ui_x + 30, 390, 640, 32, change_number_unit($game_party.gold))
			
			#맵이름의 표시
			map_infos = load_data("Data/MapInfos.rxdata")
			mapname = map_infos[$game_map.map_id].name.to_s
			mapname = "두고개" if mapname.include?("두고개") 
				
			self.contents.draw_frame_text(15, 0, 640, 12, mapname, 1)
			
			# 좌표의 표시
			@old_x = $game_player.x
			@old_y = $game_player.y
			
			#If the HP is too low
			if @actor.hp.to_i <= LOW_HP
			end
			#If the SP Item is more then 0
			if $game_party.item_number(SP_ITEMID) > 0
				self.contents.blt(110, 0, bitmap, Rect.new(0, 0, 24, 24))
			end
			#if the HP Item is more then 0
			if $game_party.item_number(HP_ITEMID) > 0
				self.contents.blt(110, 20, bitmap, Rect.new(0, 0, 24, 24))
			end
			if STATES_SHOW
				begin
					#Draw States Background
					n = -2
					for id in @actor.states
						state = $data_states[id]
						next if state == nil
						bitmap = RPG::Cache.picture("")
						x = (n*40) + 185
						self.contents.blt(x, 50, bitmap, Rect.new(0, 0, 49, 58))
						n += 1
					end
					#Draw States
					n = -2
					for id in @actor.states
						state = $data_states[id]
						next if state == nil
						x = (n*40) + +195
						self.contents.blt(x, 65, bitmap, Rect.new(0, 0, 32, 27))
						self.contents.draw_frame_text(x, 0, 49, 58, state.name.to_s)
						n += 1
					end
				rescue
					print "#{$!} - Don't ask Mr.Mo for it!!!"
				end
			end
			if HOTKEYS_SHOW
				#Draw Hotkeys
				count = 0
				#Make a loop to get all the ideas that are Hotkeyed
				for id in $ABS.skill_keys.values
					#Skip NIL values
					next if id == nil
					#Get skill
					skill = $data_skills[id]
					#Skip NIL values
					next if skill == nil
					#Get Icon
					icon = RPG::Cache.icon(skill.icon_name)
					x = (count*32) + 280
					self.contents.blt(x, 27, icon, Rect.new(0, 0, 200, 100))
					self.contents.draw_text(x, 33, 49, 58, skill.name.to_s)
					#Increase Count
					count += 1
				end
			end
			#Change font size
			self.contents.font.size = 20
		end
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			if @old_x != $game_player.x or @old_y != $game_player.y
				@pos.dispose
				@pos = Sprite.new
				@pos.bitmap = Bitmap.new(100, 100)
				@pos.bitmap.font.size = 12
				
				@pos.visible = self.visible
				@pos.x = 520
				@pos.y = 320
				@pos.z = 99999
				@pos.bitmap.font.color = normal_color
				@pos.bitmap.draw_frame_text(0, 0, 640, 32, "좌표: [#{'%03d' % ($game_player.x + 1)}] [#{'%03d' % ($game_player.y + 1)}]")
				@old_x = $game_player.x
				@old_y = $game_player.y
			end
			
			if something_changed?
				refresh 
				Network::Main.send_newstats
			end
		end
		#--------------------------------------------------------------------------
		# * Something Changed?
		#--------------------------------------------------------------------------
		def something_changed?
			return false if Graphics.frame_count % 30 != 0
			return true if @actor != $game_party.actors[0]
			return true if @old_hp != @actor.hp or @old_sp != @actor.sp or @old_exp != @actor.exp
			return true if @level != @actor.level
			return true if @hp_n != $game_party.item_number(HP_ITEMID) or @sp_n != $game_party.item_number(SP_ITEMID)
			return true if @gold_n != $game_party.gold
			return true if @states.to_s != @actor.states.to_s
			return true if @dash != $ABS.dash_min or @sneak != $ABS.sneak_min
			return true if $kts != nil and @time != $kts.time.to_s
			return false
		end
		#--------------------------------------------------------------------------
		def CAN_TOGGLE
			return CAN_TOGGLE
		end
		#--------------------------------------------------------------------------
		def TOGGLE_KEY
			return TOGGLE_KEY
		end
	end
	#==============================================================================
	# * Scene_Map
	#==============================================================================
	class Scene_Map
		#--------------------------------------------------------------------------
		alias mrmo_hud_main_draw main_draw
		alias mrmo_hud_main_dispose main_dispose
		alias mrmo_hud_update_graphics update_graphics
		alias mrmo_keyhud_update update
		attr_accessor:mrmo_hud
		#--------------------------------------------------------------------------
		# * Main Draw
		#--------------------------------------------------------------------------
		def main_draw
			@mrmo_hud = Window_MrMo_HUD.new
			@mrmo_hud.visible = false if !$game_switches[62]
			mrmo_hud_main_draw
		end
		#--------------------------------------------------------------------------
		# * Turn HUD Show
		#--------------------------------------------------------------------------
		def hud_show
			@mrmo_hud.visible = true
			@mrmo_hud.pos.visible = true
			$game_switches[62] = true
		end
		#--------------------------------------------------------------------------
		# * Turn HUD Hide
		#--------------------------------------------------------------------------
		def hud_hide
			@mrmo_hud.visible = false
			@mrmo_hud.pos.visible = false
			$game_switches[62] = false
		end
		#--------------------------------------------------------------------------
		# * Main Dispose
		#--------------------------------------------------------------------------
		def main_dispose
			@mrmo_hud.dispose
			mrmo_hud_main_dispose
		end
		#--------------------------------------------------------------------------
		# * Update Graphics
		#--------------------------------------------------------------------------
		def update_graphics
			mrmo_hud_update_graphics
			@mrmo_hud.update
		end
		#--------------------------------------------------------------------------
		# * Update
		#--------------------------------------------------------------------------
		def update
			mrmo_keyhud_update
			if not $map_chat_input.active
				# 만약 토글키가 눌리면? 보여줄까 말까
				if @mrmo_hud.CAN_TOGGLE and Key.trigger?(KEY_E)
					if !@mrmo_hud.visible
						hud_show
						return 
					elsif @mrmo_hud.visible
						hud_hide
						return 
					end
				end
			end
		end
	end
	
	#--------------------------------------------------------------------------
	# * SDK End
	#--------------------------------------------------------------------------
end
class Game_Actor
	#--------------------------------------------------------------------------
	# * Get the current EXP
	#--------------------------------------------------------------------------
	def now_exp
		return @exp - @exp_list[@level]
	end
	#--------------------------------------------------------------------------
	# * Get the next level's EXP
	#--------------------------------------------------------------------------
	def next_exp
		exp = @exp_list[@level+1] > 0 ? @exp_list[@level+1] - @exp_list[@level] : 0
		return exp
	end
end