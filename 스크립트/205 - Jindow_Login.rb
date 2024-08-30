class Jindow_Login < Jindow
  attr_reader :type_username, :type_password

  WINDOW_WIDTH = 135
  WINDOW_HEIGHT = 120
  CENTER_X = 640 / 2
  CENTER_Y = 480 / 2

  LABEL_WIDTH = 40
  LABEL_HEIGHT = 32
  INPUT_WIDTH = WINDOW_WIDTH - LABEL_WIDTH
  INPUT_HEIGHT = 18
  BUTTON_WIDTH = 60

  def initialize
    super(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)
    self.name = "로그인"
    @head = true
    @mark = true
    self.refresh("Login")
    center_window

    create_labels
    create_input_fields
    create_buttons
    create_footer_text
  end

  def update
    super
		
    handle_login 
    handle_register 
		handle_server_select
  end
	
  def center_window
    self.x = CENTER_X - self.max_width / 2
    self.y = CENTER_Y - self.max_height / 2 + 180
  end

  def create_labels
    create_label(@username_s, "아이디", 3)
    create_label(@password_s, "비밀번호", 23)
  end

  def create_label(sprite, text, y_position)
    sprite = Sprite.new(self)
    sprite.y = y_position
    sprite.bitmap = Bitmap.new(LABEL_WIDTH, LABEL_HEIGHT)
    sprite.bitmap.font.color.set(0, 0, 0, 255)
    sprite.bitmap.draw_text(0, 0, LABEL_WIDTH, LABEL_HEIGHT, text)
  end

  def create_input_fields
    @type_username = create_input_field(40, 12)
    @type_password = create_input_field(40, 30, true)
  end

  def create_input_field(x, y, hidden = false)
    input = J::Type.new(self).refresh(x, y, INPUT_WIDTH, INPUT_HEIGHT, false)
    input.hide = hidden
    input
  end

  def create_buttons
    @login_button = create_button("접속하기", 0, 63)
    @regist_button = create_button("회원가입", 70, 63)
		@server_button = create_button("서버 선택", 0, @login_button.y + @login_button.height)
		@server_button.x = (self.max_width - @server_button.width) / 2 - 10
  end

  def create_button(text, x, y)
    button = J::Button.new(self).refresh(BUTTON_WIDTH, text)
    button.x = x
    button.y = y
    button
  end

  def create_footer_text
    @text104 = J::Text_Box.new(self)
    @text104.set("tb_6", 2).refresh(190, 0)
    @text104.font.alpha = 1
    @text104.bitmap.font.size = 12
    @text104.bitmap.font.color.set(0, 0, 0, 255)
    @text104.bitmap.draw_text(0, 0, @text104.width, 12, "흑부엉, 크랩훕흐", 0)
    @text104.y = @server_button.y + @server_button.height
  end

  def handle_login
		return unless @login_button.click || Key.trigger?(KEY_ENTER)
		
    if @type_username.result.to_s.empty?
      show_error_dialog("아이디를 잘못 입력하셨습니다.")
    elsif @type_password.result.to_s.empty?
      show_error_dialog("비밀번호를 잘못 입력하셨습니다.")
    else
      login_user
    end
  end

  def show_error_dialog(message)
    Jindow_Dialog.new("오류", [message], [["확인", "Hwnd.dispose(self)"]])
  end

  def login_user
    @type_username.bluck = false
    @type_password.bluck = false
    Network::Main.update
    Network::Main.send_login(@type_username.result.to_s, @type_password.result.to_s)
  end

  def handle_register
		return unless @regist_button.click && !Hwnd.include?("Register")
		
    Jindow_Register.new
  end
	
	def handle_server_select
		return unless @server_button.click
		
		로그아웃
	end
end
