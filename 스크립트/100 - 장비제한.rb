class Game_Actor
#================================================
#
#   ■ 레벨제한 무기&방어구 스크립트
#------------------------------------------------
#
#   Author: 준돌
#
#   Desc: 무기와 방어구에 간편한 방법으로
#            레벨제한을 구현합니다.
#
#   How to use: 아이템의 설명란에 [LV 제한레벨]을
#                     쓴다. (ex:강철의 검이다[lv13])
#
#   ※레벨적용을 안하면 자동으로 렙제는 0이 됩니다.
#
#================================================


  def equippable?(item)
    
    if item.is_a? (RPG::Weapon)
      if $data_classes[@class_id]. weapon_set.include? (item.id)
        if level  >= item_level(item)
          return true
        end
      end
    end
      
    if item.is_a? (RPG::Armor)
      if $data_classes[@class_id]. armor_set.include? (item.id)
        if level  >= item_level(item)
          return true
        end
      end
    end
    return false
    
  end

  def item_level(item)
    if item != nil
      text = item.description.dup 
      text.gsub!(/\[[제재][한][레래][벨밸]:([0-9]+)\]/) do
        return $1.to_i
      end
    end
    return 0
  end
  
end
  
class Window_EquipItem < Window_Selectable

  def refresh
    if self.contents != nil
      self.contents.dispose
      self.contents = nil
    end
    @data = []
    # 장비 가능한 무기를 추가
    if @equip_type == 0
      weapon_set = $data_classes[@actor.class_id]. weapon_set
      for i in 1...$data_weapons.size
        if $game_party.weapon_number(i) > 0 and weapon_set.include? (i)
          if @actor.equippable?($data_weapons[i])
            @data.push($data_weapons[i])
          end
        end
      end
    end
    # 장비 가능한 방어용 기구를 추가
    if @equip_type != 0
      armor_set = $data_classes[@actor.class_id]. armor_set
      for i in 1...$data_armors.size
        if $game_party.armor_number(i) > 0 and armor_set.include? (i)
          if $data_armors[i]. kind == @equip_type-1
            if @actor.equippable?($data_armors[i])
              @data.push($data_armors[i])
            end
          end
        end
      end
    end
    # 공백을 추가
    @data.push(nil)
    # 비트 맵을 작성해, 전항목을 묘화
    @item_max = @data.size
    self.contents = Bitmap.new(width - 32, row_max * 32)
    for i in 0...@item_max-1
      draw_item(i)
    end
  end
end
