#~ #모든 한글을 가,각,갂,간,갇,....형식으로 저장
#~ for o in 0xAC00..0xD7A3
	#~ skor = "#{skor}#{(o).to_a.pack('U*')},"
#~ end

#~ #저장한 한글을 ","를 기준으로 배열에 때려박음(?)
#~ KOR = skor.split(",")

#~ #한글입력
#~ Korkey = ["R","","S","E","","F","A","Q","","T","","D","W","","C","Z","X","V","G"]
#~ Korkey+= ["K","O","I","","J","P","U","","H","","","","Y","N","","","","B","M","","L"]

#~ #한글+쉬프트
#~ Kor_shift = [1,-1,2,4,-1,5,6,8,-1,10,-1,11,13,-1,14,15,16,17,18]
#~ Kor_shift += [19,22,21,-1,23,26,24,-1,27,28,29,30,31,32,33,34,35,36,37,38,39]


#~ #자음받침
#~ Lastsound = [1,2,4,7,nil,8,16,17,nil,19,20,21,22,nil,23,24,25,26,27]

#~ #종성 -> 초성 변환
#~ LFsound = [-1,0,1,9,2,12,18,3,5,0,6,7,9,16,17,18,6,7,9,9,10,11,12,14,15,16,17,18]

#~ #종성->초성후 종성에 남는자음
#~ LLsound = [nil,nil,nil,1,nil,4,4,nil,nil,8,8,8,8,8,8,8,nil,nil,17,nil,nil]

#~ #초성 단독 출력
#~ Vowel = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]
#~ #중성 단독 출력
#~ Vowel2 = ["ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ","ㅘ","ㅙ","ㅚ","ㅛ","ㅜ","ㅝ","ㅞ","ㅟ","ㅠ","ㅡ","ㅢ","ㅣ"]

#~ #특수문자 입력
#~ Specials = [Input::Collon,Input::Equal,Input::Comma,Input::Underscore,Input::Dot,Input::Quote,Input::Backslash]
#~ Specials += [Input::Lb,Input::Rb,Input::Space]

#~ #영어, 숫자, 특수문자
#~ Others = [0,1,2,3,4,5,6,7,8,9]
#~ Others += ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"]
#~ Others += ["q","r","s","t","u","v","w","x","y","z",";","=",",","-",".","'","/","[","]","  "," "]

#~ #영어, 숫자, 특수문자 + 쉬프트
#~ Sh_others = [")","!","@","#","$","%","^","&","*","(","A","B","C","D","E"]
#~ Sh_others += ["F","G","H","I","J","K","L","M","N","O","P","Q","R"]
#~ Sh_others += ["S","T","U","V","W","X","Y","Z",":","+","<","_",">","\"","?","{","}","  "]
#~ Sh_others += [""]

