#==============================================================================
# ■ Jindow_Shop_Menu
#------------------------------------------------------------------------------
#   상점 메뉴 진도우화 
#------------------------------------------------------------------------------
class Jindow_Shop_Menu < Jindow
	def initialize(shopData, eventId) # 상점 데이터, 이벤트 아이디
		$game_system.se_play($data_system.decision_se)
		super(0, 0, 200, 60)
		@head = true
		@mark = true
		@drag = true
		@close = true
		@event = $game_map.events[eventId]
		
		self.name = @event.sprite_id != nil ? @event.sprite_id : "상점"
		self.refresh "Shop_Menu_Window"
		self.x = (640 - self.max_width) / 6
		self.y = (480 - self.max_height) / 2
		
		@data = shopData
		@shop_button = J::Button.new(self).refresh(60, "물건 사기")
		@shop_button.x = 10
		@shop_button.y = 10
		
		@sell_button = J::Button.new(self).refresh(60, "물건 팔기")
		@sell_button.x = @shop_button.x + @shop_button.width + 5
		@sell_button.y = @shop_button.y
		
		@close_button = J::Button.new(self).refresh(60, "종료")
		@close_button.x = @sell_button.x + @sell_button.width + 5
		@close_button.y = @sell_button.y
	end
	
	def dispose
		$game_temp.message_proc.call if $game_temp.message_proc != nil
		$j_inven.setMode(0) if $j_inven != nil
		super
	end
	
	def update
		super
		if @shop_button.click
			@shop_button.click = false
			Hwnd.include?("Shop_Window") ? Hwnd.dispose("Shop_Window") : 0
			Jindow_Shop.new($game_temp.shop_goods, @event.id)
		end
		
		if @sell_button.click
			@sell_button.click = false
			Hwnd.include?("Shop_Window") ? Hwnd.dispose("Shop_Window") : 0
			
			# 인벤토리 모드 변경
			if $j_inven != nil
				$j_inven.show
				$j_inven.setMode(2)
			end
		end
		
		if @close_button.click
			@close_button.click = false
			Hwnd.include?("Shop_Window") ? Hwnd.dispose("Shop_Window") : 0
			Hwnd.dispose(self)
		end
	end
end

class Interpreter
	#--------------------------------------------------------------------------
	# * Shop Processing
	#--------------------------------------------------------------------------
	def command_302
		# Set battle abort flag
		$game_temp.battle_abort = true
		# Set shop calling flag
		$game_temp.shop_calling = true
		# Set goods list on new item
		$game_temp.shop_goods = [@parameters]
		
		$game_temp.message_proc = Proc.new { @message_waiting = false }
		@message_waiting = true
		# Loop
		loop do
			# Advance index
			@index += 1
			# If next event command has shop on second line or after
			if @list[@index].code == 605 or @list[@index].code == 302
				# Add goods list to new item
				$game_temp.shop_goods.push(@list[@index].parameters)
				# If event command does not have shop on second line or after
			else
				# End
				$temp_event_id = @event_id
				return false
			end
		end
	end
end

class Scene_Map
	
	#--------------------------------------------------------------------------
	# * Shop Call
	#--------------------------------------------------------------------------
	def call_shop
		# Clear shop call flag
		$game_temp.shop_calling = false
		Jindow_Shop_Menu.new($game_temp.shop_goods, $temp_event_id)
		$temp_event_id = 0
	end
end