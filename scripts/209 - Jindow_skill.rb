#----------------------------------------------------------------------------------
# *진도우 스킬창
#----------------------------------------------------------------------------------
class Jindow_Skill < Jindow
  
  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 100, 63)
    self.name = "Skill\정렬 : 1"
    @head = true
    @mark = true
    @drag = true
    @close = true
    self.refresh "Skill"
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
    @a = J::Button.new(self).refresh(100, "스킬창")
    @b = J::Button.new(self).refresh(100, "취소")
    @a.y = 12
    @b.y = 42

  end
  
  def update
    super
    if @a.click
      $game_system.se_play($data_system.decision_se)
        $scene = Scene_Skill.new
    elsif @b.click
      Hwnd.dispose(self)
    end
  end
  
end
