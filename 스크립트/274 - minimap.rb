#============================================================================== 
# 축소 맵의 표시(ver 0.999) 
# by 피놀 clum-sea 
#============================================================================== 


#============================================================================== 
# 캐스터 마이즈포인트 
#============================================================================== 
$zoom = 1.0
$minimap_data_cache = {} # 미니맵 데이터를 저장하자.

module PLAN_Map_Window 
	WIN_X = 100 # 윈도우의 X 좌표 
	WIN_Y = 20 # 윈도우의 Y 좌표 
	WIN_WIDTH = 13 * 32 # 윈도우의 폭 
	WIN_HEIGHT = 13 * 32 # 윈도우의 높이 
	ZOOM = 5.0 # 프의 축소율(32 * 32 의 타일을 몇분의 1으로 할까) 
	WINDOWSKIN = "" # 스킨(하늘에서 디폴트) 
	
	ON_OFF_KEY = KEY_M # 윈도우의 온 오프를 바꾸는 버튼 
	
	SWITCH = 63 # 맵 윈도우 표시 금지용의 스윗치 번호 
	# (ON로 표시 금지, OFF로 표시 가능) 
	
	NAME_SWITCH = 64 # 맵 이벤트 이름의 스윗치 번호 
	# (ON로 표시 금지, OFF로 표시 가능) 
	
	WINDOW_MOVE = false # 윈도우와 플레이어가 겹쳤을 시 자동적으로 이동할까 
	# (true:하는, false:하지 않는다) 
	OVER_X = 632 - WIN_WIDTH # 이동 후의 X 좌표(초기 위치와 왕복합니다) 
	OVER_Y = 8 # 이동 후의 Y 좌표(초기 위치와 왕복합니다) 
	
	OPACITY = 180 # 윈도우의 투명도
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
		plan_map_window_initialize # 되돌린다
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
		plan_map_window_main 
		@map_window.dispose if !@map_window.disposed?
	end 
	#-------------------------------------------------------------------------- 
	# ● 프레임 갱신 
	#-------------------------------------------------------------------------- 
	alias plan_map_window_update update 
	def update  
		$game_temp.map_visible = @map_window.visible 
		plan_map_window_update 
		
		if $game_switches[PLAN_Map_Window::SWITCH] 
			return if $inputKeySwitch
			
			@map_window.visible = false if Key.trigger?(KEY_ESC)
			@map_window.visible = !@map_window.visible if Key.trigger?(PLAN_Map_Window::ON_OFF_KEY)
		else
			$console.write_line("지도를 펼 수 없습니다.") if Key.trigger?(PLAN_Map_Window::ON_OFF_KEY)
			@map_window.visible = false if @map_window.visible
		end 
		
		# 표시되고 있을 때만 갱신 
		@map_window.update if @map_window.visible 
	end 
	
	#-------------------------------------------------------------------------- 
	# ● 플레이어의 장소 이동 
	#-------------------------------------------------------------------------- 
	alias plan_map_window_transfer_player transfer_player 
	def transfer_player 
		visible = @map_window.visible     
		plan_map_window_transfer_player 
		@map_window.dispose if !@map_window.disposed?
		@map_window = Window_Map.new 
		@map_window.visible = visible 
	end 
end 


#============================================================================== 
# ■ Window_Map 
#============================================================================== 

