#==============================================================================
# ■ Spriteset_Map
#------------------------------------------------------------------------------
# 　맵 화면의 스프라이트나 타일 맵등을 정리한 클래스입니다.이 클래스는
# Scene_Map 클래스의 내부에서 사용됩니다.
#==============================================================================

class Spriteset_Map
  #--------------------------------------------------------------------------
  # ● 오브젝트 초기화
  #--------------------------------------------------------------------------
  def initialize
    # 뷰포트를 작성
    @viewport1 = Viewport.new(0, 0, 640, 480)
    @viewport2 = Viewport.new(0, 0, 640, 480)
    @viewport3 = Viewport.new(0, 0, 640, 480)
    @viewport2.z = 200
    @viewport3.z = 5000
    # 타일 맵을 작성
    @tilemap = Tilemap.new(@viewport1)
    @tilemap.tileset = RPG::Cache.tileset($game_map.tileset_name)
    for i in 0..6
      autotile_name = $game_map.autotile_names[i]
      @tilemap.autotiles[i] = RPG::Cache.autotile(autotile_name)
    end
    @tilemap.map_data = $game_map.data
    @tilemap.priorities = $game_map.priorities
    # 파노라마 프레인을 작성
    @panorama = Plane.new(@viewport1)
    @panorama.z = -1000
    # 포그 프레인을 작성
    @fog = Plane.new(@viewport1)
    @fog.z = 3000
    # 캐릭터 스프라이트를 작성
    @character_sprites = []
    for i in $game_map.events.keys.sort
      sprite = Sprite_Character.new(@viewport1, $game_map.events[i])
      @character_sprites.push(sprite)
    end
    @character_sprites.push(Sprite_Character.new(@viewport1, $game_player))
    # 기후를 작성
    @weather = RPG::Weather.new(@viewport1)
    # 픽쳐를 작성
    @picture_sprites = []
    for i in 1..50
      @picture_sprites.push(Sprite_Picture.new(@viewport2,
        $game_screen.pictures[i]))
    end
    # 타이머 스프라이트를 작성
    @timer_sprite = Sprite_Timer.new
    # 프레임 갱신
    update
  end
  #--------------------------------------------------------------------------
  # ● 해방
  #--------------------------------------------------------------------------
  def dispose
    # 타일 맵을 해방
    @tilemap.tileset.dispose
    for i in 0..6
      @tilemap.autotiles[i].dispose
    end
    @tilemap.dispose
    # 파노라마 프레인을 해방
    @panorama.dispose
    # 포그 프레인을 해방
    @fog.dispose
    # 캐릭터 스프라이트를 해방
    for sprite in @character_sprites
      sprite.dispose
    end
    # 기후를 해방
    @weather.dispose
    # 픽쳐를 해방
    for sprite in @picture_sprites
      sprite.dispose
    end
    # 타이머 스프라이트를 해방
    @timer_sprite.dispose
    # 뷰포트를 해방
    @viewport1.dispose
    @viewport2.dispose
    @viewport3.dispose
  end
  #--------------------------------------------------------------------------
  # ● 프레임 갱신
  #--------------------------------------------------------------------------
  def update
    # 파노라마가 현재의 것과 다른 경우
    if @panorama_name != $game_map.panorama_name or
       @panorama_hue != $game_map.panorama_hue
      @panorama_name = $game_map.panorama_name
      @panorama_hue = $game_map.panorama_hue
      if @panorama.bitmap != nil
        @panorama.bitmap.dispose
        @panorama.bitmap = nil
      end
      if @panorama_name != ""
        @panorama.bitmap = RPG::Cache.panorama(@panorama_name, @panorama_hue)
      end
      Graphics.frame_reset
    end
    # 포그가 현재의 것과 다른 경우
    if @fog_name != $game_map.fog_name or @fog_hue != $game_map.fog_hue
      @fog_name = $game_map.fog_name
      @fog_hue = $game_map.fog_hue
      if @fog.bitmap != nil
        @fog.bitmap.dispose
        @fog.bitmap = nil
      end
      if @fog_name != ""
        @fog.bitmap = RPG::Cache.fog(@fog_name, @fog_hue)
      end
      Graphics.frame_reset
    end
    # 타일 맵을 갱신
    @tilemap.ox = $game_map.display_x / 4
    @tilemap.oy = $game_map.display_y / 4
    @tilemap.update
    # 파노라마 프레인을 갱신
    @panorama.ox = $game_map.display_x / 8
    @panorama.oy = $game_map.display_y / 8
    # 포그 프레인을 갱신
    @fog.zoom_x = $game_map.fog_zoom / 100.0
    @fog.zoom_y = $game_map.fog_zoom / 100.0
    @fog.opacity = $game_map.fog_opacity
    @fog.blend_type = $game_map.fog_blend_type
    @fog.ox = $game_map.display_x / 4 + $game_map.fog_ox
    @fog.oy = $game_map.display_y / 4 + $game_map.fog_oy
    @fog.tone = $game_map.fog_tone
    # 캐릭터 스프라이트를 갱신
    for sprite in @character_sprites
      sprite.update
    end
    # 기후 그래픽을 갱신
    @weather.type = $game_screen.weather_type
    @weather.max = $game_screen.weather_max
    @weather.ox = $game_map.display_x / 4
    @weather.oy = $game_map.display_y / 4
    @weather.update
    # 픽쳐를 갱신
    for sprite in @picture_sprites
      sprite.update
    end
    # 타이머 스프라이트를 갱신
    @timer_sprite.update
    # 화면의 색조와 시이크 위치를 설정
    @viewport1.tone = $game_screen.tone
    @viewport1.ox = $game_screen.shake
    # 화면의 플래시색을 설정
    @viewport3.color = $game_screen.flash_color
    # 뷰포트를 갱신
    @viewport1.update
    @viewport3.update
  end
end
