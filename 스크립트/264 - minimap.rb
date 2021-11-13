#============================================================================== 
# 축소 맵의 표시(ver 0.999) 
# by 피놀 clum-sea 
#============================================================================== 


#============================================================================== 
# 캐스터 마이즈포인트 
#============================================================================== 
$zoom = 1.0
module PLAN_Map_Window 
	WIN_X = 100 # 윈도우의 X 좌표 
	WIN_Y = 20 # 윈도우의 Y 좌표 
	WIN_WIDTH = 13 * 32 # 윈도우의 폭 
	WIN_HEIGHT = 13 * 32 # 윈도우의 높이 
	ZOOM = 5.0 # 프의 축소율(32 * 32 의 타일을 몇분의 1으로 할까) 
	WINDOWSKIN = "" # 스킨(하늘에서 디폴트) 
	
	ON_OFF_KEY = KEY_M # 윈도우의 온 오프를 바꾸는 버튼 
	
	SWITCH = 40 # 맵 윈도우 표시 금지용의 스윗치 번호 
	# (ON로 표시 금지, OFF로 표시 가능) 
	
	WINDOW_MOVE = false # 윈도우와 플레이어가 겹쳤을 시 자동적으로 이동할까 
	# (true:하는, false:하지 않는다) 
	OVER_X = 632 - WIN_WIDTH # 이동 후의 X 좌표(초기 위치와 왕복합니다) 
	OVER_Y = 8 # 이동 후의 Y 좌표(초기 위치와 왕복합니다) 
	
	OPACITY = 124 # 윈도우의 투명도
	C_OPACITY = 255 # 맵의 투명도 
	VISIBLE = false # 최초, 표시할까 하지 않는가(true:하는, false:하지 않는다) 
end 

#============================================================================== 
# ?? Game_Temp 
#============================================================================== 
class Game_Temp 
	#-------------------------------------------------------------------------- 
	# ● 공개 인스턴스 변수 
	#-------------------------------------------------------------------------- 
	attr_accessor :map_visible # ?맵 윈도우의 표시 상태 
	#-------------------------------------------------------------------------- 
	# ● 오브젝트 초기화 
	#-------------------------------------------------------------------------- 
	alias plan_map_window_initialize initialize 
	def initialize 
		# 되돌린다 
		plan_map_window_initialize 
		
		@map_visible = PLAN_Map_Window::VISIBLE
	end 
end 
#============================================================================== 
# ■ Scene_Map 
#============================================================================== 

class Scene_Map 
	#-------------------------------------------------------------------------- 
	# ● 메인 처리 
	#-------------------------------------------------------------------------- 
	alias plan_map_window_main main 
	def main 
		# 윈도우를 작성 
		@map_window = Window_Map.new 
		@map_window.visible = $game_temp.map_visible 
		# 되돌린다 
		plan_map_window_main 
		# 메세지 윈도우를 해방 
		@map_window.dispose if !@map_window.disposed?
	end 
	#-------------------------------------------------------------------------- 
	# ● 프레임 갱신 
	#-------------------------------------------------------------------------- 
	alias plan_map_window_update update 
	def update 
		# visible 를 기억 
		$game_temp.map_visible = @map_window.visible 
		# 되돌린다 
		plan_map_window_update 
		
		# 금지가 아니면, 변환 처리 
		unless $game_switches[PLAN_Map_Window::SWITCH] 
			# 표시되고 있는 경우, 비표시로 한다
			if not $map_chat_input.active
				@map_window.visible = false if Key.trigger?(KEY_ESC)
				if Key.trigger?(PLAN_Map_Window::ON_OFF_KEY)
					# 표시되어 있지 않은 경우, 표시한다 
					if @map_window.visible 
						@map_window.visible = false 
						# 표시되어 있지 않은 경우, 표시한다 
					else 
						@map_window.visible = true 
					end 
				end
			end 
			# 금지의 경우는 강제적으로 비표시 
		else 
			if @map_window.visible 
				@map_window.visible = false
			end 
		end 
		# 표시되고 있을 때만 갱신 
		if @map_window.visible 
			@map_window.update 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 플레이어의 장소 이동 
	#-------------------------------------------------------------------------- 
	alias plan_map_window_transfer_player transfer_player 
	def transfer_player 
		# visible 를 기억 
		visible = @map_window.visible  
		# 되돌린다 
		plan_map_window_transfer_player 
		# 맵 윈도우를 해방 
		@map_window.dispose if !@map_window.disposed?
		# 맵 윈도우를 작성 
		@map_window = Window_Map.new 
		# 표시 설정을 전맵 상태에 되돌린다 
		@map_window.visible = visible 
	end 
end 


#============================================================================== 
# ■ Window_Map 
#============================================================================== 

