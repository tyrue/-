
def 자동저장
	return if $game_map.map_id == 3
	return if $rpg_skill == nil
	if not $game_party.actors[0].name == "/no"
		@skilllist = ""
		@itemlist = ""
		@weaponlist = ""
		@armorlist = ""
		@valist = ""
		@swlist = ""
		@hotkeylist = ""
		@itemKeyList = ""
		@skill_mash_list = ""
		@buff_mash_list = ""
		@self_switches = ""
		
		if $skill_Delay_Console != nil and $skill_Delay_Console.console_log2.size <= 0 
			$rpg_skill.base_str = 0
			$rpg_skill.base_agi = 0
			$rpg_skill.base_int = 0
			$rpg_skill.base_dex = 0
		end
		
		$game_variables[52] = $rpg_skill.base_str
		$game_variables[53] = $rpg_skill.base_agi
		$game_variables[54] = $rpg_skill.base_int
		$game_variables[55] = $rpg_skill.base_dex
		
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
		
		for sw in 0..550
			if $game_switches[sw] != nil
				if $game_switches[sw] == true
					@swlist += ("1" + ",")
				elsif $game_switches[sw] == false
					@swlist += ("0" + ",")
				end
			end
		end
		
		for va in 0..500
			if $game_variables[va] != nil
				@valist += ($game_variables[va].to_s + ",")
			end
		end
		
		if $ABS != nil
			for i in $ABS.skill_keys.keys
				if $ABS.skill_keys[i] != nil
					@hotkeylist += ($ABS.skill_keys[i].to_s + ",")
				end
			end
		end
		
		if $ABS != nil
			for i in $ABS.item_keys.keys
				if $ABS.item_keys[i] != nil
					@itemKeyList += ($ABS.item_keys[i].to_s + ",")
				end
			end
		end
		
		for skill_mash_time in SKILL_MASH_TIME
			if skill_mash_time[1][1] > 0 
				@skill_mash_list += (skill_mash_time[0].to_s + "," + skill_mash_time[1][1].to_s + ".")
			end
		end
		
		for skill_mash_time in SKILL_BUFF_TIME
			if skill_mash_time[1][1] > 0 
				@buff_mash_list += (skill_mash_time[0].to_s + "," + skill_mash_time[1][1].to_s + ".")
			end
		end
		
		base_hp = $game_party.actors[0].take_base_maxhp
		base_sp = $game_party.actors[0].take_base_maxsp
		
		Network::Main.socket.send("<userdata>흑부엉 서버|#{$game_party.actors[0].name}|#{$game_party.actors[0].class_id}|#{$game_party.actors[0].level}|#{$game_party.actors[0].exp}|#{$game_party.actors[0].str}|#{$game_party.actors[0].dex}|#{$game_party.actors[0].agi}|#{$game_party.actors[0].int}|#{base_hp}|#{base_sp}|#{$game_map.map_id}|#{$game_player.x}|#{$game_player.y}|#{$game_player.direction}|#{$game_party.actors[0].character_name}|#{$game_party.actors[0].weapon_id}|#{$game_party.actors[0].armor1_id}|#{$game_party.actors[0].armor2_id}|#{$game_party.actors[0].armor3_id}|#{$game_party.actors[0].armor4_id}|#{@itemlist}|#{@weaponlist}|#{@armorlist}|#{@skilllist}|#{$game_party.gold}|#{$game_party.actors[0].hp}|#{$game_party.actors[0].sp}|#{@swlist}|#{@valist}|#{@hotkeylist}|#{@itemKeyList}|#{$game_party.actors[0].pdef}|#{$game_party.actors[0].mdef}|#{@skill_mash_list}|#{@buff_mash_list}|#{$cha_name}</userdata>\n")
	end
end