#==============================================================================
# ** Scene_Map - Additions for Netplay Plus™
#------------------------------------------------------------------------------
# Author    Me™ and Mr.Mo
# Version   1.0
#==============================================================================
class Scene_Map
	attr_accessor :spriteset
	#--------------------------------------------------------------------------
	# * Initializes map.
	#--------------------------------------------------------------------------
	def initialize
		$game_temp.spriteset_refresh
		Network::Main.send_map
		Network::Main.socket.send "<npc>#{$game_map.map_id}</npc>\n"
		$game_variables[1003] = 0
		$nowtrade = 0
		$magic1 = 0 # 석화기탄 초기화
		$game_player.move_speed = 3
		자동저장 if not $game_party.actors[0].name == "평민"
	end
	
	#--------------------------------------------------------------------------
	# * Transfer Player
	#--------------------------------------------------------------------------
	alias pldlltransfer_player transfer_player
	def transfer_player
		pldlltransfer_player
		Network::Main.mapplayers_delete
		Network::Main.send_start
		# Freeze Graphics
		Graphics.freeze
		$scene = Scene_Reinit.new
		$game_temp.spriteset_renew = true
	end
	#--------------------------------------------------------------------------
	# * Updates Net/Map PLayers
	#--------------------------------------------------------------------------
	def update_netplayers
		return if Network::Main.mapplayers == {}
		for mapplayer in Network::Main.mapplayers.values
			next if mapplayer == nil
			mapplayer.update #if in_range?(mapplayer)
		end
	end
	#--------------------------------------------------------------------------
	# * Updates Systems
	#--------------------------------------------------------------------------
	alias netplay2_update_systems update_systems
	def update_systems
		# Update Network
		update_network
		# Update Mouse
		update_mouse if SDK.state("Path Finding") == true
		# Update Input
		update_input
		# Update old systems
		netplay2_update_systems
		# Update Netplayers
		update_netplayers
		# Update Move
		Network::Main.send_move_change
		# Update Mouse Position
		update_mouse
		$chat.update
	end
end


#--------------------------------------------------------------------------
# * Updates Input
#--------------------------------------------------------------------------
def update_input
	if Input.trigger?(Input::C)
		for player in Network::Main.mapplayers.values
			next if player == nil
			next if not face_too?(player)
			update_pvp if SDK.state('Player_vs_Player2')
		end
	end
end
#--------------------------------------------------------------------------
# * Updates Mouse
#--------------------------------------------------------------------------  
def update_mouse
	if Input.triggerd?(Input::Mouse_Left)
		if $game_player.mouse_passable?($game_player.x, $game_player.y, Mouse.map_x, Mouse.map_y)
			#$game_player.find_path(Mouse.map_x, Mouse.map_y)
		else
			for player in Network::Main.mapplayers.values
				next if player == nil
				next if player.x != Mouse.map_x or player.y != Mouse.map_y
				if not Hwnd.include?("P_Status")
					Jindow_P_Status.new(player.name, player.level, player.hp, player.maxhp, player.sp, player.maxsp, player.pci)
				end
			end
		end
	end
	if Input.triggerd?(Input::Mouse_Right)
		if Hwnd.include?("Item_Info")
			if Hwnd.include?("P_Status")
				Hwnd.dispose("Item_Info")
			else
				Hwnd.dispose("Item_Info")
			end
		elsif Hwnd.include?("P_Status")
			Hwnd.dispose("P_Status")
		end
	end
end

#--------------------------------------------------------------------------
# * Faceing and next too (object) ?
#--------------------------------------------------------------------------
def face_too?(events)
	new_x = $game_player.x + ($game_player.direction == 6 ? 1 : $game_player.direction == 4 ? -1 : 0)
	new_y = $game_player.y + ($game_player.direction == 2 ? 1 : $game_player.direction == 8 ? -1 : 0)
	# If event coordinates are consistent
	return true if events.x == new_x and events.y == new_y
	return false
end
#--------------------------------------------------------------------------
# * Updates Network
#-------------------------------------------------------------------------- 
def update_network
	Network::Main.update
end
#--------------------------------------------------------------------------
# * Checks the object range
#--------------------------------------------------------------------------
def in_range?(object)
	screne_x = $game_map.display_x 
	screne_x -= 256
	screne_y = $game_map.display_y
	screne_y -= 256
	screne_width = $game_map.display_x 
	screne_width += 2816
	screne_height = $game_map.display_y
	screne_height += 2176
	return false if object.real_x <= screne_x
	return false if object.real_x >= screne_width
	return false if object.real_y <= screne_y
	return false if object.real_y >= screne_height
	return true
end


=begin
    if $game_temp.spriteset_renew
      @spriteset.dispose
      @spriteset = nil
      @spriteset = Spriteset_Map.new
      $game_temp.spriteset_renew = false
      return
    end
=end

