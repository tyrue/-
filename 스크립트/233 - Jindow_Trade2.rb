#==============================================================================
# ■ Jindow_Trade2
#==============================================================================
class Jindow_Trade2 < Jindow
  attr_accessor :is_ok
	attr_accessor :mode

  def initialize(id, type, number)
    # 초기 설정
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 150, 60)
    setup_window_properties
    setup_window_components(id, type, number)
  end

  # 윈도우 속성 설정
  def setup_window_properties
    self.name = "갯수 입력"
    @head = true
    @drag = true
    @close = true
    self.refresh("Trade2")
    self.x = 366
    self.y = 306
  end

  # 윈도우 구성 요소 설정
  def setup_window_components(id, type, number)
    @item_id = id
    @type = type
    @number = number
    @is_ok = false
		@mode = 0
    
    # 개수 표시
    @username4_s = Sprite.new(self)
    @username4_s.y = 0
    @username4_s.bitmap = Bitmap.new(40, 32)
    @username4_s.bitmap.font.color.set(0, 0, 0, 255)
    @username4_s.bitmap.draw_text(0, 0, 40, 32, "개수")

    # 입력 타입과 버튼 생성
    @type_sells = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
		@type_sells.bluck = true
		
    @a = J::Button.new(self).refresh(45, "확인")
    @b = J::Button.new(self).refresh(45, "취소")
    set_button_positions
  end

  # 버튼 위치 설정
  def set_button_positions
    @a.x = self.width - 92
    @a.y = 25
    @b.x = self.width - 45
    @b.y = 25
  end

  #--------------------------------------------------------------------------
  # ● 프레임 갱신
  #--------------------------------------------------------------------------
  def update
    super
    process_confirm_button if @a.click
    process_cancel_button if @b.click
  end

  # 확인 버튼 클릭 처리
  def process_confirm_button
    $game_system.se_play($data_system.decision_se)
    @type_sells.bluck = false
    @sell = @type_sells.result.to_i
    
    if @sell <= 0
      $console.write_line("개수는 한 개 이상 정할 수 있습니다.")
      return
    end
    
    @is_ok = item_available?(@type, @item_id, @sell)
    
    if @is_ok
			case @mode
			when 0 
				process_successful_trade
			when 1 
				process_post_item
			end
      
    else
      $console.write_line("소지하고 있는 것보다 개수가 많습니다.")
    end
  end
  
  # 취소 버튼 클릭 처리
  def process_cancel_button
    $game_system.se_play($data_system.decision_se)
    Hwnd.dispose(self)
  end

  # 아이템 사용 가능 여부 확인
  def item_available?(type, item_id, sell_count)
    case type
    when 0
      $game_party.item_number(item_id) >= sell_count
    when 1
      $game_party.weapon_number(item_id) >= sell_count
    when 2
      $game_party.armor_number(item_id) >= sell_count
    else
      false
    end
  end

  # 거래 성공 처리
  def process_successful_trade
    $trade_num += 1
    $item_number[@number] = Jindow_Trade_Data.new
    $item_number[@number].id = @item_id
    $item_number[@number].type = @type
    $item_number[@number].amount = @sell
    Hwnd.dispose(self)
  end
	
	def process_post_item
		post_jin = Hwnd.include?("Post", 1)
		data = Jindow_Trade_Data.new
		data.id = @item_id
		data.type = @type
		data.amount = @sell
		post_jin.set_data(data)
		Hwnd.dispose(self)
	end
end