class Window_Map < Window_Base 
	#-------------------------------------------------------------------------- 
	# 타일 맵의 경우 
	#-------------------------------------------------------------------------- 
	def initialize 
		x = PLAN_Map_Window::WIN_X 
		y = PLAN_Map_Window::WIN_Y 
		w = PLAN_Map_Window::WIN_WIDTH 
		h = PLAN_Map_Window::WIN_HEIGHT 
		super(x, y, w, h) # 해당 좌표에 창을 띄움
		
		unless PLAN_Map_Window::WINDOWSKIN.empty? 
			self.windowskin = RPG::Cache.windowskin(PLAN_Map_Window::WINDOWSKIN) 
		end 
		self.contents = Bitmap.new(width - 32, height - 32) 
		
		self.opacity = PLAN_Map_Window::OPACITY 
		self.contents_opacity = PLAN_Map_Window::C_OPACITY 
		@map_data = $game_map.data 
		
		# 현재 맵의 타일 데이터 가져옴 
		@tileset = RPG::Cache.tileset($game_map.tileset_name) if $game_map.tileset_name != nil
		@autotiles = [] 
		for i in 0..6 
			if $game_map.autotile_names != nil
				autotile_name = $game_map.autotile_names[i] 
				@autotiles[i] = RPG::Cache.autotile(autotile_name) 
			end
		end 
		# 플레이어 위치 저장
		@old_real_x = $game_player.real_x 
		@old_real_y = $game_player.real_y 
		# 맵 그래픽 구현 
		@all_map = make_all_map 
		@all_event = make_all_event
		
		# 창 표시
		self.visible = PLAN_Map_Window::VISIBLE 
		refresh 
	end 
	
	
	def make_all_event
		test_bitmap = Bitmap.new(self.contents.width, self.contents.height)
		for event in $game_map.events.values
			next if event.list == nil
			if event.list[0].code != 108
				size = 8
				bitmap = Bitmap.new(size, size)
				if event.list[0].code == 201
					bitmap.fill_rect(bitmap.rect, Color.new(100, 100, 255)) # 꽉찬 네모  	
				else
					bitmap.fill_rect(bitmap.rect, Color.new(0, 255, 0)) # 꽉찬 네모  
				end
				w = bitmap.width 
				h = bitmap.height
				
				src_rect = Rect.new(0, 0, w, h) 
				
				one_tile_size = 32 / $zoom
				
				x = (event.x ) * one_tile_size + (self.contents.width - @all_map.width) / 2
				y = (event.y ) * one_tile_size + (self.contents.height - @all_map.height) / 2
				
				dest_rect = Rect.new(x, y, w, h) 
				test_bitmap.stretch_blt(dest_rect, bitmap, src_rect) 
			end
		end
		
		ret_bitmap = Bitmap.new(self.contents.width, self.contents.height)
		src_rect = Rect.new(0, 0, test_bitmap.width, test_bitmap.height) 
		dest_rect = Rect.new(0, 0, ret_bitmap.width, ret_bitmap.height) 
		ret_bitmap.stretch_blt(dest_rect, test_bitmap, src_rect) 
		return ret_bitmap
	end
	
	#-------------------------------------------------------------------------- 
	# ?? ??b?v???S??????????i?k???????t???j 
	#-------------------------------------------------------------------------- 
	def make_all_map 
		all_map = Bitmap.new($game_map.width * 32, $game_map.height * 32) 
		for y in 0...$game_map.height 
			for x in 0...$game_map.width 
				for z in 0...3 
					tile_num = @map_data[x, y, z] 
					next if tile_num == nil 
					# ?I??g??C???????? 
					if tile_num < 384 
						# ????C???????????????? 
						if tile_num >= 48 
							tile_num -= 48 
							src_rect = Rect.new(32, 2 * 32, 32, 32) 
							all_map.blt(x * 32, y * 32, @autotiles[tile_num / 48], src_rect) 
						end 
						# 타일 맵의 경우 
					else 
						tile_num -= 384 
						src_rect = Rect.new(tile_num % 8 * 32, tile_num / 8 * 32, 32, 32) 
						all_map.blt(x * 32, y * 32, @tileset, src_rect) 
					end 
				end 
			end 
		end 
		# 맵의 크기에 맞게 축소해보자
		v_max = [$game_map.width, $game_map.height].max
		$zoom = ((v_max + 8) * (32.0) / PLAN_Map_Window::WIN_WIDTH)
		
		w = ($game_map.width / $zoom) * 32 
		h = ($game_map.height / $zoom) * 32 
		ret_bitmap = Bitmap.new(w, h) 
		src_rect = Rect.new(0, 0, all_map.width, all_map.height) 
		dest_rect = Rect.new(0, 0, ret_bitmap.width, ret_bitmap.height) 
		ret_bitmap.stretch_blt(dest_rect, all_map, src_rect) 
		all_map.dispose if !all_map.disposed?
		return ret_bitmap 
	end 
	#-------------------------------------------------------------------------- 
	# ● 리프레쉬 
	#-------------------------------------------------------------------------- 
	def refresh 
		self.contents.clear 
		# 축소 맵 표시 
		one_tile_size = 32 / $zoom 
		x = $game_player.real_x - 128 * (self.contents.width / one_tile_size) / 2 
		y = $game_player.real_y - 128 * (self.contents.height / one_tile_size) / 2 
		x = x * one_tile_size / 128 
		y = y * one_tile_size / 128 
		
		# 스크롤 스톱 처리(옆) 
		# 캐릭터의 위치(contents 의 중앙) 
		half_width = self.contents.width * 128 / 2 
		# 캐릭터의 위치(실위치)~맵의 구석까지의 나머지폭 
		rest_width = ($game_map.width * 128 - $game_player.real_x) * one_tile_size 
		# 윈도우보다 맵의 폭이 작으면 
		rev_x = 0 
		# 맵이 윈도우보다 작은 경우는 중앙 표시 
		if @all_map.width < self.contents.width 
			rev_x = (half_width - $game_player.real_x * one_tile_size) / 128 
			rev_x -= (self.contents.width - @all_map.width) / 2 
			x += rev_x 
			# ??????b?v????????????? 
		elsif half_width > $game_player.real_x * one_tile_size 
			rev_x = (half_width - $game_player.real_x * one_tile_size) / 128 
			x += rev_x 
			# 오른쪽이 맵의 구석을 넘으면 
		elsif half_width > rest_width 
			rev_x = -((half_width - rest_width) / 128) 
			x += rev_x 
		end 
		
		# 스크롤 스톱 처리(세로) 
		# 캐릭터의 정도 치(contents 의 중앙) 
		half_height = self.contents.height * 128 / 2 
		# 캐릭터의 위치(실위치)~맵의 구석까지의 나머지 높이 
		rest_height = ($game_map.height * 128 - $game_player.real_y) * one_tile_size 
		# 윈도우보다 맵의 폭이 작으면 
		rev_y = 0 
		# 맵이 윈도우보다 작은 경우는 중앙 표시 
		if @all_map.height < self.contents.height 
			rev_y = (half_height - $game_player.real_y * one_tile_size) / 128 
			rev_y -= (self.contents.height - @all_map.height) / 2 
			y += rev_y 
			# 오른쪽이 맵의 구석을 넘으면 
		elsif half_height > $game_player.real_y * one_tile_size 
			rev_y = (half_height - $game_player.real_y * one_tile_size) / 128 
			y += rev_y 
			# ?E????b?v????????????? 
		elsif half_height > rest_height 
			rev_y = -((half_height - rest_height) / 128) 
			y += rev_y 
		end 
		
		src_rect = Rect.new(x, y, self.contents.width, self.contents.height)
		src_rect2 = Rect.new(0, 0, self.contents.width, self.contents.height)
		self.contents.blt(0, 0, @all_map, src_rect) 
		self.contents.blt(0, 0, @all_event, src_rect2) 
		
		# 윈도우의 이동 처리 
		if PLAN_Map_Window::WINDOW_MOVE == true 
			# 윈도우의 범위를 취득(범위 오브젝트) 
			w = self.x..self.x + self.width 
			h = self.y..self.y + self.height 
			# 플레이어가 윈도우의 범위내에 들어갔을 경우 
			if w === $game_player.screen_x and h === $game_player.screen_y 
				# 이동 장소 판정 
				# 초기 위치라면 
				if self.x == PLAN_Map_Window::WIN_X and self.y == PLAN_Map_Window::WIN_Y 
					# 이동 후의 좌표에 이동 
					self.x = PLAN_Map_Window::OVER_X 
					self.y = PLAN_Map_Window::OVER_Y 
					# 초기 위치가 아닌 경우 
				else 
					# 초기 위치에 이동 
					self.x = PLAN_Map_Window::WIN_X 
					self.y = PLAN_Map_Window::WIN_Y 
				end 
			end 
		end 
				
		# 액터가 있는 경우는 최초의 액터를 맵에 표시 
		if $game_party.actors.size > 0 
			actor = $game_party.actors[0] 
			size = 40
			bitmap = Bitmap.new(size, size)
			bitmap.fill_rect(bitmap.rect, Color.new(255, 255, 0)) # 꽉찬 네모 
			#bitmap = RPG::Cache.character(actor.character_name, actor.character_hue) 
			width = bitmap.width / 4 
			height = bitmap.height / 4 
			src_rect = Rect.new(0, 0, width, height) 
			# 액터를 중앙에 표시 
			w = width #/ $zoom 
			h = height #/ $zoom
			# 타일의 폭만 짝수이므로 반타일분 늦춘다 
			x = self.contents.width / 2 - w / 2 + one_tile_size / 2 - rev_x 
			y = self.contents.height / 2 - h / 2 - rev_y 
			dest_rect = Rect.new(x, y, w, h) 
			self.contents.stretch_blt(dest_rect, bitmap, src_rect) 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 프레임 갱신 
	#-------------------------------------------------------------------------- 
	def update 
		super 
		if @old_real_x != $game_player.real_x or @old_real_y != $game_player.real_y 
			@old_real_x = $game_player.real_x 
			@old_real_y = $game_player.real_y 
			refresh 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 해방 
	#-------------------------------------------------------------------------- 
	def dispose 
		super 
		@all_map.dispose 
	end 
end
