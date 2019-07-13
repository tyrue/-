module J
	#모든 한글을 가,각,갂,간,갇,....형식으로 저장
	for o in 0xAC00..0xD7A3
		skor = "#{skor}#{(o).to_a.pack('U*')},"
	end
	
	#저장한 한글을 ","를 기준으로 배열에 때려박음(?)
	KOR = skor.split(",")
	
	#한글입력
	Korkey = ["R","","S","E","","F","A","Q","","T","","D","W","","C","Z","X","V","G"]
	Korkey+= ["K","O","I","","J","P","U","","H","","","","Y","N","","","","B","M","","L"]
	
	#한글+쉬프트
	Kor_shift = [1,-1,2,4,-1,5,6,8,-1,10,-1,11,13,-1,14,15,16,17,18]
	Kor_shift += [19,22,21,-1,23,26,24,-1,27,28,29,30,31,32,33,34,35,36,37,38,39]
	
	#초성 중성 종성
	$kor_first = []
	$kor_second = []
	$kor_last = []
	
	#자음받침
	Lastsound = [1,2,4,7,nil,8,16,17,nil,19,20,21,22,nil,23,24,25,26,27]
	
	#종성 -> 초성 변환
	LFsound = [-1,0,1,9,2,12,18,3,5,0,6,7,9,16,17,18,6,7,9,9,10,11,12,14,15,16,17,18]
	
	#종성->초성후 종성에 남는자음
	LLsound = [nil,nil,nil,1,nil,4,4,nil,nil,8,8,8,8,8,8,8,nil,nil,17,nil,nil]
	
	#초성 단독 출력
	Vowel = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
	
	$KB_order = []
	
	#특수문자 입력
	Specials = [Input::Collon,Input::Equal,Input::Comma,Input::Underscore,Input::Dot,Input::Quote,Input::Backslash]
	Specials += [Input::Lb,Input::Rb,Input::Tab,Input::Space]
	
	#영어, 숫자, 특수문자
	Others = [0,1,2,3,4,5,6,7,8,9]
	Others += ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"]
	Others += ["q","r","s","t","u","v","w","x","y","z",";","=",",","-",".","'","/","[","]","  "," "]
	
	#영어, 숫자, 특수문자 + 쉬프트
	Sh_others = [")","!","@","#","$","%","^","&","*","(","A","B","C","D","E"]
	Sh_others += ["F","G","H","I","J","K","L","M","N","O","P","Q","R"]
	Sh_others += ["S","T","U","V","W","X","Y","Z",":","+","<","_",">","\"","?","{","}","  "]
	Sh_others += [""]
	
	
	class Type < Sprite
		attr_reader :id
		attr_reader :skin
		attr_reader :file
		attr_reader :push
		attr_reader :click
		attr_reader :double_click
		attr_reader :bluck
		attr_accessor :hide
		attr_accessor :font
		
		def initialize(viewport = Viewport.new(0, 0, 640, 480))
			super(viewport)
			@id = viewport.item.index self
			@viewport = viewport
			@skin = viewport.skin
			@route = "Graphics/Jindow/" + @skin + "/Window/"
			@file = @route + "type"
			@font = Font.new(User_Edit::FONT_DEFAULT_NAME, 13)
			@font.alpha = 2
			@font.color.set(255, 255, 255, 255)
			@push = false
			@click = false
			@double_click = false
			@double_wait = 0
			@press_wait = 0
			@hide = false
			@edit = true
			@bluck = false
			@start = false
			@input_hangul = true
			
			return self
		end
		
		def file=(val)
			@file = @route + val
		end
		
		def refresh?
			return @start
		end
		
		def set(command)
			
			return self
		end
		
		def view
			command = ""
			for i in @text
				command += i
			end
			if self.bitmap.text_size(command).width > self.bitmap.width
				@text.delete_at(@text.size - 1)
				return
			else
				self.bitmap.clear
				for x in 0..self.bitmap.width
					for y in 0..self.bitmap.height
						self.bitmap.set_pixel(x, y, @memory.color[x][y])
					end
				end
				if @hide
					command = "*" * command.scan(/./).size
				end
				self.bitmap.draw_text(self.bitmap.rect, command + "|", 0)
			end
		end
		
		def result
			command = ""
			for i in @text
				command += i
			end
			return command
		end
		
		def bluck?
			return @bluck
		end
		
		def bluck=(val)
			if val and not @bluck
				@bluck = true
				self.tone.set(-64, -64, 64)
				for i in self.viewport.item
					i == self ? next : 0
					i.JS? ? 0 : next
					i.bluck = false
				end
			elsif not val and @bluck
				@bluck = false
				self.tone.set(0, 0, 0)
			end
		end
		
		def refresh(x, y, width, height,hangul=true)
			@start = true
			@input_hangul = hangul
			if x.rect?
				y = x.y
				width = x.width
				height = x.height
				x = x.x
			end
			self.x = x
			self.y = y
			self.bitmap = Bitmap.new(width, height)
			ul = Sprite.new
			um = Sprite.new
			ur = Sprite.new
			ml = Sprite.new
			mr = Sprite.new
			dl = Sprite.new
			dm = Sprite.new
			dr = Sprite.new
			ul.bitmap = Bitmap.new(@file + "_ul")
			ur.bitmap = Bitmap.new(@file + "_ur")
			dl.bitmap = Bitmap.new(@file + "_dl")
			dr.bitmap = Bitmap.new(@file + "_dr")
			ow = self.bitmap.width - ul.bitmap.width - ur.bitmap.width
			oh = self.bitmap.height - ul.bitmap.height - dl.bitmap.height
			um.bitmap = Bitmap.new(ow, ul.bitmap.height, @file + "_um", 1)
			ml.bitmap = Bitmap.new(ul.bitmap.width, oh, @file + "_ml", 1)
			mr.bitmap = Bitmap.new(ur.bitmap.width, oh, @file + "_mr", 1)
			dm.bitmap = Bitmap.new(ow, dl.bitmap.height, @file + "_dm", 1)
			self.bitmap.blt(0, 0, ul.bitmap, ul.bitmap.rect)
			self.bitmap.blt(ul.bitmap.width, 0, um.bitmap, um.bitmap.rect)
			self.bitmap.blt(self.bitmap.width - ur.bitmap.width, 0, ur.bitmap, ur.bitmap.rect)
			self.bitmap.blt(0, ul.bitmap.height, ml.bitmap, ml.bitmap.rect)
			self.bitmap.blt(self.bitmap.width - mr.bitmap.width, ur.bitmap.height, mr.bitmap, mr.bitmap.rect)
			self.bitmap.blt(0, self.bitmap.height - dl.bitmap.height, dl.bitmap, dl.bitmap.rect)
			self.bitmap.blt(dl.bitmap.width, self.bitmap.height - dl.bitmap.height, dm.bitmap, dm.bitmap.rect)
			self.bitmap.blt(self.bitmap.width - dr.bitmap.width, self.bitmap.height - dr.bitmap.height, dr.bitmap, dr.bitmap.rect)
			self.bitmap.font = @font
			self.bitmap.font.alpha = @font.alpha
			self.bitmap.font.beta = @font.beta
			self.bitmap.font.gamma = @font.gamma
			@memory = JS.get_bitmap(self)
			ul.dispose
			um.dispose
			ur.dispose
			ml.dispose
			mr.dispose
			dl.dispose
			dm.dispose
			dr.dispose
			self.view
			return self
		end
		
		#---- update 시작 ----#
		def update
			super
			self.refresh? ? 0 : return
			
			@click ? (@click = false) : 0
			if not @viewport.hudle
				if Input.mouse_lbutton
					if not @push and Mouse.arrive_sprite_rect?(self) and @viewport.base?
						@push = true
						self.bluck = true
					end
				else
					@push ? (@push = false) : 0
				end
			else
			end
			if Hwnd.highlight? == @viewport and self.bluck? and Key.trigger?(4)
				@click = true
			end
			self.bluck? ? 0 : return
			Hwnd.highlight? == @viewport ? 0 : return
			update_key if @edit == true
			old_char = @char
			if @piece[3] == nil
				@piece[0] = nil
				@piece[1] = nil
				@piece[2] = nil
			end
			if HANGUL_FIRST_CHARACTER_TABLE[@char]!=nil or HANGUL_MID_CHARACTER_TABLE[@char]!=nil
				make_hangul
			else
				@char = nil
				@piece[0] = nil
				@piece[1] = nil
				@piece[2] = nil
				@piece[3] = nil
			end
		end
		#---- update 끝 ----#
		
		def click=(value)
			@click = value
			self.bluck = value
		end
		
			uni = ""
			div_piece = []
			text = @char
			if @piece[3] == nil
				if text == nil
					return
				else
					if HANGUL_MID_CHARACTER_TABLE[text]!=nil
						@piece[0] = nil
						@piece[1] = text
						@piece[2] = nil
						make_p
						return
					else
						@piece[0] = text
						@piece[1] = nil
						@piece[2] = nil
						make_p
						return
					end
				end
			else
				if HANGUL_MID_CHARACTER_TABLE[text]!=nil
					if @piece[0] != nil and @piece[1] == nil and @piece[2] == nil
						@piece[1] = text
						make_p
						edit_text(@piece[3])
						return
					elsif @piece[0] == nil and @piece[1] != nil and @piece[2] == nil
						uni = get_union(@piece[1], text)
						if uni == nil
							@piece[1] = text
							make_p
							return
						else
							@piece[1] = uni
							make_p
							edit_text(@piece[3])
							return
						end
					elsif @piece[0] == nil and @piece[1] == nil and @piece[2] != nil
						div_piece = divide_piece(@piece[2])
						if div_piece == @piece[2]
							@piece[0] = @piece[2]
							@piece[1] = text
							@piece[2] = nil
							make_p
							return
						else
							@piece[2] = div_piece[0]
							make_p
							edit_text(@piece[3])
							@piece[0] = div_piece[1]
							@piece[1] = text
							@piece[2] = nil
							make_p
							@text.push(@piece[3])
							return
						end
					elsif @piece[0] != nil and @piece[1] != nil and @piece[2] == nil
						uni = get_union(@piece[1], text)
						if uni == nil
							if ["ㅝ","ㅞ","ㅟ","ㅘ","ㅙ","ㅚ","ㅢ"].include?(@piece[1])
								make_p
								return
							else
								if HANGUL_MID_CHARACTER_TABLE[@text[@text.size - 1]]!=nil
									@piece[0] = nil
								end
								@piece[1] = text
								make_p
								return
							end
						else
							@piece[1] = uni
							make_p
							edit_text(@piece[3])
							return
						end
					elsif @piece[0] != nil and @piece[1] != nil and @piece[2] != nil
						div_piece = divide_piece(@piece[2])
						if div_piece == @piece[2]
							@piece[2] = nil
							make_p
							edit_text(@piece[3])
							@piece[0] = div_piece
							@piece[1] = text
							@piece[2] = nil
							make_p
							@text.push(@piece[3])
							return
						else
							@piece[2] = div_piece[0]
							make_p
							edit_text(@piece[3])
							@piece[0] = div_piece[1]
							@piece[1] = text
							@piece[2] = nil
							make_p
							@text.push(@piece[3])
							return
						end
					end
				else
					if @piece[0] != nil and @piece[1] == nil and @piece[2] == nil
						uni = get_union(@piece[0], text)
						if uni == nil
							@piece[0] = text
							make_p
							return
						else
							@piece[0] = nil
							@piece[2] = uni
							make_p
							edit_text(@piece[3])
							return
						end
					elsif @piece[0] == nil and @piece[1] != nil and @piece[2] == nil
						@piece[0] = text
						@piece[1] = nil
						make_p
						return
					elsif @piece[0] == nil and @piece[1] == nil and @piece[2] != nil
						div_piece = divide_piece(@piece[2])
						if div_piece == @piece[2]
							uni = get_union(@piece[2], text)
						else
							uni = get_union(div_piece[1], text)
						end
						if uni == nil
							if @text[@text.size - 1] == text
								@piece[0] = text
								@piece[2] = nil
							end
							make_p
							return
						else
							if div_piece == @piece[2]
								@piece[2] = nil
								@piece[0] = uni
								make_p
								return
							else
								@piece[2] = div_piece[0]
								make_p
								edit_text(@piece[3])
								@piece[0] = nil
								@piece[1] = nil
								@piece[2] = uni
								make_p
								@text.push(@piece[3])
								return
							end
						end
					elsif @piece[0] != nil and @piece[1] != nil and @piece[2] == nil
						@piece[2] = text
						make_p
						edit_text(@piece[3])
						return
					elsif @piece[0] != nil and @piece[1] != nil and @piece[2] != nil
						div_piece = divide_piece(@piece[2])
						if div_piece == @piece[2]
							uni = get_union(@piece[2], text)
						else
							uni = get_union(div_piece[1], text)
						end
						if uni == nil
							if @text[@text.size - 1] == text
								@piece[0] = @piece[2]
								@piece[1] = nil
								@piece[2] = nil
								make_p
							end
							return
						else
							if div_piece == @piece[2]
								@piece[2] = uni
								make_p
								edit_text(@piece[3])
								return
							else
								@piece[2] = div_piece[0]
								make_p
								edit_text(@piece[3])
								@piece[0] = nil
								@piece[1] = nil
								@piece[2] = uni
								make_p
								@text.push(@piece[3])
								return
							end
							return
						end
					end
				end
			end
		end
		
	
			if @piece[0] == nil and @piece[1] == nil and @piece[2] == nil
				@piece[3] = nil
				return
			elsif @piece[0] != nil and @piece[1] == nil and @piece[2] == nil
				@piece[3] = @piece[0]
				return
			elsif @piece[0] == nil and @piece[1] != nil and @piece[2] == nil
				@piece[3] = @piece[1]
				return
			elsif @piece[0] == nil and @piece[1] == nil and @piece[2] != nil
				@piece[3] = @piece[2]
				return
			elsif @piece[0] != nil and @piece[1] != nil 
				if @piece[2] != nil					
					if HANGUL_LAST_CHARACTER_TABLE[@piece[2]] != nil
						@piece[3] = HANGUL_CHARACTER_TABLE[HANGUL_FIRST_CHARACTER_TABLE[@piece[0]]][HANGUL_MID_CHARACTER_TABLE[@piece[1]]][HANGUL_LAST_CHARACTER_TABLE[@piece[2]]]
					end
					return
				else
					@piece[3] = HANGUL_CHARACTER_TABLE[HANGUL_FIRST_CHARACTER_TABLE[@piece[0]]][HANGUL_MID_CHARACTER_TABLE[@piece[1]]][HANGUL_LAST_CHARACTER_TABLE[""]]
					return
				end
			end
		end
		

		
	end
end
