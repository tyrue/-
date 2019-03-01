#===============================================================================
# ** TCPSocket - Creates and manages TCP sockets.
#-------------------------------------------------------------------------------
# Author    Ruby
# Version   1.8.1
#===============================================================================
SDK.log("TCPSocket", "Ruby", "1.8.1", "Unknown")

#-------------------------------------------------------------------------------
# Begin SDK Enabled Check
#-------------------------------------------------------------------------------
if SDK.state('TCPSocket') == true
	
	class TCPSocket < Socket
		
		#--------------------------------------------------------------------------
		# ● Creates a new socket and connects it to the given host and port.
		#--------------------------------------------------------------------------  
		def self.open(*args)
			socket = new(*args)
			if block_given?
				begin
					yield socket
				ensure
					socket.close
				end
			end
			nil
		end
		
		#--------------------------------------------------------------------------
		# ● Creates a new socket and connects it to the given host and port.
		#--------------------------------------------------------------------------  
		def initialize(host, port)
			super(AF_INET, SOCK_STREAM, IPPROTO_TCP)
			connect(Socket.sockaddr_in(port, host))
		end
		
	end
	
	#==============================================================================
	# ■ SocketError
	#------------------------------------------------------------------------------
	# 　Default exception class for sockets.
	#==============================================================================
	class SocketError < StandardError
		ENOASSOCHOST = "getaddrinfo: no address associated with hostname."
		def self.check
			errno = Winsock.WSAGetLastError
			# If we are not Testing....
			if not Network::Test.testing
				# Raise the Error, by retrieving the error using the constant IF it exists
				#raise ("서버가 닫혀있습니다.서버 여는 시간대는 홈페이지를 참조해주세요.
				print "현재 서버가 닫혀있습니다."
				exit
			elsif errno != 0
				# If there is an Error (Testing)
				Network::Test.test_result(true)
			else
				Network::Test.socket.send("<20>'Test Completed'</20>")
				# If there is not an Error (Testing)
				Network::Test.test_result(false) 
			end
		end
	end
end
#-------------------------------------------------------------------------------
# End SDK Enabled Test
#-------------------------------------------------------------------------------