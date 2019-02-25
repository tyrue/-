class Game_Party
  attr_accessor :items
  attr_accessor :weapons
  attr_accessor :armors
  #--------------------------------------------------------------------------
  # * Gain Gold (or lose)
  #     n : amount of gold
  #--------------------------------------------------------------------------
  def gain_gold(n)
    @gold = [[@gold + n, 0].max, 999999999999].min
  end
  #--------------------------------------------------------------------------
  # * Lose Gold
  #     n : amount of gold
  #--------------------------------------------------------------------------
  def lose_gold(n)
    # Reverse the numerical value and call it gain_gold
    gain_gold(-n)
  end
end