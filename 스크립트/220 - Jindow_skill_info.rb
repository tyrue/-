#----------------------------------------------------------------------------------
# *진도우 스킬창
#----------------------------------------------------------------------------------
class Jindow_Skill_Info < Jindow
	
	def initialize(data)
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 200, 100)
		@data = data
		self.name = "⊙ 스킬 정보 (#{@data.name})"
		@head = true
		@mark = true
		@drag = true
		@close = true
		
		self.x = Mouse.x + 5
		self.y = Mouse.y + 5
		self.refresh "Skill_Info"
		
		@button_key = J::Button.new(self).refresh(60, "단축키 지정")
		@button_key.x = 0
		@button_key.y = 0
		
		# 스킬명, 스킬 내용, 마나 소모량
		@s_info = [
			"이름 : #{@data.name}",
			"마력 #{@data.sp_cost}소모"
		]
		@s_info2 = []
		
		@d_x = 0
		@d_y = @button_key.y + @button_key.height
		for i in 0...@s_info.size
			@s_info2[i] = Sprite.new(self)
			@s_info2[i].bitmap = Bitmap.new(400, 20)
			@s_info2[i].bitmap.font.size = 13
			@s_info2[i].x = @d_x
			@s_info2[i].y = @d_y + (@s_info2[i].bitmap.font.size + 4) * i
			@s_info2[i].bitmap.font.alpha = 3
			@s_info2[i].bitmap.font.beta = 1
			@s_info2[i].bitmap.font.color.set(255, 255, 255, 255) 
			@s_info2[i].bitmap.font.gamma.set(0, 0, 0, 255)
			@s_info2[i].bitmap.draw_text(0, 0, @s_info2[i].width, @s_info2[i].height, @s_info[i].to_s, 0)
		end
		
		height = @s_info2[@s_info2.size - 1].y + @s_info2[@s_info2.size - 1].height + 10
		
		if @data.description != ""
			@description = Sprite.new(self)
			@description.y = @s_info2[@s_info2.size - 1].y + @s_info2[@s_info2.size - 1].height + 10				
			@description.bitmap = Bitmap.new(self.width, 80)
			@description.bitmap.font.color.set(255, 255, 255, 255)
			@description.bitmap.font.alpha = 3
			@description.bitmap.font.beta = 1
			@description.bitmap.font.gamma.set(0, 0, 0, 255)
			@description.bitmap.font.size = 14
			
			w = 0
			h = 0
			for i in @data.description.scan(/./)
				rect = @description.bitmap.text_size(i)
				if w + rect.width > self.width
					h += rect.height
					w = 0
					@description.bitmap.draw_text(w, h, rect.width, rect.height, i)
					w += rect.width
				else
					@description.bitmap.draw_text(w, h, rect.width, rect.height, i)
					w += rect.width
				end
			end
			height = @description.y + @description.height + 10
		end
		
		self.height = height
		self.refresh("Skill_Info")
	end
	
	def update
		super
		if @button_key != nil and @button_key.click
			if not Hwnd.include?("Keyset_menu")
				Jindow_Keyset_menu.new(@data.id, 3)
			else
				Hwnd.dispose("Keyset_menu")
				Jindow_Keyset_menu.new(@data.id, 3)
			end
		end
	end
	
end