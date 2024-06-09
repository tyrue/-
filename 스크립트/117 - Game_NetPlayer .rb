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
		attr_accessor :str
		attr_accessor :dex
		attr_accessor :int
		attr_accessor :atk
		attr_accessor :pdef
		attr_accessor :eva
		attr_accessor :mdef
		attr_accessor :states
		attr_accessor :damage
		attr_accessor :critical
		attr_accessor :gold
		attr_accessor :maxhp
		attr_accessor :message
		attr_accessor :guild
		attr_accessor :saybal
		attr_accessor :pci
		attr_accessor :character_name
		attr_accessor :trans_v
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
			attr_accessor :damage_array # 
			attr_accessor :critical_array # 
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
			@str = 0
			@dex = 0
			@agi = 0
			@int = 0
			@pdef = 0
			@mdef = 0
			@states = []
			@damage = ""
			@critical = false
			@gold = 0
			@guild = ""
			@maxhp = $game_party.actors[0].maxhp
			@maxsp = $game_party.actors[0].maxsp
			@pci = $game_party.actors[0].class_name
			@message = ""
			@character_name = "바람머리"
			@is_transparency = false
			@trans_v = 0
			@damage_array = []
			@critical_array = []
			@rpg_skill = Rpg_skill.new(self)
			
			if User_Edit::VISUAL_EQUIP_ACTIVE
				@equip_change = false
				@weapon_id = 0
				@armor1_id = 0
				@armor2_id = 0
				@armor3_id = 0
				@armor4_id = 0
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
			eval(data) if data != nil
			
			net_move if @oldx != @x or @oldy != @y 
			@move_tom = false
		end
		
		def atk
			weapon = $data_weapons[@weapon_id]
			return weapon != nil ? weapon.atk : 0
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
			self.ic
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
