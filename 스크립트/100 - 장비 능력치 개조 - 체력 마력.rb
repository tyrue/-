module RPG
  class Weapon
		attr_accessor :hp_plus
    attr_accessor :sp_plus
		
		alias initialize_plus initialize
    def initialize
			@hp_plus = 0
			@sp_plus = 0
			initialize_plus
    end
  end
	
	class Armor
		attr_accessor :hp_plus
    attr_accessor :sp_plus
		
		alias initialize_plus initialize
    def initialize
			@hp_plus = 0
			@sp_plus = 0
			initialize_plus
    end
	end
end

# 무기 옵션 처리
class Set_Weapon_plus
	def initialize
		@data = {}
		@data[1] = [50, 30]					# 주작의 검
		@data[2] = [50, 30]     		# 백호의 검 
		@data[3] = [50, 30] 		# 현무의 검 
		@data[4] = [50, 30]    	# 청룡의 검 
		
		
		for d in @data
			id = d[0]
			hp = d[1][0]
			sp = d[1][1]
			
			$data_weapons[id].hp_plus = hp if hp != nil 
			$data_weapons[id].sp_plus = sp if sp != nil
		end
	end
end


# 장비 옵션 처리
class Set_Armor_plus
	def initialize
		@data = {}
		# 투구
		@data[2] = [0, 30]     		# 지력의투구1
		@data[15] = [100, 100]		# 수선도사 머리띠
		@data[18] = [200, 150]		# 용왕의투구 모조
		@data[19] = [200, 150]		# 청선투구
		@data[22] = [300, 200]		# 황금투구
		
		# 갑옷
		@data[1] = [1, 1]					# 초심자의갑주
		@data[12] = [500, 300] 		# 주술갑옷
		@data[13] = [100, 100]    # 남자타라의옷
		@data[14] = [700, 1000]		# 해골갑옷
		@data[30] = [5000, 3000]		# 가릉빈가의 날개옷
		@data[32] = [300, 1000]		# 현인의영혼
		
		
		# 장신구
		@data[16] = [80, 100]		# 수정귀걸이
		@data[17] = [100, 150]		# 용왕의반지 모조
		@data[20] = [200, 150]		# 청선팔찌
		@data[21] = [200, 150]		# 청선팔찌
		@data[23] = [300, 200]		# 황금팔찌
		
		# 방패
		@data[39] = [300, 200]		# 정화의방패
		
		for d in @data
			id = d[0]
			hp = d[1][0]
			sp = d[1][1]
			
			$data_armors[id].hp_plus = hp if hp != nil 
			$data_armors[id].sp_plus = sp if sp != nil
		end
	end
end


class Game_Actor
	# 장비 착용할 때 체력, 마력 추가 하기
	def change_hsp(base_equip = 0, change_equip = 0, type = -1)
		return if type == -1 
		case type
		when 0
			temp_hp = maxhp
			temp_sp = maxsp
			
			temp_hp -= $data_weapons[base_equip].hp_plus if $data_weapons[base_equip] != nil and $data_weapons[base_equip].hp_plus != nil
			temp_sp -= $data_weapons[base_equip].sp_plus if $data_weapons[base_equip] != nil and $data_weapons[base_equip].sp_plus != nil
			
			temp_hp += $data_weapons[change_equip].hp_plus if $data_weapons[change_equip] != nil and $data_weapons[change_equip].hp_plus != nil
			temp_sp += $data_weapons[change_equip].sp_plus if $data_weapons[change_equip] != nil and $data_weapons[change_equip].sp_plus != nil
				
			self.maxhp = temp_hp
			self.maxsp = temp_sp
		else
			temp_hp = maxhp
			temp_sp = maxsp
			
			temp_hp -= $data_armors[base_equip].hp_plus if $data_armors[base_equip] != nil and $data_armors[base_equip].hp_plus != nil
			temp_sp -= $data_armors[base_equip].sp_plus if $data_armors[base_equip] != nil and $data_armors[base_equip].sp_plus != nil
			
			temp_hp += $data_armors[change_equip].hp_plus if $data_armors[change_equip] != nil and $data_armors[change_equip].hp_plus != nil
			temp_sp += $data_armors[change_equip].sp_plus if $data_armors[change_equip] != nil and $data_armors[change_equip].sp_plus != nil
			
			self.maxhp = temp_hp
			self.maxsp = temp_sp
		end
	end
	
	alias edit_equip equip
	def equip(equip_type, id)
		case equip_type
		when 0  # Weapon
			if id == 0 or $game_party.weapon_number(id) > 0
				change_hsp(@weapon_id, id, equip_type)
				$game_party.gain_weapon(@weapon_id, 1)
				@weapon_id = id
				$game_party.lose_weapon(id, 1)
			end
		when 1  # Shield
			if id == 0 or $game_party.armor_number(id) > 0
				update_auto_state($data_armors[@armor1_id], $data_armors[id])
				change_hsp(@armor1_id, id, equip_type)
				$game_party.gain_armor(@armor1_id, 1)
				@armor1_id = id
				$game_party.lose_armor(id, 1)
			end
		when 2  # Head
			if id == 0 or $game_party.armor_number(id) > 0
				update_auto_state($data_armors[@armor2_id], $data_armors[id])
				change_hsp(@armor2_id, id, equip_type)
				$game_party.gain_armor(@armor2_id, 1)
				@armor2_id = id
				$game_party.lose_armor(id, 1)
			end
		when 3  # Body
			if id == 0 or $game_party.armor_number(id) > 0
				update_auto_state($data_armors[@armor3_id], $data_armors[id])
				change_hsp(@armor3_id, id, equip_type)
				$game_party.gain_armor(@armor3_id, 1)
				@armor3_id = id
				$game_party.lose_armor(id, 1)
			end
		when 4  # Accessory
			if id == 0 or $game_party.armor_number(id) > 0
				update_auto_state($data_armors[@armor4_id], $data_armors[id])
				change_hsp(@armor4_id, id, equip_type)
				$game_party.gain_armor(@armor4_id, 1)
				@armor4_id = id
				$game_party.lose_armor(id, 1)
			end
		end
	end
end
