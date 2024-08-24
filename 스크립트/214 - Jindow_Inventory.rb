#==============================================================================
# ■ Jindow_Inventory
#------------------------------------------------------------------------------
#   캐릭터 인벤토리 창
#------------------------------------------------------------------------------
$trade_num = 1

class Jindow_Inventory < Jindow
  attr_reader :temp_sw

  def initialize
		자동저장
    $game_system.se_play($data_system.decision_se)
		super(0, 0, 240, 300)
		
    setup_window
    setup_buttons
    setup_inventory
    load_items
    hide_all_items
    adjust_window_dimensions
    setMode(0)
    self.refresh("Inventory")
  end

  def setMode(id)
    @mode = id
    case @mode
    when 0
      update_window_name("아이템", "기본 가방 상태")
    when 1
      update_window_name("교환할 아이템을 더블 클릭하세요.", "교환 가방 상태")
    when 2
      update_window_name("판매할 아이템을 더블 클릭하세요.", "상점 판매 가방 상태")
    end
  end

  def sort(id = 0)
    return unless @tog
    자동저장
    add_buttons_to_item_list
    update_item_visibility
    organize_items
    arrange_items
  end

  def hide
    super
    @tog = false
  end

  def show(val = @opacity)
    super
    @tog = true
    sort
  end

  def toggle
    @tog ? hide : show(@opacity)
    @temp_sw = @tog
  end

  def update
    return unless @tog
    handle_sort_button_click
    handle_gold_drop_button_click
    handle_item_double_click
    super
  end

  private

  def setup_window
    self.name = "아이템"
    @head = true
    @mark = true
    @drag = true
    @close = true
    @tog = true
    @temp_sw = true
    self.x = 330
    self.y = 95
    @inventory_size = 100
    @margin = 10
    @line_count = 7
    @item_margin = 9
    @opacity = 255
    self.opacity = @opacity
  end

  def setup_buttons
    @sort_button = create_button(60, "정렬하기")
    @gold_drop_button = create_button(60, "금전 버리기")
  end

  def create_button(width, text)
    button = J::Button.new(self).refresh(width, text)
    button.y = 0
    button
  end

  def setup_inventory
    @data = { 0 => [], 1 => [], 2 => [] }
  end

  def load_items
    load_data_items($data_items, 0)
    load_data_items($data_weapons, 1)
    load_data_items($data_armors, 2)
  end

  def load_data_items(data, type)
    data.each_with_index do |item, index|
      next if item.nil? || item.name.empty?
      @data[type] << J::Item.new(self).set(true).refresh(item.id, type)
    end
  end

  def hide_all_items
    @item.clear
    sort
  end

  def adjust_window_dimensions
    self.width = @line_count * (@item_margin + @data[0][0].width)
    adjust_button_positions
  end

  def adjust_button_positions
    @sort_button.x = self.width - @sort_button.width - @gold_drop_button.width - 20
    @gold_drop_button.x = @sort_button.x + @sort_button.width + 10
  end

  def update_window_name(name, message)
    self.name = name
    change_name(name)
    $console.write_line(message)
  end

  def add_buttons_to_item_list
    @item << @gold_drop_button unless @item.include?(@gold_drop_button)
    @item << @sort_button unless @item.include?(@sort_button)
  end

  def update_item_visibility
    @data.each do |_, items|
      items.each do |item|
        next if item.nil?
        if item.num <= 0
          @item.delete(item)
          item.offVisible
        else
          @item << item unless @item.include?(item)
        end
      end
    end
  end

  def organize_items
    @organized_items = { 0 => [], 1 => [], 2 => Array.new(5) { [] } }
    @item.each do |item|
      next unless item.is_a?(J::Item)
      if item.type == 2
        @organized_items[2][item.item.kind] << item
      else
        @organized_items[item.type] << item
      end
      item.visible = @tog
    end
  end

  def arrange_items
    count = 0
    temp_y = @gold_drop_button.y + @gold_drop_button.height + 5
    @organized_items.each do |idx, items|
      old_count = count
      items.each do |item|
        if idx == 2
          count = arrange_nested_items(item, temp_y, count)
        else
          count = arrange_item(item, temp_y, count)
        end
      end
      count = adjust_count_for_next_category(old_count, count)
    end
  end

  def arrange_nested_items(items, temp_y, count)
    items.each do |item|
      item.x = (count % @line_count) * (item.width + @item_margin)
      item.y = (count / @line_count) * (item.height + @item_margin) + temp_y
      count += 1
    end
    adjust_for_line_end(count)
  end

  def arrange_item(item, temp_y, count)
    item.x = (count % @line_count) * (item.width + @item_margin)
    item.y = (count / @line_count) * (item.height + @item_margin) + temp_y
		return count + 1
  end

  def adjust_for_line_end(count)
		count += (count % @line_count) != 0 ? @line_count : 0
		count -= count % @line_count
		count
  end

  def adjust_count_for_next_category(old_count, count)
    return count if old_count == count
		
		count += (count % @line_count) != 0 ? @line_count * 2 : @line_count
		count -= count % @line_count
		count
  end

  def handle_sort_button_click
    return unless @sort_button.click
		
    @sort_button.click = false
    $console.write_line("물품을 정리했습니다.")
    @item.clear
    sort
  end

  def handle_gold_drop_button_click
    return unless @gold_drop_button.click
		
    @gold_drop_button.click = false
    if $game_switches[296]
      $console.write_line("귀신은 할 수 없습니다.")
    elsif $game_party.gold <= 0
      $console.write_line("버릴 돈이 없습니다.")
    else
      Hwnd.dispose("Item_Drop") if Hwnd.include?("Item_Drop")
      Jindow_Drop.new(0, 0, 0)
    end
  end

  def handle_item_double_click
    @item.each do |item|
      next unless item.item?
      next unless item.double_click
			
      item.double_click = false
      case @mode
      when 0 then item_use(item)
      when 1 then trade_check(item)
      when 2 then shop_sell_item(item)
      when 3 then post_item(item)
      end
    end
  end

  def item_use(item)
    case item.type
    when 0 then use_consumable_item(item)
    when 1, 2 then equip_item(item)
    end
  end

  def use_consumable_item(item)
    return unless $game_party.actors[0].item_effect(item.item)
		
    $game_player.animation_id = item.item.animation1_id
    $game_party.lose_item(item.item.id, 1) if item.item.consumable
    $game_system.se_play(item.item.menu_se)
    $game_temp.common_event_id = item.item.common_event_id if item.item.common_event_id > 0
  end

  def equip_item(item)
    if $game_switches[296]
      $console.write_line("귀신은 할 수 없습니다.")
      return
    end
    return unless $game_party.actors[0].equippable?(item.item)
		
    kind = item.type == 1 ? 0 : item.item.kind + 1
    $game_party.actors[0].equip(kind, item.item.id)
    $game_system.se_play("장비")
  end

  def trade_check(item)
    return $console.write_line("[교환]: 교환 불가 아이템입니다.") unless $Abs_item_data.is_trade_ok?(item.item.id, item.type)
		
    Jindow_Trade2.new(item.item.id, item.type)
  end

  def shop_sell_item(item)
    if item.item.price > 0
      Hwnd.include?("Shop_Num_Window") ? Hwnd.dispose("Shop_Num_Window") : 0
      Jindow_Shop_Num.new(item.item, item.type, 1)
    else
      $console.write_line("판매 불가 아이템입니다.")
    end
  end

  def post_item(item)
    if $Abs_item_data.is_trade_ok?(item.item.id, item.type) 
			$Abs_item_data.process_one_trade_switch(item.item.id, item.type)
      post_jin = Hwnd.include?("Post", 1)
      data = Jindow_Trade_Data.new
      data.id = item.item.id
      data.type = item.type
      data.amount = 1
      post_jin.set_data(data)
    else
      $console.write_line("[편지]: 교환 불가 아이템입니다.")
    end
  end

  def dispose2
    $game_system.se_play($data_system.cancel_se)
    toggle
  end
