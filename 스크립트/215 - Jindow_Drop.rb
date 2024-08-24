#==============================================================================
# ■ Jindow_Drop
#------------------------------------------------------------------------------
#   돈, 아이템 버리기
#------------------------------------------------------------------------------
class Jindow_Drop < Jindow
  
  def initialize(type1, type2, id) # 돈/아이템, 타입, 아이디
    $game_system.se_play($data_system.decision_se)
    자동저장
    super(0, 0, 150, 50)
    setup_window_properties
    setup_item_info(type1, type2, id)
    create_input_field
    create_confirm_button
    adjust_window_position
  end

  def update
    super
    handle_confirm_click if @confirm_button.click || Key.trigger?(KEY_ENTER)
  end

  def setup_window_properties
    self.name = ""
    @head = true
    @mark = true
    @drag = true
    @close = true
    self.refresh "Item_Drop"
  end

  def setup_item_info(type1, type2, id)
    @type1 = type1
    @type2 = type2
    @item_id = id
    @item_name = get_item_name
    self.name = "#{@item_name} 버리기"

    @text = Sprite.new(self)
    @text.y = 0
    @text.bitmap = Bitmap.new(40, 32)
    @text.bitmap.font.color.set(0, 0, 0, 255)
    @text.bitmap.draw_text(0, 0, 40, 32, type1 == 0 ? "액수 : " : "개수 : ")
  end

  def get_item_name
    return "금전" if @type1 == 0

    case @type2
    when 0 then $data_items[@item_id].name
    when 1 then $data_weapons[@item_id].name
    when 2 then $data_armors[@item_id].name
    end
  end

  def create_input_field
    @input = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
    @input.set("1")
    @input.view
    @input.bluck = false
  end

  def create_confirm_button
    @confirm_button = J::Button.new(self).refresh(45, "확인")
    @confirm_button.x = self.width - 92
    @confirm_button.y = 25
    self.refresh "Item_Drop"
  end

  def adjust_window_position
    self.x = 640 / 3 - self.max_width / 3
    self.y = 480 / 3 - self.max_height / 3
  end

  def handle_confirm_click
    $game_system.se_play($data_system.decision_se)
    @input.bluck = false
    num = @input.result.to_i

    if num <= 0
      $console.write_line("1 이상의 수를 입력하세요")
      return
    end

    x = $game_player.x
    y = $game_player.y

    if @type1 == 0
      handle_money_drop(num, x, y)
    else
      handle_item_drop(num, x, y)
    end
  end

  def handle_money_drop(num, x, y)
    num = [num, $game_party.gold.to_i].min
    $game_party.lose_gold(num)
    create_moneys(num, x, y)
    $console.write_line("#{@item_name} #{num}전을 버렸습니다.")
    finalize_drop($game_party.gold)
  end

  def handle_item_drop(num, x, y)
    method = get_item_method
    num = [num, $game_party.send("#{method}_number", @item_id)].min
		
    $game_party.send("lose_#{method}", @item_id, num)
    create_drops(@type2, @item_id, x, y, num)
		$console.write_line("#{@item_name} #{num}개를 버렸습니다.")
		$Abs_item_data.process_one_trade_switch(@item_id, @type2)
    finalize_drop($game_party.send("#{method}_number", @item_id))
  end

  def get_item_method
    case @type2
    when 0 then :item
    when 1 then :weapon
    when 2 then :armor
    end
  end

  def finalize_drop(num)
    $game_system.se_play("줍기")
    Hwnd.dispose(self) if num <= 0
  end
end
