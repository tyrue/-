#===============================================================================
# ** Module Winsock - Maps out the functions held in the Winsock DLL.
#-------------------------------------------------------------------------------
# Author    Ruby
# Version   1.8.1
#===============================================================================
SDK.log("Winsock", "Ruby", "1.0", "Unknown")

#-------------------------------------------------------------------------------
# Begin SDK Enabled Check
#-------------------------------------------------------------------------------
if SDK.state('Winsock') == true
	
	module Winsock
		
		DLL = "ws2_32"
		
		#--------------------------------------------------------------------------
		# * Accept Connection
		#--------------------------------------------------------------------------
		def self.accept(*args)
			Win32API.new(DLL, "accept", "ppl", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Bind
		#--------------------------------------------------------------------------
		def self.bind(*args)
			Win32API.new(DLL, "bind", "ppl", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Close Socket
		#--------------------------------------------------------------------------
		def self.closesocket(*args)
			Win32API.new(DLL, "closesocket", "p", "l").call(*args)
		end  
		
		#--------------------------------------------------------------------------
		# * Connect
		#--------------------------------------------------------------------------
		def self.connect(*args)
			Win32API.new(DLL, "connect", "ppl", "l").call(*args)
		end    
		
		#--------------------------------------------------------------------------
		# * Get host (Using Adress)
		#--------------------------------------------------------------------------
		def self.gethostbyaddr(*args)
			Win32API.new(DLL, "gethostbyaddr", "pll", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Get host (Using Name)
		#-------------------------------------------------------------------------- 
		def self.gethostbyname(*args)
			Win32API.new(DLL, "gethostbyname", "p", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Get host's Name
		#--------------------------------------------------------------------------
		def self.gethostname(*args)
			Win32API.new(DLL, "gethostname", "pl", "").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Get Server (Using Name)
		#--------------------------------------------------------------------------
		def self.getservbyname(*args)
			Win32API.new(DLL, "getservbyname", "pp", "p").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * HT OnL
		#--------------------------------------------------------------------------
		def self.htonl(*args)
			Win32API.new(DLL, "htonl", "l", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * HT OnS
		#--------------------------------------------------------------------------
		def self.htons(*args)
			Win32API.new(DLL, "htons", "l", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Inet Adress
		#--------------------------------------------------------------------------
		def self.inet_addr(*args)
			Win32API.new(DLL, "inet_addr", "p", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Inet NtOA
		#--------------------------------------------------------------------------
		def self.inet_ntoa(*args)
			Win32API.new(DLL, "inet_ntoa", "l", "p").call(*args)
		end  
		
		#--------------------------------------------------------------------------
		# * Listen
		#--------------------------------------------------------------------------
		def self.listen(*args)
			Win32API.new(DLL, "listen", "pl", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Recieve
		#--------------------------------------------------------------------------
		def self.recv(*args)
			Win32API.new(DLL, "recv", "ppll", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Select
		#--------------------------------------------------------------------------
		def self.select(*args)
			Win32API.new(DLL, "select", "lpppp", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Send
		#--------------------------------------------------------------------------
		def self.send(*args)
			Win32API.new(DLL, "send", "ppll", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Set Socket Options
		#--------------------------------------------------------------------------
		def self.setsockopt(*args)
			Win32API.new(DLL, "setsockopt", "pllpl", "l").call(*args)
		end  
		
		#--------------------------------------------------------------------------
		# * Shutdown
		#--------------------------------------------------------------------------
		def self.shutdown(*args)
			Win32API.new(DLL, "shutdown", "pl", "l").call(*args)
		end
		
		#--------------------------------------------------------------------------
		# * Socket
		#--------------------------------------------------------------------------
		def self.socket(*args)
			Win32API.new(DLL, "socket", "lll", "l").call(*args)  
		end
		
		#--------------------------------------------------------------------------
		# * Get Last Error
		#--------------------------------------------------------------------------
		def self.WSAGetLastError(*args)
			Win32API.new(DLL, "WSAGetLastError", "", "l").call(*args)
		end
		
	end
	#==============================================================================
	#End
	#==============================================================================
	
end