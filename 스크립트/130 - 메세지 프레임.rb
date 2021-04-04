#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/ 
#_/　　◆인연 잡기·그림자 문자 묘화 － KGC_FrameShadowText◆ 
#_/---------------------------------------------------------------------------- 
#_/　draw_text 를 강화해, 인연 잡기나 그림자 문자의 묘화 기능을 추가합니다. 
#_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/ 


#============================================================================== 
# ■ Bitmap 
#============================================================================== 

class Bitmap 
	#-------------------------------------------------------------------------- 
	# ● 테두리 문자 묘화 
	#     x, y, width, height, string[, align, frame_color] 
	#    rect, string[, align, frame_color] 
	#-------------------------------------------------------------------------- 
	def draw_frame_text(*args) 
		# 引?判定 
		if args[0].is_a?(Rect) 
			if args.size >= 2 && args.size <= 4 
				# 引?を?理用のロ?カル??へコピ? 
				x, y = args[0].x, args[0].y 
				width, height = args[0].width, args[0].height 
				string = args[1] 
				align = args[2] == nil ? 0 : args[2] 
				frame_color = args[3] == nil ? Color.new(0, 0, 0) : args[3] 
			else 
				# 引?が不正ならエラ?を吐く 
				raise(ArgumentError, "wrong number of arguments(#{args.size} of #{args.size < 2 ? 2 : 4})") 
				return 
			end 
		else 
			if args.size >= 5 && args.size <= 7 
				# 引?を?理用のロ?カル??へコピ? 
				x, y, width, height = args 
				string = args[4] 
				align = args[5] == nil ? 0 : args[5]
				frame_color = !args[6].is_a?(Color) ? Color.new(0, 0, 0) : args[6] 
			else 
				# 引?が不正ならエラ?を吐く 
				raise(ArgumentError, "wrong number of arguments(#{args.size} of #{args.size < 5 ? 5 : 7})") 
				return 
			end 
		end 
		# 元の色を保存 
		origin_color = font.color.dup 
		# ?取り 
		font.color = frame_color 
		draw_text(x - 1, y - 1, width, height, string, align) 
		draw_text(x - 1, y + 1, width, height, string, align) 
		draw_text(x + 1, y - 1, width, height, string, align) 
		draw_text(x + 1, y + 1, width, height, string, align) 
		# 元の色に?す 
		font.color = origin_color 
		draw_text(x, y, width, height, string, align) 
	end 
	#-------------------------------------------------------------------------- 
	# ● 影文字描? 
	#     x, y, width, height, string[, align, shadow_color] 
	#    rect, string[, align, shadow_color] 
	#-------------------------------------------------------------------------- 
	def draw_shadow_text(*args) 
		# 引?判定 
		if args[0].is_a?(Rect) 
			if args.size >= 2 && args.size <= 4 
				# 引?を?理用のロ?カル??へコピ? 
				x, y = args[0].x, args[0].y 
				width, height = args[0].width, args[0].height 
				string = args[1] 
				align = args[2] == nil ? 0 : args[2] 
				shadow_color = args[3] == nil ? Color.new(0, 0, 0) : args[3] 
			else 
				# 引?が不正ならエラ?を吐く 
				raise(ArgumentError, "wrong number of arguments(#{args.size} of #{args.size < 2 ? 2 : 4})") 
				return 
			end 
		else 
			if args.size >= 5 && args.size <= 7 
				# 引?を?理用のロ?カル??へコピ? 
				x, y, width, height = args 
				string = args[4] 
				align = args[5] == nil ? 0 : args[5] 
				shadow_color = args[6] == nil ? Color.new(0, 0, 0) : args[6] 
			else 
				# 引?が不正ならエラ?を吐く 
				raise(ArgumentError, "wrong number of arguments(#{args.size} of #{args.size < 5 ? 5 : 7})") 
				return 
			end 
		end 
		# 元の色を保存 
		origin_color = font.color.dup 
		# 影描? 
		font.color = shadow_color 
		draw_text(x + 2, y + 2, width, height, string, align) 
		# 元の色に?す 
		font.color = origin_color 
		draw_text(x, y, width, height, string, align) 
	end 
end 
