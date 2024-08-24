class Jindow_Dialog < Jindow
  def initialize(name, texts, commands)
    $game_system.se_play($data_system.decision_se)
    $now_dialog = true
		
		@font_size = 18
		@margin = 5
		super(0, 0, 250, texts.size * @font_size)
		
		self.name = name
    @head = true
    @mark = true
    @drag = true
    @close = true
		@scripts = []
		
    setup_text(texts)
    setup_buttons(commands)
		
		self.x = (640 - self.width) / 2
    self.y = (480 - self.height) / 2
		self.refresh(name)
  end

  def setup_text(texts)
    @text = Sprite.new(self)
    @text.bitmap = Bitmap.new(self.width, texts.size * (@font_size + @margin))
    @text.bitmap.font.color.set(0, 0, 0, 255)
    texts.each_with_index do |text, index|
			x = 0
			y = index * @font_size + @margin
      @text.bitmap.draw_text(0, y, self.width, @font_size + @margin, text)
    end
  end

  def setup_buttons(commands)
    @buttons = []
    commands.each_with_index do |command, index|
			button_name, script = command
      button = J::Button.new(self).refresh(60, button_name)
      button.x = index * (button.width + 10)
      button.y = (@text.y + @text.height + @margin)  # Adjusted position to be consistent
			
      @buttons << button
			@scripts << script
    end
		self.height = @buttons.last.y + @buttons.last.height + 10 if @buttons.last
  end

  def update
    super
    @buttons.each_with_index do |button, index|
      eval(@scripts[index]) if button.click
    end
  end
end
