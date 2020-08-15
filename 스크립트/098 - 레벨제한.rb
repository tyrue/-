#LV 한계 돌파
#
#처음에 거절하고 일어나시면 ，이 스크립트（script）를 사용한 것보다도
#자력으로 개조한 쪽이 ，다양 자유롭게 가능하다 하여 권장입니다．
#이기 때문에 ，참고 정도에 보여 줄 수 있는다면 좋을지도 모릅니다．
#( 물론，이것 단체라도 움직이도록 만들고 있으므로
#그대로 사용하고 받아도 상관하지 않습니다．)
#
#그대로 사용한 경우의 주의점으로서 ，
#지금까지의 스크립트（script）와 달리，기초로부터 있는 처리를 몇개인가 개서하고 입니다．
#병용이라든가 한 경우，가능한한 위의 쪽에 부착하면 그럭 저럭 되다，카모시れ 늘릴 수 없다．
#
#사용 방법
#먼저，데이터베이스（database）의 배우（actor） 설정으로 패러미터（parameter）의 설정을 합니다．
#각 패러미터（parameter）는 초기치 + 기본 치 * LV 로 산출됩니다．
#배우（actor）의 LV1의 때의 패러미터（parameter）의 값이 초기치
#LV2의 때의 값이 기본 값입니다．
#가사 HP의 초기치가 1500，기본치가 150과 자태라면，
#데이터베이스（database）의 배우（actor）의 패러미터（parameter） 설정으로
#LV1의 때의 HP가 1500，LV2의 때의 HP가 150으로 되도록 설정하십시오．
#
#패러미터（parameter）의 산출이 적당 지나기 때문에 ，각자 수정이 필요나와 ．

BASE_FINAL_LEVEL = 100   #상한 레벨（level）(그다지 큰 값을 설정한다면 항 합니다)
MAXHP_LIMIT = 20000000    #HP 한계 치
MAXSP_LIMIT = 20000000    #SP 한계 치
STR_LIMIT   = 2000      	#STR 한계 치
DEX_LIMIT   = 2000      	#DEX 한계 치
AGI_LIMIT   = 2000      	#AGI 한계 치
INT_LIMIT   = 2000      	#INT 한계 치
MAX_EXP			= 4200000000  #만렙시 경험치 

