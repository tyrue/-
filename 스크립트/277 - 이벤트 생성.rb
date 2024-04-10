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
		d = (rand(4) + 1) * 2
		e = create_events(16, 1, 1, d, id, monster_id)
		return if e == nil
		$ABS.rand_spawn(e)
		$ABS.send_network_monster($ABS.enemies[id])
	end
end

# 운영자가 소환하는 몬스터, 한 번 잡으면 서버에서 삭제시키도록 하자
def create_abs_monsters_admin(monster_id, num = 1)
	x = $game_player.x
	y = $game_player.y
	r = 12
	
	for i in 0...num
		count = 0
		while count < 100
			count += 1
			x2 = x + rand(r) - r / 2
			y2 = y + rand(r) - r / 2
			d = (rand(4) + 1) * 2
			
			if $game_map.passable?(x2, y2, d)
				e = create_events(16, x2, y2, d, -1, monster_id)
				return if e == nil
				$ABS.send_network_monster($ABS.enemies[e.id], 1)
				break
			end
		end
	end
end

def create_events(mob_id, x, y, dir, event_no = -1, monster_id = -1)
	temp = load_data("Data/Map022.rxdata").events[mob_id]
	return if temp == nil
	no = event_no <= -1 ? check_create_monster_id : event_no
	map_id = $game_map.map_id
	
	$game_map.events[no] = Game_Event.new(map_id, temp)
	event = $game_map.events[no]
	return if not event
	
	if monster_id > 0 and event.list[0].parameters[0].include?("ABS")
		event.list[1].parameters[0] = "ID #{monster_id}" 
	end
	
	event.id = no
	event.event.id = no
	event.moveto(x, y)
	event.direction = dir
	event.refresh_set_page
	create_sprite(event) 
	event.refresh
	return event
end

def make_item_dto(type, item_id, x, y, num = 1, sw = 0)
	id = check_drop_id
	
	item_data = {
		"id" => id,
		"map_id" => $game_map.map_id,
		"x" => x,
		"y" => y,
		"num" => num,
		"type" => type,
		"item_id" => item_id,
		"sw" => sw
	}
	
	return item_data
end

def create_drop_message(item_data)
	message = "<Drop>"
	item_data.each { |key, value| message += "#{key}:#{value}|" }
	message += "</Drop>\n"
	Network::Main.socket.send(message) # 나를 포함한 전체 방송
end

def create_drops(type, item_id, x, y, num = 1, sw = 0)
	item_data = make_item_dto(type, item_id, x, y, num, sw)
	create_drop_message(item_data)
end

def create_moneys(num, x, y)
	item_data = make_item_dto(3, 0, x, y, num)
	create_drop_message(item_data)
end

def create_drops2(no, x, y, type, id, num)
	return if num == 0
	$game_map.events[no] = Game_Event.new($game_map.map_id, load_data("Data/Map022.rxdata").events[138])
	event = $game_map.events[no]
	return if not event
	
	item = case type
	when 0 then $data_items[id]
	when 1 then $data_weapons[id]
	when 2 then $data_armors[id]
	else nil
	end
	
	$Drop[no] = Drop.new
	$Drop[no].id = id
	$Drop[no].type = type
	$Drop[no].type2 = 1
	$Drop[no].amount = num #아이템 개수
	
	event.id = no
	event.moveto(x, y)
	event.es_set_graphic("../Icons/" + item.icon_name, 255, 0)
	create_sprite(event, true)
	
	event.name = num <= 1 ? "[id#{item.name}]" : "[id#{item.name} #{num}개]"
	event.refresh
end

def create_moneys2(no, x, y, money)
	$game_map.events[no] = Game_Event.new($game_map.map_id, load_data("Data/Map022.rxdata").events[138])
	event = $game_map.events[no]
	return if not event
	
	event.id = no
	event.moveto(x, y)
	
	$Drop[no] = Drop.new
	$Drop[no].type2 = 0
	$Drop[no].amount = money #아이템 개수
		
	event.es_set_graphic(choose_money_icon(money), 255, 0)
	event.name = "[id#{money}전]"
	create_sprite(event, true) 
	event.refresh	
end

def choose_money_icon(money)
  case money
  when 1...10      then "../Icons/[기타]1전"
  when 10...100    then "../Icons/[기타]10전"
  when 100...500   then "../Icons/[기타]100전"
  when 500...1000  then "../Icons/[기타]500전"
  when 1000...5000 then "../Icons/[기타]1000전"
  else                   "../Icons/[기타]10000전"
  end
end

def delete_events(id)
	event = $game_map.events[id]
	return if not event
	remove_sprite event
	$game_map.events.delete(event.id) 
end

#=================================================
# ■ 보관이벤트
#-------------------------------------------------
# 　제작자: 비밀소년
#   p.s 안쓰는부분은 없앴음
#=================================================
def event_remove(event)
	remove_sprite event
	$game_map.events.delete event.id
end

def 소환물다지워!
	for dst in 20001..20500
		event = $game_map.events[dst]
		remove_sprite event
		$game_map.events.delete dst
	end
end

def 보관이벤트(id)
	for dst in 20001..20500
		if $game_map.events[dst] == nil
			return 보관이벤트_a(dst, id)
		end
	end
	return nil
end

def 보관이벤트_a(dst, id)
	if not $bo_map
		$bo_map = load_data(sprintf("Data/Map022.rxdata", 1))
	end
	$game_map.instance_eval do
		@events[dst] = Game_Event.new(@map_id, $bo_map.events[id])
	end
	$game_map.events[dst].instance_eval do
		@id = dst
	end
	create_sprite $game_map.events[dst]
	return $game_map.events[dst]
end

def create_sprite(c, sw = false)
	if $scene.is_a?(Scene_Map)
		$scene.instance_eval do
			@spriteset.instance_eval do
				return if @character_sprites == nil
				@character_sprites.each do |v|
					if v.character == c
						return v
					end
				end
				sprite = Sprite_Character.new(@viewport1, c, sw)
				@character_sprites.push(sprite)
			end
		end
	end
	return nil
end

def remove_sprite(c)
	if $scene.is_a?(Scene_Map)
		$scene.instance_eval do
			@spriteset.instance_eval do
				delv = nil
				@character_sprites.each do |v|
					if v.character == c
						delv = v
					end
				end
				if delv
					delv.dispose
					@character_sprites.delete delv
				end
			end
		end
	end
	return nil
end


class Sprite_Character
	attr_accessor :is_item
	
	alias sprite_item_initialize initialize
	def initialize(viewport, character = nil, is_item = false)
		sprite_item_initialize(viewport, character)
		@is_item = is_item
	end
	
	alias sprite_item_update update
	def update
		sprite_item_update
		# If tile ID, file name, or hue are different from current ones
		if @is_item
			# If graphic is character
			if @tile_id == 0
				@cw = bitmap.width
				@ch = bitmap.height
				self.ox = @cw / 2
				self.oy = @ch
				
				# Set rectangular transfer
				sx = bitmap.width
				sy = bitmap.height
				self.src_rect.set(0, 0, sx, sy)
			end
			# Set sprite coordinates
			self.x = @character.screen_x
			self.y = @character.screen_y
			self.z = @character.screen_z(@ch)
			
			@is_item = false
		end
	end
end