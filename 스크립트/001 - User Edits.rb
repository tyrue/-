#==============================================================================
# * Net Play
#------------------------------------------------------------------------------
#==============================================================================
module User_Edit
	#────────────디버그──────────────────────
	PRINTLINES        = false
	#────────────클라이언트 버전─────────────
	VERSION           = "0.5.6"
	#────────────────────────────────────────────────────────────────
	MUPLEVDIFF        = 1   # How many LOWER may thew other's level be?
	MDOWNLEVDIFF      = 1   # How many HIGHER may the other's Level be?
	BONUSDAM          = [100,10,30] # X / Y + Z
	ALLOWBONUSDAM     = true
	
	#─────캐릭터 정보 부분 및 스위치─────────
	# 0 => 서버로 보내는 캐릭터 정보를 아주 간단하게 보냄
	# 1 => 서버로 보내는 캐릭터 정보를 비교적 간단하게 보냄
	# 2 => 서버로 보내는 캐릭터 정보를 적당하게 보냄        
	# 3 => 서버로 보내는 캐릭터 정보를 약간 세세하게 보냄
	# 4 => 서버로 보내는 캐릭터 정보를 정확히 세세하게 보냄
	Bandwith          = 3
	STARTNETSWITCH    = 1000   # 스윗치 몇번부터 서버공유를 할 것 인지
	STARTNETVAR       = 1000   # 변수 몇번부터 서버공유를 할 것 인지
	GLOBAL_SELF       = ["A", "B"] #A,B,C 중에 어느것을 셀프스위치 공유할것인지
	# ["A", "B", "C"] simple ;)
	WELCOME_MESSAGE   = "3.0" #접속하고 나서 환영 메세지 안내.
	#------------------Password Display-----------------------------
	# Should the Password be displayed with * or letters and numbers?
	# false           = *
	# true            = Letters and Numbers
	Password_Display  = false
	
	#-----------------------Global Visual Equip---------------------
	VISUAL_EQUIP_ACTIVE = true
	#────────────마우스 아이콘───────────────
	CURSOR_ICON = "마우스"
	#────────────폰트────────────────────────
	FONT_DEFAULT_SIZE = 12
	FONT_DEFAULT_NAME = ["굴림"]
	FONT_DEFAULT_COLOR = Color.new(0, 0, 0)
	FONT_DEFAULT_BOLD = false
	FONT_DEFAULT_ITALIC = false
	#────────────────────가입과 로그인────────────
	MAX_USER_LETTERS  = 8            #최대아이디(10이상 불가)
	MAX_PASS_LETTERS  = 8            #최대비번(10이상 불가)
	
	REGISTER_TITLE    = "--가입하기--"
	REGISTERING_TITLE = "--가입정보-- "
	REGISTER_STATUS   = "가입중..."
	REGISTER_ERROR    = "에러"
	REGISTER_DENIED   = "현재 사용중인 아이디 입니다"
	REGISTERED        = "가입 감사합니다."
	
	REGISTER_BUTTON   = "가입하기"
	LOGIN_BUTTON      = "로그인"
	EXIT_BUTTON       = "종료"
	RETURN_BUTTON     = "돌아가기"
	
	USERNAMETXT       = "아이디:"
	PASSWORDTXT       = "비밀번호:"
	
	VER_ERROR         = "Error: Version not available!"
	MOD_ERROR         = "Error: Message of the Day Not availeble!"
	UNEXPECTLOGERR    = "Unexpected Login Error"
	NOTAUTH           = "서버에러"
	USERTFAIL         = "User test Failed."
	
	LOGIN_TITLE       = "방향키를 이용하세요"
	LOGIN_USERERROR   = "접속중이거나 없는 아이디 입니다"
	LOGIN_PASSERROR   = "비밀번호가 틀립니다"
	LOGIN_STATUS      = "서버접속중..."
	LOGIN_STATUS2     = "서버접속완료!"
	LOGIN_FILLERROR   = "필에러."
	
	BLINK             = true
	BLINKBUT          = true
	
	NOMOTD            = "흑부엉의 온라인에 오셔서 감사합니다"
	#---------------Connection Scenes-------------------------------
	# 0               => Use a List to display Servers, Need SERVERS!
	# 1               => Input Connection
	CONNTYPE          = 0
	#---------------------------------------------------------------
	# Only if CONNTYPE is 0, if set to tru, tests servers
	TESTSERVER        = true
	#---------------------------------------------------------------
	# Only if CONNTYPE is 1.
	# INPUT 0         = Only IP, DEFAULTPORT is used as port
	# INPUT 1         = Port and IP
	#INPUT             = 1
	# INPTP 0         = Numbers Only
	# INPTP 1         = Text Only
	# INPTP 2         = Both
	#INPTP             = 2
	#---------------------------------------------------------------
	
	#---------------Connection--------------------------------------
	SERVERON          = "온라인"
	SERVEROFF         = "오프라인"
	SERVERERR         = "에러"
	CONNFAILTRY       = 3
	SERVERREFRESH     = 300
	# IP              # Port   # Display
	SERVERS           = [["27.119.108.46", 52001 , "흑부엉 서버"]] # 외부 아이피
	#SERVERS           = [["127.0.0.1" ,52000 , "흑부엉 서버"]] # 테스트용 내부 아이피
	
	
	#Avialbe Chat Systems;
	#Chat[0]          => No Chat
	#Chat[1]          => Netplay Style
	#Chat[2]          => RuneScape Style - Dynamic on map
	CHAT_SYSTEM       = 'Chat[2]'
	
	ENABLE_PC         = true # Enables Private Chat 
	ENABLE_MC         = false # Enables Map Chat and disables all chat
	#-----------Admin Control Panel---------------------------------
	SCENE_ADMIN1      = 'A Player'
	SCENE_ADMIN2      = 'All Players'
	SCENE_ADMIN3      = 'Raise Monsters'
	#---------------------------------------------------------------
	
	#----------PvP System------------------------------------------
	#Avialbe PvP Systems;
	#Pvp[0]          => ABS Compatible, 
	#Pvp[1]          => ABS un-compatible,
	PvP_SYSTEM = "Pvp[0]"
	#---------------------------------------------------------------
	
	#-----------Storage---------------------------------------------
	STOREADD = 'Store'
	STORECANCEL = '종료'
	STOREGET = 'Get'
	
	SMAX_STORAGE = 0 #0 is unlimited, doesn't apply to money.
	SMAX_ITEMS = 0   #0 is unlimited
	SMAX_WEAPONS = 0 #0 is unlimited
	SMAX_ARMORS = 0  #0 is unlimited
	#---------------------------------------------------------------
	SENDBUT           = "보내기"
	NEXTBUT           = "다음"
	PREVBUT           = "Prev"
	NEWBUT            = "New"
	PNEWTEXT          = "likes to talk to you..."
	
	DONTGOTTRADE      = "교환되지 않았습니다!"
	NOTENOUGHTRADE    = "아이탬이 충분하지 않습니다"
	TRADEADDB         = "올리기"
	TRADECANCELB      = "취소"
	TRADEREMOVEB      = "꺼내기"
	TRADETRADEB       = "교환"
	
	ADMKICKALL        = "모두 강퇴당했습니다."
	ADMKICK           = "당신은 강퇴당하였습니다."
	PVPMAPS           = [100, 101, 102, 103, 104, 105]
	
end