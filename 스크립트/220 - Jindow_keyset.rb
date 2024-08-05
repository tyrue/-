#----------------------------------------------------------------------------------
# * 진도우 단축키 확인 창
#----------------------------------------------------------------------------------
class Jindow_Keyset < Jindow
  HEADER_FONT_SIZE = 15
  HEADER_FONT_COLOR = [255, 142, 122, 255]
  SUB_HEADER_FONT_COLOR = [133, 133, 255, 255]
  CONTENT_FONT_SIZE = 13
  CONTENT_FONT_COLOR = [0, 0, 0, 255]

  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 250, 270)
    self.name = "⊙ 단축키 확인"
    @head = true
    @mark = true
    @drag = true
    @close = true
    self.refresh("Keyset") 
    center_window

    @keyset = {}
    @k_value = {}
		
		make_x_position
    draw_headers
    populate_key_values
    create_keyset_sprites
  end

  def update
    super
  end

  private

  def center_window
    self.x = 640 / 2 - self.max_width / 2
    self.y = 480 / 2 - self.max_height / 2
  end
	
	def make_x_position
		@keyboard_x = 0
		@keypad_x = 125
	end

  def draw_headers
    create_header(@keyboard_x, 0, "키보드 단축키", HEADER_FONT_COLOR)
    create_header(@keypad_x, 0, "키패드 단축키", SUB_HEADER_FONT_COLOR)
  end

  def create_header(x, y, text, color)
    sprite = Sprite.new(self)
    sprite.bitmap = Bitmap.new(100, 20)
    sprite.x = x
    sprite.y = y
    sprite.bitmap.font.size = HEADER_FONT_SIZE
		sprite.bitmap.font.alpha = 3
		sprite.bitmap.font.beta = 1
    sprite.bitmap.font.color.set(*color)
    sprite.bitmap.draw_text(0, 0, 100, 20, text, 0)
  end

  def populate_key_values
    merge_key_values($ABS.skill_keys, $data_skills)
    merge_key_values($ABS.item_keys, $data_items)
  end

  def merge_key_values(key_hash, data)
    key_hash.sort.each do |k, v|
      next if v.nil? || v == 0
			
      @k_value[k] = data[v].name if data[v]
    end
  end

  def create_keyset_sprites
    i = 0
    i2 = 0

    $ABS.skill_keys.sort.each do |k, v|
      key_s, type_x, type_y = determine_key_position(k, i, i2)
      next unless key_s

      @keyset[k] = create_key_sprite(type_x, type_y, key_s, @k_value[k])
      i += 1 if type_x == @keyboard_x
      i2 += 1 if type_x == @keypad_x
    end
  end

  def determine_key_position(k, i, i2)
    key_s = ""
    type_x = @keyboard_x
    type_y = i

    case k
    when Input::Underscore then key_s = "-"
    when Input::Equal then key_s = "="
    when Input::Letters["Z"] then key_s = "z"
    when Input::Letters["X"] then key_s = "x"
    when Input::Numberkeys[0]..Input::Numberkeys[9]
      key_s = (k - 48).to_s
    when Input::Numberpad[0]..Input::Numberpad[9]
      key_s = (k - 96).to_s
      type_x = @keypad_x
      type_y = i2
      i2 += 1
      i -= 1
    else
      return [nil, nil, nil]
    end

    [key_s, type_x, type_y]
  end

  def create_key_sprite(x, y, key_s, value)
    sprite = Sprite.new(self)
    sprite.bitmap = Bitmap.new(150, 20)
    sprite.x = x
    sprite.y = y * 17 + 22
    sprite.bitmap.font.size = CONTENT_FONT_SIZE
    sprite.bitmap.font.color.set(*CONTENT_FONT_COLOR)
    sprite.bitmap.draw_text(0, 0, 150, 20, "#{key_s} : #{value}", 0)
    sprite
  end
end
