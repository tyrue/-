#~ #=================================================
#~ # ■ 보관이벤트
#~ #-------------------------------------------------
#~ # 　제작자: 비밀소년
#~ #   p.s 안쓰는부분은 없앴음
#~ #=================================================
#~ def event_remove(event)
	#~ remove_sprite event
	#~ $game_map.events.delete event.id
#~ end

#~ def 소환물다지워!
	#~ for dst in 20001..20500
		#~ event = $game_map.events[dst]
		#~ remove_sprite event
		#~ $game_map.events.delete dst
	#~ end
#~ end

#~ def 보관이벤트(id)
	#~ for dst in 20001..20500
		#~ if $game_map.events[dst] == nil
			#~ return 보관이벤트_a(dst, id)
		#~ end
	#~ end
	#~ return nil
#~ end

#~ def 보관이벤트_a(dst, id)
	#~ if not $bo_map
		#~ $bo_map = load_data(sprintf("Data/Map022.rxdata", 1))
	#~ end
	#~ $game_map.instance_eval do
		#~ @events[dst] = Game_Event.new(@map_id, $bo_map.events[id])
	#~ end
	#~ $game_map.events[dst].instance_eval do
		#~ @id = dst
	#~ end
	#~ create_sprite $game_map.events[dst]
	#~ return $game_map.events[dst]
#~ end

#~ def create_sprite(c, sw = false)
	#~ if $scene.is_a?(Scene_Map)
		#~ $scene.instance_eval do
			#~ @spriteset.instance_eval do
				#~ return if @character_sprites == nil
				#~ @character_sprites.each do |v|
					#~ if v.character == c
						#~ return v
					#~ end
				#~ end
				#~ sprite = Sprite_Character.new(@viewport1, c, sw)
				#~ @character_sprites.push(sprite)
			#~ end
		#~ end
	#~ end
	#~ return nil
#~ end

#~ def remove_sprite(c)
	#~ if $scene.is_a?(Scene_Map)
		#~ $scene.instance_eval do
			#~ @spriteset.instance_eval do
				#~ delv = nil
				#~ @character_sprites.each do |v|
					#~ if v.character == c
						#~ delv = v
					#~ end
				#~ end
				#~ if delv
					#~ delv.dispose
					#~ @character_sprites.delete delv
				#~ end
			#~ end
		#~ end
	#~ end
	#~ return nil
#~ end


#~ class Sprite_Character
	#~ attr_accessor :is_item
	
	#~ alias sprite_item_initialize initialize
	#~ def initialize(viewport, character = nil, is_item = false)
		#~ sprite_item_initialize(viewport, character)
		#~ @is_item = is_item
	#~ end
	
	#~ alias sprite_item_update update
	#~ def update
		#~ sprite_item_update
		#~ # If tile ID, file name, or hue are different from current ones
		#~ if @is_item
			#~ # If graphic is character
			#~ if @tile_id == 0
				#~ @cw = bitmap.width
				#~ @ch = bitmap.height
				#~ self.ox = @cw / 2
				#~ self.oy = @ch
				
				#~ # Set rectangular transfer
				#~ sx = bitmap.width
				#~ sy = bitmap.height
				#~ self.src_rect.set(0, 0, sx, sy)
			#~ end
			#~ # Set sprite coordinates
			#~ self.x = @character.screen_x
			#~ self.y = @character.screen_y
			#~ self.z = @character.screen_z(@ch)
			
			#~ @is_item = false
		#~ end
	#~ end
#~ end