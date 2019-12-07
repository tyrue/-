#===============================================================================
# ** Input Script v2 - This script was first created by Cybersam and she 
#                         deserves most of the credit, all I did was add a few 
#                         functions. (Astro_Mech says)
#-------------------------------------------------------------------------------
# Author    Cybersam
# Version   2.0
# Date      11-04-06
# Edit      Astro_mech and Mr.Mo
#===============================================================================
SDK.log("Input", "Astro_mech and Mr.Mo", "2.0", " 13-04-06")
#-------------------------------------------------------------------------------
# Begin SDK Enabled Check
#-------------------------------------------------------------------------------
if SDK.state('Input')
	module Input
		#--------------------------------------------------------------------------
		# * Variable Setup 변수 설정
		#-------------------------------------------------------------------------- 
		@keys = []    
		@pressed = []
		Mouse_Left = 1
		Mouse_Right = 2
		Mouse_Middle = 4
		Back= 8
		Tab = 9
		Enter = 13
		Shift = 16
		Ctrl = 17
		Alt = 18
		Esc = 0x1B
		LT = 0x25
		UPs = 0x26  
		RT = 0x27 
		DN = 0x28
		Space = 32
		Numberkeys = {}
		Numberkeys[0] = 48        # => 0
		Numberkeys[1] = 49        # => 1
		Numberkeys[2] = 50        # => 2
		Numberkeys[3] = 51        # => 3
		Numberkeys[4] = 52        # => 4
		Numberkeys[5] = 53        # => 5
		Numberkeys[6] = 54        # => 6
		Numberkeys[7] = 55        # => 7
		Numberkeys[8] = 56        # => 8
		Numberkeys[9] = 57        # => 9
		Numberpad = {}
		Numberpad[0] = 96
		Numberpad[1] = 97
		Numberpad[2] = 98
		Numberpad[3] = 99
		Numberpad[4] = 100
		Numberpad[5] = 101
		Numberpad[6] = 102
		Numberpad[7] = 103
		Numberpad[8] = 104
		Numberpad[9] = 105
		Letters = {}
		Letters["A"] = 65
		Letters["B"] = 66
		Letters["C"] = 67
		Letters["D"] = 68
		Letters["E"] = 69
		Letters["F"] = 70
		Letters["G"] = 71
		Letters["H"] = 72
		Letters["I"] = 73
		Letters["J"] = 74
		Letters["K"] = 75
		Letters["L"] = 76
		Letters["M"] = 77
		Letters["N"] = 78
		Letters["O"] = 79
		Letters["P"] = 80
		Letters["Q"] = 81
		Letters["R"] = 82
		Letters["S"] = 83
		Letters["T"] = 84
		Letters["U"] = 85
		Letters["V"] = 86
		Letters["W"] = 87
		Letters["X"] = 88
		Letters["Y"] = 89
		Letters["Z"] = 90
		Fkeys = {}
		Fkeys[1] = 112
		Fkeys[2] = 113
		Fkeys[3] = 114
		Fkeys[4] = 115
		Fkeys[5] = 116
		Fkeys[6] = 117
		Fkeys[7] = 118
		Fkeys[8] = 119
		Fkeys[9] = 120
		Fkeys[10] = 121
		Fkeys[11] = 122
		Fkeys[12] = 123
		Collon = 186        # => \ |
		Equal = 187         # => = +
		Comma = 188         # => , <
		Underscore = 189    # => - _
		Dot = 190           # => . >
		N_Dot = 110
		Backslash = 191     # => / ?
		Lb = 219
		Rb = 221
		Quote = 222         # => '"
		State = Win32API.new('user32','GetKeyState',['i'],'i')
		Key = Win32API.new('user32','GetAsyncKeyState',['i'],'i')
		#-------------------------------------------------------------------------------
		USED_KEYS = [Mouse_Left, Mouse_Right, Mouse_Middle] 
		#-------------------------------------------------------------------------------
		module_function
		#--------------------------------------------------------------------------  
		def Input.getstate(key) #getstate을 정의합니다.
			return true unless State.call(key).between?(0, 1)
			return false
		end
		#--------------------------------------------------------------------------
		def Input.testkey(key)
			Key.call(key) & 0x01 == 1
		end
		#--------------------------------------------------------------------------
		def Input.update
			@keys = []
			@keys.push(Input::Mouse_Left) if Input.testkey(Input::Mouse_Left)
			@keys.push(Input::Mouse_Right) if Input.testkey(Input::Mouse_Right)
			@keys.push(Input::Back) if Input.testkey(Input::Back)
			@keys.push(Input::Tab) if Input.testkey(Input::Tab)
			@keys.push(Input::Enter) if Input.testkey(Input::Enter)
			@keys.push(Input::Shift) if Input.testkey(Input::Shift)
			@keys.push(Input::Ctrl) if Input.testkey(Input::Ctrl)
			@keys.push(Input::Alt) if Input.testkey(Input::Alt)
			@keys.push(Input::Esc) if Input.testkey(Input::Esc)
			for key in Input::Letters.values
				@keys.push(key) if Input.testkey(key)
			end
			for key in Input::Numberkeys.values
				@keys.push(key) if Input.testkey(key)
			end
			for key in Input::Numberpad.values
				@keys.push(key) if Input.testkey(key)
			end
			for key in Input::Fkeys.values
				@keys.push(key) if Input.testkey(key)
			end
			@keys.push(Input::Collon) if Input.testkey(Input::Collon)
			@keys.push(Input::Equal) if Input.testkey(Input::Equal)
			@keys.push(Input::Comma) if Input.testkey(Input::Comma)
			@keys.push(Input::Underscore) if Input.testkey(Input::Underscore)
			@keys.push(Input::Dot) if Input.testkey(Input::Dot)
			@keys.push(Input::N_Dot) if Input.testkey(Input::N_Dot)
			@keys.push(Input::Backslash) if Input.testkey(Input::Backslash)
			@keys.push(Input::Lb) if Input.testkey(Input::Lb)
			@keys.push(Input::Rb) if Input.testkey(Input::Rb)
			@keys.push(Input::Quote) if Input.testkey(Input::Quote)
			@keys.push(Input::Space) if Input.testkey(Input::Space)
			@keys.push(Input::LT) if Input.testkey(Input::LT)
			@keys.push(Input::UPs) if Input.testkey(Input::UPs)
			@keys.push(Input::RT) if Input.testkey(Input::RT)
			@keys.push(Input::DN) if Input.testkey(Input::DN)
			@pressed = []
			@pressed.push(Input::Space) if Input.getstate(Input::Space)
			@pressed.push(Input::Mouse_Left) if Input.getstate(Input::Mouse_Left)
			@pressed.push(Input::Mouse_Right) if Input.getstate(Input::Mouse_Right)
			@pressed.push(Input::Back) if Input.getstate(Input::Back)
			@pressed.push(Input::Tab) if Input.getstate(Input::Tab)
			@pressed.push(Input::Enter) if Input.getstate(Input::Enter)
			@pressed.push(Input::Shift) if Input.getstate(Input::Shift)
			@pressed.push(Input::Ctrl) if Input.getstate(Input::Ctrl)
			@pressed.push(Input::Alt) if Input.getstate(Input::Alt)
			@pressed.push(Input::Esc) if Input.getstate(Input::Esc)
			@pressed.push(Input::LT) if Input.getstate(Input::LT)
			@pressed.push(Input::UPs) if Input.getstate(Input::UPs)
			@pressed.push(Input::RT) if Input.getstate(Input::RT)
			@pressed.push(Input::DN) if Input.getstate(Input::DN)
			for key in Input::Numberkeys.values
				@pressed.push(key) if Input.getstate(key)
			end
			for key in Input::Numberpad.values
				@pressed.push(key) if Input.getstate(key)
			end
			for key in Input::Letters.values
				@pressed.push(key) if Input.getstate(key)
			end
			for key in Input::Fkeys.values
				@pressed.push(key) if Input.getstate(key)
			end
			@pressed.push(Input::Collon) if Input.getstate(Input::Collon)
			@pressed.push(Input::Equal) if Input.getstate(Input::Equal)
			@pressed.push(Input::Comma) if Input.getstate(Input::Comma)
			@pressed.push(Input::Underscore) if Input.getstate(Input::Underscore)
			@pressed.push(Input::Dot) if Input.getstate(Input::Dot)
			@pressed.push(Input::Backslash) if Input.getstate(Input::Backslash)
			@pressed.push(Input::Lb) if Input.getstate(Input::Lb)
			@pressed.push(Input::Rb) if Input.getstate(Input::Rb)
			@pressed.push(Input::Quote) if Input.getstate(Input::Quote)  
		end
		#--------------------------------------------------------------------------
		def Input.triggerd?(key)
			return true if @keys.include?(key)
			return false
		end
		#--------------------------------------------------------------------------
		def Input.pressed?(key)
			return true if @pressed.include?(key)
			return false
		end
		#--------------------------------------------------------------------------
		# * 4 Diraction
		#--------------------------------------------------------------------------
		def Input.dir4
			return 2 if Input.pressed?(Input::DN)
			return 4 if Input.pressed?(Input::LT)
			return 6 if Input.pressed?(Input::RT)
			return 8 if Input.pressed?(Input::UPs)
			return 0
		end
		#--------------------------------------------------------------------------
		# * Trigger (key)
		#-------------------------------------------------------------------------- 
		def trigger?(key)
			keys = []
			case key
			when Input::DOWN
				keys.push(Input::DN)
			when Input::UP
				keys.push(Input::UPs)
			when Input::LEFT
				keys.push(Input::LT)
			when Input::RIGHT
				keys.push(Input::RT)
			when Input::C
				keys.push(Input::Space, Input::Letters["Z"], Input::N_Dot)
			when Input::B
				keys.push(Input::Esc)
			when Input::X
				keys.push(Input::Letters["A"])
			when Input::L
				keys.push(Input::Letters["Q"])
			when Input::R
				keys.push(Input::Letters["W"])
			when Input::Y
				keys.push(Input::Letters["R"])
			when Input::F5
				keys.push(Input::Fkeys[5])
			when Input::F6
				keys.push(Input::Fkeys[6])
			when Input::F7
				keys.push(Input::Fkeys[7])
			when Input::F8
				keys.push(Input::Fkeys[8])
			when Input::F9
				keys.push(Input::Fkeys[9])
			when Input::SHIFT
				keys.push(Input::Shift)
			when Input::CTRL
				keys.push(Input::Ctrl)
			when Input::ALT
				keys.push(Input::Alt)
			else
				keys.push(key)
			end
			for k in keys
				if Input.triggerd?(k)
					return true
				end
			end
			return false
		end
		#--------------------------------------------------------------------------
		# * Repeat (key)
		#-------------------------------------------------------------------------- 
		def repeat?(key)
			keys = []
			case key
			when Input::DOWN
				keys.push(Input::DN)
			when Input::UP
				keys.push(Input::UPs)
			when Input::LEFT
				keys.push(Input::LT)
			when Input::RIGHT
				keys.push(Input::RT)
			when Input::C
				keys.push(Input::Space, Input::Enter)
			when Input::B
				keys.push(Input::Esc, Input::Numberpad[0])
			when Input::X
				keys.push(Input::Letters["A"])
			when Input::L
				keys.push(Input::Letters["Q"])
			when Input::R
				keys.push(Input::Letters["W"])
			when Input::Y
				keys.push(Input::Letters["R"])
			when Input::F5
				keys.push(Input::Fkeys[5])
			when Input::F6
				keys.push(Input::Fkeys[6])
			when Input::F7
				keys.push(Input::Fkeys[7])
			when Input::F8
				keys.push(Input::Fkeys[8])
			when Input::F9
				keys.push(Input::Fkeys[9])
			when Input::SHIFT
				keys.push(Input::Shift)
			when Input::CTRL
				keys.push(Input::Ctrl)
			when Input::ALT
				keys.push(Input::Alt)
			else
				keys.push(key)
			end
			for k in keys
				if Input.triggerd?(k)
					return true
				end
			end
			return false
		end     
		#--------------------------------------------------------------------------
		# * Press (key)
		#-------------------------------------------------------------------------- 
		def press?(key)
			keys = []
			case key
			when Input::DOWN
				keys.push(Input::DN)
			when Input::UP
				keys.push(Input::UPs)
			when Input::LEFT
				keys.push(Input::LT)
			when Input::RIGHT
				keys.push(Input::RT)
			when Input::C
				keys.push(Input::Space, Input::Enter)
			when Input::B
				keys.push(Input::Esc, Input::Numberpad[0])
			when Input::X
				keys.push(Input::Letters["A"])
			when Input::L
				keys.push(Input::Letters["Q"])
			when Input::R
				keys.push(Input::Letters["W"])
			when Input::Y
				keys.push(Input::Letters["R"])
			when Input::F5
				keys.push(Input::Fkeys[5])
			when Input::F6
				keys.push(Input::Fkeys[6])
			when Input::F7
				keys.push(Input::Fkeys[7])
			when Input::F8
				keys.push(Input::Fkeys[8])
			when Input::F9
				keys.push(Input::Fkeys[9])
			when Input::SHIFT
				keys.push(Input::Shift)
			when Input::CTRL
				keys.push(Input::Ctrl)
			when Input::ALT
				keys.push(Input::Alt)
			else
				keys.push(key)
			end
			for k in keys
				if Input.pressed?(k)
					return true
				end
			end
			return false
		end     
		#--------------------------------------------------------------------------
		# * Check (key)
		#-------------------------------------------------------------------------- 
		def check(key)
			Win32API.new("user32","GetAsyncKeyState",['i'],'i').call(key) & 0x01 == 1  # key 0
		end
		#--------------------------------------------------------------------------
		# * Mouse Update
		#-------------------------------------------------------------------------- 
		def mouse_update
			@used_i = []
			for i in USED_KEYS
				x = check(i)
				if x == true
					@used_i.push(i)
				end
			end
		end
		#--------------------------------------------------------------------------
		# * Short Write C
		#-------------------------------------------------------------------------- 
		def Input.C
			Input.trigger?(C)
		end
		#--------------------------------------------------------------------------
		# * Short Write B
		#-------------------------------------------------------------------------- 
		def Input.B
			Input.trigger?(B)
		end
		#--------------------------------------------------------------------------
		# * Short Write A
		#-------------------------------------------------------------------------- 
		def Input.A
			Input.trigger?(A)
		end
		#--------------------------------------------------------------------------
		# * Short Write Down
		#-------------------------------------------------------------------------- 
		def Input.Down
			Input.trigger?(DOWN)
		end
		#--------------------------------------------------------------------------
		# * Short Write Up
		#-------------------------------------------------------------------------- 
		def Input.Up
			Input.trigger?(UP)
		end
		#--------------------------------------------------------------------------
		# * Short Write Right
		#-------------------------------------------------------------------------- 
		def Input.Right
			Input.trigger?(RIGHT)
		end
		#--------------------------------------------------------------------------
		# * Short Write Left
		#-------------------------------------------------------------------------- 
		def Input.Left
			Input.trigger?(LEFT)
		end
		#--------------------------------------------------------------------------
		# * Anykey pressed?  ( A or B or C or Down or Up or Right or Left )
		#-------------------------------------------------------------------------- 
		def Input.Anykey
			if A or B or C or Down or Up or Right or Left
				return true
			else
				return false
			end
		end
	end
end
#-------------------------------------------------------------------------------
# End SDK Enabled Check
#-------------------------------------------------------------------------------