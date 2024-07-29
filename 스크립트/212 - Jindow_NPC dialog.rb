#==============================================================================
# ■ Jindow_N
#------------------------------------------------------------------------------
#   NPC 대화
#------------------------------------------------------------------------------
class Jindow_N < Jindow
	def initialize(text = "", name = "", select_num = 0, type = 0, is_end = false) # 텍스트, npc 이름, 메뉴들, 타입
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 400, 105)
		name = sanitize_name(name)
		
		self.name = name
		@head = true
		@drag = true
		@close = true
		@type = type
		@is_end = is_end
		self.x = (640 - self.width) / 2
		self.y = 255 - self.height
		
		@menu = []
		
		text = change_txt(text)
		@text_size = 18
		@margin = 10
		@texts = text.split("\n")
		@text = Sprite.new(self)
		@text.bitmap = Bitmap.new(self.width, (@texts.size - select_num + 1) * @text_size)
		@text.bitmap.font.color.set(0, 0, 0, 255)
		
		@close_ok = @is_end
		setup_dialog(select_num)
		
		@a = J::Button.new(self).refresh(45, "다음")
		@b = J::Button.new(self).refresh(45, "닫기")
		@a.x = self.width - (@a.width + @margin) * 2
		@b.x = @a.x + @a.width + @margin
		
		setup_positions
		
		self.refresh("Npc_dialog")
	end
	
	def sanitize_name(name)
		name = "" unless name
		return "" if name.include?("EV")
		
		name.gsub!(/\[[iI][dD]/, "")
		name.delete!("]")
		name
	end
	
	def change_txt(text)
		begin
			last_text = text.clone
			text.gsub!(/\#\{(.*)\}/) { eval("#{$1}") rescue "" }
			text.gsub!(/\\[Cc]\[([0-9]+)\]/, "")
			text.gsub!(/\\[Vv]\[([0-9]+)\]/) { change_number_unit($game_variables[$1.to_i]) rescue "" }
			text.gsub!(/\\[Ss]\[([0-9]+)\]/) { $data_skills[$1.to_i].name rescue ""} 
			text.gsub!(/\\[Dd]\[([0-9]+)\]/) { $data_skills[$1.to_i].description rescue "" }
			text.gsub!(/\\[Ii]\[([0-9]+)\]/) { $data_items[$1.to_i].name rescue "" }
			text.gsub!(/\\[Ww]\[([0-9]+)\]/) { $data_weapons[$1.to_i].name rescue "" }
			text.gsub!(/\\[Aa]\[([0-9]+)\]/) { $data_armors[$1.to_i].name rescue "" }
			text.gsub!(/\\[Nn]\[([0-9]+)\]/) { $game_actors[$1.to_i].name rescue "" }
		end until text == last_text
		
		text
	end
	
	def setup_dialog(select_num)
		case @type
		when 0
			setup_general_dialog(select_num)
		when 1
			setup_button_only_dialog(select_num)
		when 2
			setup_input_only_dialog
		end
	end
	
	def setup_general_dialog(select_num)
		@texts[0...(@texts.size - select_num)].each_with_index do |line, i|
			@text.bitmap.draw_text(@margin, i * @text_size + @margin, self.width, @text_size, line)
		end
		
		setup_menu(select_num) if select_num > 0
		setup_input if $game_temp.num_input_start > 0
	end
	
	def setup_button_only_dialog(select_num)
		setup_menu(select_num) if select_num > 0
	end
	
	def setup_input_only_dialog
		setup_input
	end
	
	def setup_menu(select_num)
		@texts.last(select_num).each_with_index do |text, i|
			button = J::Button.new(self).refresh(self.width / 2, text)
			button.x = (self.width - self.width / 2) / 2
			button.y = @text.height + i * button.height
			@menu << button
		end
	end
	
	def setup_input
		@input_num = J::Type.new(self).refresh((self.width - self.width / 2) / 2, @text.height + 10, self.width / 2, 18)
		@input_res = 0
		@input_num.bluck = true
		
		@input_help_txt = Sprite.new(self)
		@input_help_txt.x = @input_num.x + @input_num.width
		@input_help_txt.y = @input_num.y
		@input_help_txt.bitmap = Bitmap.new(self.width, 18)
		@input_help_txt.bitmap.draw_text(0, 0, self.width, 18, "enter키로 입력")
	end
	
	def setup_positions
		if @input_num
			@a.y = @input_num.y + @input_num.height + 20
			@input_num.set ""
			@input_clear = false
		elsif @menu.size > 0
			@a.y = @menu.last.y + @menu.last.height + 5
		else
			@a.y = @text.y + @text.height + 5
		end
		
		@b.y = @a.y
		self.height = @b.y + @b.height + 30
		handle_close_button
	end
	
	def handle_close_button
		if !@close_ok
			@close = false
			@b.dispose
		else
			@a.dispose 
		end
	end
	
	def dispose2
		$game_temp.message_proc.call if $game_temp.message_proc
		$end_proc.call if $end_proc
		super
	end
	
	def update
		super
		clear_input if @input_num && !@input_clear
		
		handle_menu_click if @menu.size > 0
		handle_key_press
		
		handle_next_button if @a.click
		dispose2 if @b.click
	end
	
	def clear_input
		@input_num.set ""
		@input_clear = true
	end
	
	def handle_menu_click
		@menu.each_with_index do |menu_item, i|
			next unless menu_item.click
			
			$game_system.se_play($data_system.decision_se)
			Hwnd.dispose(self)
			$game_temp.message_proc.call if $game_temp.message_proc
			$game_temp.choice_proc.call(i) if $game_temp.choice_proc
		end
	end
	
	def handle_key_press
		return unless Hwnd.highlight? == self
		
		if Key.trigger?(KEY_ENTER)
			handle_enter_key
		elsif Key.trigger?(KEY_SPACE)
			handle_space_key
		elsif Key.trigger?(KEY_ESC)
			handle_esc_key
		end
	end
	
	def handle_enter_key
		@a.click = true if !@a.disposed?
		@b.click = true if !@b.disposed?
	end
	
	def handle_space_key
		@a.click = true if !@a.disposed?
	end
	
	def handle_esc_key
		@a.click = true if !@a.disposed?
		@b.click = true if !@b.disposed?
	end
	
	def handle_next_button	
		$game_system.se_play($data_system.decision_se)
		
		if @menu.size > 0
			# 캔슬
			if $game_temp.choice_cancel_type > 0
				$game_temp.choice_proc.call($game_temp.choice_cancel_type - 1)
			else
				$console.write_line("선택지를 골라주세요.")
				return 
			end
		end
		
		if @input_num
			if @input_num.result == ""
				return dispose2
			end
			
			if @input_num.result.to_i <= 0
				$console.write_line("1 이상의 수를 입력하세요.")
				return 
			end
			
			$game_map.need_refresh = true
			$game_variables[$game_temp.num_input_variable_id] = @input_num.result.to_i
			$game_temp.num_input_variable_id = 0
			$game_temp.num_input_digits_max = 0					
		end
		
		$game_temp.message_proc.call if $game_temp.message_proc
		Hwnd.dispose(self)
	end
end


# 클라에서의 명령문을 수정한다.
class Interpreter
	#--------------------------------------------------------------------------
	# * npc 대화
	#--------------------------------------------------------------------------
	def make_message_window(text)
		set_message_end_waiting_flag_and_callback
		$game_temp.message_text = text + "\n"
		handle_jindow_message(0, @m_count)
		$game_temp.message_text = nil
	end
	
	def command_101
		return false if $game_temp.message_text
		
		set_message_end_waiting_flag_and_callback
		
		# Set message text on first line
		$game_temp.message_text = @list[@index].parameters[0] + "\n"
		line_count = 1
		
		# Loop
		$game_temp.choice_start = 4
		$game_temp.num_input_start = 0
		
		loop do
			if @list[@index + 1].code == 401
				# Add the second line or after to message_text
				$game_temp.message_text += @list[@index + 1].parameters[0] + "\n"
				line_count += 1
			else
				handle_choices_and_num_input(line_count)
				handle_jindow_message(0, @m_count)
				$game_temp.message_text = nil
				return true
			end
			
			# Advance index
			@index += 1
		end
	end
	
	#--------------------------------------------------------------------------
	# * 선택 메시지
	#--------------------------------------------------------------------------
	def command_102
		return false if $game_temp.message_text
		
		set_message_end_waiting_flag_and_callback
		
		# Choices setup
		$game_temp.message_text = ""
		$game_temp.choice_start = 0
		setup_choices(@parameters)
		
		# Continue
		handle_jindow_message(1, @parameters[0].size)
		$game_temp.message_text = nil
		return true
	end
	
	#--------------------------------------------------------------------------
	# * Input Number
	#--------------------------------------------------------------------------
	def command_103
		return false if $game_temp.message_text
		
		set_message_end_waiting_flag_and_callback
		
		# Number input setup
		$game_temp.message_text = ""
		$game_temp.num_input_start = 0
		$game_temp.num_input_variable_id = @parameters[0]
		$game_temp.num_input_digits_max = @parameters[1]
		
		# Continue
		handle_jindow_message(2, 0)
		$game_temp.message_text = nil
		return true
	end
	
	def set_message_end_waiting_flag_and_callback
		@message_waiting = true
		$game_temp.message_proc = Proc.new { @message_waiting = false }
		$end_proc = Proc.new { self.command_end }
	end
	
	def handle_choices_and_num_input(line_count)
		@m_count = 0
		next_line = @list[@index + 1]
		if next_line.code == 102
			return if next_line.parameters[0].size + line_count > 4 
			
			@m_count = next_line.parameters[0].size
			@index += 1
			$game_temp.choice_start = line_count
			setup_choices(@list[@index].parameters)
			
		elsif next_line.code == 103
			return if line_count >= 4
			
			@index += 1
			$game_temp.num_input_start = line_count
			$game_temp.num_input_variable_id = @list[@index].parameters[0]
			$game_temp.num_input_digits_max = @list[@index].parameters[1]			
		end
	end
	
	def handle_jindow_message(type, line_count)
		e_name = $game_map.events[@event_id].name if $game_map.events[@event_id]
		next_line = @list[@index + 1]
		is_end = next_line.code == 0 ? true : false
		Jindow_N.new($game_temp.message_text, e_name, line_count, type, is_end)
	end
	
	#--------------------------------------------------------------------------
	# * Setup Choices
	#--------------------------------------------------------------------------
	def setup_choices(parameters)
		$game_temp.choice_max = parameters[0].size
		$game_temp.message_text ||= ""
		$game_temp.message_text += parameters[0].join("\n") + "\n"
		$game_temp.choice_cancel_type = parameters[1]
		current_indent = @list[@index].indent
		$game_temp.choice_proc = Proc.new { |n| @branch[current_indent] = n }
	end
end


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
		
		# 메시지 윈도우
		$mess = Sprite.new
		$mess.bitmap = RPG::Cache.picture("MessageBack.png")
		$mess.y = 160
		$mess.visible = false
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
	def terminate_message(sw = true)
		self.active = false
		self.pause = false
		self.index = -1
		self.contents.clear
		# 표시중 플래그를 클리어
		@contents_showing = false
		# 메세지 콜백을 부른다
		if $game_temp.message_proc != nil and sw
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
			$mess.visible = true if $mess.visible == false
			text = $game_temp.message_text
			# 제어 문자 처리
			begin
				last_text = text.clone
				
				text.gsub!(/\\[Vv]\[([0-9]+)\]/) { $game_variables[$1.to_i] }
				text.gsub!(/\\[Ss]\[([0-9]+)\]/) do 
					$data_skills[$1.to_i] != nil ? $data_skills[$1.to_i].name : ""
				end
				
				text.gsub!(/\\[Dd]\[([0-9]+)\]/) do 
					$data_skills[$1.to_i] != nil ? $data_skills[$1.to_i].description : ""
				end
				
				text.gsub!(/\\[Ii]\[([0-9]+)\]/) do
					$data_items[$1.to_i] != nil ? $data_items[$1.to_i].name : ""
				end
				
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
		# 캔슬
		if Input.trigger?(Input::B)
			#terminate_message
		end
		
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
				$game_variables[$game_temp.num_input_variable_id] = @input_number_window.number
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
			$mess.visible = false
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
