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

#----------------------------------------------------------------
# 드롭 아이디 확인 및 생성
#----------------------------------------------------------------
def check_drop_id
	(30001..31000).each do |i|
		unless $Drop[i]
			$Drop[i] = Drop.new
			return i 
		end
	end
end

def check_create_monster_id
	(10001..12000).each do |i|
		return i unless $game_map.events[i]
	end
end

def create_abs_monsters(monster_id, num = 1, id = nil)
	return unless $is_map_first
	
	num.times do 
		e_id = id || check_create_monster_id
		dir = (rand(4) + 1) * 2
		event = create_events(16, 1, 1, dir, e_id)
		return unless event
		
		event.list[1].parameters[0] = "ID #{monster_id}"
		setup_event(event, e_id, 1, 1, dir)
		
		$ABS.rand_spawn(event)
		$ABS.send_network_monster($ABS.enemies[e_id])
	end
end

# 운영자가 소환하는 몬스터, 한 번 잡으면 서버에서 삭제시키도록 하자
def create_abs_monsters_admin(monster_id, num = 1)
	x, y, r = $game_player.x, $game_player.y, 12
	
	num.times do
		count = 0
		while count < 100
			count += 1
			x2 = x + rand(r) - r / 2
			y2 = y + rand(r) - r / 2
			dir = (rand(4) + 1) * 2
			next unless $game_map.passable?(x2, y2, dir)
			
			id = check_create_monster_id
			event = create_events(16, x2, y2, dir, id)
			return unless event
			
			event.list[1].parameters[0] = "ID #{monster_id}"
			setup_event(event, id, x2, y2, dir)
			
			$ABS.send_network_monster($ABS.enemies[id], 1)
			break
		end
	end
end

def create_events(event_id, x, y, dir = 2, id = nil)
	temp = load_data("Data/Map022.rxdata").events[event_id]
	return unless temp
	
	map_id = $game_map.map_id
	event = Game_Event.new(map_id, temp)
	return unless event
	
	id ||= check_create_monster_id
	$game_map.events[id] = event 
	setup_event(event, id, x, y, dir)
	create_sprite(event) 
	return event
end

def setup_event(event, id, x, y, dir)
  return unless event
  
  event.id = id
	event.event.id = id
  event.moveto(x, y)
  event.direction = dir
	
  event.refresh_set_page
  event.refresh
end

def make_item_dto(type, item_id, x, y, num = 1, sw = 0)
	{
		"id" => check_drop_id,
		"map_id" => $game_map.map_id,
		"x" => x,
		"y" => y,
		"num" => num,
		"type" => type,
		"item_id" => item_id,
		"sw" => sw
	}
end

def create_drop_message(item_data)
	message = item_data.map { |key, value| "#{key}:#{value}|" }.join
	Network::Main.send_with_tag("Drop", message)
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
	
	item = case type
	when 0 then $data_items[id]
	when 1 then $data_weapons[id]
	when 2 then $data_armors[id]
	else nil
	end
	return unless item
	
	event = create_drop_event(no, x, y, type, id, num)
	return unless event
	
	event.es_set_graphic(choose_item_icon(item), 255, 0)
	event.name = num <= 1 ? "[id#{item.name}]" : "[id#{item.name} #{num}개]"
	event.refresh
end

def create_moneys2(no, x, y, money)
	return if money == 0
	
	event = create_drop_event(no, x, y, 3, money, money)
	return unless event
	
	event.es_set_graphic(choose_money_icon(money), 255, 0)
	event.name = "[id#{money}전]" 
	event.refresh	
end

def create_drop_event(no, x, y, type, id, amount)
  event = Game_Event.new($game_map.map_id, load_data("Data/Map022.rxdata").events[1])
  return unless event
  
  $game_map.events[no] = event
	
  $Drop[no] = Drop.new
  $Drop[no].id = id
  $Drop[no].type = type
  $Drop[no].amount = amount
	
  event.id = no
  event.moveto(x, y)
  create_sprite(event, true)
  event
end

def choose_item_icon(item)
	return "../Icons/#{item.icon_name}"
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
	return unless event
	
	remove_sprite(event) 
	$game_map.events.delete(event.id) 
end

def create_sprite(c, sw = false)
	return unless $scene.is_a?(Scene_Map)
	
	$scene.instance_eval do
		@spriteset.instance_eval do
			return if @character_sprites.nil?
			
			sprite = @character_sprites.find { |v| v.character == c }
			return sprite if sprite
			
			sprite = Sprite_Character.new(@viewport1, c, sw)
			@character_sprites.push(sprite)
		end
	end
end

def remove_sprite(event)
	return unless $scene.is_a?(Scene_Map)
	
	$scene.instance_eval do
		@spriteset.instance_eval do
			delv = @character_sprites.find { |v| v.character == event }
			next unless delv
			
			delv.dispose
			@character_sprites.delete(delv)
		end
	end
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
		update_item_sprite
	end
	
	def update_item_sprite
		# If tile ID, file name, or hue are different from current ones
		return if !@is_item
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