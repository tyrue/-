#==============================================================================
# ** Input_Mouse
#==============================================================================
module Input
	VK_LBUTTON = 1
	VK_RBUTTON = 2
	VK_MBUTTON = 4
	SM_SWAPBUTTON = 23
	gsm = Win32API.new 'user32', 'GetSystemMetrics', 'i', 'i'
	@@swapped = gsm.call(SM_SWAPBUTTON) != 0
	@@key_state = Win32API.new 'user32', 'GetAsyncKeyState',
	'i', 'i'
	@@cursor_pos = Win32API.new 'user32', 'GetCursorPos',
	'p', 'i'
	module_function
	def mouse_global_pos
		pos = [0, 0].pack('ll')
		if @@cursor_pos.call(pos) != 0
			return pos.unpack('ll')
		else
			return nil
		end
	end
	def mouse_pos(catch_anywhere = false)
		x, y = screen_to_client(*mouse_global_pos)
		width, height = client_size
		if x != nil and y != nil
			if catch_anywhere or (x >= 0 and y >= 0 and x < width and y < height)
				return x, y
			else
				return nil
			end
		else
			return nil
		end
	end
	def mouse_lbutton(ignore_swap = false)
		if @@swapped and !ignore_swap
			button = @@key_state.call(VK_RBUTTON)
		else
			button = @@key_state.call(VK_LBUTTON)
		end
		return(button == -32767 or button == 32768 or button == -32768)
	end
	def mouse_rbutton(ignore_swap = false)
		if @@swapped and !ignore_swap
			button = @@key_state.call(VK_LBUTTON)
		else
			button = @@key_state.call(VK_RBUTTON)
		end
		return(button == -32767 or button == 32768 or button == -32768)
	end
	def mouse_mbutton
		button = @@key_state.call(VK_MBUTTON)
		return(button == -32767 or button == 32768 or button == -32768)
	end
end
$scr2cli = Win32API.new 'user32', 'ScreenToClient', %w(l p), 'i'
$client_rect = Win32API.new 'user32', 'GetClientRect', %w(l p), 'i'
$readini = Win32API.new 'kernel32', 'GetPrivateProfileStringA',
%w(p p p p l p), 'l'
$findwindow = Win32API.new 'user32', 'FindWindowA', %w(p p), 'l'
def screen_to_client(x, y)
	return nil unless x and y
	pos = [x, y].pack('ll')
	if $scr2cli.call(hwnd, pos) != 0
		return pos.unpack('ll')
	else
		return nil
	end
end
def hwnd
	game_name = "\0" * 256
	$readini.call('Game','Title','',game_name,255,".\\Game.ini")
	game_name.delete!("\0")
	return $findwindow.call('RGSS Player',game_name)
end
def client_size
	rect = [0, 0, 0, 0].pack('l4')
	$client_rect.call(hwnd, rect)
	right, bottom = rect.unpack('l4')[2..3]
	return right, bottom
end
