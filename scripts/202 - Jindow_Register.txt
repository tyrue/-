class Jindow_Register < Jindow
  attr_reader :type_username
  attr_reader :type_password
  
  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 150, 200)
    self.name = "회원가입"
    @head = true
    @mark = true
    @drag = true
    @close = true
    self.refresh "Register"
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
    @username_s = Sprite.new(self)
    @username_s.y = 0
    @username_s.bitmap = Bitmap.new(40, 32)
    @username_s.bitmap.font.color.set(0, 0, 0, 255)
    @username_s.bitmap.draw_text(0, 0, 40, 32, "아이디")
    @password_s = Sprite.new(self)
    @password_s.y = 20
    @password_s.bitmap = Bitmap.new(40, 32)
    @password_s.bitmap.font.color.set(0, 0, 0, 255)
    @password_s.bitmap.draw_text(0, 0, 40, 32, "비번")
    @nickname = Sprite.new(self)
    @nickname.y = 40
    @nickname.bitmap = Bitmap.new(40, 32)
    @nickname.bitmap.font.color.set(0, 0, 0, 255)
    @nickname.bitmap.draw_text(0, 0, 40, 32, "닉네임")
    
    @text101 = J::Text_Box.new(self)
    @text101.set("tb_6", 2).refresh(190, 0)
    @text101.font.alpha = 1
    @text101.bitmap.font.size = 12
    @text101.bitmap.font.color.set(0, 0, 0, 255)
    @text101.bitmap.draw_text(0, 0, @text101.width, @text101.height, "*주의사항:아이디는 영어만", 0)
    @text101.y = 100
    
    @text102 = J::Text_Box.new(self)
    @text102.set("tb_6", 2).refresh(190, 0)
    @text102.font.alpha = 1
    @text102.bitmap.font.size = 12
    @text102.bitmap.font.color.set(0, 0, 0, 255)
    @text102.bitmap.draw_text(0, 0, @text102.width, @text102.height, "사용하여 만드셔야합니다.", 0)
    @text102.y = 120
    
    @text103 = J::Text_Box.new(self)
    @text103.set("tb_6", 2).refresh(190, 0)
    @text103.font.alpha = 1
    @text103.bitmap.font.size = 12
    @text103.bitmap.font.color.set(0, 0, 0, 255)
    @text103.bitmap.draw_text(0, 0, @text103.width, @text103.height, "한/영 변경키:Alt키", 0)
    @text103.y = 140

    @type_username = J::Type.new(self).refresh(40, 12, self.width - 40, 18)
    @type_password = J::Type.new(self).refresh(40, 30, self.width - 40, 18)
    @type_password.hide = true
    @type_nickname = J::Type.new(self).refresh(40, 48, self.width - 40, 18)
    @a = J::Button.new(self).refresh(60, "가입")
    @b = J::Button.new(self).refresh(60, "취소")
    @a.y = 70
    @b.x = 60
    @b.y = 70
  end
  


  def update
    super
    if @a.click  # 확인
      if @type_username.result.include?("a") or @type_username.result.include?("b") or @type_username.result.include?("c") or @type_username.result.include?("d") or @type_username.result.include?("e") or @type_username.result.include?("f") or @type_username.result.include?("g") or @type_username.result.include?("h") or @type_username.result.include?("i") or @type_username.result.include?("j") or @type_username.result.include?("k") or @type_username.result.include?("l") or @type_username.result.include?("m") or @type_username.result.include?("n") or @type_username.result.include?("o") or @type_username.result.include?("p") or @type_username.result.include?("q") or @type_username.result.include?("r") or @type_username.result.include?("s") or @type_username.result.include?("t") or @type_username.result.include?("u") or @type_username.result.include?("v") or @type_username.result.include?("w") or @type_username.result.include?("x") or @type_username.result.include?("y") or @type_username.result.include?("z") or @type_username.result.include?("1") or @type_username.result.include?("2") or @type_username.result.include?("3") or @type_username.result.include?("4") or @type_username.result.include?("5") or @type_username.result.include?("6") or @type_username.result.include?("7") or @type_username.result.include?("8") or @type_username.result.include?("9") or @type_username.result.include?("0")
      $game_system.se_play($data_system.decision_se)
      @type_username.bluck = false
      @type_password.bluck = false
      Network::Main.send_nickname(@type_nickname.result.to_s,@type_username.result,@type_password.result)
      $nickname = @type_nickname.result.to_s
      Hwnd.dispose(self)
      
    else # 아이디에 영어를 사용하는 경우
      
        Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 100 / 2 + 50, 180,
              ["아이디/비밀번호에 한글 사용 불가"],
              ["확인"], ["Hwnd.dispose(self); $now_dialog = false"], "오류")
      end
    end
    if @b.click
      $game_system.se_play($data_system.decision_se)
      Hwnd.dispose(self)
    end
  end
end
