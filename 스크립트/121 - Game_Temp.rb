#==============================================================================
# ** Game_Temp - Netplay Plus™ additions 
#------------------------------------------------------------------------------
# Version   1.0
#==============================================================================
class Game_Temp
	
	#--------------------------------------------------------------------------
	# * Attributes
	#--------------------------------------------------------------------------
	attr_accessor :spriteset_refresh
	attr_accessor :spriteset_renew
	attr_accessor :chat_refresh
	attr_accessor :chat_log
	attr_accessor :pchat_log
	attr_accessor :pchat_refresh
	attr_accessor :lastpchatid
	attr_accessor :motd
	attr_accessor :trade_refresh
	attr_accessor :items
	attr_accessor :weapons
	attr_accessor :armors
	attr_accessor :items2
	attr_accessor :weapons2
	attr_accessor :armors2
	attr_accessor :trade_window
	attr_accessor :trade_accepting
	attr_accessor :start_trade
	attr_accessor :trade_now 
	attr_accessor :refresh_itemtrade
	attr_accessor :versione
	#--------------------------------------------------------------------------
	# * オブジェクト初期化
	#--------------------------------------------------------------------------
	alias netplay_initialize initialize
	def initialize
		netplay_initialize
		@spriteset_refresh = false
		@spriteset_renew = false
		@chat_refresh = false
		@chat_log = []
		@pchat_refresh = [false]
		@pchat_log = [[""]]
		@lastpchatid = [-1]
		@motd = User_Edit::NOMOTD
		@versione = User_Edit::VERSION
		@trade_refresh = false
		@items = {}
		@weapons = {}
		@armors = {}
		@items2 = {}
		@weapons2 = {}
		@armors2 = {}
		@trade_window = nil
		@trade_accepting = false
		@start_trade = false
		@trade_now = false
		@refresh_itemtrade = false
	end
end
