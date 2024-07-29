#----------------------------------------------------------------------------------
# * Jindow Skill Window
#----------------------------------------------------------------------------------
class Jindow_Skill < Jindow
  
  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 200, 100)
    setup_window_properties
    setup_actor_skills
    create_page_buttons
    create_page_sprites
    draw_skill_buttons
		set_page_button_positions
    adjust_window_size
    center_window
  end
  
  def setup_window_properties
    self.name = "⊙ 스킬창"
    @head = true
    @mark = true
    @drag = true
    @close = true
  end
  
  def setup_actor_skills
    @actor = $game_party.actors[0]
    @data = @actor.skills.map { |skill_id| $data_skills[skill_id] }.compact
    @page_n = 10
    @page = []
    @now_page = 1
    @max_page = [(@data.size / @page_n.to_f).ceil, 1].max
  end
  
  def create_page_buttons
    @prev_button = create_button(60, self.height, "◀")
    @next_button = create_button(95, self.height, "▶")
  end
  
  def create_button(x, y, text, width = 30, type = 1)
    button = J::Button.new(self).refresh(width, text, type)
    button.x = x
    button.y = y - button.height
    button
  end
  
  def create_page_sprites
    @s1 = create_sprite(5, 0, 100, 20, "페이지 : #{@now_page}")
    @s2 = create_sprite(5, @s1.y + @s1.height + 2, 200, 20, "마우스 왼쪽:스킬 사용 / 마우스 오른쪽:정보 확인")
  end
  
  def create_sprite(x, y, width, height, text)
    sprite = Sprite.new(self)
    sprite.bitmap = Bitmap.new(width, height)
    sprite.x = x
    sprite.y = y
    sprite.bitmap.font.size = 12
    sprite.bitmap.font.color.set(0, 0, 0, 255)
    sprite.bitmap.draw_text(0, 0, width, height, text, 0)
    sprite
  end
  
  def draw_skill_buttons
    @page.each {|p| p.dispose unless p.disposed?}
    @page = []
    start_index = (@now_page - 1) * @page_n
    @page_n.times do |i|
      skill = @data[start_index + i]
			next unless skill
			
      text = "#{start_index + i + 1} : #{skill.name}"
			button = create_button(30, 0, text, 120, 0)
      button.y = (@s2.y + @s2.height) + (button.height + 3) * i
      @page << button
    end
  end
  
  def set_page_button_positions
    last_button = @page.last
    @prev_button.y = last_button.y + last_button.height + 10 if last_button
    @next_button.y = @prev_button.y
  end
  
  def adjust_window_size
    self.width = @s2.width
    self.height = [@next_button.y + @next_button.height + 10, self.height].max
    self.refresh("Skill")
  end
  
  def center_window
    self.x = (640 - self.max_width) / 2
    self.y = (480 - self.max_height) / 2
    self.refresh("Skill")
  end
  
	def update
    super
    handle_prev_button_click
    handle_next_button_click
    handle_skill_buttons_click
  end
	
  def handle_prev_button_click
    return unless @prev_button.click
    
    @now_page = @now_page == 1 ? @max_page : @now_page - 1
    update_page_text
    draw_skill_buttons
  end
  
  def handle_next_button_click
    return unless @next_button.click
    
    @now_page = @now_page == @max_page ? 1 : @now_page + 1
    update_page_text
    draw_skill_buttons
  end
  
  def update_page_text
    @s1.bitmap.clear
    @s1.bitmap.draw_text(0, 0, 100, 20, "페이지 : #{@now_page}", 0)
  end
  
  def handle_skill_buttons_click
    @page.each_with_index do |button, i|
      next if button.nil? || button.disposed?
      
      skill = @data[(@now_page - 1) * @page_n + i]
      if button.click
        $ABS.player_skill(skill.id)
      elsif button.r_click
        Hwnd.dispose("Skill_Info")
        Jindow_Skill_Info.new(skill)
      end
    end
  end
  
end
