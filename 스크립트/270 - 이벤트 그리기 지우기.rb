########################################################
## 제작자 : 비밀소년
## 비밀소년님 감사히 쓰겠습니다.
########################################################

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
