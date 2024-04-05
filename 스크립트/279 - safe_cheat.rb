$safe_cheat_num = 2567
# 메모리상에는 실제 값 + num 으로 저장 되고 게임에서 볼때는 -num에서 보여주기

class Game_Party 
	#-------------------------------------------------------------------------- 
	# ● 아이템의 소지수취득 
	#    item_id : 아이템 ID 
	#-------------------------------------------------------------------------- 
	def item_number(item_id) 
		# 해시에 개수 데이터가 있으면 그 수치를, 없으면 0 을 돌려준다 
		return @items.include? (item_id) ?  @items[item_id] - $safe_cheat_num : 0 
	end 
	#-------------------------------------------------------------------------- 
	# ● 무기의 소지수취득 
	#    weapon_id : 무기 ID 
	#-------------------------------------------------------------------------- 
	def weapon_number(weapon_id) 
		# 해시에 개수 데이터가 있으면 그 수치를, 없으면 0 을 돌려준다 
		return @weapons.include? (weapon_id) ?  @weapons[weapon_id] - $safe_cheat_num : 0 
	end 
	#-------------------------------------------------------------------------- 
	# ● 방어용 기구의 소지수취득 
	#    armor_id : 방어용 기구 ID 
	#-------------------------------------------------------------------------- 
	def armor_number(armor_id) 
		# 해시에 개수 데이터가 있으면 그 수치를, 없으면 0 을 돌려준다 
		return @armors.include? (armor_id) ?  @armors[armor_id] - $safe_cheat_num : 0 
	end 
	
	def gold
		return @gold > 0 ? @gold - $safe_cheat_num : 0
	end
	
	#-------------------------------------------------------------------------- 
	# ● 골드의 증가 (감소) 
	#    n : 금액 
	#-------------------------------------------------------------------------- 
	def gain_gold(n) 
		#-------------------------------------------------------------------------- 
		@gold = [[gold + n, 0].max, 999999999999].min + $safe_cheat_num
		
		$console.write_line("금전 #{change_number_unit(-n)}전 감소. 현재 #{change_number_unit(gold)}전") if $login_check and n < 0
		$console.write_line("금전 #{change_number_unit(n)}전 증가. 현재 #{change_number_unit(gold)}전") if $login_check and n > 0
		자동저장 if $login_check
	end 
	#-------------------------------------------------------------------------- 
	# ● 아이템의 증가 (감소) 
	# item_id : 아이템 ID 
	# n : 개수 
	#-------------------------------------------------------------------------- 
	def gain_item(item_id, n) 
		# 해시의 개수 데이터를 갱신 
		if item_id > 0 
			limit_num = ITEM_LIMIT_NUM[item_id] != nil ? ITEM_LIMIT_NUM[item_id] : $item_maximum
			
			@items[item_id] = [[item_number(item_id) + n, 0].max, $item_maximum].min + $safe_cheat_num
			$console.write_line("#{$data_items[item_id].name}을(를) #{n}개 획득. 현재 #{$game_party.item_number(item_id)}개") if $login_check and n > 0
			$console.write_line("#{$data_items[item_id].name}을(를) #{-n}개 소모. 현재 #{$game_party.item_number(item_id)}개") if $login_check and n < 0
			자동저장 if $login_check
			$j_inven.sort if $j_inven != nil # 인벤토리 정렬
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 무기의 증가 (감소) 
	# weapon_id : 무기 ID 
	# n : 개수 
	#-------------------------------------------------------------------------- 
	def gain_weapon(weapon_id, n) 
		# 해시의 개수 데이터를 갱신 
		if weapon_id > 0 
			@weapons[weapon_id] = [[weapon_number(weapon_id) + n, 0].max, $item_maximum].min + $safe_cheat_num
			$console.write_line("#{$data_weapons[weapon_id].name}을(를) #{n}개 획득. 현재 #{$game_party.weapon_number(weapon_id)}개") if $login_check and n > 0
			$console.write_line("#{$data_weapons[weapon_id].name}을(를) #{-n}개 소모. 현재 #{$game_party.weapon_number(weapon_id)}개") if $login_check and n < 0
			자동저장 if $login_check
			$j_inven.sort if $j_inven != nil # 인벤토리 정렬
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 방어용 기구의 증가 (감소) 
	# armor_id : 방어용 기구 ID 
	# n : 개수 
	#-------------------------------------------------------------------------- 
	def gain_armor(armor_id, n) 
		# 해시의 개수 데이터를 갱신 
		if armor_id > 0 
			@armors[armor_id] = [[armor_number(armor_id) + n, 0].max, $item_maximum].min + $safe_cheat_num
			$console.write_line("#{$data_armors[armor_id].name}을(를) #{n}개 획득. 현재 #{$game_party.armor_number(armor_id)}개") if $login_check and n > 0
			$console.write_line("#{$data_armors[armor_id].name}을(를) #{-n}개 소모. 현재 #{$game_party.armor_number(armor_id)}개") if $login_check and n < 0
			자동저장 if $login_check
			$j_inven.sort if $j_inven != nil # 인벤토리 정렬
		end 
	end
end