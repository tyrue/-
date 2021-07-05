#~ #==============================================================================
#~ # ■ Jindow_N
#~ #------------------------------------------------------------------------------
#~ #   NPC 대화
#~ #------------------------------------------------------------------------------
#~ class Jindow_N2 < Jindow
	#~ def initialize(text_list = [""], name = "") # 텍스트, npc 이름
		#~ $game_system.se_play($data_system.decision_se)
		#~ super(0, 0, 400, 105)
		#~ name = "" if name.include?("EV")		
		#~ name.delete!("[id")
		#~ name.delete!("[Id")
		#~ name.delete!("[iD")
		#~ name.delete!("[ID")
		#~ name.delete!("]") 
		
		#~ self.name = name
		#~ @head = true
		#~ @drag = true
		#~ @close = true
		#~ @type = type
		
		#~ self.x = (640 - self.width) / 2
		#~ self.y = 255 - self.height
		#~ self.refresh("Npc_dialog2")
		

		
		#~ text = change_txt(text)
		#~ @texts = text.split("\n")
		#~ @a = J::Button.new(self).refresh(45, "다음")
		#~ @b = J::Button.new(self).refresh(45, "닫기")
		#~ @a.x = self.width - @a.width * 2
		#~ @b.x = @a.x + @a.width
		
		#~ @close_ok = false
		
		#~ # npc 대화 추가
		#~ @text = Sprite.new(self)
		#~ @text.bitmap = Bitmap.new(self.width, (@texts.size - select_num + 1) * 18)
		#~ @text.bitmap.font.color.set(0, 0, 0, 255)
		
		#~ text_size = @texts.size - select_num
		#~ for i in 0...text_size
			#~ @text.bitmap.draw_text(0, i * 18, self.width, 32, @texts[i])
		#~ end
			
			
		#~ @b.y = @a.y
		#~ if !@close_ok
			#~ @close = false
			#~ @b.dispose 
		#~ end
		
		#~ self.height = @a.y + @a.height + 30
		#~ self.refresh("Npc_dialog2")
	#~ end
	
	#~ def change_txt(text)
		#~ # 제어 문자 처리
		#~ begin
			#~ last_text = text.clone
			
			#~ text.gsub!(/\\[Vv]\[([0-9]+)\]/) { $game_variables[$1.to_i] }
			#~ text.gsub!(/\\[Ss]\[([0-9]+)\]/) do 
				#~ $data_skills[$1.to_i] != nil ? $data_skills[$1.to_i].name : ""
			#~ end
			#~ text.gsub!(/\\[Dd]\[([0-9]+)\]/) do 
				#~ $data_skills[$1.to_i] != nil ? $data_skills[$1.to_i].description : ""
			#~ end
			#~ text.gsub!(/\\[Ii]\[([0-9]+)\]/) do
				#~ $data_items[$1.to_i] != nil ? $data_items[$1.to_i].name : ""
			#~ end
		#~ end until text == last_text
		#~ text.gsub!(/\\[Nn]\[([0-9]+)\]/) do
			#~ $game_actors[$1.to_i] != nil ? $game_actors[$1.to_i].name : ""
		#~ end
		
		#~ # 편의상,"\\\\" 을 "\000" 에 변환
		#~ text.gsub!(/\\\\/) { "\000" }
		#~ # "\\C" 를 "\001" 에,"\\G" 를 "\002" 에 변환
		#~ text.gsub!(/\\[Cc]\[([0-9]+)\]/) { "" }
		#~ #text.gsub!(/\\[Cc]\[([0-9]+)\]/) { "\001[#{$1}]" }
		#~ text.gsub!(/\\[Gg]/) { "\002" }
		#~ return text
	#~ end
	
	#~ def dispose2
		#~ $game_temp.message_proc.call
		#~ $end_proc.call
		#~ super
	#~ end
	
	#~ def update
		#~ super
		#~ if @menu.size > 0
			#~ for i in 0...@menu.size
				#~ if @menu[i].click			
					#~ $game_system.se_play($data_system.decision_se)
					#~ Hwnd.dispose(self)
					#~ $game_temp.message_proc.call
					#~ $game_temp.choice_proc.call(i)
				#~ end
			#~ end
		#~ end
		
		#~ if Key.trigger?(KEY_SPACE) #space
			#~ @a.click = true if Hwnd.highlight? == self
		#~ end
		
		#~ if Key.trigger?(KEY_ESC) #esc
			#~ @b.click = true if Hwnd.highlight? == self and !@b.disposed?
		#~ end
		
		#~ case @type
		#~ when 0
			#~ if @a.click # 다음 버튼 클릭
				#~ if @input_num != nil				
					#~ if @input_num.result.to_i > 0
						#~ $game_variables[$game_temp.num_input_variable_id] = @input_num.result.to_i
						#~ $game_map.need_refresh = true
						#~ $game_system.se_play($data_system.decision_se)
						#~ $game_temp.message_proc.call
						#~ $game_temp.num_input_variable_id = 0
						#~ $game_temp.num_input_digits_max = 0
						#~ Hwnd.dispose(self)
					#~ else
						#~ $console.write_line("1 이상의 수를 입력하세요.")
					#~ end
				#~ else
					#~ $game_system.se_play($data_system.decision_se)
					#~ $game_temp.message_proc.call
					#~ Hwnd.dispose(self)
				#~ end
			#~ elsif @b.click # 닫기 버튼 클릭
				#~ dispose2
			#~ end
		#~ when 1
			#~ if @a.click # 다음 버튼 클릭
				#~ $game_system.se_play($data_system.decision_se)
				#~ $game_temp.message_proc.call
				#~ Hwnd.dispose(self)
			#~ elsif @b.click # 닫기 버튼 클릭
				#~ dispose2
			#~ end
		#~ when 2
			#~ if @a.click # 다음 버튼 클릭
				#~ if @input_num.result.to_i > 0
					#~ $game_variables[$game_temp.num_input_variable_id] = @input_num.result.to_i
					#~ $game_map.need_refresh = true
					#~ $game_system.se_play($data_system.decision_se)
					#~ $game_temp.message_proc.call
					#~ $game_temp.num_input_variable_id = 0
					#~ $game_temp.num_input_digits_max = 0
					#~ Hwnd.dispose(self)
				#~ else
					#~ $console.write_line("1 이상의 수를 입력하세요.")
				#~ end
			#~ elsif @b.click # 닫기 버튼 클릭
				#~ dispose2
			#~ end
		#~ end
		
	#~ end
