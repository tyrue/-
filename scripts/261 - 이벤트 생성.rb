#----------------------------------------------------
# 제작자 : 이실로드
# 간단한 이벤트 생성
#----------------------------------------------------
# 사용법 :       
#Network::Main.socket.send "<Drop>#{@item_index.to_s},#{@item_type.to_s},1,#{$game_map.map_id},#{$game_player.x},#{$game_player.y},#{@item_id.to_i}</Drop>\n"
#                                      아이템 번호        아이템 타입   방향         맵 아이디         x좌표               y좌표           아이템 이름

class Game_Event
  attr_accessor :id
end

def create_events(no, mob_id, map_id, direction, x, y)
  $game_map.events[no] = Game_Event.new(map_id ,load_data("Data/Map022.rxdata").events[mob_id])
  event = $game_map.events[no]
  return if not event
  event.id = no
  event.moveto(x, y)
  event.direction = direction
  create_sprite event
  event.refresh
end

def create_drops(no, mob_id, map_id, direction, x, y, image)
  $game_map.events[no] = Game_Event.new(map_id ,load_data("Data/Map022.rxdata").events[mob_id])
  event = $game_map.events[no]
  return if not event
  event.id = no
  event.moveto(x, y)
  event.direction = direction
  event.es_set_graphic("Item", 255, 0)
  #event.es_set_graphic("../icons/" + image, 255, 0)
  create_sprite event
  event.refresh
end

def create_moneys(no, mob_id, map_id, direction, x, y)
  $game_map.events[no] = Game_Event.new(map_id ,load_data("Data/Map022.rxdata").events[mob_id])
  event = $game_map.events[no]
  return if not event
  event.id = no
  event.moveto(x, y)
  event.direction = direction
  event.es_set_graphic("10전", 255, 0)
  create_sprite event
  event.refresh
end

def delete_events(id)
  no = id
  event = $game_map.events[no]
  return if not event
  remove_sprite event
end