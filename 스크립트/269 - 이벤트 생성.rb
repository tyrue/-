class Interpreter
	#--------------------------------------------------------------------------
	# * Transfer Player
	#--------------------------------------------------------------------------
	def command_201
		# If in battle
		if $game_temp.in_battle
			# Continue
			return true
		end
		# If transferring player, showing message, or processing transition
		if $game_temp.player_transferring or
			$game_temp.message_window_showing or
			$game_temp.transition_processing
			# End
			return false
		end
		# Set transferring player flag
		$game_temp.player_transferring = true
		# If appointment method is [direct appointment] 직접 이동
		if @parameters[0] == 0
			if $game_map.map_id != @parameters[1]
				$game_temp.player_new_map_id = @parameters[1]
				$game_temp.player_new_x = @parameters[2]
				$game_temp.player_new_y = @parameters[3]
				$game_temp.player_new_direction = @parameters[4]
			else
				$game_temp.player_transferring = false
				$game_player.moveto(@parameters[2], @parameters[3])
			end
			# Set player move destination
			
			# If appointment method is [appoint with variables]
		else
			# Set player move destination
			if $game_map.map_id != $game_variables[@parameters[1]]
				$game_temp.player_new_map_id = $game_variables[@parameters[1]]
				$game_temp.player_new_x = $game_variables[@parameters[2]]
				$game_temp.player_new_y = $game_variables[@parameters[3]]
				$game_temp.player_new_direction = @parameters[4]
			else
				$game_temp.player_transferring = false
				$game_player.moveto($game_variables[@parameters[2]], $game_variables[@parameters[3]])
			end
		end
		# Advance index
		@index += 1
		# If fade is set
		if @parameters[5] == 0 and $game_temp.player_transferring
			# Prepare for transition
			Graphics.freeze
			# Set transition processing flag
			$game_temp.transition_processing = true
			$game_temp.transition_name = ""
		end
		# End
		return false
	end
end


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

def check_create_monster_id
	return $game_map.events.size + 10000
end

def create_abs_monsters(monster_id, num)
	return if !$is_map_first
	for i in 0...num
		id = check_create_monster_id
		e = create_events(id, monster_id, $game_map.map_id, 2, 1, 1)
		
		return if e == nil
		$ABS.rand_spawn(e)
		Network::Main.socket.send("<monster2>#{$game_map.map_id},#{id},#{monster_id}</monster2>\n")
	end
end

# 운영자가 소환하는 몬스터, 한 번 잡으면 서버에서 삭제시키도록 하자
def create_abs_monsters_admin(monster_id, num)
	x = $game_player.x
	y = $game_player.y
	d = 2
	r = 12
	
	for i in 0...num
		id = check_create_monster_id	
		count = 0
		while count < 10000
			count += 1
			x2 = x + rand(r) - r / 2
			y2 = y + rand(r) - r / 2
			if $game_map.passable?(x2, y2, d)
				e = create_events(id, monster_id, $game_map.map_id, 2, x2, y2)
				return if e == nil
				Network::Main.socket.send("<monster2>#{$game_map.map_id},#{id},#{monster_id},#{x2},#{y2},-1</monster2>\n")
				break
			end
		end
	end
end


def create_events(no, mob_id, map_id, direction, x, y)
	temp = load_data("Data/Map022.rxdata").events[mob_id]
	return if temp == nil
	temp.id = no
	
	$game_map.events[no] = Game_Event.new(map_id, temp)
	event = $game_map.events[no]
	return if not event
	event.id = no
	event.moveto(x, y)
	event.direction = direction
	create_sprite(event) 
	event.refresh
	return event
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
		event.es_set_graphic("../Icons/[기타]1전", 255, 0)
	elsif 10 <= money and money < 100
		event.es_set_graphic("../Icons/[기타]10전", 255, 0)
	elsif 100 <= money and money < 500
		event.es_set_graphic("../Icons/[기타]100전", 255, 0)
	elsif 500 <= money and money < 1000
		event.es_set_graphic("../Icons/[기타]500전", 255, 0)
	elsif 1000 <= money and money < 5000
		event.es_set_graphic("../Icons/[기타]1000전", 255, 0)
	else
		event.es_set_graphic("../Icons/[기타]10000전", 255, 0)
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