#============================================================================
# ■ Input_KeyBoard
#----------------------------------------------------------------------------
# 　한영 키보드 입력
#   만든이: XP가 짱
#   일시:  2018.7.18 (방학이다!!)
#   ※무단배포, 수정 가능합니다.(잠만 그럼 무단이 아니잖아?)
#    원작자만 제대로 표기해 주시길...
#============================================================================
# 사용법
#----------------------------------------------------------------------------
#  실행 : KB_Input(전달사항)   ex) KB_Input("이름이든 뭐든 입력하시yo")
#  결과 : $KB_result          입력완료값
#
#  조작 : 키보드로 입력, 아래방향키로 입력완료, 위키로 다시 입력
#      백스페이스로 지우기, Shift+Space로 한영전환
#
#  입력가능: 한글, 영어, 숫자, ! @ # $ % ^ & * ( ) < > ? , . / [ ] { } ; ' : " 
#         Tab, Space
#
#  부가기능: KB_set_name(액터번호)  =>  액터의 이름을 입력값으로(입력 이후에 사용)
#----------------------------------------------------------------------------

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

#한/영
$engkor = "kor"

class Window_InputKB < Window_Base
	
	#----------------------------------------------------------------------------
	# ● 오브젝트 초기화
	#----------------------------------------------------------------------------
	def initialize
		super(0, 0, 416, 128)
		self.contents = Bitmap.new(width - 32, height - 32)
		$slength = 0
		inpKB
	end
	#----------------------------------------------------------------------------
	# ● 리프레쉬
	#----------------------------------------------------------------------------
	def inpKB
		self.contents.clear
		self.contents.font.color = system_color
		self.contents.draw_text(4, 0, 300, 32,"#{$messsage}")
		self.contents.font.color = normal_color
		self.contents.draw_text(4,32, 384, 32,"#{$KB_string}")
		if Input.trigger?(Input::DOWN)
			exit_kb = Window_Command.new(192,["입력완료"])
			exit_kb.opacity = 180
			exit_kb.x = 220
			exit_kb.y = 240
			self.y -= 64
			$game_system.se_play($data_system.cursor_se)
			loop do
				Graphics.update
				Input.update
				exit_kb.update
				if Input.trigger?(Input::UP)
					exit_kb.dispose
					self.y += 64
					break
				end
				if Input.trigger?(Input::C)
					exit_kb.dispose
					$KB_result = $KB_string
					$kend = true
					$game_system.se_play($data_system.decision_se)
					break
				end  
			end
		end
	end
	#============================================================================
	# ● 입력
	#============================================================================
	def inputKB
		$KB_string = ""
		$KB_result = ""
		loop do
			
			Graphics.update
			Input.update
			inpKB
			if $kend == true
				break
			end
			
			if Input.trigger?(Input::Y)
				del($KB_order,$KB_order.length-1)
				$slength -= 1
				update_KB
			end
			
			if Input.trigger?(Input::Space)
				if Input.pressed?(Input::Shift)
					if $engkor == "eng"
						$engkor = "kor"
					else
						$engkor = "eng"
					end
				end
			end
			
			for i in 36..36+Specials.length
				if not Sh_others[i] == "" && Input.pressed?(Input::Shift)
					if Input.trigger?(Specials[i-36])
						$KB_order[$KB_order.length] = i + 999
						$KB_order[$KB_order.length-1] += 1000 if Input.pressed?(Input::Shift)
						$slength+=1
						update_KB
					end
				end
			end
			
			for i in 0..9
				if Input.trigger?(Input::Numberkeys[i])
					$KB_order[$KB_order.length] = i + 999
					$KB_order[$KB_order.length-1] += 1000 if Input.pressed?(Input::Shift)
					$slength+=1
					update_KB
				end
			end
			
			if $engkor == "kor"#한글입력
				for i in 0..39
					if Input.trigger?(Input::Letters[Korkey[i]])
						if Input.pressed?(Input::Shift)
							$KB_order[$KB_order.length] = Kor_shift[i]
						else
							$KB_order[$KB_order.length] = i
						end
						$slength+=1
						update_KB
					end
				end
			else               #영어입력
				for i in 10..35
					if Input.trigger?(Input::Letters[Others[i].upcase])
						$KB_order[$KB_order.length] = i + 999
						$KB_order[$KB_order.length-1] += 1000 if Input.pressed?(Input::Shift)
						$slength+=1
						update_KB
					end
				end
			end
			#============================================================================
			#  글자의 표시
			#============================================================================
			#글자의 개수
			t = $kor_first.length
			t = $kor_second.length if $kor_second.length > t
			t = $kor_last.length if $kor_last.length > t
			
			$KB_string = ""
			#글자가 있으면 표시
			if t != 0
				for d in 0...t
					if $kor_second[d] == nil
						$KB_string = "#{$KB_string}#{Vowel[$kor_first[d]]}"
					else
						if $kor_last[d] == nil
							m = $kor_first[d]*588
							m += ($kor_second[d]-19)*28
							$KB_string = "#{$KB_string}#{KOR[m]}"
						else
							m = $kor_first[d]*588
							m += ($kor_second[d]-19)*28
							m += $kor_last[d]
							$KB_string = "#{$KB_string}#{KOR[m]}"
						end
					end
					if $kor_first[d]-999 > -1
						if $kor_first[d]-1999 < -1
							$KB_string = "#{$KB_string}#{Others[$kor_first[d]-999]}"
						else
							$KB_string = "#{$KB_string}#{Sh_others[$kor_first[d]-1999]}"
						end
					end
				end
			end
		end
	end
