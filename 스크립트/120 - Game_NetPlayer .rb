#===============================================================================
# ** Network - Manages network data.
#-------------------------------------------------------------------------------
# Author    Me™ and Mr.Mo
# Version   1.0
# Date      11-04-06
#===============================================================================
SDK.log("Netplayer", "Me™ and Mr.Mo", "1.0", " 11-04-06")

p "Network Script not found!(Game_NetPlayer)" if not SDK.state('Network')
#-------------------------------------------------------------------------------
# Begin SDK Enabled Check
#-------------------------------------------------------------------------------
if SDK.state('Netplayer') == true and SDK.state('Network')
	
	class Game_NetPlayer < Game_Character
		#--------------------------------------------------------------------------
		# * Class Variables
		#--------------------------------------------------------------------------
		attr_accessor :map_id
		attr_accessor :name
		attr_accessor :level
		attr_accessor :netid
		attr_accessor :hp
		attr_accessor :sp
		attr_accessor :maxsp
		attr_accessor :username
		attr_accessor :event
		attr_accessor :agi
		attr_accessor :pdef
		attr_accessor :eva
		attr_accessor :mdef
		attr_accessor :states
		attr_accessor :damage
		attr_accessor :gold
		attr_accessor :maxhp
		attr_accessor :message
		attr_accessor :guild
		attr_accessor :saybal
		attr_accessor :pci
		attr_accessor :character_name
		if User_Edit::VISUAL_EQUIP_ACTIVE
			attr_accessor :weapon_id
			attr_accessor :armor1_id
			attr_accessor :armor2_id
			attr_accessor :armor3_id
			attr_accessor :armor4_id
			attr_accessor :capelli
			attr_accessor :equips
			attr_accessor :equip_change
			attr_accessor :is_transparency # 스킬 투명 썼는지 여부
		end  
		#--------------------------------------------------------------------------
		# * Initializes a network player.
		#--------------------------------------------------------------------------
		def initialize
			super
			@saybal = ""
			@map_id = 0
			@name = ""
			@level = -1
			@netid = -1
			@hp = -1
			@sp = -1
			@username = ""
			@move_tom = true
			@event = self
			@eva = 0
			@agi = 0
			@pdef = 0
			@mdef = 0
			@states = []
			@damage = 0
			@gold = 0
			@guild = ""
			@maxhp = $game_party.actors[0].maxhp
			@maxsp = $game_party.actors[0].maxsp
			@pci = $game_party.actors[0].class_name
			@message = ""
			@character_name = "바람머리"
			if User_Edit::VISUAL_EQUIP_ACTIVE
				@equip_change = false
				@weapon_id = 0
				@armor1_id = 0
				@armor2_id = 0
				@armor3_id = 0
				@armor4_id = 0
				@capelli = 0
				@ove = [@weapon_id, @armor1_id, @armor2_id, @armor3_id, @armor4_id]
				@is_transparency = false
			end
			$game_temp.spriteset_refresh = true
		end
		#-------------------------------------------------------------------------
		# * Refresh Netplayer with Data
		#-------------------------------------------------------------------------
		def refresh(data)
			return if @netid == Network::Main.id
			@oldx = @x
			@oldy = @y
			@tran = @is_transparency
			
			eval(data) unless data == nil
			if new_equip? or (@tran != @is_transparency)
				@equip_change = true
			end
			if User_Edit::VISUAL_EQUIP_ACTIVE
				@ove = [@weapon_id, @armor1_id, @armor2_id, @armor3_id, @armor4_id]
			end
			
			@transparent = (not $game_map.map_id == @map_id) rescue @transparent =false
			net_move if @oldx != @x or @oldy != @y 
			@move_tom = false
		end
		#--------------------------------------------------------------------------
		# * Get the Demage
		#--------------------------------------------------------------------------
		def attack_effect(attacker = $game_party.actors[0])
			# First hit detection
			hit_result = (rand(100) < attacker.hit)
			@damage = "Miss" if !hit_result
			return "Miss" if !hit_result
			# Calculate basic damage
			atk = [attacker.atk - @pdef / 2, 0].max
			damage = atk * (20 + attacker.str) / 20
			# Element correction
			damage *= attacker.elements_correct(attacker.element_set)
			damage /= 100
			# If damage value is strictly positive
			if damage > 0
				# Critical correction
				if rand(100) < 4 * attacker.dex / @agi
					damage *= 2
					@critical = true
				end
			end
			# Dispersion
			if damage.abs > 0
				amp = [damage.abs * 15 / 100, 1].max
				damage += rand(amp+1) + rand(amp+1) - amp
			end
			# Second hit detection
			eva = 8 * @agi / attacker.dex + @eva
			hit = damage < 0 ? 100 : 100 - eva
			hit = cant_evade? ? 100 : hit
			hit_result = (rand(100) < hit)
			# State change
			netid = @netid
			Network::Main.socket.send("<state_id>#{netid}\n")
			# State Removed by Shock
			Network::Main.socket.send("<state>remove_states_shock</state>\n")
			# Substract damage from HP
			@hp -= damage
			#Get all the plus states
			s = "["
			m = attacker.plus_state_set
			for i in 0..m.size
				k = m[i]
				s += "#{k}"
				s += ", " if i != m.size 
			end
			s += "]"
			Network::Main.socket.send("<state>states_plus(#{s})</state>\n")
			#Get all the minus states
			s = "["
			m = attacker.minus_state_set
			for i in 0..m.size
				k = m[i]
				s += "#{k}"
				s += ", " if i != m.size 
			end
			s += "]"
			Network::Main.socket.send("<state>states_minus(#{s})</state>\n")
			@damage = damage
			return damage
		end
		#--------------------------------------------------------------------------
		# * Apply Skill Effects
		#     user  : the one using skills (battler)
		#     skill : skill
		#--------------------------------------------------------------------------
		def effect_skill(user, skill)
			# Clear critical flag
			@critical = false
			# If skill scope is for ally with 1 or more HP, and your own HP = 0,
			# or skill scope is for ally with 0, and your own HP = 1 or more
			if ((skill.scope == 3 or skill.scope == 4) and @hp == 0) or
				((skill.scope == 5 or skill.scope == 6) and @hp >= 1)
				# End Method
				return false
			end
			# Clear effective flag
			effective = false
			# Set effective flag if common ID is effective
			effective |= skill.common_event_id > 0
			# First hit detection
			hit = skill.hit
			if skill.atk_f > 0
				hit *= user.hit / 100
			end
			hit_result = (rand(100) < hit)
			# Set effective flag if skill is uncertain
			effective |= hit < 100
			# If hit occurs
			if hit_result == true
				# Calculate power
				power = skill.power + user.atk * skill.atk_f / 100
				if power > 0
					power -= @pdef * skill.pdef_f / 200
					power -= @mdef * skill.mdef_f / 200
					power = [power, 0].max
				end
				# Calculate rate
				rate = 20
				rate += (user.str * skill.str_f / 100)
				rate += (user.dex * skill.dex_f / 100)
				rate += (user.agi * skill.agi_f / 100)
				rate += (user.int * skill.int_f / 100)
				# Calculate basic damage
				@damage = power * rate / 20
				# Element correction
				@damage *= user.elements_correct(skill.element_set)
				@damage /= 100
				# Dispersion
				if skill.variance > 0 and @damage.abs > 0
					amp = [@damage.abs * skill.variance / 100, 1].max
					@damage += rand(amp+1) + rand(amp+1) - amp
				end
				# Second hit detection
				eva = 8 * @agi / user.dex + @eva
				hit = @damage < 0 ? 100 : 100 - eva * skill.eva_f / 100
				hit = cant_evade? ? 100 : hit
				hit_result = (rand(100) < hit)
				# Set effective flag if skill is uncertain
				effective |= hit < 100
			end
			# If hit occurs
			if hit_result == true
				# If physical attack has power other than 0
				if skill.power != 0 and skill.atk_f > 0
					# State change
					netid = @netid
					Network::Main.socket.send("<state_id>#{netid}\n")
					# State Removed by Shock
					Network::Main.socket.send("<state>remove_states_shock</state>\n")
					# Set to effective flag
					effective = true
				end
				
				# Substract damage from HP
				last_hp = @hp
				@hp -= @damage
				effective |= @hp != last_hp
				# State change
				@state_changed = false
				
				#Get all the plus states
				s = "["
				m = user.plus_state_set
				for i in 0..m.size
					k = m[i]
					s += "#{k}"
					s += ", " if i != m.size 
				end
				s += "]"
				Network::Main.socket.send("<state>states_plus(#{s})</state>\n")
				
				#Get all the minus states
				s = "["
				m = user.minus_state_set
				for i in 0..m.size
					k = m[i]
					s += "#{k}"
					s += ", " if i != m.size 
				end
				s += "]"
				Network::Main.socket.send("<state>states_minus(#{s})</state>\n")
				
				# If power is 0
				if skill.power == 0
					# Set damage to an empty string
					@damage = ""
					# If state is unchanged    
					unless @state_changed
						# Set damage to "Miss"
						@damage = "Miss"
					end
				end
				
				# If miss occurs
			else
				# Set damage to "Miss"
				@damage = "Miss"
			end
			# End Method
			return effective
		end
		#--------------------------------------------------------------------------
		# * Determine [Can't Evade] States
		#--------------------------------------------------------------------------
		def cant_evade?
			for i in @states
				if $data_states[i].cant_evade
					return true
				end
			end
			return false
		end
		#--------------------------------------------------------------------------
		# * Move
		#--------------------------------------------------------------------------
		def net_move
			if @move_tom
				moveto(@x,@y)
				return
			end
			# Get difference in player coordinates
			sx = @oldx - @x 
			sy = @oldy - @y
			# If coordinates are equal
			return if sx == 0 and sy == 0
			# Get absolute value of difference
			abs_sx = sx.abs
			abs_sy = sy.abs
			moveto(@x,@y) if (abs_sx + abs_sy) >= 2
		end
		#-------------------------------------------------------------------------
		# * Set NetId
		#-------------------------------------------------------------------------
		def do_id(id)
			@netid = id
		end
		#-------------------------------------------------------------------------
		# * Start 
		#-------------------------------------------------------------------------
		def start(id)
			return if id.to_i == Network::Main.id
			#Network::Main.send_start_request(id)
		end
		#-------------------------------------------------------------------------
		# * Map (dummy)
		#-------------------------------------------------------------------------
		def map
			return
		end
		#-------------------------------------------------------------------------
		# * Increase steps
		#-------------------------------------------------------------------------
		def ic
			increase_steps
		end
		#-------------------------------------------------------------------------
		# * Emptied(for errors) Check event trigger touch
		#-------------------------------------------------------------------------
		def check_event_trigger_touch(x, y)
			return
		end
		
		def in_range?(range)
			x = (@oldx - $game_player.x) * (@oldx - $game_player.x)
			y = (@oldy - $game_player.y) * (@oldy - $game_player.y)
			r = x + y
			return true if r <= (range * range)
			return false
		end
	end
end
#-------------------------------------------------------------------------------
# End SDK Enabled Check
#-------------------------------------------------------------------------------
