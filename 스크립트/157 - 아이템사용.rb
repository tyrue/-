class MrMo_ABS
	def item_event(id)
		case id
		when 4 # 소환비서
			x = $game_player.x 
			y = $game_player.y
			x = x + ($game_player.direction == 4 ? -1 : $game_player.direction == 6 ? 1 : 0)
			y = y + ($game_player.direction == 2 ? 1 : $game_player.direction == 8 ? -1 : 0)
			# 여기서 다른 유저가 내 앞에 있는지 확인해야함
			for player in Network::Main.mapplayers.values
				next if player == nil
				if player.x == x and player.y == y
					Network::Main.socket.send("<item_summon>#{player.name},#{$game_player.x},#{$game_player.y}</item_summon>\n")
				end
			end
		end
	end
end

class Game_Battler
	alias abs_item_event item_effect
	def item_effect(item)
		$ABS.item_event(item.id)
		abs_item_event(item)
	end
end