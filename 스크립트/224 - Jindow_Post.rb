#==============================================================================
# ■ Jindow_Post
#==============================================================================
class Jindow_Post < Jindow
  attr_accessor :is_ok

  # 각종 초기화 값 설정
  WINDOW_WIDTH = 340
  WINDOW_HEIGHT = 160
  FONT_COLOR = Color.new(0, 0, 0, 255)
  ERROR_COLOR = Color.new(65, 105, 0)

  # 생성자: 윈도우 초기화 및 기본 설정
  def initialize
    super(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)
    setup_window
    create_sprites
    create_buttons
    initialize_inventory
  end

  # 윈도우 속성 설정
  def setup_window
    self.name = "편지 보내기"
    @head = @mark = @drag = @close = true
    self.refresh("Post")
    center_window
  end

  # 윈도우 중앙 정렬
  def center_window
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
  end

  # Sprite 및 UI 생성
  def create_sprites
    @slot_size = 4
    @item_data = Array.new(@slot_size)
		@item_slot = Array.new(@slot_size) # 아이템 이미지
		
		@margin = 10
    create_label("받는 사람 이름 :", 0, 10, "username")
    @username = create_input_field(@username_sprite, 1 / 3)

    create_label("물품", 0, @username_sprite.y + @username_sprite.height + @margin, "item")
    create_item_slots(@slot_size, @item_sprite.y, @username_sprite.width)

    create_label("개수 :", 0, @item_sprite_slot.last.y + @item_sprite_slot.last.height + @margin, "item_num")
    create_item_numbers(@slot_size, @item_num_sprite.y)

    create_label("보내는 말 :", 0, @item_num_sprite.y + @item_num_sprite.height + @margin, "message")
    @message = create_input_field(@message_sprite, 0.5)
  end

  # Sprite 생성 메소드
  def create_label(text, x, y, var_name)
    sprite = Sprite.new(self)
    sprite.bitmap = Bitmap.new(self.width / 3, 15)
    sprite.bitmap.font.color = FONT_COLOR
    sprite.bitmap.draw_text(0, 0, sprite.bitmap.width, 15, text)
    sprite.x = x
    sprite.y = y
    instance_variable_set("@#{var_name}_sprite", sprite)
  end

  def create_input_field(label_sprite, fraction)
    input = J::Type.new(self).refresh(0, 0, self.width / 2, 18)
    input.x = label_sprite.x + label_sprite.width
    input.y = label_sprite.y
    input
  end

  def create_item_slots(count, y, x_offset)
    @item_sprite_slot = Array.new(count) do |i|
      sprite = Sprite.new(self)
      sprite.bitmap = Bitmap.new("Graphics/Jindow/" + @skin + "/Window/item_win")
      sprite.x = x_offset + i * (sprite.width + 10)
      sprite.y = y
      sprite
    end
  end

  def create_item_numbers(count, y)
    @item_num = Array.new(count) do |i|
      input = J::Type.new(self).refresh(0, 0, @item_sprite_slot[0].width + 3, 18)
      input.x = @item_sprite_slot[i].x
      input.y = y
      input
    end
  end

  # 버튼 생성
  def create_buttons
    @Yes = J::Button.new(self).refresh(60, "보내기")
    @Yes.x = self.width / 2 - @Yes.width
    @Yes.y = @message.y + @message.height + 10

    @No = J::Button.new(self).refresh(60, "취소")
    @No.x = @Yes.x + @Yes.width + 10
    @No.y = @Yes.y
  end

  # 인벤토리 초기화
  def initialize_inventory
    return unless $j_inven
    $j_inven.show
    $j_inven.setMode(3)
  end

  # 리소스 정리
  def dispose
    $j_inven.setMode(0) if $j_inven
    $j_inven.hide if $j_inven
    super
  end

  # 프레임별 업데이트
  def update
    super
    send_letter if @Yes.click
    Hwnd.dispose(self) if @No.click
  end
	
	def set_data(data)
		data.id = data.id.to_i
		data.type = data.type.to_i
		data.amount = data.amount.to_i
		
		for i in 0...@slot_size
			next if @item_data[i] != nil
			@item_data[i] = data
			
			@item_slot[i] = J::Item.new(self).refresh(data.id, data.type)
			@item_slot[i].x = @item_sprite_slot[i].x
			@item_slot[i].y = @item_sprite_slot[i].y
			
			@item_num[i].set(data.amount.to_s) 
			@item_num[i].view
			return
		end
	end

  # 편지 보내기
  def send_letter
    return $chat.write("◎ 안 적은 곳이 있습니다.", ERROR_COLOR) unless fields_filled?

    if @username.result == $game_party.actors[0].name
      return $chat.write("◎ 자기 자신에게는 보낼 수 없습니다.", ERROR_COLOR)
    end

    @item_data.compact.each do |data|
      send_item(data)
    end

    Hwnd.dispose(self)
  end

  # 각 필드가 채워져 있는지 확인
  def fields_filled?
    [@username, @message].all? { |field| !field.result.empty? }
  end

  # 아이템 전송
  def send_item(data)
    item_id, type, amount = data.id, data.type, data.amount
    send_method = case type
                  when 0 then :lose_item
                  when 1 then :lose_weapon
                  when 2 then :lose_armor
                  else return
                  end

    if item_available?(item_id, type, amount)
      $game_party.send("#{send_method}", item_id, amount)
      send_message(item_id, type, amount)
    else
      $chat.write("◎ 소유하고 있지 않습니다.", ERROR_COLOR)
    end
  end
	
  # 아이템 소유 확인
  def item_available?(item_id, type, amount)
    case type
    when 0 then $game_party.item_number(item_id) >= amount
    when 1 then $game_party.weapon_number(item_id) >= amount
    when 2 then $game_party.armor_number(item_id) >= amount
    else false
    end
  end

  # 아이템 전송 메세지
  def send_message(item_id, type, amount)
    message_data = {
      "type" => type,
      "id" => item_id,
      "send_name" => $game_party.actors[0].name,
      "target_name" => @username.result,
      "num" => amount,
      "body" => @message.result
    }

    message_str = message_data.map { |k, v| "#{k}:#{v}|" }.join
    Network::Main.socket.send("<post>#{message_str}</post>\n")
    $chat.write("◎ 상대방에게 물품을 보냈습니다.", ERROR_COLOR)
  end
end
