#==============================================================================
# ** Sprite_Text
#------------------------------------------------------------------------------
#  This sprite is used to display the text.
#==============================================================================

class Sprite_Text < RPG::Sprite
  #--------------------------------------------------------------------------
  # * Public Instance Variables
  #--------------------------------------------------------------------------
  attr_accessor :text
  attr_accessor :font
  attr_accessor :color1
  attr_accessor :color2
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     viewport  : viewport
  #     text : text
  #--------------------------------------------------------------------------
  def initialize(viewport, text = "hello")
    super(viewport)
    @text = text
    @font = nil
    @color1 = Color.new(255,255,255)
    @color2 = nil
    update
  end
  #--------------------------------------------------------------------------
  # * Redraw Text
  #--------------------------------------------------------------------------
  def redraw
    bitmap1 = Bitmap.new(1, 1)
    bitmap1.font = @font if @font
    rect1 = bitmap1.text_size(@text.to_s)
    bitmap1.dispose
    self.bitmap.dispose if self.bitmap
    self.bitmap = Bitmap.new(rect1.width + 2, rect1.height + 2)
    self.bitmap.font = @font if @font
    if @color2
      self.bitmap.font.color = @color2
      self.bitmap.draw_text(0, 1, rect1.width, rect1.height, @text.to_s)
      self.bitmap.draw_text(1, 0, rect1.width, rect1.height, @text.to_s)
      self.bitmap.draw_text(1, 2, rect1.width, rect1.height, @text.to_s)
      self.bitmap.draw_text(2, 1, rect1.width, rect1.height, @text.to_s)
      self.bitmap.font.color = @color1
      self.bitmap.draw_text(1, 1, rect1.width, rect1.height, @text.to_s)
    else
      #self.bitmap.draw_text(0, 1, rect1.width, rect1.height, @text.to_s)
      self.bitmap.font.color = @color1
      self.bitmap.draw_text(1, 0, rect1.width, rect1.height, @text.to_s)
    end
  end
  #--------------------------------------------------------------------------
  # * Frame Update
  #--------------------------------------------------------------------------
  def update
    super
    if @drawn_text != @text
      redraw
      @drawn_text = @text
    end
  end
end
