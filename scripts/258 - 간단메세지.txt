#=================================================
# ■ 간단메세지
#-------------------------------------------------
# 　Author: Bimilist[비밀소년]
#   Editor: Ryucheon[류천]
# 　Desc: 액션 알피지의 간단한 버젼입니다.
#             고의적으로 함수를 한국어로 만들었으므로,
#             일본어로 번역시 작동여부는 불투명합니다.
#             스프라이트 추가버전.
#=================================================



class Scene_Map < Scene_Map
  #───────────────────────
  # ♧ 오브젝트 초기화
  #───────────────────────
  def initialize
    super
    $간단윈도우 = Window_Help.new
    $간단윈도우.opacity = 0
    $간단윈도우.z = 999
  end
  #───────────────────────
  # ♧ 프레임 갱신
  #───────────────────────
  def update
    super
    if $간단윈도우.disposed?
      $간단윈도우 = Window_Help.new
      $간단윈도우.opacity = 0
    end

    #맵 이동시 간단윈도우를 종료
    if $scene != self

    end
  end
end
  
def 간단메세지(text)
  $간단윈도우.opacity = 0
  $간단윈도우.set_text("", 1)
  bitmap = Bitmap.new(400, 16)
  bitmap.font.name = "맑은 고딕"
  bitmap.font.size = 13
  bitmap.font.color.set(65, 105, 255)
  bitmap.draw_text(-1, -1, 400, 16, text, 1)
  bitmap.draw_text(-1, 0, 400, 16, text, 1)
  bitmap.draw_text(-1, 1, 400, 16, text, 1)
  bitmap.draw_text(0, -1, 400, 16, text, 1)
  bitmap.draw_text(0, 0, 400, 16, text, 1)
  bitmap.draw_text(1, -1, 400, 16, text, 1)
  bitmap.draw_text(1, 1, 400, 16, text, 1)
  bitmap.draw_text(1, 1, 400, 16, text, 1)
  bitmap.font.color.set(255, 255, 255)
  bitmap.draw_text(0, 0, 400, 16, text, 1)
  @simple_sprite = Sprite.new
  @simple_sprite.bitmap = bitmap
  @simple_sprite.ox = 0
  @simple_sprite.oy = 0
  @simple_sprite.x = 10
  @simple_sprite.y = 346
  @simple_sprite.z = 3000
  @simple_sprite_visible = true
end

