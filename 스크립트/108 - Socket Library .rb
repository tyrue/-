#===============================================================================
# ** Socket - Creates and manages sockets.
#-------------------------------------------------------------------------------
# Author    Ruby
# Version   1.8.1
#===============================================================================
SDK.log("Socket", "Ruby", "1.8.1", "Unknown")

#-------------------------------------------------------------------------------
# Begin SDK Enabled Check
#-------------------------------------------------------------------------------
if SDK.state('Socket') == true
	
	class Socket
		
		#--------------------------------------------------------------------------
		# ● Constants
		#--------------------------------------------------------------------------
		AF_UNSPEC                 = 0  
		AF_UNIX                   = 1
		AF_INET                   = 2
		AF_IPX                    = 6
		AF_APPLETALK              = 16
		
		PF_UNSPEC                 = 0  
		PF_UNIX                   = 1
		PF_INET                   = 2
		PF_IPX                    = 6
		PF_APPLETALK              = 16
		
		SOCK_STREAM               = 1
		SOCK_DGRAM                = 2
		SOCK_RAW                  = 3
		SOCK_RDM                  = 4
		SOCK_SEQPACKET            = 5
		
		IPPROTO_IP                = 0
		IPPROTO_ICMP              = 1
		IPPROTO_IGMP              = 2
		IPPROTO_GGP               = 3
		IPPROTO_TCP               = 6
		IPPROTO_PUP               = 12
		IPPROTO_UDP               = 17
		IPPROTO_IDP               = 22
		IPPROTO_ND                = 77
		IPPROTO_RAW               = 255
		IPPROTO_MAX               = 256
		
		SOL_SOCKET                = 65535
		
		SO_DEBUG                  = 1
		SO_REUSEADDR              = 4
		SO_KEEPALIVE              = 8
		SO_DONTROUTE              = 16
		SO_BROADCAST              = 32
		SO_LINGER                 = 128
		SO_OOBINLINE              = 256
		SO_RCVLOWAT               = 4100
		SO_SNDTIMEO               = 4101
		SO_RCVTIMEO               = 4102
		SO_ERROR                  = 4103
		SO_TYPE                   = 4104
		SO_SNDBUF                 = 4097
		SO_RCVBUF                 = 4098
		SO_SNDLOWAT               = 4099
		
		TCP_NODELAY               =	1
		
		MSG_OOB                   = 1
		MSG_PEEK                  = 2
		MSG_DONTROUTE             = 4
		
		IP_OPTIONS                =	1
		IP_DEFAULT_MULTICAST_LOOP =	1
		IP_DEFAULT_MULTICAST_TTL  =	1
		IP_MULTICAST_IF           =	2
		IP_MULTICAST_TTL          =	3
		IP_MULTICAST_LOOP         =	4
		IP_ADD_MEMBERSHIP         =	5
		IP_DROP_MEMBERSHIP        =	6
		IP_TTL                    =	7
		IP_TOS                    =	8
		IP_MAX_MEMBERSHIPS        =	20
		
		EAI_ADDRFAMILY            = 1
		EAI_AGAIN                 = 2
		EAI_BADFLAGS              = 3
		EAI_FAIL                  = 4
		EAI_FAMILY                = 5
		EAI_MEMORY                = 6
		EAI_NODATA                = 7
		EAI_NONAME                = 8
		EAI_SERVICE               = 9
		EAI_SOCKTYPE              = 10
		EAI_SYSTEM                = 11
		EAI_BADHINTS              = 12
		EAI_PROTOCOL              = 13
		EAI_MAX                   = 14
		
		AI_PASSIVE                = 1
		AI_CANONNAME              = 2
		AI_NUMERICHOST            = 4
		AI_MASK                   = 7
		AI_ALL                    = 256
		AI_V4MAPPED_CFG           = 512
		AI_ADDRCONFIG             = 1024
		AI_DEFAULT                = 1536
		AI_V4MAPPED               = 2048
		
		#--------------------------------------------------------------------------
		# ● Returns the associated IP address for the given hostname.
		#--------------------------------------------------------------------------  
		def self.getaddress(host)
			gethostbyname(host)[3].unpack("C4").join(".")
		end
		
		#--------------------------------------------------------------------------
		# ● Returns the associated IP address for the given hostname.
		#--------------------------------------------------------------------------  
		def self.getservice(serv)
			case serv
			when Numeric
				return serv
			when String
				return getservbyname(serv)
			else
				raise "Please us an interger or string for services."
			end
		end
		
		#--------------------------------------------------------------------------
		# ● Returns information about the given hostname.
		#--------------------------------------------------------------------------
		def self.gethostbyname(name)
			raise SocketError::ENOASSOCHOST if (ptr = Winsock.gethostbyname(name)) == 0
			host = ptr.copymem(16).unpack("iissi")
      
			[host[0].copymem(64).split("\0")[0], [], host[2], host[4].copymem(4).unpack("l")[0].copymem(4)]
		end
		
		#--------------------------------------------------------------------------
		# ● Returns the user's hostname.
		#--------------------------------------------------------------------------  
		def self.gethostname
			buf = "\0" * 256
			Winsock.gethostname(buf, 256)
			buf.strip
		end
		
		#--------------------------------------------------------------------------
		# ● Returns information about the given service.
		#--------------------------------------------------------------------------
		def self.getservbyname(name)
			case name
			when /echo/i
				return 7
			when /daytime/i
				return 13
			when /ftp/i
				return 21
			when /telnet/i
				return 23
			when /smtp/i
				return 25
			when /time/i
				return 37
			when /http/i
				return 80
			when /pop/i
				return 110
			else
				if Network::Test.testing or Network::Test.testcompleted
					Network::Test.testresult(true)
					return if Network::Test.testcompleted
				else
					raise "Service not recognized."
				end
			end
		end
		
		#--------------------------------------------------------------------------
		# ● Creates an INET-sockaddr struct.
		#--------------------------------------------------------------------------  
		def self.sockaddr_in(port, host)
			begin
				[AF_INET, getservice(port)].pack("sn") + gethostbyname(host)[3] + [].pack("x8")
			rescue
				if Network::Test.testcompleted or Network::Test.testing
					Network::Test.testresult(true)
					return if Network::Test.testcompleted
				end
			end
		end
		
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
		# ● Creates a new socket.
		#--------------------------------------------------------------------------  
		def initialize(domain, type, protocol)
			SocketError.check if (@fd = Winsock.socket(domain, type, protocol)) == -1
			@fd
		end
		
		#--------------------------------------------------------------------------
		# ● Accepts incoming connections.
		#--------------------------------------------------------------------------  
		def accept(flags = 0)
			buf = "\0" * 16
			SocketError.check if Winsock.accept(@fd, buf, flags) == -1
			buf
		end
		
		#--------------------------------------------------------------------------
		# ● Binds a socket to the given sockaddr.
		#--------------------------------------------------------------------------  
		def bind(sockaddr)
			SocketError.check if (ret = Winsock.bind(@fd, sockaddr, sockaddr.size)) == -1
			ret
		end
		
		#--------------------------------------------------------------------------
		# ● Closes a socket.
		#--------------------------------------------------------------------------  
		def close
			SocketError.check if (ret = Winsock.closesocket(@fd)) == -1
			ret
		end
		
		#--------------------------------------------------------------------------
		# ● Connects a socket to the given sockaddr.
		#--------------------------------------------------------------------------  
		def connect(sockaddr)
			return if Network::Test.testcompleted
			SocketError.check if (ret = Winsock.connect(@fd, sockaddr, sockaddr.size)) == -1
			ret
		end
		
		#--------------------------------------------------------------------------
		# ● Listens for incoming connections.
		#--------------------------------------------------------------------------  
		def listen(backlog)
			SocketError.check if (ret = Winsock.listen(@fd, backlog)) == -1
			ret
		end
		
		#--------------------------------------------------------------------------
		# ● Checks waiting data's status.
		#--------------------------------------------------------------------------  
		def select(timeout)
			SocketError.check if (ret = Winsock.select(1, [1, @fd].pack("ll"), 0, 0, [timeout, timeout * 1000000].pack("ll"))) == -1
			ret
		end
		
		#--------------------------------------------------------------------------
		# ● Checks if data is waiting.
		#--------------------------------------------------------------------------  
		def ready?
			not select(0) == 0
		end  
		
		#--------------------------------------------------------------------------
		# ● Reads data from socket.
		#--------------------------------------------------------------------------  
		def read(len)
			buf = "\0" * len
			Win32API.new("msvcrt", "_read", "lpl", "l").call(@fd, buf, len)
			buf
		end
		
		#--------------------------------------------------------------------------
		# ● Returns recieved data.
		#--------------------------------------------------------------------------  
		def recv(len, flags = 0)
			buf = "\0" * len
			SocketError.check if Winsock.recv(@fd, buf, buf.size, flags) == -1
			buf
		end
		
		#--------------------------------------------------------------------------
		# ● Sends data to a host.
		#--------------------------------------------------------------------------  
		def send(data, flags = 0)
			SocketError.check if (ret = Winsock.send(@fd, data, data.size, flags)) == -1
			ret
		end
		
		#--------------------------------------------------------------------------
		# ● Writes data to socket.
		#--------------------------------------------------------------------------  
		def write(data)
			Win32API.new("msvcrt", "_write", "lpl", "l").call(@fd, data, 1)
		end
		
	end
	
end
#-------------------------------------------------------------------------------
# End SDK Enabled Test
#-------------------------------------------------------------------------------