end

class Game_Battler
  alias jindow_item_event item_effect
  def item_effect(item)
    return false if handle_special_cases(item)
		
    jindow_item_event(item)
    return true
  end

  private

  def handle_special_cases(item)
    return true if handle_ghost_case(item)
    return true if handle_full_recovery_case(item)
		return true if handle_item_absence_case(item)
		return false
  end

  def handle_ghost_case(item)
		return false unless $game_switches[296]
    return false if item.id == 63 # 부활시약
		
    $console.write_line("귀신은 할 수 없습니다.")
    return true
  end

  def handle_full_recovery_case(item)
    if (item.recover_hp > 0 || item.recover_hp_rate > 0) && ($game_party.actors[0].hp >= $game_party.actors[0].maxhp)
      $console.write_line("이미 완전 회복된 상태 입니다.")
      return true
		end
		
    if (item.recover_sp > 0 || item.recover_sp_rate > 0) && ($game_party.actors[0].sp >= $game_party.actors[0].maxsp)
      $console.write_line("이미 완전 회복된 상태 입니다.")
      return true  
		end
		
		return false
  end

  def handle_item_absence_case(item)
    if $game_party.item_number(item.id) <= 0
      $console.write_line("아이템이 없습니다.")
      return true
    end
		
		return false
  end
end
