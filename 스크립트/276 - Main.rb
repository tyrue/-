begin
	$anti_lag_mode = true
	$chat = Chat.new
	Graphics.freeze
	Graphics.frame_rate = 60
	$global_x = 0  
	#하우징
	$global_house1 = 0
	$global_house2 = 0
	$global_house3 = 0
	$global_house4 = 0
	
	$scene = Scene_Connect.new
	
	
	while $scene != nil
		$scene.main
	end
	# Fade out
	Network::Main.close_socket 
	Graphics.transition(25)
	exit!
rescue Errno::ENOENT
	Network::Main.close_socket 
	# Supplement Errno::ENOENT exception
	# If unable to open file, display message and end
	filename = $!.message.sub("No such file or directory - ", "")
	print("Unable to find file #{filename}.")
	time = Time.now
	time = time.strftime("%a %d %b %Y, %X") 
	File.open("ErrorLog.rxdata","a+"){ |fh| fh.puts("On <<#{time}>> the file <<#{filename}>> was missing." )}
ensure
	게임종료 if $scene.is_a?(Scene_Map)
	Network::Main.close_socket if Network::Main.socket != nil
end
