#==============================================================================
# ■ Window_Message
#------------------------------------------------------------------------------
# 　문장 표시에 사용하는 메세지 윈도우입니다.
#==============================================================================

class Window_Message < Window_Selectable
	#--------------------------------------------------------------------------
	# ● 오브젝트 초기화
	#--------------------------------------------------------------------------
	def initialize
		super(80, 304, 480, 160)
		self.contents = Bitmap.new(width - 32, height - 32)
		self.visible = false
		self.z = 9998
		@fade_in = false
		@fade_out = false
		@contents_showing = false
		@cursor_width = 0
		self.active = false
		self.index = -1
	end
	#--------------------------------------------------------------------------
	# ● 해방
	#--------------------------------------------------------------------------
	def dispose
		terminate_message
		$game_temp.message_window_showing = false
		if @input_number_window != nil
			@input_number_window.dispose
		end
		super
	end
	#--------------------------------------------------------------------------
	# ● 메세지 종료 처리
	#--------------------------------------------------------------------------
	def terminate_message
		self.active = false
		self.pause = false
		self.index = -1
		self.contents.clear
		# 표시중 플래그를 클리어
		@contents_showing = false
		# 메세지 콜백을 부른다
		if $game_temp.message_proc != nil
			$game_temp.message_proc.call  
			
		end
		# 문장, 선택사항, 수치 입력에 관한 변수를 클리어
		$game_temp.message_text = nil
		$game_temp.message_proc = nil
		$game_temp.choice_start = 99
		$game_temp.choice_max = 0
		$game_temp.choice_cancel_type = 0
		$game_temp.choice_proc = nil
		$game_temp.num_input_start = 99
		$game_temp.num_input_variable_id = 0
		$game_temp.num_input_digits_max = 0
		# 골드 윈도우를 개방
		if @gold_window != nil
			@gold_window.dispose
			@gold_window = nil
		end
	end
	#--------------------------------------------------------------------------
	# ● 리프레쉬
	#--------------------------------------------------------------------------
	def refresh
		self.contents.clear
		self.contents.font.color = normal_color
		x = y = 0
		@cursor_width = 0
		# 선택사항이라면 인덴트를 실시한다
		if $game_temp.choice_start == 0
			x = 8
		end
		# 표시 기다리는 메세지가 있는 경우
		if $game_temp.message_text != nil
			if $mess == nil or $mess.bitmap == nil or $mess.bitmap.disposed?
				$mess = Sprite.new
				$mess.bitmap = RPG::Cache.picture("MessageBack.png")
				$mess.y = 160
			end
			text = $game_temp.message_text
			# 제어 문자 처리
			begin
				last_text = text.clone
				text.gsub!(/\\[Vv]\[([0-9]+)\]/) { $game_variables[$1.to_i] }
			end until text == last_text
			text.gsub!(/\\[Nn]\[([0-9]+)\]/) do
				$game_actors[$1.to_i] != nil ? $game_actors[$1.to_i].name : ""
			end
			# 편의상,"\\\\" 을 "\000" 에 변환
			text.gsub!(/\\\\/) { "\000" }
			# "\\C" 를 "\001" 에,"\\G" 를 "\002" 에 변환
			text.gsub!(/\\[Cc]\[([0-9]+)\]/) { "\001[#{$1}]" }
			text.gsub!(/\\[Gg]/) { "\002" }
			# c 에 1 문자를 취득 (문자를 취득할 수 없게 될 때까지 루프)
			while ((c = text.slice!(/./m)) != nil)
				# \\ 의 경우
				if c == "\000"
					# 본래의 문자에 되돌린다
					c = "\\"
				end
				# \C[n] 의 경우
				if c == "\001"
					# 문자색을 변경
					text.sub!(/\[([0-9]+)\]/, "")
					color = $1.to_i
					if color >= 0 and color <= 7
						self.contents.font.color = text_color(color)
					end
					# 다음의 문자에
					next
				end
				# \G 의 경우
				if c == "\002"
					# 골드 윈도우를 작성
					if @gold_window == nil
						@gold_window = Window_Gold.new
						@gold_window.x = 560 - @gold_window.width
						if $game_temp.in_battle
							@gold_window.y = 192
						else
							@gold_window.y = self.y >= 128 ? 32 : 384
						end
						@gold_window.opacity = self.opacity
						@gold_window.back_opacity = self.back_opacity
					end
					# 다음의 문자에
					next
				end
				# 개행 문자의 경우
				if c == "\n"
					# 선택사항이라면 커서의 폭을 갱신
					if y >= $game_temp.choice_start
						@cursor_width = [@cursor_width, x].max
					end
					# y 에 1 을 가산
					y += 1
					x = 0
					# 선택사항이라면 인덴트를 실시한다
					if y >= $game_temp.choice_start
						x = 8
					end
					# 다음의 문자에
					next
				end
				# 문자를 묘화
				self.contents.font.size = 14
				self.contents.draw_frame_text(4 + x, 32 * y, 40, 32, c)
				# x 에 묘화 한 문자의 폭을 가산
				x += self.contents.text_size(c).width
			end
		end
		# 선택사항의 경우
		if $game_temp.choice_max > 0
			@item_max = $game_temp.choice_max
			self.active = true
			self.index = 0
		end
		# 수치 입력의 경우
		if $game_temp.num_input_variable_id > 0
			digits_max = $game_temp.num_input_digits_max
			number = $game_variables[$game_temp.num_input_variable_id]
			@input_number_window = Window_InputNumber.new(digits_max)
			@input_number_window.number = number
			@input_number_window.x = self.x + 8
			@input_number_window.y = self.y + $game_temp.num_input_start * 32
		end
	end
	#--------------------------------------------------------------------------
	# ● 윈도우의 위치와 불투명도의 설정
	#--------------------------------------------------------------------------
	def reset_window
		if $game_temp.in_battle
			self.y = 16
		else
			case $game_system.message_position
			when 0  # 상
				self.y = 160
			when 1  # 중
				self.y = 160
			when 2  # 하
				self.y = 160
			end
		end
		if $game_system.message_frame == 0
			self.opacity = 0
		else
			self.opacity = 0
		end
		self.back_opacity = 160
	end
	#--------------------------------------------------------------------------
	# ● 프레임 갱신
	#--------------------------------------------------------------------------
	def update
		super
		# 용명의 경우
		if @fade_in
			self.contents_opacity += 24
			if @input_number_window != nil
				@input_number_window.contents_opacity += 24
			end
			if self.contents_opacity == 255
				@fade_in = false
			end
			return
		end
		# 수치 입력중의 경우
		if @input_number_window != nil
			@input_number_window.update
			# 결정
			if Input.trigger?(Input::C)
				$game_system.se_play($data_system.decision_se)
				$game_variables[$game_temp.num_input_variable_id] =
				@input_number_window.number
				$game_map.need_refresh = true
				# 수치 입력 윈도우를 해방
				@input_number_window.dispose
				@input_number_window = nil
				terminate_message
			end
			return
		end
		# 메세지 표시중의 경우
		if @contents_showing
			# 선택사항의 표시중이 아니면 포즈 싸인을 표시
			if $game_temp.choice_max == 0
				self.pause = true
			end
			# 캔슬
			if Input.trigger?(Input::B)
				if $game_temp.choice_max > 0 and $game_temp.choice_cancel_type > 0
					$game_system.se_play($data_system.cancel_se)
					$game_temp.choice_proc.call($game_temp.choice_cancel_type - 1)
					terminate_message
				end
			end
			# 결정
			if Input.trigger?(Input::C)
				if $game_temp.choice_max > 0
					$game_system.se_play($data_system.decision_se)
					$game_temp.choice_proc.call(self.index)
				end
				terminate_message
			end
			return
		end
		# 페이드아웃중 이외로 표시 기다리는 메세지나 선택사항이 있는 경우
		if @fade_out == false and $game_temp.message_text != nil
			@contents_showing = true
			$game_temp.message_window_showing = true
			reset_window
			refresh
			Graphics.frame_reset
			self.visible = true
			self.contents_opacity = 0
			if @input_number_window != nil
				@input_number_window.contents_opacity = 0
			end
			@fade_in = true
			return
		end
		# 표시해야 할 메세지가 없지만, 윈도우가 가시 상태의 경우
		if self.visible
			$mess.bitmap.dispose if !$mess.bitmap.disposed?
			@fade_out = true
			self.opacity -= 48
			if self.opacity == 0
				self.visible = false
				@fade_out = false
				$game_temp.message_window_showing = false
			end
			return
		end
	end
	#--------------------------------------------------------------------------
	# ● 커서의 구형 갱신
	#--------------------------------------------------------------------------
	def update_cursor_rect
		if @index >= 0
			n = $game_temp.choice_start + @index
			self.cursor_rect.set(8, n * 32, @cursor_width, 32)
		else
			self.cursor_rect.empty
		end
	end
end
