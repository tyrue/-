
def 자동저장
	if not $game_party.actors[0].name == "평민"
		
		@skilllist = ""
		@itemlist = ""
		@weaponlist = ""
		@armorlist = ""
		@variablelist = ""
		@switchlist = ""
		
		
		for i in 0...$game_party.actors[0].skills.size
			skill = $game_party.actors[0].skills[i]
			@skilllist += ("#{skill},")
		end
		
		for i in 1...$data_items.size
			if $game_party.item_number(i) > 0
				item = $game_party.item_number(i)
				@itemlist += ("#{i},#{item}.")
			end
		end
		
		
		for i in 1...$data_weapons.size
			if $game_party.weapon_number(i) > 0
				weapon = $game_party.weapon_number(i)
				@weaponlist += ("#{i},#{weapon}.")
			end
		end
		
		
		for i in 1...$data_armors.size
			if $game_party.armor_number(i) > 0
				armor = $game_party.armor_number(i)
				@armorlist += ("#{i},#{armor}.")
			end
		end
		
		
		swlist = ""
		for sw in 0..350
			if $game_switches[sw] != nil
				if $game_switches[sw] == true
					swlist += ("1" + ",")
				elsif $game_switches[sw] == false
					swlist += ("0" + ",")
				end
			end
		end
		
		valist = ""
		for va in 0..250
			if $game_variables[va] != nil
				valist += ($game_variables[va].to_s + ",")
			end
		end
		
		Network::Main.socket.send("<userdata>흑부엉 서버|#{$game_party.actors[0].name}|#{$game_party.actors[0].class_id}|#{$game_party.actors[0].level}|#{$game_party.actors[0].exp}|#{$game_party.actors[0].str}|#{$game_party.actors[0].dex}|#{$game_party.actors[0].agi}|#{$game_party.actors[0].int}|#{$game_party.actors[0].maxhp}|#{$game_party.actors[0].maxsp}|#{$game_map.map_id}|#{$game_player.x}|#{$game_player.y}|#{$game_player.direction}|#{$game_player.character_name}|#{$game_party.actors[0].weapon_id}|#{$game_party.actors[0].armor1_id}|#{$game_party.actors[0].armor2_id}|#{$game_party.actors[0].armor3_id}|#{$game_party.actors[0].armor4_id}|#{@itemlist}|#{@weaponlist}|#{@armorlist}|#{@skilllist}|#{$game_party.gold}|#{$game_party.actors[0].hp}|#{$game_party.actors[0].sp}|#{swlist}|#{valist}</userdata>\n")
	end
end