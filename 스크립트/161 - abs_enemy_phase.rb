# 적의 페이즈 데이터 : [페이즈 체력 비율, 캐릭터파일이름, hue(색깔 변화)]
ABS_ENEMY_PHASE = {}
ABS_ENEMY_PHASE[102] = [[70.0, "반고1", 40], [40.0, "반고1", 225]] # 반고
ABS_ENEMY_PHASE[232] = [[50.0, "바람도적", 75]] # 산신대왕
ABS_ENEMY_PHASE[259] = [[60.0, "(보스, 가릉빈가, 1)", 75], [30.0, "(보스, 가릉빈가, 1)", 175]] # 가릉빈가

class MrMo_ABS
	def update_enemy_phase(enemy)
		return if ABS_ENEMY_PHASE[enemy.id] == nil
		data = ABS_ENEMY_PHASE[enemy.id][enemy.phase]
		return if data == nil
		if enemy.hp <= enemy.maxhp * data[0] / 100.0
			enemy.phase += 1
			enemy.event.character_name = data[1] if data[1] != nil and data[1] != ""
			enemy.event.character_hue = data[2] if data[2] != nil
		end
	end
end

#============================================================================
# * ABS Enemy
#============================================================================
class ABS_Enemy < Game_Battler
	attr_accessor :phase
	alias abs_phase_ini initialize
	def initialize(enemy_id)
		abs_phase_ini(enemy_id)
		@phase = 0
	end
end