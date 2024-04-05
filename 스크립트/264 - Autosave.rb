def 자동저장
	return if 자동저장_준비가_필요한_상황?
	
	초기화_변수()
	
	기본_스킬_목록_생성()
	아이템_목록_생성()
	무기_목록_생성()
	방어구_목록_생성()
	스위치_목록_생성()
	변수_목록_생성()
	단축키_목록_생성()
	아이템키_목록_생성()
	
	스킬_밀기_목록_생성()
	버프_밀기_목록_생성()
	
	네트워크_데이터_전송()
end


def 자동저장_준비가_필요한_상황?
	$game_map.map_id == 3 || $rpg_skill.nil? || $game_party.actors[0].name == "/no"
end

def 초기화_변수
	@skilllist, @itemlist, @weaponlist, @armorlist, @valist, @swlist, @hotKeyList, @itemKeyList, @skill_mash_list, @buff_mash_list, @self_switches = [""] * 11
	
	초기화_스킬_지연_콘솔() if 스킬_지연_콘솔_비어있음?
	초기화_기본_스탯_변수()
end

def 초기화_스킬_지연_콘솔
	$rpg_skill.base_str = $rpg_skill.base_agi = $rpg_skill.base_int = $rpg_skill.base_dex = 0
end

def 스킬_지연_콘솔_비어있음?
	($skill_Delay_Console ? $skill_Delay_Console.console_log2 : nil).empty?
end

def 초기화_기본_스탯_변수
	$game_variables[52] = $rpg_skill.base_str
	$game_variables[53] = $rpg_skill.base_agi
	$game_variables[54] = $rpg_skill.base_int
	$game_variables[55] = $rpg_skill.base_dex
end


def 기본_스킬_목록_생성
	@skilllist = $game_party.actors[0].skills.join(",")
end

def 아이템_목록_생성
	@itemlist = (1...$data_items.size).map { |i| "#{i},#{$game_party.item_number(i)}." if $game_party.item_number(i) > 0 }.compact.join
end

def 무기_목록_생성
	@weaponlist = (1...$data_weapons.size).map { |i| "#{i},#{$game_party.weapon_number(i)}." if $game_party.weapon_number(i) > 0 }.compact.join
end

def 방어구_목록_생성
	@armorlist = (1...$data_armors.size).map { |i| "#{i},#{$game_party.armor_number(i)}." if $game_party.armor_number(i) > 0 }.compact.join
end

def 스위치_목록_생성
	# 스위치가 켜진것만 넣자
	@swlist = (0..1000).map { |sw| "#{sw}," if $game_switches[sw]}.compact.join
end

def 변수_목록_생성
	# 값이 있는 것만 넣자
	@valist = (0..1000).map { |va| "#{va},#{$game_variables[va]}." if $game_variables[va].is_a?(Integer) && $game_variables[va].to_i > 0 }.compact.join
end

def 단축키_목록_생성
	k = $ABS.skill_keys
	k.keys.each do |i|
		next if k[i] == 0
		@hotKeyList += "#{i},#{k[i]}.".to_s
	end
end

def 아이템키_목록_생성
	k = $ABS.item_keys
	k.keys.each do |i|
		next if k[i] == 0
		@itemKeyList += "#{i},#{k[i]}.".to_s
	end
end

def 스킬_밀기_목록_생성
	@skill_mash_list = SKILL_MASH_TIME.map { |skill_mash_time| "#{skill_mash_time[0]},#{skill_mash_time[1][1]}." if skill_mash_time[1][1] > 0 }.compact.join
end

def 버프_밀기_목록_생성
	@buff_mash_list = $game_party.actors[0].buff_time.map { |buff_time| "#{buff_time[0]},#{buff_time[1]}." if buff_time[1] > 0 }.compact.join
end

def 네트워크_데이터_전송
	actor = $game_party.actors[0]
	base_hp, base_sp = actor.take_base_maxhp, actor.take_base_maxsp
	userdata = {
		#"server_name" => "흑부엉 서버",
		"nickname" => actor.name,
		"class_id" => actor.class_id,
		"level" => actor.level,
		"exp" => actor.exp,
		"a_str" => actor.str,
		"a_dex" => actor.dex,
		"a_agi" => actor.agi,
		"a_int" => actor.int,
		"max_hp" => base_hp,
		"max_sp" => base_sp,
		"map_id" => $game_map.map_id,
		"player_x" => $game_player.x,
		"player_y" => $game_player.y,
		"player_direction" => $game_player.direction,
		"character_image" => actor.character_name,
		"weapon_id" => actor.weapon_id,
		"armor1_id" => actor.armor1_id,
		"armor2_id" => actor.armor2_id,
		"armor3_id" => actor.armor3_id,
		"armor4_id" => actor.armor4_id,
		"item_list" => @itemlist,
		"weapon_list" => @weaponlist,
		"armor_list" => @armorlist,
		"skill_list" => @skilllist,
		"gold" => $game_party.gold,
		"hp" => actor.hp,
		"sp" => actor.sp,
		"switch_list" => @swlist,
		"variable_list" => @valist,
		"hotkey_list" => @hotKeyList,
		"itemkey_list" => @itemKeyList,
		"physical_defense" => actor.pdef,
		"magical_defense" => actor.mdef,
		"skill_mash_list" => @skill_mash_list,
		"buff_mash_list" => @buff_mash_list,
		"character_name2" => $cha_name
	}
	
	
	message = "<userdata>"
	userdata.each { |key, value| message += "#{key}:#{value}|" }
	message += "</userdata>\n"
	
	Network::Main.socket.send(message)
end

