class Jindow_Post < Jindow
  def initialize
    super(0, 0, 340, 110)
    self.name = "편지 보내기"
    @head = true
    @mark = true
    @drag = true
		
    self.refresh("Post")
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
		
    @dialog = Sprite.new(self)
    @dialog.bitmap = Bitmap.new(280, 110)
    @dialog.bitmap.font.color.set(0, 0, 0, 255)
    @dialog.bitmap.draw_text(0, 10, 200, 30, "보낼 사람 캐릭터명 :")
		@dialog.bitmap.draw_text(0, 30, 200, 30, "아이템 종류 :")
		@dialog.bitmap.draw_text(0, 50, 200, 30, "보낼 아이템 번호 :")
		@dialog.bitmap.draw_text(210, 50, 200, 30, "갯수 :")
		@dialog.bitmap.draw_text(0, 75, 200, 30, "보낼 말 :")

    @username = J::Type.new(self).refresh(110, 15, 90, 18)
    @item_group = J::Type.new(self).refresh(@username.x, 35, 90, 18)
    @item_name = J::Type.new(self).refresh(@username.x, 55, 90, 18)
    @item_quantity = J::Type.new(self).refresh(240, 55, 60, 18)
    @Message = J::Type.new(self).refresh(42, 80, 120, 18)
		
    @Yes = J::Button.new(self).refresh(60, "보내기")
    @Yes.x = @Message.x + @Message.width + 10
    @Yes.y = @Message.y
		
		@No = J::Button.new(self).refresh(60, "취소")
    @No.x = @Yes.x + @Yes.width + 10
    @No.y = @Yes.y
  end

  def update
    super
    send_letter if @Yes.click
    Hwnd.dispose(self) if @No.click
  end

  def send_letter
    if fields_filled?
      unless @username.result == $game_party.actors[0].name
        case @item_group.result
        when "무기" then send_weapon
        when "방어구" then send_armor
        when "기타" then send_item
        end
      else
        $chat.write("◎ 자기 자신에게는 보낼 수 없습니다.", Color.new(65, 105, 0))
      end
    else
      $chat.write("◎ 안 적은 곳이 있습니다.", Color.new(65, 105, 0))
    end
  end

  def fields_filled?
    [@username, @item_group, @item_name, @item_quantity, @Message].all? { |field| !field.result.empty? }
  end

  def send_weapon
    weapon_id = @item_name.result
    if $game_party.weapon_number(weapon_id.to_i) >= @item_quantity.result.to_i
      $game_party.lose_weapon(weapon_id.to_i, @item_quantity.result.to_i)
      send_post("#{weapon_id},#{0}")
    else
      $chat.write("◎ 보내실려는 무기를 소유하고 있지 않습니다.", Color.new(65, 105, 0))
    end
  end

  def send_armor
    armor_id = @item_name.result
    if $game_party.armor_number(armor_id.to_i) >= @item_quantity.result.to_i
      $game_party.lose_armor(armor_id.to_i, @item_quantity.result.to_i)
      send_post("#{armor_id},#{1}")
    else
      $chat.write("◎ 보내실려는 방어구를 소유하고 있지 않습니다.", Color.new(65, 105, 0))
    end
  end

  def send_item
    item_id = @item_name.result
    if $game_party.item_number(item_id.to_i) >= @item_quantity.result.to_i
      $game_party.lose_item(item_id.to_i, @item_quantity.result.to_i)
      send_post("#{item_id},#{2}")
    else
      $chat.write("◎ 보내실려는 아이템을 소유하고 있지 않습니다.", Color.new(65, 105, 0))
    end
  end

  def send_post(item_info)
		item_id, type = item_info.split(",")
		
		info_data = {}
		info_data["type"] = type
		info_data["id"] = item_id
		info_data["send_name"] = $game_party.actors[0].name
		info_data["target_name"] = @username.result
		info_data["num"] = @item_quantity.result
		info_data["body"] = @Message.result
		
		send_message = ""
		info_data.each { |key, value| send_message += "#{key}:#{value}|" }
		
    Network::Main.socket.send("<post>#{send_message}</post>\n")
    $chat.write("◎ 상대방에게 물품을 보냈습니다.", Color.new(65, 105, 0))
  end
end
