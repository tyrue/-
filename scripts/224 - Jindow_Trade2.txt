#==============================================================================
# ■ Jindow_ShopSells
#==============================================================================
class Jindow_Trade2 < Jindow
  def initialize(id, type, number)
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 150, 60)
    self.name = "갯수 입력(오른쪽키 불가)"
    @head = true
    @drag = true
    @close = true
    self.refresh "Trade2"
    self.x = 366
    self.y = 306
    @item_id = id
    @type = type
    @number = number
    @username4_s = Sprite.new(self)
    @username4_s.y = 0
    @username4_s.bitmap = Bitmap.new(40, 32)
    @username4_s.bitmap.font.color.set(0, 0, 0, 255)
    @username4_s.bitmap.draw_text(0, 0, 40, 32, "개수")
    @type_sells = J::Type.new(self).refresh(40, 7, self.width - 40, 16)
    @a = J::Button.new(self).refresh(45, "확인")
    @b = J::Button.new(self).refresh(45, "취소")
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
    if @a.click
      $game_system.se_play($data_system.decision_se)
      @type_sells.bluck = false
      @sell = @type_sells.result
      if @type == 0
        if $game_party.item_number(@item_id.to_i) >= @sell.to_i
          if @sell != 0 or @sell.to_s != ""
            case @number
            when 1
              $item_number[1] = Jindow_Trade_Data.new
              $item_number[1].id = @item_id
              $item_number[1].type = @type
              $item_number[1].amount = @sell.to_i
              $trade_item[1] = 1
              $game_variables[1003] += 2

            when 2
              $item_number[2] = Jindow_Trade_Data.new
              $item_number[2].id = @item_id
              $item_number[2].type = @type
              $item_number[2].amount = @sell.to_i
              $trade_item[2] = 1
              $game_variables[1003] += 2

            when 3
              $item_number[3] = Jindow_Trade_Data.new
              $item_number[3].id = @item_id
              $item_number[3].type = @type
              $item_number[3].amount = @sell.to_i
              $trade_item[3] = 1
              $game_variables[1003] += 2

              
            when 4
              $item_number[4] = Jindow_Trade_Data.new
              $item_number[4].id = @item_id
              $item_number[4].type = @type
              $item_number[4].amount = @sell.to_i
              $trade_item[4] = 1
              $game_variables[1003] += 2

              
            end
            Hwnd.dispose(self)
          else
        $console.write_line("개수는 한 개 이상 정할수 있습니다.")
          end
        else
        $console.write_line("소지하고 있는것 보다 개수가 많습니다.")
        end
      elsif @type == 1
        if $game_party.weapon_number(@item_id.to_i) >= @sell.to_i
          if @sell != 0 or @sell.to_s != ""
            case @number
            when 1
              $item_number[1] = Jindow_Trade_Data.new
              $item_number[1].id = @item_id
              $item_number[1].type = @type
              $item_number[1].amount = @sell.to_i
              $trade_item[1] = 1
              $game_variables[1003] += 2
             
            when 2
              $item_number[2] = Jindow_Trade_Data.new
              $item_number[2].id = @item_id
              $item_number[2].type = @type
              $item_number[2].amount = @sell.to_i
              $trade_item[2] = 1
              $game_variables[1003] += 2

              
            when 3
              $item_number[3] = Jindow_Trade_Data.new
              $item_number[3].id = @item_id
              $item_number[3].type = @type
              $item_number[3].amount = @sell.to_i
              $trade_item[3] = 1
              $game_variables[1003] += 2

            when 4
              $item_number[4] = Jindow_Trade_Data.new
              $item_number[4].id = @item_id
              $item_number[4].type = @type
              $item_number[4].amount = @sell.to_i
              $trade_item[4] = 1
              $game_variables[1003] += 2
             
            end
            Hwnd.dispose(self)
          else
        $console.write_line("개수는 한 개 이상 정할수 있습니다.")
          end
        else
        $console.write_line("소지하고 있는것 보다 개수가 많습니다.")
        end
      elsif @type == 2
        if $game_party.armor_number(@item_id.to_i) >= @sell.to_i
          if @sell != 0 or @sell.to_s != ""
            case @number
            when 1
              $item_number[1] = Jindow_Trade_Data.new
              $item_number[1].id = @item_id
              $item_number[1].type = @type
              $item_number[1].amount = @sell.to_i
              $trade_item[1] = 1
              $game_variables[1003] += 2
             
            when 2
              $item_number[2] = Jindow_Trade_Data.new
              $item_number[2].id = @item_id
              $item_number[2].type = @type
              $item_number[2].amount = @sell.to_i
              $trade_item[2] = 1
              $game_variables[1003] += 2
             
            when 3
              $item_number[3] = Jindow_Trade_Data.new
              $item_number[3].id = @item_id
              $item_number[3].type = @type
              $item_number[3].amount = @sell.to_i
              $trade_item[3] = 1
              $game_variables[1003] += 2
           
            when 4
              $item_number[4] = Jindow_Trade_Data.new
              $item_number[4].id = @item_id
              $item_number[4].type = @type
              $item_number[4].amount = @sell.to_i
              $trade_item[4] = 1
              $game_variables[1003] += 2
             
            end
            Hwnd.dispose(self)
          else
        $console.write_line("개수는 한 개 이상 정할수 있습니다.")
          end
        else
        $console.write_line("소지하고 있는것 보다 개수가 많습니다.")
        end
      end
    elsif @b.click
      $game_system.se_play($data_system.decision_se)
      Hwnd.dispose(self)
    end
  end
end