class Game_Actor < Game_Battler
	attr_accessor :exp_list
	
	def new_final_level
		lv = BASE_FINAL_LEVEL
		#이하 상한 LV 개별 지정 용
		#case self.id #엑터의 ID 번호에 따라 레벨 한계치를 각자 개별로 바꿔줄 수 있습니다.
		#when 1
		#  lv = 255
		#when 2
		#  lv = 999
		#when 8
		#  lv = 15600
		#end
		return lv
	end
	#--------------------------------------------------------------------------
	# ● EXP 계산
	#--------------------------------------------------------------------------
	def make_exp_list
		actor = $data_actors[@actor_id]
		@exp_list = Array.new(new_final_level + 2)
		@exp_list[1] = 0
		pow_i = 2.4 + actor.exp_inflation / 100.0
		for i in 2..new_final_level + 1
			if i > new_final_level
				@exp_list[i] = 0
			else
				n = actor.exp_basis * ((i + 3) ** pow_i) / (5 ** pow_i)
				@exp_list[i] = @exp_list[i-1] + Integer(n)
			end
		end
		@exp_list[100] = MAX_EXP
	end
	#--------------------------------------------------------------------------
	# ● MaxHP 의(것) 취득
	#--------------------------------------------------------------------------
	def maxhp
		n = [[base_maxhp + @maxhp_plus, 1].max, MAXHP_LIMIT].min
		for i in @states
			n *= $data_states[i].maxhp_rate / 100.0
		end
		n = [[Integer(n), 1].max, MAXHP_LIMIT].min
		return n
	end
	#--------------------------------------------------------------------------
	# ● 기본 MaxHP 의(것) 취득
	#--------------------------------------------------------------------------
	def base_maxhp
		n = $data_actors[@actor_id].parameters[0, 1]
		n += $data_actors[@actor_id].parameters[0, 2] * @level
		return n
	end
	#--------------------------------------------------------------------------
	# ● 기본 MaxSP 의(것) 취득
	#--------------------------------------------------------------------------
	def base_maxsp
		n = $data_actors[@actor_id].parameters[1, 1]
		n += $data_actors[@actor_id].parameters[1, 2] * @level
		return n
	end
	#--------------------------------------------------------------------------
	# ● 기본 완력의 취득
	#--------------------------------------------------------------------------
	def base_str
		n = $data_actors[@actor_id].parameters[2, 1]
		n += $data_actors[@actor_id].parameters[2, 2] * @level
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n += weapon != nil ? weapon.str_plus : 0
		n += armor1 != nil ? armor1.str_plus : 0
		n += armor2 != nil ? armor2.str_plus : 0
		n += armor3 != nil ? armor3.str_plus : 0
		n += armor4 != nil ? armor4.str_plus : 0
		return [[n, 1].max, STR_LIMIT].min
	end
	#--------------------------------------------------------------------------
	# ● 기본 손재주가 사노 취득
	#--------------------------------------------------------------------------
	def base_dex
		n = $data_actors[@actor_id].parameters[3, 1]
		n += $data_actors[@actor_id].parameters[3, 2] * @level
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n += weapon != nil ? weapon.dex_plus : 0
		n += armor1 != nil ? armor1.dex_plus : 0
		n += armor2 != nil ? armor2.dex_plus : 0
		n += armor3 != nil ? armor3.dex_plus : 0
		n += armor4 != nil ? armor4.dex_plus : 0
		return [[n, 1].max, DEX_LIMIT].min
	end
	#--------------------------------------------------------------------------
	# ● 기본 신속함의 취득
	#--------------------------------------------------------------------------
	def base_agi
		n = $data_actors[@actor_id].parameters[4, 1]
		n += $data_actors[@actor_id].parameters[4, 2] * @level
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n += weapon != nil ? weapon.agi_plus : 0
		n += armor1 != nil ? armor1.agi_plus : 0
		n += armor2 != nil ? armor2.agi_plus : 0
		n += armor3 != nil ? armor3.agi_plus : 0
		n += armor4 != nil ? armor4.agi_plus : 0
		return [[n, 1].max, AGI_LIMIT].min
	end
	#--------------------------------------------------------------------------
	# ● 기본 마력의 취득
	#--------------------------------------------------------------------------
	def base_int
		n = $data_actors[@actor_id].parameters[5, 1]
		n += $data_actors[@actor_id].parameters[5, 2] * @level
		weapon = $data_weapons[@weapon_id]
		armor1 = $data_armors[@armor1_id]
		armor2 = $data_armors[@armor2_id]
		armor3 = $data_armors[@armor3_id]
		armor4 = $data_armors[@armor4_id]
		n += weapon != nil ? weapon.int_plus : 0
		n += armor1 != nil ? armor1.int_plus : 0
		n += armor2 != nil ? armor2.int_plus : 0
		n += armor3 != nil ? armor3.int_plus : 0
		n += armor4 != nil ? armor4.int_plus : 0
		return [[n, 1].max, INT_LIMIT].min
	end
	#--------------------------------------------------------------------------
	# ● EXP 의(것) 변경
	#     exp : 새롭다 EXP
	#--------------------------------------------------------------------------
	def exp=(exp)
		@exp = [exp, 0].max
		if @exp > MAX_EXP
			@exp = MAX_EXP
			$console.write_line("경험치를 더이상 얻을 수 없습니다.") 
		end
		
		# 레벨업（level up）
		while @exp >= @exp_list[@level+1] and @exp_list[@level+1] > 0
			@level += 1
			next if $global_x == 4
			
			자동저장
			$console.write_line("[정보]:레벨이 올랐습니다!")
			# 직업에 따라 체력, 마력 증가량 다르게 함
			actor = $game_party.actors[0]
			
			if(actor.class_id == 7) # 전사 99때 체력 4500
				actor.maxhp += 16
				actor.str += 2
			elsif(actor.class_id == 2 or actor.class_id == 4) # 주술사, 도사 99때 마력 2000
				actor.maxsp += 5
				actor.int += 2
			elsif(actor.class_id == 17) # 도적
				actor.maxhp += 8
				actor.dex += 2 # 손재주(명중률)
				actor.agi += 2 # 민첩 (회피율)
			end
			
			# 풀체
			actor.hp = actor.maxhp
			actor.sp = actor.maxsp
			$game_player.animation_id = 180
			Network::Main.ani(Network::Main.id, 180)
			
			# 숙련（skill） 습득
			for j in $data_classes[@class_id].learnings
				if j.level == @level
					learn_skill(j.skill_id)
				end
			end
		end
		
		# 레벨（level） 다운（down）
		while @exp < @exp_list[@level]
			if @level == 100 or @level == 6
				@level -= 1
			else 
				break
			end
		end
		# 현재의 HP 라고(와) SP 이(가) 최대치를 초과하고 있다면 수정
		@hp = [@hp, self.maxhp].min
		@sp = [@sp, self.maxsp].min
	end
	#--------------------------------------------------------------------------
	# ● 레벨（level）의 변경
	#     level : 새로운 레벨（level）
	#--------------------------------------------------------------------------
	def level=(level)
		# 상하한 체크（check）
		# ★LV 상한을 new_final_level로 체크（check）하도록 변경
		level = [[level, new_final_level].min, 1].max
		# EXP 을(를) 변경
		self.exp = @exp_list[level]
	end
