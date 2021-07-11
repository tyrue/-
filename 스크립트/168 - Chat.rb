#~ # Chat
#~ # 백스프라이트 추가한 버전 (2008/12/13)
#~ # 제작: 류현 (NAVER swparkaust2)
#~ # 문의: psw0107_2@hotmail.com
#~ #       010-삼팔구일-오이육사
#~ class Chat
	#~ MAX_SCALE = 2
	#~ def initialize          # 채팅바의 표시 x, y, 채팅창 크기의 x, y
		#~ @viewport = Viewport.new(0, 360, 513, 200)
		#~ @viewport.z = 1000
		#~ @original_y = @viewport.rect.y
		#~ @original_height = @viewport.rect.height
		#~ @scale_count = 0
		#~ @chat_sprites = []
		#~ @back_sprite = Sprite.new(@viewport)
	#~ end
	#~ def write(text, color = COLOR_NORMAL, back_color = Color.new(0, 0, 0, 0))
		#~ scroll
		#~ sprite = Sprite_Chat.new(@viewport)
		#~ sprite.text = text
		#~ sprite.color = color
		#~ sprite.back_color = back_color
		#~ @chat_sprites.push(sprite)
	#~ end
	#~ def scroll
		#~ for sprite in @chat_sprites
			#~ sprite.y -= 16
		#~ end
	#~ end
	
	#~ def toggle
		#~ if @back_sprite.visible 
			#~ @back_sprite.visible = false
			#~ for sprite in @chat_sprites
				#~ sprite.visible = false
			#~ end
		#~ elsif
			#~ @back_sprite.visible = true
			#~ for sprite in @chat_sprites
				#~ sprite.visible = true
			#~ end
		#~ end
	#~ end
	
	#~ def clear
		#~ @back_sprite.dispose
		#~ for sprite in @chat_sprites
			#~ sprite.dispose
		#~ end
		#~ @chat_sprites.clear
	#~ end
	
	#~ def scale
		#~ @viewport.rect.y -= 32
		#~ @viewport.rect.height += 32
		#~ for sprite in @chat_sprites
			#~ sprite.y += 32
		#~ end
		#~ @scale_count += 1
		#~ if @scale_count > MAX_SCALE
			#~ @viewport.rect.y = @original_y
			#~ @viewport.rect.height = @original_height
			#~ for sprite in @chat_sprites
				#~ sprite.y -= 32 * @scale_count
			#~ end
			#~ @scale_count = 0
		#~ end
	#~ end
	
	#~ def update
		#~ if @back_sprite.bitmap != nil
			#~ @back_sprite.bitmap.dispose
		#~ end
		#~ @back_sprite.bitmap = Bitmap.new(@viewport.rect.width, @viewport.rect.height)
		#~ @back_sprite.bitmap.fill_rect(@back_sprite.bitmap.rect, Color.new(0, 0, 0, 100)) # 꽉찬 네모
		#~ @back_sprite.update
		#~ for sprite in @chat_sprites
			#~ sprite.update
		#~ end
		#~ @viewport.update
	#~ end
#~ end

#~ #$chat = Chat.new