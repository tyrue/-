class MrMo_ABS
	def item_event(id)
		rpg = @actor.rpg_skill
		x, y, d = $game_player.x, $game_player.y, $game_player.direction
		
		case id
		when 4 # 소환비서
			new_x = x + (d == 4 ? -1 : d == 6 ? 1 : 0)
			new_y = y + (d == 2 ? 1 : d == 8 ? -1 : 0)
			
			Network::Main.mapplayers.values.each do |player| # 여기서 다른 유저가 내 앞에 있는지 확인해야함
				next unless player
				
				Network::Main.socket.send("<item_summon>#{player.name},#{x},#{y}</item_summon>\n") if player.x == new_x and player.y == new_y
			end
		when 21 # 산삼
			rpg.buff_active(71) # 혼신의힘
		when 67 # 갈색시약
			rpg.buff_active(46) # 무장
		when 68 # 초록시약
			rpg.buff_active(47) # 보호
		when 77 # 백억경
			@actor.exp += 10_000_000_000
		when 81 # 속도시약
			rpg.buff_active(99) # 속도시약 스킬 사용
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