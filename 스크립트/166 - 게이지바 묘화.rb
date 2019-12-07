#--------------------------------------------------------------------------
# * Load Gradient from RPG::Cache
#--------------------------------------------------------------------------
module RPG
	module Cache
		def self.gradient(filename, hue = 0)
			self.load_bitmap("Graphics/Gradients/", filename, hue)
		end
	end
end
class Window_Base < Window
	#--------------------------------------------------------------------------
	# * Constants Bar Types and Hues for parameters and parameter names
	#--------------------------------------------------------------------------
	HP_BAR = "014-Reds01"
	SP_BAR = "013-Blues01"
	EXP_BAR = "015-Greens01"
	ATK_BAR = "020-Metallic01"
	PDEF_BAR = "020-Metallic01"
	MDEF_BAR = "020-Metallic01"
	STR_BAR = "020-Metallic01"
	DEX_BAR = "020-Metallic01"
	AGI_BAR = "020-Metallic01"
	INT_BAR = "020-Metallic01"
	HUES = [150,180,60,30,270,350,320]
	STATS = ["atk","pdef","mdef","str","dex","agi","int"]
	# leave this alone if you don't know what you are doing
	OUTLINE = 1
	BORDER = 1
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
		self.contents.stretch_blt(back_dest_rect, back, back_source_rect)
		self.contents.stretch_blt(back2_dest_rect, back2, back2_source_rect)
		self.contents.stretch_blt(bar_dest_rect, bar, bar_source_rect)
	end  
	
	def draw_vertical_gradient_bar(x, y, min, max, file, width = nil, height = nil, hue = 0, back = "Back", back2 = "Back2")
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
		bar_y = (zoom_y - zoom_y * percent).ceil
		source_y = bar.height - bar.height * percent
		back_dest_rect = Rect.new(x,y,zoom_x,zoom_y)
		back2_dest_rect = Rect.new(x+dx,y+dy,zoom_x -dx*2,zoom_y-dy*2)
		bar_dest_rect = Rect.new(x+cx,y+bar_y+cy,zoom_x-cx*2,(zoom_y * percent).to_i-cy*2)
		back_source_rect = Rect.new(0,0,back.width,back.height)
		back2_source_rect = Rect.new(0,0,back2.width,back2.height)
		bar_source_rect = Rect.new(0,source_y,bar.width,bar.height * percent)
		self.contents.stretch_blt(back_dest_rect, back, back_source_rect)
		self.contents.stretch_blt(back2_dest_rect, back2, back2_source_rect)
		self.contents.stretch_blt(bar_dest_rect, bar, bar_source_rect)
	end  
	#--------------------------------------------------------------------------
	# * Draw HP
	#     actor : actor
	#     x     : draw spot x-coordinate
	#     y     : draw spot y-coordinate
	#     width : draw spot width
	#--------------------------------------------------------------------------
	alias trick_draw_actor_hp draw_actor_hp
	def draw_actor_hp(actor, x, y, width = 144)
		# Calculate if there is draw space for MaxHP
		if width - 32 >= 108
			hp_x = x + width - 108
			flag = true
		elsif width - 32 >= 48
			hp_x = x + width - 48
			flag = false
		end
		width = hp_x - x
		width += $game_temp.in_battle ? 50 : 100
		# Draw HP
		draw_gradient_bar(x, y + 16, actor.hp, actor.maxhp, HP_BAR, width, 8)
		trick_draw_actor_hp(actor, x, y, width)
	end
	#--------------------------------------------------------------------------
	# * Draw SP
	#     actor : actor
	#     x     : draw spot x-coordinate
	#     y     : draw spot y-coordinate
	#     width : draw spot width
	#--------------------------------------------------------------------------
	alias trick_draw_actor_sp draw_actor_sp
	def draw_actor_sp(actor, x, y, width = 144)
		# Calculate if there is draw space for MaxHP
		if width - 32 >= 108
			sp_x = x + width - 108
			flag = true
		elsif width - 32 >= 48
			sp_x = x + width - 48
			flag = false
		end
		width = sp_x - x
		width += $game_temp.in_battle ? 50 : 100
		# Draw SP
		draw_gradient_bar(x, y + 16, actor.sp, actor.maxsp, SP_BAR, width, 8)
		trick_draw_actor_sp(actor, x, y, width)
	end
	#--------------------------------------------------------------------------
	# * Draw Exp
	#     actor : actor
	#     x     : draw spot x-coordinate
	#     y     : draw spot y-coordinate
	#--------------------------------------------------------------------------
	alias trick_bars_base_exp draw_actor_exp
	def draw_actor_exp(actor, x, y)
	end
	#--------------------------------------------------------------------------
	# * Draw Parameter
	#     actor : actor
	#     x     : draw spot x-coordinate
	#     y     : draw spot y-coordinate
	#     type  : draw which parameter
	#--------------------------------------------------------------------------
	alias trick_bars_base_parameter draw_actor_parameter
	def draw_actor_parameter(actor, x, y, type)
		hue = HUES[type]
		stat = eval("actor.#{STATS[type]}")
		bar_type = eval("#{STATS[type].upcase}_BAR")
		draw_gradient_bar(x, y + 18, stat, 999, bar_type, 190, 8, hue)
		trick_bars_base_parameter(actor, x, y, type)
	end
end
