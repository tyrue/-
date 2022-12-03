#================================================= 
# ■ 아이디를 띄우기 (스프라이트 구현) 
#================================================= 

class Game_Event < Game_Event 
	def name=(name)
		@event.name = name
	end
	
	def refresh 
		super 
		text = @event.name.dup 
		text.gsub!(/\[[Ii][Dd](.+?)\]/) do 
			@sprite_id = $1 
		end 
		@sprite_id = nil if @erased 
		@sprite_id = nil if @character_name == "" 
	end 
end 

class Game_Character 
	attr_accessor :sprite_id 
end 

class Sprite_Character < Sprite_Character
	attr_accessor :_id_sprite
	
	def create_id_sprite(text) 
		bitmap = Bitmap.new(160, 20) 
		bitmap.font.name = "맑은 고딕" 
		bitmap.font.size = 16
		bitmap.font.color.set(0, 0, 0) 
		bitmap.draw_frame_text(+1, +1, 160, 20, text, 1) 
		bitmap.font.color.set(255, 255, 255) 
		bitmap.draw_frame_text(0, 0, 160, 20, text, 1) 
		
		@_id_sprite = Sprite.new(self.viewport) 
		@_id_sprite.bitmap = bitmap 
		@_id_sprite.ox = 80 
		@_id_sprite.oy = 20
		@_id_sprite.x = self.x 
		@_id_sprite.y = self.y - self.oy / 2 
		@_id_sprite.z = 3000 
		if $game_variables[11] == 0
			@_id_sprite.visible = false 
		else
			@_id_sprite.visible = true
		end
	end 
	
	def dispose_id_sprite 
		@_id_sprite.visible = false 
		@_id_sprite.dispose 
		@_id_sprite = nil
	end 
	
	def update_id_sprite 
		if @character.sprite_id != nil
			if @_id_sprite == nil
				create_id_sprite(@character.sprite_id)
			end
			if !@_id_sprite.disposed?
				@_id_sprite.x = self.x 
				@_id_sprite.y = self.y - self.oy 
			end
		else 
			if @_id_sprite != nil and !@_id_sprite.disposed?
				dispose_id_sprite 
			end 
		end 
	end 
	
	def toggle_id
		return if @_id_sprite == nil or @_id_sprite.disposed?
		if $game_variables[11] == 0
			@_id_sprite.visible = false 
		else
			@_id_sprite.visible = true
		end
	end
	
	def update 
		super 
		update_id_sprite 
	end 
end 


class Spriteset_Map
	def toggle_id
		if $game_variables[11] == 0
			$game_variables[11] = 1
		else
			$game_variables[11] = 0
		end
		
		for sprite in @character_sprites
			sprite.toggle_id
		end
	end
end