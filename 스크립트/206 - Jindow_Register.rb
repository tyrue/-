class Jindow_Register < Jindow
  attr_reader :type_username, :type_password

  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 200, 200)
    setup_window
    setup_labels
    setup_input_fields
		setup_buttons
		setup_text_boxes
  end

  def setup_window
    self.name = "회원가입"
    @head = true
    @mark = true
    @close = true
    self.refresh "Register"
    center_window
  end

  def center_window
    self.x = (640 - self.max_width) / 2
    self.y = (480 - self.max_height) / 2
  end

  def setup_labels
    @id_text = create_label(0, "아이디")
    @pw_text = create_label(20, "비밀번호")
		@pw_check_text = create_label(40, "비밀번호 확인")
    @nick_text = create_label(60, "닉네임")
  end

  def create_label(y, text)
    label = Sprite.new(self)
    label.y = y
    label.bitmap = Bitmap.new(80, 32)
    label.bitmap.font.color.set(0, 0, 0, 255)
    label.bitmap.draw_text(0, 0, 80, 32, text)
		label
  end
	
  def create_text_box(y, text)
    text_box = J::Text_Box.new(self)
    text_box.set("tb_6", 2).refresh(190, 0)
    text_box.font.alpha = 1
    text_box.bitmap.font.size = 12
    text_box.bitmap.font.color.set(0, 0, 0, 255)
    text_box.bitmap.draw_text(0, 0, text_box.width, text_box.height, text, 0)
    text_box.y = y
  end

  def setup_input_fields
		margin = 5
    @type_username = create_input_field(@id_text.y + margin)
    @type_password = create_input_field(@pw_text.y + margin, true)
		@type_password_check = create_input_field(@pw_check_text.y + margin, true)
    @type_nickname = create_input_field(@nick_text.y + margin)
  end

  def create_input_field(y, hide = false)
    field = J::Type.new(self).refresh(80, y, self.width - 80, 18)
    field.hide = hide
    field
  end

  def setup_buttons
    @a = create_button(@type_nickname.y + @type_nickname.height + 5, "가입")
    @b = create_button(@a.y, "취소", 60)
  end

  def create_button(y, text, x = 0)
    button = J::Button.new(self).refresh(60, text)
    button.y = y
    button.x = x
    button
  end
	
	def setup_text_boxes
		dy = @a.y + @a.height + 10
    create_text_box(dy, "*주의사항:아이디는 영어만")
    create_text_box(dy + 20, "사용하여 만드셔야합니다.")
    create_text_box(dy + 40, "한/영 변경키:Alt키")
  end

  def update
    super
    handle_confirm_click if @a.click
    handle_cancel_click if @b.click
  end

  def handle_confirm_click
    id = @type_username.result.strip
    pw = @type_password.result
		pw_check = @type_password_check.result
    nick = @type_nickname.result.strip

    if id.empty? || nick.empty?
      return show_error_dialog("빈 문자열 사용 불가")
    end
		
    if id.length != id.scan(/[A-z]/).length
      return show_error_dialog("아이디에는 영어만 사용 해주세요")	
    end
		
		if id.length < 3 || id.length > 8
			return show_error_dialog("아이디는 3~8자리로 사용해주세요")	
		end
		
		if pw.length < 4 || pw.length > 10
			return show_error_dialog("비밀번호는 4~10자리로 사용해주세요")	
		end
		
		if pw != pw_check
      return show_error_dialog("비밀번호와 비밀번호 확인을 맞춰주세요")	
    end
		
		if nick =~ /gm/i
      return show_error_dialog("사용할 수 없는 닉네임이 있습니다.")	
    end
		
		proceed_with_registration
  end

  def show_error_dialog(message)
    Jindow_Dialog.new("오류", [message], [["확인", "Hwnd.dispose(self)"]])
  end

  def proceed_with_registration
    $game_system.se_play($data_system.decision_se)
    @type_username.bluck = false
    @type_password.bluck = false
    Network::Main.send_regist(@type_nickname.result.to_s, @type_username.result, @type_password.result)
    $nickname = @type_nickname.result.to_s
    #Hwnd.dispose(self)
  end

  def handle_cancel_click
    $game_system.se_play($data_system.decision_se)
    Hwnd.dispose(self)
  end
end