#~ module J
	#~ class Type < Sprite
		#~ attr_reader :id
		#~ attr_reader :skin
		#~ attr_reader :file
		#~ attr_reader :push
		#~ attr_reader :click
		#~ attr_reader :double_click
		#~ attr_reader :bluck
		#~ attr_accessor :hide
		#~ attr_accessor :font
		
		#~ def initialize(viewport = Viewport.new(0, 0, 640, 480))
			#~ super(viewport)
			#~ @id = viewport.item.index self
			#~ @viewport = viewport
			#~ @skin = viewport.skin
			#~ @route = "Graphics/Jindow/" + @skin + "/Window/"
			#~ @file = @route + "type"
			#~ @font = Font.new(User_Edit::FONT_DEFAULT_NAME, 13)
			#~ @font.alpha = 2
			#~ @font.color.set(255, 255, 255, 255)
			#~ @push = false
			#~ @click = false
			#~ @double_click = false
			#~ @double_wait = 0
			#~ @press_wait = 0
			#~ @hide = false
			#~ @edit = true
			#~ @bluck = false
			#~ @start = false
			#~ @input_hangul = true
			#~ @text = ""
			#~ @n_temp = false
			#~ $engkor = "eng"
			#~ @KB_string = ""
			#~ @KB_order = []
			#~ #초성 중성 종성
			#~ @kor_first = []
			#~ @kor_second = []
			#~ @kor_last = []
			#~ @slength = 0
			#~ return self
		#~ end
		
		#~ def file=(val)
			#~ @file = @route + val
		#~ end
		
		#~ def refresh?
			#~ return @start
		#~ end
		
		#~ def set(command)
			#~ @KB_string = command
			#~ return self
		#~ end
		
		#~ def view
			#~ return if @text == @KB_string
			#~ @text = @KB_string
			#~ command = @text
			
			#~ if self.bitmap.text_size(command).width > self.bitmap.width
				#~ @text = command[0, command.size]
				#~ return
			#~ else
				#~ self.bitmap.clear
				#~ for x in 0..self.bitmap.width
					#~ for y in 0..self.bitmap.height
						#~ self.bitmap.set_pixel(x, y, @memory.color[x][y])
					#~ end
				#~ end
				#~ if @hide
					#~ command = "*" * command.scan(/./).size
				#~ end
				#~ self.bitmap.draw_text(self.bitmap.rect, command + "|", 0)
			#~ end
		#~ end
		
		#~ def result
			#~ @KB_order = []
			#~ #초성 중성 종성
			#~ @kor_first = []
			#~ @kor_second = []
			#~ @kor_last = []
			
			#~ return @text
		#~ end
		
		#~ def bluck?
			#~ return @bluck
		#~ end
		
		#~ def bluck=(val)
			#~ if val and not @bluck
				#~ @bluck = true
				#~ self.tone.set(-64, -64, 64)
				#~ for i in self.viewport.item
					#~ i == self ? next : 0
					#~ i.JS? ? 0 : next
					#~ i.bluck = false
				#~ end
			#~ elsif not val and @bluck
				#~ @bluck = false
				#~ self.tone.set(0, 0, 0)
			#~ end
		#~ end
		
		#~ def refresh(x, y, width, height, hangul=true)
			#~ @start = true
			#~ @input_hangul = hangul
			#~ if x.rect?
				#~ y = x.y
				#~ width = x.width
				#~ height = x.height
				#~ x = x.x
			#~ end
			#~ self.x = x
			#~ self.y = y
			#~ self.bitmap = Bitmap.new(width, height)
			#~ ul = Sprite.new
			#~ um = Sprite.new
			#~ ur = Sprite.new
			#~ ml = Sprite.new
			#~ mr = Sprite.new
			#~ dl = Sprite.new
			#~ dm = Sprite.new
			#~ dr = Sprite.new
			#~ ul.bitmap = Bitmap.new(@file + "_ul")
			#~ ur.bitmap = Bitmap.new(@file + "_ur")
			#~ dl.bitmap = Bitmap.new(@file + "_dl")
			#~ dr.bitmap = Bitmap.new(@file + "_dr")
			#~ ow = self.bitmap.width - ul.bitmap.width - ur.bitmap.width
			#~ oh = self.bitmap.height - ul.bitmap.height - dl.bitmap.height
			#~ um.bitmap = Bitmap.new(ow, ul.bitmap.height, @file + "_um", 1)
			#~ ml.bitmap = Bitmap.new(ul.bitmap.width, oh, @file + "_ml", 1)
			#~ mr.bitmap = Bitmap.new(ur.bitmap.width, oh, @file + "_mr", 1)
			#~ dm.bitmap = Bitmap.new(ow, dl.bitmap.height, @file + "_dm", 1)
			#~ self.bitmap.blt(0, 0, ul.bitmap, ul.bitmap.rect)
			#~ self.bitmap.blt(ul.bitmap.width, 0, um.bitmap, um.bitmap.rect)
			#~ self.bitmap.blt(self.bitmap.width - ur.bitmap.width, 0, ur.bitmap, ur.bitmap.rect)
			#~ self.bitmap.blt(0, ul.bitmap.height, ml.bitmap, ml.bitmap.rect)
			#~ self.bitmap.blt(self.bitmap.width - mr.bitmap.width, ur.bitmap.height, mr.bitmap, mr.bitmap.rect)
			#~ self.bitmap.blt(0, self.bitmap.height - dl.bitmap.height, dl.bitmap, dl.bitmap.rect)
			#~ self.bitmap.blt(dl.bitmap.width, self.bitmap.height - dl.bitmap.height, dm.bitmap, dm.bitmap.rect)
			#~ self.bitmap.blt(self.bitmap.width - dr.bitmap.width, self.bitmap.height - dr.bitmap.height, dr.bitmap, dr.bitmap.rect)
			#~ self.bitmap.font = @font
			#~ self.bitmap.font.alpha = @font.alpha
			#~ self.bitmap.font.beta = @font.beta
			#~ self.bitmap.font.gamma = @font.gamma
			#~ @memory = JS.get_bitmap(self)
			#~ ul.dispose
			#~ um.dispose
			#~ ur.dispose
			#~ ml.dispose
			#~ mr.dispose
			#~ dl.dispose
			#~ dm.dispose
			#~ dr.dispose
			#~ self.view # 글씨 보여주기
			#~ return self
		#~ end
		
		#~ #---- update 시작 ----#
		#~ def update
			#~ super
			#~ self.refresh? ? 0 : return
			
			#~ @click ? (@click = false) : 0
			#~ if not @viewport.hudle
				#~ if Input.mouse_lbutton
					#~ if not @push and Mouse.arrive_sprite_rect?(self) and @viewport.base?
						#~ @push = true
						#~ self.bluck = true
					#~ end
				#~ else
					#~ @push ? (@push = false) : 0
				#~ end
			#~ else
			#~ end
			
			#~ if Hwnd.highlight? == @viewport and self.bluck? and Key.trigger?(4) # 엔터키
				#~ @click = true
			#~ end
			
			#~ self.bluck? ? 0 : return
			#~ Hwnd.highlight? == @viewport ? 0 : return
			#~ inputKB if @edit == true
			#~ update_KB if @n_temp
			
			#~ self.view
		#~ end
		#~ #---- update 끝 ----#
		
		#~ def click=(value)
			#~ @click = value
			#~ self.bluck = value
		#~ end
		
		#~ #============================================================================
		#~ # ● 입력
		#~ #============================================================================
		#~ def inputKB
			#~ if Input.triggerd?(Input::Back)
				#~ del(@KB_order, @KB_order.length-1)
				#~ @slength -= 1
				#~ @n_temp = true
				#~ return
			#~ end
			
			#~ if Key.trigger?(KEY_ALT) or Key.trigger?(98)  # 한 / 영 전환	
				#~ if $engkor == "eng"
					#~ $engkor = "kor"
				#~ else
					#~ $engkor = "eng"
				#~ end
				#~ @n_temp = true
				#~ return
			#~ end
			
			#~ for i in 36..36 + Specials.length
				#~ if not Sh_others[i] == "" && Input.pressed?(Input::Shift)
					#~ if Input.trigger?(Specials[i - 36])
						#~ @KB_order[@KB_order.length] = i + 999
						#~ @KB_order[@KB_order.length-1] += 1000 if Input.pressed?(Input::Shift)
						#~ @slength += 1
						#~ @n_temp = true
						#~ return
					#~ end
				#~ end
			#~ end
			
			#~ for i in 0..9
				#~ if Input.trigger?(Input::Numberkeys[i]) or Input.trigger?(Input::Numberpad[i])
					#~ @KB_order[@KB_order.length] = i + 999
					#~ @KB_order[@KB_order.length-1] += 1000 if Input.pressed?(Input::Shift)
					#~ @slength += 1
					#~ @n_temp = true
					#~ return
				#~ end
			#~ end
			
			#~ if $engkor == "kor"#한글입력
				#~ for i in 0..39
					#~ if Input.trigger?(Input::Letters[Korkey[i]])
						#~ if Input.pressed?(Input::Shift)
							#~ @KB_order[@KB_order.length] = Kor_shift[i]
						#~ else
							#~ @KB_order[@KB_order.length] = i
						#~ end
						#~ @slength+=1
						#~ @n_temp = true
						#~ return
					#~ end
				#~ end
			#~ else               #영어입력
				#~ for i in 10..35
					#~ if Input.trigger?(Input::Letters[Others[i].upcase])
						#~ @KB_order[@KB_order.length] = i + 999
						#~ @KB_order[@KB_order.length-1] += 1000 if Input.pressed?(Input::Shift)
						#~ @slength+=1
						#~ @n_temp = true
						#~ return
					#~ end
				#~ end
			#~ end
		#~ end
		
		#~ def last?(arr)
			#~ t = @kor_first.length
			#~ t = @kor_second.length if @kor_second.length > t
			#~ t = @kor_last.length if @kor_last.length > t
			#~ if t-1 < 0
				#~ return -1
			#~ else
				#~ if arr[t-1] == nil
					#~ return -1
				#~ else
					#~ return arr[t-1]
				#~ end
			#~ end
		#~ end
		
		#~ def del(zx, hh)
			#~ if hh == -1
				#~ zx = []  
			#~ else
				#~ zx[hh] = 111118189
				#~ zx.delete(111118189)
			#~ end
		#~ end
		
		#~ def update_KB  ###글자 조합(한글 기반)
			#~ @n_temp = false
			#~ @KB_string = ""
			#~ @kor_first = []
			#~ @kor_second = []
			#~ @kor_last = []
			#~ u = @KB_order.length
			
			#~ for k in 0...u
				#~ if @KB_order[k] < 19   #자음인가?
					#~ if last?(@kor_second) == -1   #마지막 글자에 중성이 없는가?
						#~ @kor_first[@kor_first.length] = @KB_order[k]
						
					#~ else                  #마지막 글자에 중성이 있는가?
						#~ if last?(@kor_last) == -1   #마지막 글자에 종성이 없는가?
							#~ if last?(@kor_first) == -1  
								#~ @kor_first[@kor_second.length] = @KB_order[k]
							#~ elsif Lastsound[@KB_order[k]] != nil
								#~ @kor_last[@kor_first.length-1] = Lastsound[@KB_order[k]]
							#~ else
								#~ @kor_first[@kor_first.length] = @KB_order[k]
							#~ end
							
						#~ else                  #마지막 글자에 종성이 있는가?
							#~ case last?(@kor_last)
							#~ when 1 #ㄱ
								#~ if @KB_order[k] == 0
									#~ @kor_last[@kor_first.length-1] += 1#ㄲ
								#~ else if @KB_order[k] == 9
										#~ @kor_last[@kor_first.length-1] += 2#ㄳ
									#~ else
										#~ @kor_first[@kor_first.length] = @KB_order[k]
									#~ end 
								#~ end
								
							#~ when 4 #ㄴ
								#~ if @KB_order[k] == 12
									#~ @kor_last[@kor_first.length-1] += 1#ㄵ
								#~ else if @KB_order[k] == 18
										#~ @kor_last[@kor_first.length-1] += 2#ㄶ
									#~ else
										#~ @kor_first[@kor_first.length] = @KB_order[k]
									#~ end 
								#~ end
								
							#~ when 7 #ㄷ
								#~ if @KB_order[k] == 3
									#~ @kor_first[@kor_first.length] = @KB_order[k]
								#~ end
								
							#~ when 8 #ㄹ
								#~ if @KB_order[k] == 0
									#~ @kor_last[@kor_first.length-1] += 1#ㄺ
								#~ else if @KB_order[k] == 6
										#~ @kor_last[@kor_first.length-1] += 2#ㄻ
									#~ else if @KB_order[k] == 7
											#~ @kor_last[@kor_first.length-1] += 3#ㄼ
										#~ else if @KB_order[k] == 9
												#~ @kor_last[@kor_first.length-1] += 4#ㄽ
											#~ else if @KB_order[k] == 16
													#~ @kor_last[@kor_first.length-1] += 5#ㄾ
												#~ else if @KB_order[k] == 17
														#~ @kor_last[@kor_first.length-1] += 6#ㄿ
													#~ else if @KB_order[k] == 18
															#~ @kor_last[@kor_first.length-1] += 7#ㅀ
														#~ else
															#~ @kor_first[@kor_first.length] = @KB_order[k]
														#~ end 
													#~ end 
												#~ end 
											#~ end 
										#~ end 
									#~ end 
								#~ end
								
							#~ when 17 #ㅂ
								#~ if @KB_order[k] == 9
									#~ @kor_last[@kor_first.length-1] += 1#ㅄ
								#~ else 
									#~ if @KB_order[k] == 7
										
									#~ else
										#~ @kor_first[@kor_first.length] = @KB_order[k]
									#~ end 
								#~ end
								
							#~ when 19 #ㅅ
								#~ if @KB_order[k] == 9
									#~ @kor_last[@kor_first.length-1] += 1#ㅆ
								#~ else
									#~ @kor_first[@kor_first.length] = @KB_order[k]
								#~ end
								
							#~ when 22 #ㅈ
								#~ if @KB_order[k] == 12
									#~ if $confu[k-1] == 1
										#~ del(@kor_last,@kor_last.length-1)
										#~ @kor_first[@kor_first.length] = 13 #초성ㅉ
									#~ else
										#~ @kor_first[@kor_first.length] = @KB_order[k]
									#~ end 
								#~ else
									#~ @kor_first[@kor_first.length] = @KB_order[k]
								#~ end
								
							#~ else
								#~ @kor_first[@kor_first.length] = @KB_order[k]
							#~ end
						#~ end
					#~ end
					
				#~ else                  #모음인가?
					#~ if @KB_order[k] > 998   #숫자 및 특수문자
						#~ @kor_first[@kor_first.length] = @KB_order[k]
						
					#~ else
						#~ if last?(@kor_first) != -1   #초성이 있는가?
							#~ if last?(@kor_second) == -1   #중성이 없는가?
								#~ @kor_second[@kor_first.length-1] = @KB_order[k]
							#~ else                  #중성이 있는가?
								#~ if last?(@kor_last) == -1   #종성이 없는가?
									#~ if @KB_order[k] == last?(@kor_second)
										#~ @kor_second[@kor_second.length] = @KB_order[k]
									#~ else
										#~ case last?(@kor_second)
										#~ when 20 #ㅐ
											#~ if @KB_order[k] == 20#ㅒ
												#~ @kor_second[@kor_second.length-1] += 2
											#~ else
												#~ del(@KB_order, k)
											#~ end
										#~ when 24 #ㅔ
											#~ if @KB_order[k] == 24
												#~ @kor_second[@kor_second.length-1] += 2
											#~ else
												#~ del(@KB_order,k)
											#~ end
										#~ when 27 #ㅗ
											#~ if @KB_order[k] == 19
												#~ @kor_second[@kor_second.length-1] += 1 #ㅘ
											#~ else if @KB_order[k] == 20
													#~ @kor_second[@kor_second.length-1] += 2 #ㅙ
												#~ else if @KB_order[k] == 39
														#~ @kor_second[@kor_second.length-1] += 3 #ㅚ
													#~ else
														#~ del(@KB_order,k)
													#~ end 
												#~ end 
											#~ end
										#~ when 32 #ㅜ
											#~ if @KB_order[k] == 23
												#~ @kor_second[@kor_second.length-1] += 1 #ㅝ
											#~ else if @KB_order[k] == 24
													#~ @kor_second[@kor_second.length-1] += 2 #ㅞ
												#~ else if @KB_order[k] == 39
														#~ @kor_second[@kor_second.length-1] += 3 #ㅟ
													#~ else
														#~ del(@KB_order,k)
													#~ end 
												#~ end 
											#~ end
										#~ when 37 #ㅡ
											#~ if @KB_order[k] == 39
												#~ @kor_second[@kor_second.length-1] += 1
											#~ else
												#~ del(@KB_order,k)
											#~ end
										#~ end
									#~ end
								#~ else                 #종성이 있는가?
									#~ u = last?(@kor_last)
									#~ @kor_first[@kor_first.length] = LFsound[u]
									#~ @kor_second[@kor_second.length] = @KB_order[k]
									#~ if LLsound[u] == nil
										#~ del(@kor_last,@kor_last.length-1)
									#~ else
										#~ @kor_last[@kor_last.length-1] = LLsound[u]
									#~ end
								#~ end
							#~ end
							
						#~ else #초성이 없을 때
							#~ @kor_second[@kor_second.length] = @KB_order[k]
						#~ end
					#~ end
				#~ end
			#~ end
			
			#~ #============================================================================
			#~ #  글자의 표시
			#~ #============================================================================
			#~ #글자의 개수
			#~ t = @kor_first.length
			#~ t = @kor_second.length if @kor_second.length > t
			#~ t = @kor_last.length if @kor_last.length > t
			
			#~ #글자가 있으면 표시
			#~ if t != 0
				#~ for d in 0...t
					#~ if @kor_first[d] == nil
						#~ @KB_string = "#{@KB_string}#{Vowel2[@kor_second[d] - Vowel.size]}"
					#~ elsif @kor_second[d] == nil
						#~ @KB_string = "#{@KB_string}#{Vowel[@kor_first[d]]}"
					#~ else
						#~ if @kor_last[d] == nil
							#~ m = @kor_first[d]*588
							#~ m += (@kor_second[d]-19)*28
							#~ @KB_string = "#{@KB_string}#{KOR[m]}"
						#~ else
							#~ m = @kor_first[d]*588
							#~ m += (@kor_second[d]-19)*28
							#~ m += @kor_last[d]
							#~ @KB_string = "#{@KB_string}#{KOR[m]}"
						#~ end
					#~ end
					
					#~ next if @kor_first[d] == nil
					
					#~ if @kor_first[d]-999 > -1
						#~ if @kor_first[d]-1999 < -1
							#~ @KB_string = "#{@KB_string}#{Others[@kor_first[d]-999]}"
						#~ else
							#~ @KB_string = "#{@KB_string}#{Sh_others[@kor_first[d]-1999]}"
						#~ end
					#~ end
				#~ end
			#~ end
		#~ end
	#~ end
#~ end
