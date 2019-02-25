#==============================================================================
# ■ Jindow_Post
#------------------------------------------------------------------------------

class Jindow_Post< Jindow
  def initialize
    super(0, 0, 340, 110)
    self.name = "편지 보내기"
    @head = true
    @mark = true
    @drag = true
    self.refresh "Post"
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
    @dialog = Sprite.new(self)
    @dialog.bitmap = Bitmap.new(280,110)
    @dialog.bitmap.font.color.set(0, 0, 0, 255)
    @dialog.bitmap.draw_text(0, 10, 200, 30, "보낼 사람 캐릭터명 :")
    @username = J::Type.new(self).refresh(85, 15, 90, 18)
    @dialog.bitmap.draw_text(0, 30, 200, 30, "아이템 종류 :")
    @item_group = J::Type.new(self).refresh(85, 35, 90, 18)
    @dialog.bitmap.draw_text(0, 50, 200, 30, "보낼 아이템 번호 :")
    @item_name = J::Type.new(self).refresh(85, 55, 90, 18)
    @dialog.bitmap.draw_text(200, 50, 200, 30, "갯수 :")
    @item_quantity = J::Type.new(self).refresh(230, 55, 60, 18)
    @dialog.bitmap.draw_text(0, 75, 200, 30, "보낼 말 :")
    @Message = J::Type.new(self).refresh(42, 80, 120, 18)
    @Yes = J::Button.new(self).refresh(60, "보내기")
    @No = J::Button.new(self).refresh(60, "취소")
    @Yes.x = 180
    @Yes.y = 80
    @No.x = 260
    @No.y = 80
  end
  
  def update
    super
    if @Yes.click
      if @username.result != "" and @item_group.result != "" and @item_name.result != "" and @item_quantity.result != ""
       unless @username.result == $game_party.actors[0].name
        case @item_group.result
        when "무기"
          weapon_id = @item_name.result
          if $game_party.weapon_number(weapon_id.to_i) >= @item_quantity.result.to_i
            $game_party.lose_weapon(weapon_id.to_i, @item_quantity.result.to_i)
            Network::Main.socket.send "<post>#{@username.result},#{weapon_id},#{0},#{$game_party.actors[0].name},#{@item_quantity.result},#{@Message.result}</post>\n"
            $chat.write ("◎ 상대방에게 물품을 보냈습니다.", Color.new(65,105, 0))
          else
            $chat.write ("◎ 보내실려는 무기를 소유하고 있지 않습니다.", Color.new(65,105, 0))
          end
        when "방어구"
          armor_id = @item_name.result
          if $game_party.armor_number(armor_id.to_i) >= @item_quantity.result.to_i
            $game_party.lose_armor(armor_id.to_i, @item_quantity.result.to_i)
            Network::Main.socket.send "<post>#{@username.result},#{armor_id},#{1},#{$game_party.actors[0].name},#{@item_quantity.result},#{@Message.result}</post>\n"
            $chat.write ("◎ 상대방에게 물품을 보냈습니다.", Color.new(65,105, 0))
          else
            $chat.write ("◎ 보내실려는 방어구를 소유하고 있지 않습니다.", Color.new(65,105, 0))
          end
        when "기타"
          item_id = @item_name.result
          if $game_party.item_number(item_id.to_i) >= @item_quantity.result.to_i
            $game_party.lose_item(item_id.to_i, @item_quantity.result.to_i)
            Network::Main.socket.send "<post>#{@username.result},#{item_id},#{2},#{$game_party.actors[0].name},#{@item_quantity.result},#{@Message.result}</post>\n"
            $chat.write ("◎ 상대방에게 물품을 보냈습니다.", Color.new(65,105, 0))
          else
            $chat.write ("◎ 보내실려는 아이템을 소유하고 있지 않습니다.", Color.new(65,105, 0))
          end
        end
       else
        $chat.write ("◎ 자기 자신에게는 보낼 수 없습니다.", Color.new(65,105, 0))
       end
      else
        $chat.write ("◎ 안 적은 곳이 있습니다.", Color.new(65,105, 0))
      end
    elsif @No.click
      Hwnd.dispose(self)
    end
  end
end