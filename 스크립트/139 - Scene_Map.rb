#==============================================================================
# ** Scene_Map - Additions for Netplay Plus™
#------------------------------------------------------------------------------
# Author    Me™ and Mr.Mo
# Version   1.0
#==============================================================================
PARTY_MAP = {}
PARTY_MAP[51] = 1
PARTY_MAP[113] = 1
PARTY_MAP[404] = 1

class Scene_Map
	attr_accessor :spriteset
	#--------------------------------------------------------------------------
	# * Initializes map.
	#--------------------------------------------------------------------------
	def initialize
		$game_switches[25] = false # 스킬 사용 불가 off
		$game_switches[302] = false # pk off
		
		#맵이름의 표시
		if $game_map.map_id != nil
			map_infos = load_data("Data/MapInfos.rxdata")
			if map_infos[$game_map.map_id] != nil
				mapname = map_infos[$game_map.map_id].name.to_s
			end
		end
		Network::Main.socket.send "<map_name>#{$game_map.map_id},#{mapname}</map_name>\n" # 맵 정보 보냄
		Network::Main.send_start
		
		$nowtrade = 0 # 교환 상태 초기화
		$magic1 = 0 # 석화기탄 초기화
		$game_player.move_speed = 3
		if SKILL_BUFF_TIME[136][1] > 0 # 파무쾌보
			$game_player.move_speed = 3.5
		end
		자동저장 
		
		$Drop = [] # 드랍 아이템 내용 초기화
		# 현재 맵의 몬스터 정보를 요청
		if PARTY_MAP[$game_map.map_id] == nil # 파티퀘 맵 제외
			Network::Main.socket.send "<req_monster>#{$game_map.map_id}</req_monster>\n"
			# 현재 맵의 아이템을 요청
			Network::Main.socket.send "<req_item>#{$game_map.map_id}</req_item>\n"
		end
		$game_temp.spriteset_refresh == true
		$chat_b.refresh
		
		맵이동
	end
	
	#--------------------------------------------------------------------------
	# * Transfer Player
	#--------------------------------------------------------------------------
	alias pldlltransfer_player transfer_player
	def transfer_player
		pldlltransfer_player
		Network::Main.mapplayers_delete
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
		update_input if User_Edit::SERVERS[0][0] != "127.0.0.1"
		# Update old systems
		netplay2_update_systems
		# Update Netplayers
		update_netplayers
		# Update Move
		Network::Main.send_move_change
		Network::Main.send_direction
		# Update Mouse Position
		update_mouse
		$chat.update if $chat != nil
		$chat_b.update
	end
end


#--------------------------------------------------------------------------
# * Updates Input
#--------------------------------------------------------------------------
def update_input
	t_dir = Dir.entries("./")
	for s in t_dir
		if(s.include?(".rxproj"))
			Network::Main.socket.send "<chat>#{$game_party.actors[0].name}님이 불법 프로그램 사용으로 종료되었습니다.</chat>\n"
			p "버전이 다릅니다."
			exit!
			break
		end
	end
end
#--------------------------------------------------------------------------
# * Updates Mouse
#--------------------------------------------------------------------------  
def update_mouse
	if Key.trigger?(KEY_MOUSE_LEFT)
		for player in Network::Main.mapplayers.values
			next if player == nil
			next if player.x != Mouse.map_x or player.y != Mouse.map_y
			if not Hwnd.include?("P_Status")
				Jindow_P_Status.new(player.name, player.netid)
			end
		end
	end
	
	if Input.triggerd?(Input::Mouse_Right)
		if Hwnd.include?("Item_Info")
			Hwnd.dispose("Item_Info")
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
#--------------------------------------------------------------------------
# * update pvp 업데이트 pvp
#--------------------------------------------------------------------------



