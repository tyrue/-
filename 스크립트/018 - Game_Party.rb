#============================================================================== 
# ■ Game_Party 
#------------------------------------------------------------------------------ 
# 　파티를 취급하는 클래스입니다. 골드나 아이템등의 정보가 포함됩니다. 이 쿠 
# 라스의 인스턴스는 $game_party 로 참조됩니다. 
#============================================================================== 

class Game_Party 
	#-------------------------------------------------------------------------- 
	# ● 공개 인스턴스 변수 
	#-------------------------------------------------------------------------- 
	attr_reader  :actors                  # 엑터 
	attr_reader  :gold                    # 골드 
	attr_reader  :steps                    # 보수 
	#-------------------------------------------------------------------------- 
	# ● 오브젝트 초기화 
	#-------------------------------------------------------------------------- 
	def initialize 
		# 엑터의 배열을 작성 
		@actors = [] 
		# 골드와 보수를 초기화 
		@gold = 0 
		@steps = 0 
		# 아이템, 무기, 방어용 기구의 소지수해시를 작성 
		@items = {} 
		@weapons = {} 
		@armors = {} 
	end 
	#-------------------------------------------------------------------------- 
	# ● 초기 파티의 셋업 
	#-------------------------------------------------------------------------- 
	def setup_starting_members 
		@actors = [] 
		for i in $data_system.party_members 
			@actors.push($game_actors[i]) 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 전투 테스트용 파티의 셋업 
	#-------------------------------------------------------------------------- 
	def setup_battle_test_members 
		@actors = [] 
		for battler in $data_system.test_battlers 
			actor = $game_actors[battler.actor_id] 
			actor.level = battler.level 
			gain_weapon(battler.weapon_id, 1) 
			gain_armor(battler.armor1_id, 1) 
			gain_armor(battler.armor2_id, 1) 
			gain_armor(battler.armor3_id, 1) 
			gain_armor(battler.armor4_id, 1) 
			actor.equip(0, battler.weapon_id) 
			actor.equip(1, battler.armor1_id) 
			actor.equip(2, battler.armor2_id) 
			actor.equip(3, battler.armor3_id) 
			actor.equip(4, battler.armor4_id) 
			@actors.push(actor) 
		end 
		@items = {} 
		for i in 1...$data_items.size 
			if $data_items[i]. name != "" 
				occasion = $data_items[i]. occasion 
				if occasion == 0 or occasion == 1 
					@items[i] = 99 
				end 
			end 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 파티 멤버의 리프레쉬 
	#-------------------------------------------------------------------------- 
	def refresh 
		# 게임 데이터를 로드한 직후는 엑터 오브젝트가 
		# $game_actors 로부터 분리해 버리고 있다. 
		# 로드마다 엑터를 재설정하는 것으로 문제를 회피한다. 
		for i in 0...@actors.size 
			@actors[i] = $game_actors[@actors[i]. id] 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 최대 레벨의 취득 
	#-------------------------------------------------------------------------- 
	def max_level 
		# 파티 인원수가 0 명의 경우 
		if @actors.size == 0 
			return 0 
		end 
		# 로컬 변수 level 를 초기화 
		level = 0 
		# 파티 멤버의 최대 레벨을 요구한다 
		for actor in @actors 
			if level < actor.level 
				level = actor.level 
			end 
		end 
		return level 
	end 
	#-------------------------------------------------------------------------- 
	# ● 엑터를 가세한다 
	#    actor_id : 엑터 ID 
	#-------------------------------------------------------------------------- 
	def add_actor(actor_id) 
		# 엑터를 취득 
		actor = $game_actors[actor_id] 
		# 파티 인원수가 4 명 미만으로, 이 엑터가 파티에 없는 경우 
		if @actors.size < 4 and not @actors.include? (actor) 
			# 엑터를 추가 
			@actors.push(actor) 
			# 플레이어를 리프레쉬 
			$game_player.refresh 
			
		end  
	end 
	#-------------------------------------------------------------------------- 
	# ● 엑터를 제외한다 
	#    actor_id : 엑터 ID 
	#-------------------------------------------------------------------------- 
	def remove_actor(actor_id) 
		# 엑터를 삭제 
		@actors.delete($game_actors[actor_id]) 
		# 플레이어를 리프레쉬 
		$game_player.refresh 
	end 
	#-------------------------------------------------------------------------- 
	# ● 골드의 증가 (감소) 
	#    n : 금액 
	#-------------------------------------------------------------------------- 
	def gain_gold(n) 
		#-------------------------------------------------------------------------- 
		@gold = [[@gold + n, 0]. max, 999999999999]. min#수정해야함!현재 9999억까지. 
		#좀더 늘리고싶다면 
		#위에 999999999999에 9를 더 붙여주세요. 
		#-------------------------#수정해야할부분#-------------------------------- 
	end 
	#-------------------------------------------------------------------------- 
	# ● 골드의 감소 
	#    n : 금액 
	#-------------------------------------------------------------------------- 
	def lose_gold(n) 
		# 수치를 역전해 gain_gold 를 부른다 
		gain_gold(-n) 
	end 
	#-------------------------------------------------------------------------- 
	# ● 보수 증가 
	#-------------------------------------------------------------------------- 
	def increase_steps 
		@steps = [@steps + 1, 9999999]. min 
	end 
	#-------------------------------------------------------------------------- 
	# ● 아이템의 소지수취득 
	#    item_id : 아이템 ID 
	#-------------------------------------------------------------------------- 
	def item_number(item_id) 
		# 해시에 개수 데이터가 있으면 그 수치를, 없으면 0 을 돌려준다 
		return @items.include? (item_id) ?  @items[item_id] : 0 
	end 
	#-------------------------------------------------------------------------- 
	# ● 무기의 소지수취득 
	#    weapon_id : 무기 ID 
	#-------------------------------------------------------------------------- 
	def weapon_number(weapon_id) 
		# 해시에 개수 데이터가 있으면 그 수치를, 없으면 0 을 돌려준다 
		return @weapons.include? (weapon_id) ?  @weapons[weapon_id] : 0 
	end 
	#-------------------------------------------------------------------------- 
	# ● 방어용 기구의 소지수취득 
	#    armor_id : 방어용 기구 ID 
	#-------------------------------------------------------------------------- 
	def armor_number(armor_id) 
		# 해시에 개수 데이터가 있으면 그 수치를, 없으면 0 을 돌려준다 
		return @armors.include? (armor_id) ?  @armors[armor_id] : 0 
	end 
	#-------------------------------------------------------------------------- 
	# ● 아이템의 증가 (감소) 
	#    item_id : 아이템 ID 
	#    n      : 개수 
	#-------------------------------------------------------------------------- 
	def gain_item(item_id, n) 
		# 해시의 개수 데이터를 갱신 
		if item_id > 0 
			@items[item_id] = [[item_number(item_id) + n, 0]. max, 99]. min 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 무기의 증가 (감소) 
	#    weapon_id : 무기 ID 
	#    n        : 개수 
	#-------------------------------------------------------------------------- 
	def gain_weapon(weapon_id, n) 
		# 해시의 개수 데이터를 갱신 
		if weapon_id > 0 
			@weapons[weapon_id] = [[weapon_number(weapon_id) + n, 0]. max, 99]. min 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 방어용 기구의 증가 (감소) 
	#    armor_id : 방어용 기구 ID 
	#    n        : 개수 
	#-------------------------------------------------------------------------- 
	def gain_armor(armor_id, n) 
		# 해시의 개수 데이터를 갱신 
		if armor_id > 0 
			@armors[armor_id] = [[armor_number(armor_id) + n, 0]. max, 99]. min 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 아이템의 감소 
	#    item_id : 아이템 ID 
	#    n      : 개수 
	#-------------------------------------------------------------------------- 
	def lose_item(item_id, n) 
		# 수치를 역전해 gain_item 를 부른다 
		gain_item(item_id, -n) 
	end 
	#-------------------------------------------------------------------------- 
	# ● 무기의 감소 
	#    weapon_id : 무기 ID 
	#    n        : 개수 
	#-------------------------------------------------------------------------- 
	def lose_weapon(weapon_id, n) 
		# 수치를 역전해 gain_weapon 를 부른다 
		gain_weapon(weapon_id, -n) 
	end 
	#-------------------------------------------------------------------------- 
	# ● 방어용 기구의 감소 
	#    armor_id : 방어용 기구 ID 
	#    n        : 개수 
	#-------------------------------------------------------------------------- 
	def lose_armor(armor_id, n) 
		# 수치를 역전해 gain_armor 를 부른다 
		gain_armor(armor_id, -n) 
	end 
	#-------------------------------------------------------------------------- 
	# ● 아이템의 사용 가능 판정 
	#    item_id : 아이템 ID 
	#-------------------------------------------------------------------------- 
	def item_can_use? (item_id) 
		# 아이템의 개수가 0 개의 경우 
		if item_number(item_id) == 0 
			# 사용 불능 
			return false 
		end 
		# 사용 가능시를 취득 
		occasion = $data_items[item_id]. occasion 
		# 배틀의 경우 
		if $game_temp.in_battle 
			# 사용 가능시가 0 (상시) 또는 1 (배틀만)이라면 사용 가능 
			return (occasion == 0 or occasion == 1) 
		end 
		# 사용 가능시가 0 (상시) 또는 2 (메뉴만)라면 사용 가능 
		return (occasion == 0 or occasion == 2) 
	end 
	#-------------------------------------------------------------------------- 
	# ● 전원의 액션 클리어 
	#-------------------------------------------------------------------------- 
	def clear_actions 
		# 파티 전원의 액션을 클리어 
		for actor in @actors 
			actor.current_action.clear 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 전멸 판정 
	#-------------------------------------------------------------------------- 
	def all_dead? 
		return false
		# 파티 인원수가 0 명의 경우 
		if $game_party.actors.size == 0 
			return false 
		end 
		# HP 0 이상의 엑터가 파티에 있는 경우 
		for actor in @actors 
			if actor.hp > 0 
				return false 
			end 
		end 
		# 전멸 
		return true 
	end 
	#-------------------------------------------------------------------------- 
	# ● 슬립 데미지 체크 (맵용) 
	#-------------------------------------------------------------------------- 
	def check_map_slip_damage 
		for actor in @actors 
			if actor.hp > 0 and actor.slip_damage? 
				actor.hp -= actor.maxhp / 100 
				if actor.hp == 0 
					$game_system.se_play($data_system.actor_collapse_se) 
				end 
				$game_screen.start_flash(Color.new(255,0,0,128), 4) 
			end 
		end 
	end 
	#-------------------------------------------------------------------------- 
	# ● 대상 엑터의 랜덤인 결정 
	#    hp0 : HP 0 의 엑터에게 한정한다 
	#-------------------------------------------------------------------------- 
	def random_target_actor(hp0 = false) 
		# 룰렛을 초기화 
		roulette = [] 
		# 루프 
		for actor in @actors 
			# 조건에 해당하는 경우 
			if (not hp0 and actor.exist? ) or (hp0 and actor.hp0? ) 
				# 엑터의 클래스의 [위치] 를 취득 
				position = $data_classes[actor.class_id]. position 
				# 전위 때 n = 4, 중웨이 때 n = 3, 후위 때 n = 2 
				n = 4 - position 
				# 룰렛에 엑터를 n 회추가 
				n.times do 
					roulette.push(actor) 
				end 
			end 
		end 
		# 룰렛의 사이즈가 0 의 경우 
		if roulette.size == 0 
			return nil 
		end 
		# 룰렛을 돌려, 엑터를 결정 
		return roulette[rand(roulette.size)] 
	end 
	#-------------------------------------------------------------------------- 
	# ● 대상 엑터의 랜덤인 결정 (HP 0) 
	#-------------------------------------------------------------------------- 
	def random_target_actor_hp0 
		return random_target_actor(true) 
	end 
	#-------------------------------------------------------------------------- 
	# ● 대상 엑터의 순조로운 결정 
	#    actor_index : 엑터 인덱스 
	#-------------------------------------------------------------------------- 
	def smooth_target_actor(actor_index) 
		# 엑터를 취득 
		actor = @actors[actor_index] 
		# 엑터가 존재하는 경우 
		if actor != nil and actor.exist? 
			return actor 
		end 
		# 루프 
		for actor in @actors 
			# 엑터가 존재하는 경우 
			if actor.exist? 
				return actor 
			end 
		end 
	end 
end 