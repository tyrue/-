#----------------------------------------------------
# 제작자 : 이실로드
# 간단한 이벤트 생성
#----------------------------------------------------

class Game_Event
	attr_accessor :id
end

def check_drop_id
	for i in 30001..31000
		if $Drop[i] == nil
			$Drop[i] = Drop.new
			return i
		end
	end
end


def create_events(no, mob_id, map_id, direction, x, y)
	temp = load_data("Data/Map022.rxdata").events[mob_id]
	temp.id = no
	
	$game_map.events[no] = Game_Event.new(map_id, temp)
	event = $game_map.events[no]
	return if not event
	event.id = no
	event.moveto(x, y)
	event.direction = direction
	create_sprite(event) 
	event.refresh
end


#drop 번호, 아이템 타입1, 아이템 타입2, 아이템 id, 맵 아이디, x좌표, y좌표
def create_drops(type, id, x, y, num = 1)
	d_id = check_drop_id
	Network::Main.socket.send "<Drop>#{d_id},1,#{type},#{id},#{$game_map.map_id},#{x},#{y},#{num}</Drop>\n" # 나를 포함한 전체 방송
end

def create_moneys(money, x, y)
	d_id = check_drop_id
	Network::Main.socket.send "<Drop>#{d_id},0,0,0,#{$game_map.map_id},#{x},#{y},#{money}</Drop>\n"
end


def create_drops2(no, mob_id, map_id, x, y, image, name = "", num = 0)
	return if num == 0
	$game_map.events[no] = Game_Event.new(map_id ,load_data("Data/Map022.rxdata").events[mob_id])
	event = $game_map.events[no]
	return if not event
	event.id = no
	event.moveto(x, y)
	event.es_set_graphic("../Icons/" + image, 255, 0)
	create_sprite(event, true)
	
	if num <= 1
		event.name = "[id#{name}]"
	else
		event.name = "[id#{name} #{num}개]"
	end
	
	event.refresh
end

def create_moneys2(no, mob_id, map_id, x, y, money)
	$game_map.events[no] = Game_Event.new(map_id ,load_data("Data/Map022.rxdata").events[mob_id])
	event = $game_map.events[no]
	return if not event
	event.id = no
	event.moveto(x, y)
	if 0 < money and money < 10
		event.es_set_graphic("../Icons/1전", 255, 0)
	elsif 10 <= money and money < 100
		event.es_set_graphic("../Icons/10전", 255, 0)
	elsif 100 <= money and money < 500
		event.es_set_graphic("../Icons/100전", 255, 0)
	elsif 500 <= money and money < 1000
		event.es_set_graphic("../Icons/500전", 255, 0)
	elsif 1000 <= money and money < 5000
		event.es_set_graphic("../Icons/1000전", 255, 0)
	else
		event.es_set_graphic("../Icons/10000전", 255, 0)
	end
	
	event.name = "[id#{money}전]"
	create_sprite(event, true) 
	event.refresh	
end

def delete_events(id)
	no = id
	event = $game_map.events[no]
	return if not event
	remove_sprite event
end