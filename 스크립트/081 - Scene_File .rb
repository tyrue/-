#==============================================================================
# ■ Scene_File
#------------------------------------------------------------------------------
# 　세이브 화면 및 로드 화면의 슈퍼 클래스입니다.
#==============================================================================

class Scene_File
	#--------------------------------------------------------------------------
	# ● 오브젝트 초기화
	#     help_text : 헬프 윈도우에 표시하는 문자열
	#--------------------------------------------------------------------------
	def initialize(help_text)
		@help_text = help_text
	end
	#--------------------------------------------------------------------------
	# ● 메인 처리
	#--------------------------------------------------------------------------
	def main
		# 헬프 윈도우를 작성
		@help_window = Window_Help.new
		@help_window.set_text(@help_text)
		# 세이브 파일 윈도우를 작성
		@savefile_windows = []
		for i in 0..0
			@savefile_windows.push(Window_SaveFile.new(i, make_filename(i)))
		end
		# 마지막에 조작한 파일을 선택
		@file_index = $game_temp.last_file_index
		@savefile_windows[@file_index].selected = true
		# 트란지션 실행
		Graphics.transition
		# 메인 루프
		loop do
			# 게임 화면을 갱신
			Graphics.update
			# 입력 정보를 갱신
			Input.update
			# 프레임 갱신
			update
			# 화면이 바뀌면 루프를 중단
			if $scene != self
				break
			end
		end
		# 트란지션 준비
		Graphics.freeze
		# 윈도우를 해방
		@help_window.dispose
		for i in @savefile_windows
			i.dispose
		end
	end
	#--------------------------------------------------------------------------
	# ● 프레임 갱신
	#--------------------------------------------------------------------------
	def update
		# 윈도우를 갱신
		@help_window.update
		for i in @savefile_windows
			i.update
		end
		# C 버튼이 밀렸을 경우
		if Input.trigger?(Input::C)
			# 메소드 on_decision (계승처에서 정의)를 부른다
			on_decision(make_filename(@file_index))
			$game_temp.last_file_index = @file_index
			return
		end
		# B 버튼이 밀렸을 경우
		if Input.trigger?(Input::B)
			# 메소드 on_cancel (계승처에서 정의)를 부른다
			on_cancel
			return
		end
		# 방향 버튼아래가 밀렸을 경우
		if Input.repeat?(Input::DOWN)
			# 방향 버튼아래의 압하 상태가 리피트가 아닌 경우인가,
			# 또는 커서 위치가 3 보다 전의 경우
			if Input.trigger?(Input::DOWN) or @file_index < 3
				# 커서 SE 를 연주
				$game_system.se_play($data_system.cursor_se)
				return
			end
		end
		# 방향 버튼 위가 밀렸을 경우
		if Input.repeat?(Input::UP)
			# 방향 버튼 위의 압하 상태가 리피트가 아닌 경우인가,
			# 또는 커서 위치가 0 보다 뒤의 경우
			if Input.trigger?(Input::UP) or @file_index > 0
				# 커서 SE 를 연주
				$game_system.se_play($data_system.cursor_se)
				return
			end
		end
	end
	#--------------------------------------------------------------------------
	# ● 파일명의 작성
	#     file_index : 세이브 파일의 인덱스 (0~3)
	#--------------------------------------------------------------------------
	def make_filename(file_index)
		return "C:/Data.gmlog"
	end
end
