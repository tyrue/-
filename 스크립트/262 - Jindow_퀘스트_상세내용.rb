$mon_val_start = 300
class Jindow_Quest_Detail < Jindow
	
	def initialize(data)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 250, 300)
		self.name = ""
		@head = true
		@mark = true
		@drag = true
		@close = true
		
		@data = data
		
		#~ "title" => "제목1", 						# 퀘스트 제목
		#~ "body" => "ㅇㅇㅇ을 잡아야 한다",			# 퀘스트 내용
		#~ "region" => "부여성",						# 퀘스트 위치
		#~ "requester" => "테스터", 				# 의뢰자 이름
		
		#~ "monster_data" => [[4, 50]],			# [[잡아야하는 몬스터 id, 수], ...]
		#~ "item_data" => [[2, 3, 50]]			# [[필요한 아이템 타입, id, 필요개수], ...]
		
		for d in @data
			key = d[0]
			value = d[1]
			
			case key
			when "title"
				font_size = 14
				@title = Sprite.new(self)
				@title.bitmap = Bitmap.new(self.width, font_size)
				@title.bitmap.font.size = font_size
				@title.bitmap.font.color.set(0, 0, 0, 255)
				@title.bitmap.draw_text(0, 0, @title.width, @title.height, "[" + value + "]", 0)
				
			when "region"
				font_size = 12
				@region = Sprite.new(self)
				@region.bitmap = Bitmap.new(self.width, font_size)
				@region.bitmap.font.size = font_size
				@region.bitmap.font.color.set(140, 0, 0, 255)
				@region.bitmap.draw_text(0, 0, @region.width, @region.height, "지역 : " + value, 0)
				
			when "requester"
				font_size = 12
				@requester = Sprite.new(self)
				@requester.bitmap = Bitmap.new(self.width, font_size)
				@requester.bitmap.font.size = font_size
				@requester.bitmap.font.color.set(0, 0, 0, 255)
				@requester.bitmap.draw_text(0, 0, @requester.width, @requester.height, "의뢰자 : " + value, 0)
				
			when "body"
				font_size = 14
				@body_title = Sprite.new(self)
				@body_title.bitmap = Bitmap.new(self.width, font_size)
				@body_title.bitmap.font.size = font_size
				@body_title.bitmap.font.color.set(0, 101, 155, 255)
				@body_title.bitmap.draw_text(0, 0, @body_title.width, @body_title.height, "임무 내용", 0)
				
				font_size = 12
				@body = Sprite.new(self)
				@body.bitmap = Bitmap.new(self.width, font_size * 3)
				@body.bitmap.font.size = font_size
				@body.bitmap.font.color.set(0, 0, 0, 255)
				s_y = (font_size - @body.height) / 2
				
				i = 1
				for txt in value
					@body.bitmap.draw_text(0, s_y + (font_size) * i, @body.width, @body.height, txt, 0)
					i += 1
				end
				
			when "monster_data"
				font_size = 12
				@mon_data = value
				
				@monster_data = []
				@mon_now_num = []
				
				i = 0
				for mon_d in value
					id = mon_d[0]
					num = mon_d[1]
					mon_name = $data_enemies[id].name
					@mon_now_num[i] = $game_variables[id + $mon_val_start]
					
					@monster_data[i] = Sprite.new(self)
					@monster_data[i].bitmap = Bitmap.new(self.width, font_size)
					@monster_data[i].bitmap.font.size = font_size
					
					rate = @mon_now_num[i] * 100 / num
					@monster_data[i].bitmap.font.color.set(0, 0, 0, 255)
					@monster_data[i].bitmap.font.color.set(88, 44, 146, 255) if rate >= 50
					@monster_data[i].bitmap.font.color.set(255, 176, 37, 255) if rate >= 80
					@monster_data[i].bitmap.font.color.set(61, 255, 61, 255) if rate >= 100
					
					@monster_data[i].bitmap.draw_text(0, 0, @monster_data[i].width, font_size, mon_name + " : " + @mon_now_num[i].to_s + " / " + num.to_s, 0)
					i += 1
				end
				
			when "item_data"
				@i_data = value
				
				font_size = 12
				@item_bitmap = Bitmap.new(self.width, font_size)
				@item_bitmap.font.size = font_size
				@item_bitmap.font.color.set(0, 0, 0, 255)
				
				@item_data = []
				@now_item_num = []
				i = 0
				for item_d in value
					type = item_d[0]
					id = item_d[1]
					num = item_d[2]
					
					@now_item_num[i] = 0
					name = ""
					case type
					when 0 # 아이템
						name = $data_items[id].name
						@now_item_num[i] = $game_party.item_number(id)
					when 1 # 무기
						name = $data_weapons[id].name
						@now_item_num[i] = $game_party.weapon_number(id)
					when 2 # 방어구
						name = $data_armors[id].name
						@now_item_num[i] = $game_party.armor_number(id)
					when 3 # 돈
						name = "금전"
						@now_item_num[i] = $game_party.gold
					end
					
					@item_data[i] = Sprite.new(self)
					@item_data[i].bitmap = Bitmap.new(self.width, font_size)					
					@item_data[i].bitmap.font.size = font_size
					@item_data[i].bitmap.font.color.set(0, 0, 0, 255)
					
					rate = @now_item_num[i] * 100 / num
					@item_data[i].bitmap.font.color.set(88, 44, 146, 255) if rate >= 50
					@item_data[i].bitmap.font.color.set(255, 176, 37, 255) if rate >= 80
					@item_data[i].bitmap.font.color.set(61, 255, 61, 255) if rate >= 100
					
					@item_data[i].bitmap.draw_text(0, 0, @item_data[i].width, font_size, name + " : " + @now_item_num[i].to_s + " / " + num.to_s, 0)
					i += 1
				end
			end
		end
		
		# 각 요소들 위치 조정
		@start_x = 10
		@start_y = 10
		
		if @title != nil
			@title.x = @start_x
			@title.y = @start_y
			
			@start_x = @title.x
			@start_y = @title.y + @title.height + 10
		end
		
		if @region != nil
			@region.x = @start_x
			@region.y = @start_y
			
			@start_x = @region.x
			@start_y = @region.y + @region.height + 5
		end
		
		if @requester != nil
			@requester.x = @start_x
			@requester.y = @start_y
			
			@start_x = @requester.x
			@start_y = @requester.y + @requester.height + 15
		end
		
		if @body != nil
			@body_title.x = @start_x
			@body_title.y = @start_y
			
			@body.x = @start_x
			@body.y = @start_y + 5
			
			@start_x = @body.x
			@start_y = @body.y + @body.height + 20
		end
		
		if @monster_data != nil
			i = 0
			for mon in @monster_data
				mon.x = @start_x
				mon.y = @start_y + i * 20
				i += 1
			end
			
			@start_x = @monster_data[@monster_data.size - 1].x
			@start_y = @monster_data[@monster_data.size - 1].y + @monster_data[@monster_data.size - 1].height + 20
		end
		
		if @item_data != nil
			i = 0
			for item in @item_data
				item.x = @start_x
				item.y = @start_y + i * 20
				i += 1
			end
		end
		
		self.x = 100
		self.y = 100
		self.refresh "Quest_Detail"
	end
	
	def update
		super
		if @mon_data != nil
			i = 0
			for mon_d in @mon_data
				id = mon_d[0]
				num = mon_d[1]
				font_size = 12
				
				if @mon_now_num[i] != $game_variables[id + $mon_val_start]
					
					@monster_data[i].bitmap.clear
					@monster_data[i].bitmap = Bitmap.new(self.width, font_size)
					@monster_data[i].bitmap.font.size = font_size
					
					rate = @mon_now_num[i] * 100 / num
					@monster_data[i].bitmap.font.color.set(0, 0, 0, 255)
					@monster_data[i].bitmap.font.color.set(88, 44, 146, 255) if rate >= 49
					@monster_data[i].bitmap.font.color.set(255, 176, 37, 255) if rate >= 79
					@monster_data[i].bitmap.font.color.set(61, 255, 61, 255) if rate >= 99
					
					mon_name = $data_enemies[id].name
					@mon_now_num[i] = $game_variables[id + $mon_val_start]
					@monster_data[i].bitmap.draw_text(0, 0, @monster_data[i].width, font_size, mon_name + " : " + @mon_now_num[i].to_s + " / " + num.to_s, 0)
				end
				i += 1
			end
		end
		
		
		if @item_data != nil		
			i = 0
			for item_d in @i_data
				type = item_d[0]
				id = item_d[1]
				num = item_d[2]
				font_size = 12
				
				name = ""
				i_num = 0
				case type
				when 0 # 아이템
					name = $data_items[id].name
					i_num = $game_party.item_number(id)
				when 1 # 무기
					name = $data_weapons[id].name
					i_num = $game_party.weapon_number(id)
				when 2 # 방어구
					name = $data_armors[id].name
					i_num = $game_party.armor_number(id)
				when 3 # 돈
					name = "금전"
					i_num = $game_party.gold
				end
				
				if @now_item_num[i] != i_num
					@item_data[i].bitmap.clear
					@item_data[i].bitmap = Bitmap.new(self.width, font_size)					
					@item_data[i].bitmap.font.size = font_size
					@item_data[i].bitmap.font.color.set(0, 0, 0, 255)
					@now_item_num[i] = i_num
					
					rate = @now_item_num[i] * 100 / num
					@item_data[i].bitmap.font.color.set(88, 44, 146, 255) if rate >= 50
					@item_data[i].bitmap.font.color.set(255, 176, 37, 255) if rate >= 80
					@item_data[i].bitmap.font.color.set(61, 255, 61, 255) if rate >= 100
					
					@item_data[i].bitmap.draw_text(0, 0, @item_data[i].width, font_size, name + " : " + @now_item_num[i].to_s + " / " + num.to_s, 0)
				end
				i += 1
			end
		end
	end	
end