#~ end


#~ # 클라에서의 명령문을 수정한다.
#~ class Interpreter
	#~ #--------------------------------------------------------------------------
	#~ # * npc 대화
	#~ #--------------------------------------------------------------------------
	#~ def command_101
		#~ # If other text has been set to message_text
		#~ if $game_temp.message_text != nil
			#~ # End
			#~ return false
		#~ end
		
		#~ # Set message end waiting flag and callback
		#~ @message_waiting = true
		#~ $game_temp.message_proc = Proc.new { @message_waiting = false }
		#~ $end_proc = Proc.new {self.command_end}
		
		#~ # Set message text on first line
		#~ $game_temp.message_text = @list[@index].parameters[0] + "\n"
		#~ line_count = 1
		#~ # Loop
		#~ $game_temp.choice_start = 4
		#~ $game_temp.num_input_start = 0
		
		#~ txt_list = []
		
		#~ loop do
			#~ # 만약 다음 이벤트 명령어가 텍스트라면 추가
			#~ if @list[@index + 1].code == 101
				#~ txt_list.push($game_temp.message_text)
				#~ $game_temp.message_text = @list[@index + 1].parameters[0] + "\n"
			#~ elsif @list[@index + 1].code == 401
				#~ # Add the second line or after to message_text
				#~ $game_temp.message_text += @list[@index + 1].parameters[0] + "\n"
				#~ line_count += 1
				#~ # If event command is not on the second line or after
			#~ else
				#~ # 선택지가 있는 명령어거나 명령어 끝
				#~ @m_count = 0
				
				#~ if @list[@index + 1].code == 102
					#~ # 만약 선택지를 한번에 넣을 수 있으면 넣음
					#~ if @list[@index + 1].parameters[0].size <= 4 - line_count
						#~ @m_count = @list[@index + 1].parameters[0].size
						#~ # Advance index
						#~ @index += 1
						#~ # Choices setup
						#~ $game_temp.choice_start = line_count
						#~ setup_choices(@list[@index].parameters)
					#~ end
					
					#~ # 다음 명령어가 숫자 입력 선택지라면	
				#~ elsif @list[@index + 1].code == 103
					#~ # 화면에 넣을 수 있다면
					#~ if line_count < 4
						#~ # Advance index
						#~ @index += 1
						#~ # Number input setup
						#~ $game_temp.num_input_start = line_count
						#~ $game_temp.num_input_variable_id = @list[@index].parameters[0]
						#~ $game_temp.num_input_digits_max = @list[@index].parameters[1]
					#~ end
				#~ else
					
				#~ end
				
				#~ # Continue
				#~ if $game_map.events[@event_id] != nil
					#~ # npc대화창 생성
					#~ Jindow_N2.new($game_temp.message_text, $game_map.events[@event_id].name, @m_count, 0)
					#~ $game_temp.message_text = nil
				#~ end
				#~ return true
			#~ end
			
			#~ # Advance index
			#~ @index += 1
		#~ end
	#~ end
	#~ #--------------------------------------------------------------------------
	#~ # * 선택 메시지
	#~ #--------------------------------------------------------------------------
	#~ def command_102
		#~ # If text has been set to message_text
		#~ if $game_temp.message_text != nil
			#~ # End
			#~ return false
		#~ end
		#~ # Set message end waiting flag and callback
		#~ @message_waiting = true
		#~ $end_proc = Proc.new {self.command_end}
		#~ $game_temp.message_proc = Proc.new { @message_waiting = false }
		#~ # Choices setup
		#~ $game_temp.message_text = ""
		#~ $game_temp.choice_start = 0
		#~ setup_choices(@parameters)
		
		#~ # Continue
		#~ if $game_map.events[@event_id] != nil
			#~ Jindow_N2.new($game_temp.message_text, $game_map.events[@event_id].name, @parameters[0].size, 1)
			#~ $game_temp.message_text = nil
			#~ # Continue
		#~ end
		#~ return true
	#~ end
	
	#~ #--------------------------------------------------------------------------
	#~ # * Setup Choices
	#~ #--------------------------------------------------------------------------
	#~ def setup_choices(parameters)
		#~ # Set choice item count to choice_max
		#~ $game_temp.choice_max = parameters[0].size
		#~ # Set choice to message_text
		#~ for text in parameters[0]
			#~ $game_temp.message_text += text + "\n"
		#~ end
		#~ # Set cancel processing
		#~ $game_temp.choice_cancel_type = parameters[1]
		#~ # Set callback
		#~ current_indent = @list[@index].indent
		#~ $game_temp.choice_proc = Proc.new { |n| @branch[current_indent] = n }
	#~ end
	
	#~ #--------------------------------------------------------------------------
	#~ # * Input Number
	#~ #--------------------------------------------------------------------------
	#~ def command_103
		#~ # If text has been set to message_text
		#~ if $game_temp.message_text != nil
			#~ # End
			#~ return false
		#~ end
		#~ # Set message end waiting flag and callback
		#~ @message_waiting = true
		#~ $game_temp.message_proc = Proc.new { @message_waiting = false }
		#~ # Number input setup
		#~ $game_temp.message_text = ""
		#~ $game_temp.num_input_start = 0
		#~ $game_temp.num_input_variable_id = @parameters[0]
		#~ $game_temp.num_input_digits_max = @parameters[1]
		#~ # Continue
		#~ if $game_map.events[@event_id] != nil
			#~ Jindow_N2.new($game_temp.message_text, $game_map.events[@event_id].name, 0, 2)
			#~ $game_temp.message_text = nil
			#~ # Continue
		#~ end
		#~ # Continue
		#~ return true
	#~ end
#~ end
