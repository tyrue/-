module J
	class Item < Sprite
		attr_reader :id
		attr_reader :skin
		attr_reader :click
		attr_reader :double_click
		attr_reader :push
		attr_reader :item
		attr_reader :type
		attr_accessor :font
		
		def initialize(viewport = Viewport.new(0, 0, 640, 480), push = true)
			super(viewport, push)
			@id = viewport.item.index self
			@viewport = viewport
			@skin = viewport.skin
			@route = "Graphics/Icons/"
			@route2 = "Graphics/Jindow/" + @skin + "/Window/"
			@font = Font.new(User_Edit::FONT_DEFAULT_NAME, User_Edit::FONT_DEFAULT_SIZE)
			@font.alpha = 1
			@font.color.set(255, 255, 255, 255)
			@item = ""
			@num = 0
			@type = 0
			@fill = false
			@memory = nil
			@push = false
			@click = false
			@double_click = false
			@double_wait = 0
			@bluck = false
			@start = false
			
			@not_view_hwnd = [
				"Status",
				"NetPlayer_Info",
				"Shop_Window",
				"Shop_Window_Coin",
				"Trade",
				"Post"
			]
			return self
		end
		
		def refresh?
			return @start
		end
		
		def set(fill)
			@fill = fill
			return self
		end
		
		def bluck?
			return @bluck
		end
		
		def bluck=(val)
			if val and not @bluck
				@bluck = true
				self.tone.set(64, 64, 64)
				for i in self.viewport.item
					i == self ? next : 0
					i.JS? ? 0 : next
					i.bluck = false
				end
			elsif not val and @bluck
				@bluck = false
				self.tone.set(0, 0, 0)
			end
		end
		
		def refresh(id, type = 0, zm = 1.2)
			@start = true
			@type = type
			case @type
			when 0
				@item = $data_items[id]
			when 1
				@item = $data_weapons[id]
			when 2
				@item = $data_armors[id]
			end
			return if @item == nil 
			
			# 아이템 창 배경 비트맵
			win_bitmap = Bitmap.new(@route2 + "item_win")
			zoom = zm
			w = (win_bitmap.width * zoom).to_i
			h = (win_bitmap.height * zoom).to_i
			self.bitmap = Bitmap.new(w, h) 
			self.bitmap.stretch_blt(self.bitmap.rect, win_bitmap, win_bitmap.rect) 
			
			itemwin_mid = Sprite.new
			itemwin_mid.bitmap = Bitmap.new(@route2 + "itemwin_mid")
			self.bitmap.stretch_blt(self.bitmap.rect, itemwin_mid.bitmap, itemwin_mid.bitmap.rect)
			
			item_bitmap = Sprite.new
			if @item.icon_name == "" or @item.icon_name == nil
				@item.icon_name = "null"	
			end
			
			item_bitmap.bitmap = Bitmap.new(@route + @item.icon_name)
			w = (item_bitmap.bitmap.width * zoom).to_i
			h = (item_bitmap.bitmap.height * zoom).to_i
			item_zoom_bitmap = Bitmap.new(w, h)
			item_zoom_bitmap.stretch_blt(item_zoom_bitmap.rect, item_bitmap.bitmap, item_bitmap.bitmap.rect)
			
			difx = (self.bitmap.width - item_zoom_bitmap.width) / 2
			self.bitmap.blt(difx, 1, item_zoom_bitmap, item_zoom_bitmap.rect)
			
			win_bitmap.dispose
			itemwin_mid.dispose
			item_bitmap.dispose
			@memory = JS.get_bitmap(self)
			
			if @fill
				
			else
				
			end
			
			return self if !viewNum?
			
			@num = self.num
			# 아이템 개수 쓰기
			self.bitmap.font = @font
			self.bitmap.font.alpha = @font.alpha
			self.bitmap.font.beta = @font.beta
			self.bitmap.font.gamma = @font.gamma
			rect = self.bitmap.text_size(@num.to_s)
			self.bitmap.fill_rect(self.width - rect.width, self.height - rect.height, rect.width, rect.height, Color.new(0, 0, 0, 50)) # 꽉찬 네모
			self.bitmap.draw_text(0, self.height - rect.height, self.width, rect.height, @num.to_s, 2)
			return self
		end
		
		def id_set
			@id = viewport.item.index self
			return self
		end
		
		def update
			super
			self.refresh? ? 0 : return
			@click ? (@click = false) : 0
			@double_click ? (@double_click = false) : 0
			
			if not @viewport.hudle # 현재 진도우가 활성화 된 상태라면
				if Input.mouse_lbutton
					if not @push and Mouse.arrive_sprite_rect?(self) and @viewport.base? 
						@push = true
						self.bluck = true
					end
				else
					if @push and Mouse.arrive_sprite_rect?(self) and @viewport.base?
						@click = true
					end
					@push ? (@push = false) : 0
				end
				
				if Input.mouse_rbutton and Mouse.arrive_sprite_rect?(self)
					#jindow = Hwnd.include?("Item_Info")
					#jindow ? Hwnd.dispose("Item_Info") : 0
					jindow = Jindow_Item_Info.new(@item.id, @type, @viewport.hwnd)
					
					jindow.x = Mouse.x - jindow.max_width / 2
					jindow.x = [15, jindow.x].max
					if (jindow.x + jindow.width) > 620
						jindow.x -= (jindow.x + jindow.width - 620)
					end
					
					jindow.y = Mouse.y - jindow.max_height / 2
					jindow.y = [15, jindow.y].max
					if (jindow.y + jindow.height) > 460
						jindow.y -= (jindow.y + jindow.height - 460)
					end
				end
				
				if Mouse.arrive_sprite_rect?(self)
					if @item_name == nil
						@item_name = Sprite.new(@viewport)
						@item_name.x = self.x
						@item_name.y = self.y
						@item_name.z = 999999
						@item_name.bitmap = Bitmap.new(200, 14)
						@item_name.bitmap.font.size = 14
						rect = @item_name.bitmap.text_size(@item.name)
						if (@item_name.x + rect.width) > @viewport.width
							@item_name.x -= (@item_name.x + rect.width - @viewport.width)
						end
						@item_name.bitmap.fill_rect(rect, Color.new(0, 0, 0, 50))
						@item_name.bitmap.draw_frame_text(0, 0, @item_name.width, @item_name.height, @item.name, 0)
					end
					@item_name.opacity = 255
				else
					# 아이템 이름 감추기
					@item_name.opacity = 0 if @item_name != nil
				end
				
			else
				self.offName
			end
			
			if @click and @double_wait == 0
				@double_wait = 30
			elsif @double_wait > 0
				@double_wait -= 1
				if @click
					@double_click = true
					@double_wait = 0
				end
			end
			
			return if !viewNum?
			
			cnum = self.num
			if cnum == 0
				self.dispose
			end
			
			if @num != cnum
				@num = cnum
				self.bitmap.clear
				
				for x in 0..self.bitmap.width
					for y in 0..self.bitmap.height
						self.bitmap.set_pixel(x, y, @memory.color[x][y])
					end
				end
				
				if @num > 1 and (@viewport.hwnd == "Inventory")
					self.bitmap.font = @font
					self.bitmap.font.alpha = @font.alpha
					self.bitmap.font.beta = @font.beta
					self.bitmap.font.gamma = @font.gamma
					rect = self.bitmap.text_size(@num.to_s)
					self.bitmap.fill_rect(self.width - rect.width, self.height - rect.height, rect.width, rect.height, Color.new(0, 0, 0, 50)) # 꽉찬 네모
					self.bitmap.draw_text(0, self.height - rect.height, self.width, rect.height, @num.to_s, 2)
				end
			end
		end
		
		def viewNum?
			return false if @not_view_hwnd.include?(@viewport.hwnd)
			return true
		end
		
		def offName
			return if @item_name == nil
			return if @item_name.disposed?
			
			@item_name.visible = false
			@item_name.dispose 
			@item_name = nil
		end
		
		def offVisible
			self.visible = false
			self.offName
		end
		
		def dispose
			if @item_name != nil and !@item_name.disposed?
				@item_name.visible = false
				@item_name.dispose 
				@item_name = nil
			end
			super
		end
		
		def num
			number = 0
			case @type
			when 0
				number = $game_party.item_number(@item.id)
			when 1
				number = $game_party.weapon_number(@item.id)
			when 2
				number = $game_party.armor_number(@item.id)
			end
			if number == 0 and self.viewport.hwnd == "Status"
				case @type
				when 1
					$game_party.actors[0].weapon_id == @item.id ? (number = 1) : 0
				when 2
					$game_party.actors[0].armor1_id == @item.id ? (number = 1) : 0
					$game_party.actors[0].armor2_id == @item.id ? (number = 1) : 0
					$game_party.actors[0].armor3_id == @item.id ? (number = 1) : 0
					$game_party.actors[0].armor4_id == @item.id ? (number = 1) : 0
				end
			end
			return number
		end
		
		def click=(value)
			@click = value
			self.bluck = value
		end
		
		def double_click=(value)
			@double_click = value
			self.bluck = value
		end
	end
end
