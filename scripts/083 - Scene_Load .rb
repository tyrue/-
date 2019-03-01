#==============================================================================
# ■ Scene_Load
#------------------------------------------------------------------------------
# 　로드 화면의 처리를 실시하는 클래스입니다.
#==============================================================================

class Scene_Load < Scene_File
	#--------------------------------------------------------------------------
	# ● 오브젝트 초기화
	#--------------------------------------------------------------------------
	def initialize
		# 텐포라리오브제크트를 재작성
		$game_temp = Game_Temp.new
		# 타임 스탬프가 최신의 파일을 선택
		$game_temp.last_file_index = 0
		latest_time = Time.at(0)
		for i in 0..3
			filename = make_filename(i)
			if FileTest.exist?(filename)
				file = File.open(filename, "r")
				if file.mtime > latest_time
					latest_time = file.mtime
					$game_temp.last_file_index = i
				end
				file.close
			end
		end
		super("Please selete a slot to load your game log")
	end
	#--------------------------------------------------------------------------
	# ● 결정시의 처리
	#--------------------------------------------------------------------------
	def on_decision(filename)
		# 파일이 존재하지 않는 경우
		unless FileTest.exist?(filename)
			# 버저 SE 를 연주
			$game_system.se_play($data_system.buzzer_se)
			return
		end
		# 로드 SE 를 연주
		$game_system.se_play($data_system.load_se)
		# 세이브 데이터의 기입
		file = File.open(filename, "rb")
		read_save_data(file)
		file.close
		# BGM, BGS 를 복귀
		$game_system.bgm_play($game_system.playing_bgm)
		$game_system.bgs_play($game_system.playing_bgs)
		# 맵을 갱신 (병렬 이벤트 실행)
		$game_map.update
		# 맵 화면으로 전환해
		$scene = Scene_Map.new
	end
	#--------------------------------------------------------------------------
	# ● 캔슬시의 처리
	#--------------------------------------------------------------------------
	def on_cancel
		# 캔슬 SE 를 연주
		$game_system.se_play($data_system.cancel_se)
		# 타이틀 화면으로 전환해
		$scene = Scene_Title.new
	end
	#--------------------------------------------------------------------------
	# ● 세이브 데이터의 읽기
	#     file : 읽기용 파일 오브젝트 (오픈이 끝난 상태)
	#--------------------------------------------------------------------------
	def read_save_data(file)
		# 세이브 파일 묘화용의 캐릭터 데이터를 읽어들인다
		characters = Marshal.load(file)
		# 플레이 시간 계측용의 프레임 카운트를 읽어들인다
		Graphics.frame_count = Marshal.load(file)
		# 각종 게임 오브젝트를 읽어들인다
		$game_system        = Marshal.load(file)
		$game_switches      = Marshal.load(file)
		$game_variables     = Marshal.load(file)
		$game_self_switches = Marshal.load(file)
		$game_screen        = Marshal.load(file)
		$game_actors        = Marshal.load(file)
		$game_party         = Marshal.load(file)
		$game_troop         = Marshal.load(file)
		$game_map           = Marshal.load(file)
		$game_player        = Marshal.load(file)
		$ABS                    = Marshal.load(file) # ABS 관련 [ABS 안쓰시면 삭제]
		$name                  = Marshal.load(file) # 조합한글 관련 [조합한글 안쓰시면 삭제]
		$name_id              = Marshal.load(file) # 조합한글 관련 [조합한글 안쓰시면 삭제]
		$passwords          = Marshal.load(file) # 조합한글 관련 [조합한글 안쓰시면 삭제]
		$words                  = Marshal.load(file) # 조합한글 관련 [조합한글 안쓰시면 삭제]
		# magic number-가 세이브시와 다른 경우
		# (에디터로 편집이 더해지고 있는 경우)
		if $game_system.magic_number != $data_system.magic_number
			# 맵을 리로드
			$game_map.setup($game_map.map_id)
			$game_player.center($game_player.x, $game_player.y)
		end
		# 파티 멤버를 리프레쉬
		$game_party.refresh
	end
end
