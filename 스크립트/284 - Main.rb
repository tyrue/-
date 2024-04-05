#==============================================================================

# Modifies the error message raised to show the full traceback path.
def traceback_report
	backtrace = $!.backtrace.clone
	backtrace.each{ |bt|
		bt.sub!(/{(\d+)}/) {"[#{$1}]#{$RGSS_SCRIPTS[$1.to_i][1]}"}
	}
	return $!.message + "\n\n" + backtrace.join("\n")
end

def raise_traceback_error
	raise
	#~ if $!.message.size >= 900
		#~ File.open('traceback.log', 'w') { |f| f.write($!) }
		#~ raise 'Traceback is too big. Output in traceback.log'
	#~ else
		
	#~ end
end

begin
	Graphics.freeze
	Graphics.frame_rate = 60
	$login_check = false
	#하우징
	
	$scene = Scene_Connect.new
	
	
	while $scene != nil
		$scene.main
	end
	
	# Fade out
	Network::Main.close_socket 
	Graphics.transition(25)
	exit!
rescue SyntaxError
  $!.message.sub!($!.message, traceback_report)
  raise_traceback_error
rescue
  $!.message.sub!($!.message, traceback_report)
  raise_traceback_error
rescue Errno::ENOENT
	$!.message.sub!($!.message, traceback_report)
	raise_traceback_error
	Network::Main.close_socket 
	# Supplement Errno::ENOENT exception
	# If unable to open file, display message and end
	filename = $!.message.sub("No such file or directory - ", "")
	print("Unable to find file #{filename}.")
	time = Time.now
	time = time.strftime("%a %d %b %Y, %X") 
	File.open("ErrorLog.rxdata","a+"){ |fh| fh.puts("On <<#{time}>> the file <<#{filename}>> was missing." )}
ensure
	게임종료 #if $scene.is_a?(Scene_Map)
	$!.message.sub!($!.message, traceback_report)
	raise_traceback_error
end
