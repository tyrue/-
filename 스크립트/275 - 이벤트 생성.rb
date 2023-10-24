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
		Network::Main.socket.send("<monster2>#{$game_map.map_id},#{id},#{monster_id}</monster2>\n")
	end
end

# 운영자가 소환하는 몬스터, 한 번 잡으면 서버에서 삭제시키도록 하자
def create_abs_monsters_admin(monster_id, num)
	x = $game_player.x
	y = $game_player.y
	r = 12
	
	for i in 0...num
		count = 0
		while count < 10000
			count += 1
			x2 = x + rand(r) - r / 2
			y2 = y + rand(r) - r / 2
			d = (rand(4) + 1) * 2
			
			if $game_map.passable?(x2, y2, d)
				e = create_events(16, x2, y2, d, -1, monster_id)
				return if e == nil
				e.list[1].parameters[0] = "ID #{monster_id}"
				Network::Main.socket.send("<monster2>#{$game_map.map_id},#{e.id},#{monster_id},#{x2},#{y2},-1</monster2>\n")
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
	event.moveto(x, y)
	event.direction = dir
	event.refresh_set_page
	create_sprite(event) 
	event.refresh
	return event
end


#drop 번호, 아이템 타입1, 아이템 타입2, 아이템 id, 맵 아이디, x좌표, y좌표
def create_drops(type, id, x, y, num = 1)
	d_id = check_drop_id
	Network::Main.socket.send "<Drop>#{d_id},1,#{type},#{id},#{$game_map.map_id},#{x},#{y},#{num}</Drop>\n" # 나를 포함한 전체 방송
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

def create_moneys(money, x, y)
	d_id = check_drop_id
	Network::Main.socket.send "<Drop>#{d_id},0,0,0,#{$game_map.map_id},#{x},#{y},#{money}</Drop>\n"
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