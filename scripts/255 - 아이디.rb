#================================================= 
# ■ 아이디를 띄우기 (스프라이트 구현) 
#================================================= 

class Game_Event < Game_Event 
  def refresh 
    super 
    text = @event.name.dup 
    text.gsub!(/\[[Ii][Dd](.+?)\]/) do 
      @sprite_id = $1 
    end 
    @sprite_id = nil if @erased 
    @sprite_id = nil if @character_name == "" 
  end 
end 

class Game_Character 
  attr_accessor :sprite_id 
end 

class Sprite_Character < Sprite_Character 
  def create_id_sprite(text) 
    bitmap = Bitmap.new(160, 20) 
    bitmap.font.name = "궁서체" 
    bitmap.font.size = 12 
    bitmap.font.color.set(0, 0, 0) 
    bitmap.draw_frame_text(+1, +1, 160, 20, text, 1) 
    bitmap.font.color.set(255, 255, 255) 
    bitmap.draw_frame_text(0, 0, 160, 20, text, 1) 
    @_id_sprite = Sprite.new(self.viewport) 
    @_id_sprite.bitmap = bitmap 
    @_id_sprite.ox = 80 
    @_id_sprite.oy = 20
    @_id_sprite.x = self.x 
    @_id_sprite.y = self.y - self.oy / 2 
    @_id_sprite.z = 3000 
    @_id_sprite_visible = true 
  end 

  def dispose_id_sprite 
    @_id_sprite.dispose 
    @_id_sprite_visible = false 
  end 
  
  def update_id_sprite 
    if @character.sprite_id != nil 
      if not @_id_sprite_visible 
        create_id_sprite(@character.sprite_id) 
      end 
      @_id_sprite.x = self.x 
      @_id_sprite.y = self.y - self.oy 
    else 
      if @_id_sprite_visible 
        dispose_id_sprite 
      end 
    end 
  end 
      
  def update 
    super 
    update_id_sprite 
  end 
end 
