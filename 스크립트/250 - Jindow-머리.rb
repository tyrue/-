#----------------------------------------------------------------------------------
# * Hair Management Window
#----------------------------------------------------------------------------------
class Jindow_hairct < Jindow
  BUTTONS_Y = 85
  BUTTONS_X = [0, 105, 210, 325, 170]
  COSTS = [1000, 1000, 1000, 6000]
  HAIR_STYLES = ["바람머리", "주인공", "바람세운머리", "죽음"]

  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 500, 400)
    self.name = "머리 관리"
    @head = @drag = @close = true
    refresh("hairct")
    self.center_in_screen
    setup_sprites
    setup_buttons
  end

  def setup_sprites
    @hair1 = Sprite.new(self)
    @hair1.bitmap = Bitmap.new("Graphics/pictures/머리이미지2")
  end

  def setup_buttons
    @buttons = []
    labels = ["1000전", "1000전", "1000전", "6000전", "닫기"]
    
    labels.each_with_index do |label, index|
      @buttons[index] = J::Button.new(self).refresh(80, label)
      @buttons[index].x = BUTTONS_X[index]
      @buttons[index].y = index == 4 ? 380 : BUTTONS_Y
    end
  end

  def center_in_screen
    self.x = (640 - self.width) / 2
    self.y = (480 - self.height) / 2
  end

  def update
    super
    @buttons.each_with_index do |button, index|
      handle_click(button, index) if button.click
    end
  end

  def handle_click(button, index)
    $game_system.se_play($data_system.decision_se)

    if button.command == "닫기"  # 닫기
      Hwnd.dispose(self)
      return
    end
    
    required_gold = COSTS[index]
    if has_sufficient_gold?(required_gold)
      change_hair_style(HAIR_STYLES[index], required_gold)
    else
      display_insufficient_gold_message
    end
  end

  def has_sufficient_gold?(required_gold)
    $game_party.gold >= required_gold
  end

  def change_hair_style(hair_style, cost)
    $game_party.lose_gold(cost)
    $game_party.actors[0].set_graphic(hair_style, 0, 0, 0)
    $cha_name = hair_style
    $chat.write("머리가 변경되었습니다.", COLOR_HELP)
    Hwnd.dispose(self)
    $scene = Scene_Map.new
    Network::Main.send_map
  end

  def display_insufficient_gold_message
    Jindow_Dialog.new(
			"머리 변경",
      ["금전이 부족합니다."],
      [["확인", "Hwnd.dispose(self)"]]
    )
    Hwnd.dispose(self)
  end
end
