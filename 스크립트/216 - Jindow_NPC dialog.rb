#==============================================================================
# ■ Jindow_N
#------------------------------------------------------------------------------
#   NPC 대화
#------------------------------------------------------------------------------
class Jindow_N < Jindow
	def initialize
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 400, 105)
		self.name = $npc_name.to_s
		@head = true
		@drag = true
		self.refresh("N")
		self.x = 640 / 2 - 400 / 2
		self.y = 255
		texts = []
		texts.push("( " + $npc_name.to_s + " )")
		text = Sprite.new(self)
		text.bitmap = Bitmap.new(self.width, texts.size * 18 + 12)
		text.bitmap.font.color.set(90, 80, 70, 255)
		for i in 0...texts.size
			text.bitmap.draw_text(0, i * 18, self.width, 32, texts[i])
		end
		texts = []
		texts.push("")
		texts.push("                     " + $npc_say1.to_s)
		texts.push("                     " + $npc_say2.to_s)
		texts.push("                     " + $npc_say3.to_s)
		texts.push("                     " + $npc_say4.to_s)
		text = Sprite.new(self)
		text.bitmap = Bitmap.new(self.width, texts.size * 18 + 12)
		text.bitmap.font.color.set(0, 0, 0, 255)
		for i in 0...texts.size
			text.bitmap.draw_text(0, i * 18, self.width, 32, texts[i])
		end
		if $npcchoice != true
			@a = J::Button.new(self).refresh(45, "다음")
			@b = J::Button.new(self).refresh(45, "닫기")
			@a.x = self.width - 92
			@b.x = self.width - 45
			@a.y = 83
			@b.y = 83
		elsif $npcchoice == true
			@a = J::Button.new(self).refresh(170, "- " + $npc_choice1.to_s)
			@b = J::Button.new(self).refresh(170, "- " + $npc_choice2.to_s)
			@a.x = self.width - 315
			@b.x = self.width - 315
			@a.y = 61
			@b.y = 83
		end
	end
	
	def update
		super
		if $npcchoice != true
			if @a.click
				if $npcsgb == true
					if $npcsuc == true
						$npcclosed = true
					else
						$npcsuccess = true
					end
					Audio.se_play("Audio/SE/047-Book02")
				else
					$npc6 = $npc6.to_i+1
					Audio.se_play("Audio/SE/046-Book01")
				end
			elsif @b.click
				$npcclosed = true
				Audio.se_play("Audio/SE/047-Book02")
			end
		elsif $npcchoice == true
			if @a.click
				$npcchoice2 = 1
				$npcchoice = false
				Audio.se_play("Audio/SE/046-Book01")
			elsif @b.click
				$npcchoice3 = 1
				$npcchoice = false
				Audio.se_play("Audio/SE/046-Book01")
			end
		end
	end
end

#------------------------------------------------------------------------------
#  This interpreter runs event commands. This class is used within the
#  Game_System class and the Game_Event class.
#==============================================================================

class Interpreter
	#--------------------------------------------------------------------------
	# * Show Text
	#--------------------------------------------------------------------------
	def command_101
		# If other text has been set to message_text
		if $game_temp.message_text != nil
			# End
			return false
		end
		# Set message end waiting flag and callback
		@message_waiting = true
		$game_temp.message_proc = Proc.new { @message_waiting = false }
		# Set message text on first line
		$game_temp.message_text = @list[@index].parameters[0] + "\n"
		line_count = 1
		# Loop
		loop do
			# If next event command text is on the second line or after
			if @list[@index+1].code == 401
				# Add the second line or after to message_text
				$game_temp.message_text += @list[@index+1].parameters[0] + "\n"
				line_count += 1
				# If event command is not on the second line or after
			else
				# If next event command is show choices
				if @list[@index+1].code == 102
					# If choices fit on screen
					if @list[@index+1].parameters[0].size <= 4 - line_count
						# Advance index
						@index += 1
						# Choices setup
						$game_temp.choice_start = line_count
						setup_choices(@list[@index].parameters)
					end
					# If next event command is input number
				elsif @list[@index+1].code == 103
					# If number input window fits on screen
					if line_count < 4
						# Advance index
						@index += 1
						# Number input setup
						$game_temp.num_input_start = line_count
						$game_temp.num_input_variable_id = @list[@index].parameters[0]
						$game_temp.num_input_digits_max = @list[@index].parameters[1]
					end
				end
				# Continue
				return true
			end
			# Advance index
			@index += 1
		end
	end
	#--------------------------------------------------------------------------
	# * Show Choices
	#--------------------------------------------------------------------------
	def command_102
		# If text has been set to message_text
		if $game_temp.message_text != nil
			# End
			return false
		end
		# Set message end waiting flag and callback
		@message_waiting = true
		$game_temp.message_proc = Proc.new { @message_waiting = false }
		# Choices setup
		$game_temp.message_text = ""
		$game_temp.choice_start = 0
		setup_choices(@parameters)
		# Continue
		return true
	end
end

