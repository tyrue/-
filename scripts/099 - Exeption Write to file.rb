class Exception
  alias :old_init :initialize
  alias :old_ex :exit
  
  def initialize(arg)
    GC.start
    Network::Main.close_socket if Network::Main.socket != nil
    old_init(arg)
    time = Time.now
    time = time.strftime("%a %d %b %Y, %X") 
    File.open("ErrorLog.rxdata","a+"){ |fh| fh.puts("On <<#{time}>> the error <<#{arg} (#{$scene})>> occured." )}
    if Network::Main.socket != nil and Network != nil
    Network::Main.socket.send("<9>#{self.id}</9>\n")
    Network::Main.socket.close
    Network::Main.socket = nil
    end
  end
  
  def exit(arg)
    GC.start
    if Network::Main.socket != nil
    Network::Main.socket.send("<9>#{self.id}</9>\n")
    Network::Main.socket.close
    Network::Main.socket = nil
    end
  
   # old_ex(arg)
  end
  
end