end


class Game_Battler
	#--------------------------------------------------------------------------
	# ● MaxHP 의(것) 취득
	#--------------------------------------------------------------------------
	def maxhp
		n = [[base_maxhp + @maxhp_plus, 1].max, MAXHP_LIMIT].min
		for i in @states
			n *= $data_states[i].maxhp_rate / 100.0
		end
		n = [[Integer(n), 1].max, MAXHP_LIMIT].min
		return n
	end
	#--------------------------------------------------------------------------
	# ● MaxSP 의(것) 취득
	#--------------------------------------------------------------------------
	def maxsp
		n = [[base_maxsp + @maxsp_plus, 0].max, MAXSP_LIMIT].min
		for i in @states
			n *= $data_states[i].maxsp_rate / 100.0
		end
		n = [[Integer(n), 0].max, MAXSP_LIMIT].min
		return n
	end
	#--------------------------------------------------------------------------
	# ● 완력의 취득
	#--------------------------------------------------------------------------
	def str
		n = [[base_str + @str_plus, 1].max, STR_LIMIT].min
		for i in @states
			n *= $data_states[i].str_rate / 100.0
		end
		n = [[Integer(n), 1].max, STR_LIMIT].min
		return n
	end
	#--------------------------------------------------------------------------
	# ● 손재주가 사노 취득
	#--------------------------------------------------------------------------
	def dex
		n = [[base_dex + @dex_plus, 1].max, DEX_LIMIT].min
		for i in @states
			n *= $data_states[i].dex_rate / 100.0
		end
		n = [[Integer(n), 1].max, DEX_LIMIT].min
		return n
	end
	#--------------------------------------------------------------------------
	# ● 신속함의 취득
	#--------------------------------------------------------------------------
	def agi
		n = [[base_agi + @agi_plus, 1].max, AGI_LIMIT].min
		for i in @states
			n *= $data_states[i].agi_rate / 100.0
		end
		n = [[Integer(n), 1].max, AGI_LIMIT].min
		return n
	end
	#--------------------------------------------------------------------------
	# ● 마력의 취득
	#--------------------------------------------------------------------------
	def int
		n = [[base_int + @int_plus, 1].max, INT_LIMIT].min
		for i in @states
			n *= $data_states[i].int_rate / 100.0
		end
		n = [[Integer(n), 1].max, INT_LIMIT].min
		return n
	end
	#--------------------------------------------------------------------------
	# ● MaxHP 의(것) 설정
	#     maxhp : 새롭다 MaxHP
	#--------------------------------------------------------------------------
	def maxhp=(maxhp)
		@maxhp_plus += maxhp - self.maxhp
		@maxhp_plus = [[@maxhp_plus, -MAXHP_LIMIT].max, MAXHP_LIMIT].min
		@hp = [@hp, self.maxhp].min
	end
	#--------------------------------------------------------------------------
	# ● MaxSP 의(것) 설정
	#     maxsp : 새롭다 MaxSP
	#--------------------------------------------------------------------------
	def maxsp=(maxsp)
		@maxsp_plus += maxsp - self.maxsp
		@maxsp_plus = [[@maxsp_plus, -MAXSP_LIMIT].max, MAXSP_LIMIT].min
		@sp = [@sp, self.maxsp].min
	end
	#--------------------------------------------------------------------------
	# ● 완력의 설정
	#     str : 새로운 완력
	#--------------------------------------------------------------------------
	def str=(str)
		@str_plus += str - self.str
		@str_plus = [[@str_plus, -STR_LIMIT].max, STR_LIMIT].min
	end
	#--------------------------------------------------------------------------
	# ● 손재주가 사노 설정
	#     dex : 새로운 손재주가 
	#--------------------------------------------------------------------------
	def dex=(dex)
		@dex_plus += dex - self.dex
		@dex_plus = [[@dex_plus, -DEX_LIMIT].max, DEX_LIMIT].min
	end
	#--------------------------------------------------------------------------
	# ● 신속함의 설정
	#     agi : 새로운 신속함
	#--------------------------------------------------------------------------
	def agi=(agi)
		@agi_plus += agi - self.agi
		@agi_plus = [[@agi_plus, -AGI_LIMIT].max, AGI_LIMIT].min
	end
	#--------------------------------------------------------------------------
	# ● 마력의 설정
	#     int : 새로운 마력
	#--------------------------------------------------------------------------
	def int=(int)
		@int_plus += int - self.int
		@int_plus = [[@int_plus, -INT_LIMIT].max, INT_LIMIT].min
	end
end