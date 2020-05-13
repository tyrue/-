#==============================================================================
# ■ Game_Map
#------------------------------------------------------------------------------
# 　맵을 취급하는 클래스입니다.스크롤이나 통행 가능 판정등의 기능을 가지고 있습니다.
# 이 클래스의 인스턴스는 $game_map 로 참조됩니다.
#==============================================================================
$map_bgm_name = ""
class Game_Map
	#--------------------------------------------------------------------------
	# ● 공개 인스턴스 변수
	#--------------------------------------------------------------------------
	attr_accessor :tileset_name             # 타일 세트 파일명
	attr_accessor :autotile_names           # 오토 타일 파일명
	attr_accessor :panorama_name            # 파노라마 파일명
	attr_accessor :panorama_hue             # 파노라마 색상
	attr_accessor :fog_name                 # 포그 파일명
	attr_accessor :fog_hue                  # 포그 색상
	attr_accessor :fog_opacity              # 포그 불투명도
	attr_accessor :fog_blend_type           # 포그 브랜드 방법
	attr_accessor :fog_zoom                 # 포그 확대율
	attr_accessor :fog_sx                   # 포그 SX
	attr_accessor :fog_sy                   # 포그 SY
	attr_accessor :battleback_name          # 배틀 백 파일명
	attr_accessor :display_x                # 표시 X 좌표 * 128
	attr_accessor :display_y                # 표시 Y 좌표 * 128
	attr_accessor :need_refresh             # 리프레쉬 요구 플래그
	attr_reader   :passages                 # 통행 테이블
	attr_reader   :priorities               # priority 테이블
	attr_reader   :terrain_tags             # 지형 태그 테이블
	attr_reader   :events                   # 이벤트
	attr_reader   :fog_ox                   # 포그 원점 X 좌표
	attr_reader   :fog_oy                   # 포그 원점 Y 좌표
	attr_reader   :fog_tone                 # 포그 색조
	#--------------------------------------------------------------------------
	# ● 오브젝트 초기화
	#--------------------------------------------------------------------------
	def initialize
		@map_id = 0
		@display_x = 0
		@display_y = 0
	end
	#--------------------------------------------------------------------------
	# ● 셋업
	#     map_id : 맵 ID
	#--------------------------------------------------------------------------
	def setup(map_id)
		# 맵 ID 를 @map_id 에 기억
		@map_id = map_id
		# 맵을 파일로부터 로드해, @map 로 설정
		@map = load_data(sprintf("Data/Map%03d.rxdata", @map_id))
		# 공개 인스턴스 변수에 타일 세트의 정보를 설정
		tileset = $data_tilesets[@map.tileset_id]
		@tileset_name = tileset.tileset_name
		@autotile_names = tileset.autotile_names
		@panorama_name = tileset.panorama_name
		@panorama_hue = tileset.panorama_hue
		@fog_name = tileset.fog_name
		@fog_hue = tileset.fog_hue
		@fog_opacity = tileset.fog_opacity
		@fog_blend_type = tileset.fog_blend_type
		@fog_zoom = tileset.fog_zoom
		@fog_sx = tileset.fog_sx
		@fog_sy = tileset.fog_sy
		@battleback_name = tileset.battleback_name
		@passages = tileset.passages
		@priorities = tileset.priorities
		@terrain_tags = tileset.terrain_tags
		# 표시 좌표를 초기화
		@display_x = 0
		@display_y = 0
		# 리프레쉬 요구 플래그를 클리어
		@need_refresh = false
		# 맵 이벤트의 데이터를 설정
		@events = {}
		for i in @map.events.keys
			@events[i] = Game_Event.new(@map_id, @map.events[i])
		end
		# 코먼 이벤트의 데이터를 설정
		@common_events = {}
		for i in 1...$data_common_events.size
			@common_events[i] = Game_CommonEvent.new(i)
		end
		# 포그의 각 정보를 초기화
		@fog_ox = 0
		@fog_oy = 0
		@fog_tone = Tone.new(0, 0, 0, 0)
		@fog_tone_target = Tone.new(0, 0, 0, 0)
		@fog_tone_duration = 0
		@fog_opacity_duration = 0
		@fog_opacity_target = 0
		# 스크롤 정보를 초기화
		@scroll_direction = 2
		@scroll_rest = 0
		@scroll_speed = 4
	end
	#--------------------------------------------------------------------------
	# ● 맵 ID 의 취득
	#--------------------------------------------------------------------------
	def map_id
		return @map_id
	end
	#--------------------------------------------------------------------------
	# ● 폭의 취득
	#--------------------------------------------------------------------------
	def width
		return @map.width
	end
	#--------------------------------------------------------------------------
	# ● 높이의 취득
	#--------------------------------------------------------------------------
	def height
		return @map.height
	end
	#--------------------------------------------------------------------------
	# ● 엔카운트리스트의 취득
	#--------------------------------------------------------------------------
	def encounter_list
		return @map.encounter_list
	end
	#--------------------------------------------------------------------------
	# ● 엔카운트 보수의 취득
	#--------------------------------------------------------------------------
	def encounter_step
		return @map.encounter_step
	end
	#--------------------------------------------------------------------------
	# ● 맵 데이터의 취득
	#--------------------------------------------------------------------------
	def data
		return @map.data
	end
	#--------------------------------------------------------------------------
	# ● BGM / BGS 자동 변환
	#--------------------------------------------------------------------------
	def autoplay
		if @map.autoplay_bgm
			$game_system.bgm_play(@map.bgm)
		end
		if @map.autoplay_bgs
			$game_system.bgs_play(@map.bgs)
		end
	end
	#--------------------------------------------------------------------------
	# ● 리프레쉬
	#--------------------------------------------------------------------------
	def refresh
		# 맵 ID 가 유효하면
		if @map_id > 0
			# 모든 맵 이벤트를 리프레쉬
			for event in @events.values
				event.refresh
			end
			# 모든 코먼 이벤트를 리프레쉬
			for common_event in @common_events.values
				common_event.refresh
			end
		end
		# 리프레쉬 요구 플래그를 클리어
		@need_refresh = false
	end
	#--------------------------------------------------------------------------
	# ● 아래에 스크롤
	#     distance : 스크롤 하는 거리
	#--------------------------------------------------------------------------
	def scroll_down(distance)
		@display_y = [@display_y + distance, (self.height - 15) * 128].min
	end
	#--------------------------------------------------------------------------
	# ● 왼쪽으로 스크롤
	#     distance : 스크롤 하는 거리
	#--------------------------------------------------------------------------
	def scroll_left(distance)
		@display_x = [@display_x - distance, 0].max
	end
	#--------------------------------------------------------------------------
	# ● 오른쪽으로 스크롤
	#     distance : 스크롤 하는 거리
	#--------------------------------------------------------------------------
	def scroll_right(distance)
		@display_x = [@display_x + distance, (self.width - 20) * 128].min
	end
	#--------------------------------------------------------------------------
	# ● 위에 스크롤
	#     distance : 스크롤 하는 거리
	#--------------------------------------------------------------------------
	def scroll_up(distance)
		@display_y = [@display_y - distance, 0].max
	end
	#--------------------------------------------------------------------------
	# ● 유효 좌표 판정
	#     x          : X 좌표
	#     y          : Y 좌표
	#--------------------------------------------------------------------------
	def valid?(x, y)
		return (x >= 0 and x < width and y >= 0 and y < height)
	end
	#--------------------------------------------------------------------------
	# ● 통행 가능 판정
	#     x          : X 좌표
	#     y          : Y 좌표
	#     d          : 방향 (0,2,4,6,8,10)
	#                  ※ 0,10 = 전방향 통행 불가의 경우를 판정 (점프 등)
	#     self_event : 자신 (이벤트가 통행 판정을 하는 경우)
	#--------------------------------------------------------------------------
	def passable?(x, y, d, self_event = nil)
		# 주어진 좌표가 맵외의 경우
		unless valid?(x, y)
			# 통행 불가
			return false
		end
		# 방향 (0,2,4,6,8,10)으로부터 장애물 비트 (0,1,2,4,8,0)에 변환
		bit = (1 << (d / 2 - 1)) & 0x0f
		# 모든 이벤트로 루프
		for event in events.values
			# 자신 이외의 타일과 좌표가 일치했을 경우
			if event.tile_id >= 0 and event != self_event and
				event.x == x and event.y == y and not event.through
				# 장애물 비트가 세트 되고 있는 경우
				if @passages[event.tile_id] & bit != 0
					# 통행 불가
					return false
					# 전방향의 장애물 비트가 세트 되고 있는 경우
				elsif @passages[event.tile_id] & 0x0f == 0x0f
					# 통행 불가
					return false
					# 그 이외로 priority가 0 의 경우
				elsif @priorities[event.tile_id] == 0
					# 통행가능
					return true
				end
			end
		end
		# 층 위로부터 순서에 조사하는 루프
		for i in [2, 1, 0]
			# 타일 ID 를 취득
			tile_id = data[x, y, i]
			# 타일 ID 취득 실패
			if tile_id == nil
				# 통행 불가
				return false
				# 장애물 비트가 세트 되고 있는 경우
			elsif @passages[tile_id] & bit != 0
				# 통행 불가
				return false
				# 전방향의 장애물 비트가 세트 되고 있는 경우
			elsif @passages[tile_id] & 0x0f == 0x0f
				# 통행 불가
				return false
				# 그 이외로 priority가 0 의 경우
			elsif @priorities[tile_id] == 0
				# 통행가능
				return true
			end
		end
		# 통행가능
		return true
	end
	#--------------------------------------------------------------------------
	# ● 수풀 판정
	#     x          : X 좌표
	#     y          : Y 좌표
	#--------------------------------------------------------------------------
	def bush?(x, y)
		if @map_id != 0
			for i in [2, 1, 0]
				tile_id = data[x, y, i]
				if tile_id == nil
					return false
				elsif @passages[tile_id] & 0x40 == 0x40
					return true
				end
			end
		end
		return false
	end
	#--------------------------------------------------------------------------
	# ● 카운터 판정
	#     x          : X 좌표
	#     y          : Y 좌표
	#--------------------------------------------------------------------------
	def counter?(x, y)
		if @map_id != 0
			for i in [2, 1, 0]
				tile_id = data[x, y, i]
				if tile_id == nil
					return false
				elsif @passages[tile_id] & 0x80 == 0x80
					return true
				end
			end
		end
		return false
	end
	#--------------------------------------------------------------------------
	# ● 지형 태그의 취득
	#     x          : X 좌표
	#     y          : Y 좌표
	#--------------------------------------------------------------------------
	def terrain_tag(x, y)
		if @map_id != 0
			for i in [2, 1, 0]
				tile_id = data[x, y, i]
				if tile_id == nil
					return 0
				elsif @terrain_tags[tile_id] > 0
					return @terrain_tags[tile_id]
				end
			end
		end
		return 0
	end
	#--------------------------------------------------------------------------
	# ● 지정 위치의 이벤트 ID 취득
	#     x          : X 좌표
	#     y          : Y 좌표
	#--------------------------------------------------------------------------
	def check_event(x, y)
		for event in $game_map.events.values
			if event.x == x and event.y == y
				return event.id
			end
		end
	end
	#--------------------------------------------------------------------------
	# ● 스크롤의 개시
	#     direction : 스크롤 할 방향
	#     distance  : 스크롤 하는 거리
	#     speed     : 스크롤 하는 속도
	#--------------------------------------------------------------------------
	def start_scroll(direction, distance, speed)
		@scroll_direction = direction
		@scroll_rest = distance * 128
		@scroll_speed = speed
	end
	#--------------------------------------------------------------------------
	# ● 스크롤중 판정
	#--------------------------------------------------------------------------
	def scrolling?
		return @scroll_rest > 0
	end
	#--------------------------------------------------------------------------
	# ● 포그의 색조 변경의 개시
	#     tone     : 색조
	#     duration : 시간
	#--------------------------------------------------------------------------
	def start_fog_tone_change(tone, duration)
		@fog_tone_target = tone.clone
		@fog_tone_duration = duration
		if @fog_tone_duration == 0
			@fog_tone = @fog_tone_target.clone
		end
	end
	#--------------------------------------------------------------------------
	# ● 포그의 불투명도 변경의 개시
	#     opacity  : 불투명도
	#     duration : 시간
	#--------------------------------------------------------------------------
	def start_fog_opacity_change(opacity, duration)
		@fog_opacity_target = opacity * 1.0
		@fog_opacity_duration = duration
		if @fog_opacity_duration == 0
			@fog_opacity = @fog_opacity_target
		end
	end
	#--------------------------------------------------------------------------
	# ● 프레임 갱신
	#--------------------------------------------------------------------------
	def update
		# 필요하면 맵을 리프레쉬
		if $game_map.need_refresh
			refresh
		end
		# 스크롤중의 경우
		if @scroll_rest > 0
			# 스크롤 속도로부터 맵 좌표계로의 거리에 변환
			distance = 2 ** @scroll_speed
			# 스크롤을 실행
			case @scroll_direction
			when 2  # 하
				scroll_down(distance)
			when 4  # 왼쪽
				scroll_left(distance)
			when 6  # 오른쪽
				scroll_right(distance)
			when 8  # 상
				scroll_up(distance)
			end
			# 스크롤 한 거리를 감산
			@scroll_rest -= distance
		end
		# 맵 이벤트를 갱신
		for event in @events.values
			event.update
		end
		# 코먼 이벤트를 갱신
		for common_event in @common_events.values
			common_event.update
		end
		# 포그의 스크롤 처리
		@fog_ox -= @fog_sx / 8.0
		@fog_oy -= @fog_sy / 8.0
		# 포그의 색조 변경 처리
		if @fog_tone_duration >= 1
			d = @fog_tone_duration
			target = @fog_tone_target
			@fog_tone.red = (@fog_tone.red * (d - 1) + target.red) / d
			@fog_tone.green = (@fog_tone.green * (d - 1) + target.green) / d
			@fog_tone.blue = (@fog_tone.blue * (d - 1) + target.blue) / d
			@fog_tone.gray = (@fog_tone.gray * (d - 1) + target.gray) / d
			@fog_tone_duration -= 1
		end
		# 포그의 불투명도 변경 처리
		if @fog_opacity_duration >= 1
			d = @fog_opacity_duration
			@fog_opacity = (@fog_opacity * (d - 1) + @fog_opacity_target) / d
			@fog_opacity_duration -= 1
		end
	end
end