class Window_Map < Window_Base 
	#-------------------------------------------------------------------------- 
	# 초기화
	#-------------------------------------------------------------------------- 
	def initialize 
		x = PLAN_Map_Window::WIN_X
		y = PLAN_Map_Window::WIN_Y
		w = PLAN_Map_Window::WIN_WIDTH
		h = PLAN_Map_Window::WIN_HEIGHT
		super(x, y, w, h)
		
		initialize_window_properties
		initialize_window_bitmap
		initialize_player_position
		initialize_map_cache
		
		self.visible = PLAN_Map_Window::VISIBLE 
		refresh 
	end 
	
	#-------------------------------------------------------------------------- 
	# 창 속성 초기화
	#-------------------------------------------------------------------------- 
	def initialize_window_properties
		self.z = 999999
		unless PLAN_Map_Window::WINDOWSKIN.empty?
			self.windowskin = RPG::Cache.windowskin(PLAN_Map_Window::WINDOWSKIN)
		end
		self.opacity = PLAN_Map_Window::OPACITY
		self.contents_opacity = PLAN_Map_Window::C_OPACITY
	end
	
	#-------------------------------------------------------------------------- 
	# 창 비트맵 초기화
	#-------------------------------------------------------------------------- 
	def initialize_window_bitmap
		self.contents = Bitmap.new(width - 32, height - 32)
	end
	
	#-------------------------------------------------------------------------- 
	# 플레이어 위치 초기화
	#-------------------------------------------------------------------------- 
	def initialize_player_position
		@old_real_x = $game_player.real_x
		@old_real_y = $game_player.real_y
	end
	
	#-------------------------------------------------------------------------- 
	# 맵 캐시 초기화
	#-------------------------------------------------------------------------- 
	def initialize_map_cache
		if $minimap_data_cache[$game_map.map_id]
			@all_map = $minimap_data_cache[$game_map.map_id][0]
			@all_event = $minimap_data_cache[$game_map.map_id][1]
			@mapTxtBitmap = $minimap_data_cache[$game_map.map_id][2]
			$zoom = $minimap_data_cache[$game_map.map_id][3]
		else
			load_map_data
			generate_map_graphics
			cache_map_data
		end
	end
	
	#-------------------------------------------------------------------------- 
	# 맵 데이터 로드
	#-------------------------------------------------------------------------- 
	def load_map_data
		@map_data = $game_map.data		
		@tileset = RPG::Cache.tileset($game_map.tileset_name) if $game_map.tileset_name
		@autotiles = []
		
		if $game_map.autotile_names
			$game_map.autotile_names.each_with_index do |name, i|
				@autotiles[i] = RPG::Cache.autotile(name)
			end
		end
	end
	
	#-------------------------------------------------------------------------- 
	# 맵 그래픽 생성
	#-------------------------------------------------------------------------- 
	def generate_map_graphics
		@mapTxtBitmap = Bitmap.new(self.contents.width, self.contents.height)
		@all_map = make_all_map
		@all_event = make_all_event
	end
	
	#-------------------------------------------------------------------------- 
	# 맵 데이터 캐시
	#-------------------------------------------------------------------------- 
	def cache_map_data
		$minimap_data_cache[$game_map.map_id] = [@all_map, @all_event, @mapTxtBitmap, $zoom]
		@map_data = nil
	end
	
	#-------------------------------------------------------------------------- 
	# 전체 맵 그래픽 생성
	#-------------------------------------------------------------------------- 
	def make_all_map 
		all_map = Bitmap.new($game_map.width * 32, $game_map.height * 32) 
		$game_map.height.times do |y|
			$game_map.width.times do |x|
				3.times do |z|
					tile_num = @map_data[x, y, z]
					next unless tile_num
					
					if tile_num < 384 
						draw_autotile(all_map, x, y, tile_num)
					else 
						draw_tile(all_map, x, y, tile_num)
					end 
				end
			end
		end
		
		resize_map(all_map)
	end 
	
	#-------------------------------------------------------------------------- 
	# 오토타일 그리기
	#-------------------------------------------------------------------------- 
	def draw_autotile(all_map, x, y, tile_num)
		return unless tile_num >= 48
		
		tile_num -= 48 
		src_rect = Rect.new(32, 2 * 32, 32, 32) 
		all_map.blt(x * 32, y * 32, @autotiles[tile_num / 48], src_rect) 
	end
	
	#-------------------------------------------------------------------------- 
	# 타일 그리기
	#-------------------------------------------------------------------------- 
	def draw_tile(all_map, x, y, tile_num)
		tile_num -= 384 
		src_rect = Rect.new(tile_num % 8 * 32, tile_num / 8 * 32, 32, 32) 
		all_map.blt(x * 32, y * 32, @tileset, src_rect) 
	end
	
	#-------------------------------------------------------------------------- 
	# 맵 크기 조정
	#-------------------------------------------------------------------------- 
	def resize_map(all_map)
		max_length = [all_map.width, all_map.height].max
		$zoom = max_length.to_f / self.contents.width
		
		w = all_map.width / $zoom
		h = all_map.height / $zoom
		ret_bitmap = Bitmap.new(w, h)
		ret_bitmap.stretch_blt(ret_bitmap.rect, all_map, all_map.rect)
		all_map.dispose unless all_map.disposed?
		
		ret_bitmap
	end
	
	#-------------------------------------------------------------------------- 
	# 이벤트 그래픽 생성
	#-------------------------------------------------------------------------- 
	def make_all_event
		all_event_bitmap = Bitmap.new(self.contents.width, self.contents.height)
		map_infos = load_data("Data/MapInfos.rxdata")
		
		$game_map.events.values.each do |event|
			next unless event.list
			
			if event.list[0].code != 108
				event_bitmap, event_name_bitmap = create_event_bitmaps
				name = find_event_text(event, map_infos, event_bitmap)
				draw_event(all_event_bitmap, event, event_bitmap, event_name_bitmap, name)
			end
		end
		
		all_event_bitmap
	end
	
	#-------------------------------------------------------------------------- 
	# 이벤트 비트맵 생성
	#-------------------------------------------------------------------------- 
	def create_event_bitmaps
		@event_bitmap_size = 8
		event_bitmap = Bitmap.new(@event_bitmap_size, @event_bitmap_size)
		event_name_bitmap = Bitmap.new(200, 20)
		event_name_bitmap.font.size = 12
		event_name_bitmap.font.color = COLOR_NORMAL
		[event_bitmap, event_name_bitmap]
	end
	
	#-------------------------------------------------------------------------- 
	# 이벤트 텍스트 찾기
	#-------------------------------------------------------------------------- 
	def find_event_text(event, map_infos, event_bitmap)
		name = nil
		if event.text_display # npc등 이름이 있을 경우
			name = event.text_display[0]
			event_bitmap.fill_rect(event_bitmap.rect, Color.new(0, 255, 0))
		else
			event.list.each do |command| # 맵 이동하는 포탈일 경우
				next unless command.code == 201
				next unless command.parameters
				
				target_map_info = map_infos[command.parameters[1]]
				next unless target_map_info
				
				name = target_map_info.name.to_s
				event_bitmap.fill_rect(event_bitmap.rect, Color.new(100, 100, 255))
				break
			end
		end
		name
	end
	
	#-------------------------------------------------------------------------- 
	# 이벤트 그리기
	#-------------------------------------------------------------------------- 
	def draw_event(all_event_bitmap, event, event_bitmap, event_name_bitmap, name)
		one_tile_size = 32 / $zoom
		x = event.x * one_tile_size + (self.contents.width - @all_map.width) / 2
		y = event.y * one_tile_size + (self.contents.height - @all_map.height) / 2
		all_event_bitmap.blt(x, y, event_bitmap, event_bitmap.rect)
		
		return unless name
		
		event_name_bitmap.draw_frame_text(0, 0, event_name_bitmap.width, event_name_bitmap.height, name)
		txt_size = event_name_bitmap.text_size(name)
		txt_x = x - (txt_size.width - @event_bitmap_size) / 2
		txt_y = y - (txt_size.height - @event_bitmap_size) / 2
		txt_y = y - txt_size.height if (txt_y + txt_size.height >= self.contents.height)
		
		@mapTxtBitmap.blt(txt_x, txt_y, event_name_bitmap, event_name_bitmap.rect)
	end
	
	#-------------------------------------------------------------------------- 
	# 리프레쉬 
	#-------------------------------------------------------------------------- 
	def refresh  
		self.contents.clear
		x = (self.contents.width - @all_map.width) / 2
		y = (self.contents.height - @all_map.height) / 2
		
		self.contents.blt(x, y, @all_map, self.contents.rect)
		self.contents.blt(0, 0, @all_event, self.contents.rect)
		self.contents.blt(0, 0, @mapTxtBitmap, self.contents.rect) if $game_switches[PLAN_Map_Window::NAME_SWITCH]
		
		draw_actor(x, y)
	end 
	
	#-------------------------------------------------------------------------- 
	# 액터 그리기
	#-------------------------------------------------------------------------- 
	def draw_actor(pos_x, pos_y)
		one_tile_size = 32 / $zoom
		actor = $game_party.actors[0]
		
		size = 10
		bitmap = Bitmap.new(size, size)
		bitmap.fill_rect(bitmap.rect, Color.new(255, 255, 0))
		
		x = ($game_player.x) * one_tile_size + pos_x
		y = ($game_player.y) * one_tile_size + pos_y
		
		self.contents.blt(x, y, bitmap, bitmap.rect)
	end
	
	#-------------------------------------------------------------------------- 
	# 프레임 갱신 
	#-------------------------------------------------------------------------- 
	def update 
		return unless self.visible
		
		super 
		if @old_real_x != $game_player.x || @old_real_y != $game_player.y 
			@old_real_x = $game_player.x 
			@old_real_y = $game_player.y 
			refresh 
		end 
	end 
	
	#-------------------------------------------------------------------------- 
	# 해방 
	#-------------------------------------------------------------------------- 
	def dispose 
		super 
	end 
end