end

def last?(arr)
	t = $kor_first.length
	t = $kor_second.length if $kor_second.length > t
	t = $kor_last.length if $kor_last.length > t
	if t-1 < 0
		return -1
	else
		if arr[t-1] == nil
			return -1
		else
			return arr[t-1]
		end
	end
end

def del(zx,hh)
	if hh == -1
		zx = []  
	else
		zx[hh] = 111118189
		zx.delete(111118189)
	end
end

def KB_Input(meess)
	$KB_order = []
	$kend = false
	$messsage = meess
	$KB_string = ""
	$KB_result = ""
	ikb = Window_InputKB.new
	ikb.x = 112
	ikb.y = 176
	ikb.opacity = 180
	ikb.inputKB
	ikb.dispose
end

def update_KB  ###글자 조합(한글 기반)
	
	$kor_first = []
	$kor_second = []
	$kor_last = []
	u = $KB_order.length
	
	for k in 0...u
		if $KB_order[k] < 19   #자음인가?
			if last?($kor_second) == -1   #마지막 글자에 중성이 없는가?
				if last?($kor_first) == -1   #마지막 글자에 초성이 없는가?
					#첫글자 입력중-초성에 값저장
					$kor_first[0] = $KB_order[k]
				else                  #마지막 글자에 초성이 있는가?
					$kor_first[$kor_first.length] = $KB_order[k]
				end
			else                  #마지막 글자에 중성이 있는가?
				if last?($kor_last) == -1   #마지막 글자에 종성이 없는가?
					if Lastsound[$KB_order[k]] != nil
						$kor_last[$kor_first.length-1] = Lastsound[$KB_order[k]]
					else
						$kor_first[$kor_first.length] = $KB_order[k]
					end
				else                  #마지막 글자에 종성이 있는가?
					case last?($kor_last)
					when 1 #ㄱ
						if $KB_order[k] == 0
							$kor_last[$kor_first.length-1] += 1#ㄲ
						else if $KB_order[k] == 9
								$kor_last[$kor_first.length-1] += 2#ㄳ
							else
								$kor_first[$kor_first.length] = $KB_order[k]
							end end
					when 4 #ㄴ
						if $KB_order[k] == 12
							$kor_last[$kor_first.length-1] += 1#ㄵ
						else if $KB_order[k] == 18
								$kor_last[$kor_first.length-1] += 2#ㄶ
							else
								$kor_first[$kor_first.length] = $KB_order[k]
							end end
					when 7 #ㄷ
						if $KB_order[k] == 3
							$kor_first[$kor_first.length] = $KB_order[k]
						end
					when 8 #ㄹ
						if $KB_order[k] == 0
							$kor_last[$kor_first.length-1] += 1#ㄺ
						else if $KB_order[k] == 6
								$kor_last[$kor_first.length-1] += 2#ㄻ
							else if $KB_order[k] == 7
									$kor_last[$kor_first.length-1] += 3#ㄼ
								else if $KB_order[k] == 9
										$kor_last[$kor_first.length-1] += 4#ㄽ
									else if $KB_order[k] == 16
											$kor_last[$kor_first.length-1] += 5#ㄾ
										else if $KB_order[k] == 17
												$kor_last[$kor_first.length-1] += 6#ㄿ
											else if $KB_order[k] == 18
													$kor_last[$kor_first.length-1] += 7#ㅀ
												else
													$kor_first[$kor_first.length] = $KB_order[k]
												end end end end end end end
					when 17 #ㅂ
						if $KB_order[k] == 9
							$kor_last[$kor_first.length-1] += 1#ㅄ
						else if $KB_order[k] == 7
							else
								$kor_first[$kor_first.length] = $KB_order[k]
							end end
					when 19 #ㅅ
						if $KB_order[k] == 9
							$kor_last[$kor_first.length-1] += 1#ㅆ
						else
							$kor_first[$kor_first.length] = $KB_order[k]
						end
					when 22 #ㅈ
						if $KB_order[k] == 12
							if $confu[k-1] == 1
								del($kor_last,$kor_last.length-1)
								$kor_first[$kor_first.length] = 13 #초성ㅉ
							else
								$kor_first[$kor_first.length] = $KB_order[k]
							end 
						else
							$kor_first[$kor_first.length] = $KB_order[k]
						end
					else
						$kor_first[$kor_first.length] = $KB_order[k]
					end
				end
			end
		else                  #모음인가?
			if $KB_order[k] > 998   #숫자 및 특수문자
				$kor_first[$kor_first.length] = $KB_order[k]
			else
				if last?($kor_first) != -1   #초성이 있는가?
					if last?($kor_second) == -1   #중성이 없는가?
						$kor_second[$kor_first.length-1] = $KB_order[k]
					else                  #중성이 있는가?
						if last?($kor_last) == -1   #종성이 없는가?
							case last?($kor_second)
							when 20 #ㅐ
								if $KB_order[k] == 20#ㅒ
									$kor_second[$kor_second.length-1] += 2
								else
									del($KB_order,k)
								end
							when 24 #ㅔ
								if $KB_order[k] == 24
									$kor_second[$kor_second.length-1] += 2
								else
									del($KB_order,k)
								end
							when 27 #ㅗ
								if $KB_order[k] == 19
									$kor_second[$kor_second.length-1] += 1 #ㅘ
								else if $KB_order[k] == 20
										$kor_second[$kor_second.length-1] += 2 #ㅙ
									else if $KB_order[k] == 39
											$kor_second[$kor_second.length-1] += 3 #ㅚ
										else
											del($KB_order,k)
										end end end
							when 32 #ㅜ
								if $KB_order[k] == 23
									$kor_second[$kor_second.length-1] += 1 #ㅝ
								else if $KB_order[k] == 24
										$kor_second[$kor_second.length-1] += 2 #ㅞ
									else if $KB_order[k] == 39
											$kor_second[$kor_second.length-1] += 3 #ㅟ
										else
											del($KB_order,k)
										end end end
							when 37 #ㅡ
								if $KB_order[k] == 39
									$kor_second[$kor_second.length-1] += 1
								else
									del($KB_order,k)
								end
							end
						else                 #종성이 있는가?
							u = last?($kor_last)
							$kor_first[$kor_first.length] = LFsound[u]
							$kor_second[$kor_second.length] = $KB_order[k]
							if LLsound[u] == nil
								del($kor_last,$kor_last.length-1)
							else
								$kor_last[$kor_last.length-1] = LLsound[u]
							end
						end
					end
				end
			end
		end
	end
end
#============================================================================
# 부가기능
#============================================================================
def KB_set_name(wow)
	nname = $game_actors[wow]
	nname.name = $KB_result
end