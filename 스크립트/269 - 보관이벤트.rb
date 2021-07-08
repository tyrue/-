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
	#$game_map.events[dst].moveto(rand($game_map.width), rand($game_map.height))
	create_sprite $game_map.events[dst]
	return $game_map.events[dst]
end

def create_sprite(c)
	if $scene.is_a?(Scene_Map)
		$scene.instance_eval do
			@spriteset.instance_eval do
				@character_sprites.each do |v|
					if v.character == c
						return v
					end
				end
				sprite = Sprite_Character.new(@viewport1, c)
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

class Game_Character 
	attr_accessor :item_sprite_id 
	attr_accessor :color
end 

class Sprite_Character
	alias id_item update
	def item_id(text, color) 
		@color = color
		bitmap = Bitmap.new(160, 16) 
		bitmap.font.name = "굴림" 
		bitmap.font.size = 12 
		bitmap.font.color.set(0, 0, 0) 
		bitmap.draw_text(+1, +1, 160, 16, text, 1) 
		if @color == "빨강"
			bitmap.font.color.set(255, 0, 0) 
		elsif @color == "초록"
			bitmap.font.color.set(0, 255, 0) 
		elsif @color == "파랑"
			bitmap.font.color.set(0, 0, 255)       
		elsif @color == "노랑"
			bitmap.font.color.set(255, 255, 0)       
		elsif @color == "주황"
			bitmap.font.color.set(200, 80, 80)             
		elsif @color == "흰색"
			bitmap.font.color.set(255, 255, 255)                   
		elsif @color == "갈색"
			bitmap.font.color.set(210, 145, 70)                         
		end    
		bitmap.draw_text(0, 0, 160, 16, text, 1) 
		@_id_item = Sprite.new(self.viewport) 
		@_id_item.bitmap = bitmap 
		@_id_item.ox = 80 
		@_id_item.oy = 14 
		@_id_item.x = self.x 
		@_id_item.y = self.y - self.oy / 2 
		@_id_item.z = 3000 
		@_id_item_visible = true 
	end 
	
	def dispose_id_item
		@_id_item.dispose 
		@_id_item_visible = false 
	end 
	
	def update_id_item
		if @character.item_sprite_id != nil 
			if not @_id_item_visible 
				item_id(@character.item_sprite_id, @character.color)
			end 
			@_id_item.x = self.x 
			@_id_item.y = self.y - self.oy 
		else 
			if @_id_item_visible 
				dispose_id_item
			end 
		end 
	end 
	
	def update 
		id_item
		update_id_item
	end 
end 

class Game_Event
	alias item_id_update update
	def update
		item_id_update
		if Input.press?(Input::ALT)
			text = @event.name.dup 
			text.gsub!(/\[[Ii][Tt][Ee][Mm](.+?),(.+?)\]/) do
				@item_sprite_id = $1
				if not @item_sprite_id == nil
					@color = $2.to_s
				end      
			end 
			@item_sprite_id = nil if @erased 
			@item_sprite_id = nil if @character_name == "" 
		else
			@item_sprite_id = nil
			@color = nil
		end 
	end  
end 
