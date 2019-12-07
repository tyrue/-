#======================================
# ■ Mouse Input
#======================================
# 　By: Near Fantastica
#   Date: 06.07.05
#   Version: 1
#======================================
module Mouse
 @position
 GSM = Win32API.new('user32', 'GetSystemMetrics', 'i', 'i')
 Cursor_Pos= Win32API.new('user32', 'GetCursorPos', 'p', 'i')
 Scr2cli = Win32API.new('user32', 'ScreenToClient', %w(l p), 'i')
 Client_rect = Win32API.new('user32', 'GetClientRect', %w(l p), 'i')
 Readini = Win32API.new('kernel32', 'GetPrivateProfileStringA', %w(p p p p l p), 'l')
 Findwindow = Win32API.new('user32', 'FindWindowA', %w(p p), 'l')
 #--------------------------------------------------------------------------  
 def Mouse.grid
   return nil if @pos == nil
   x = @pos[0] / 32
   y = @pos[1] / 32
   x = x * 32
   y = y * 32
   return [x, y]
 end
 #--------------------------------------------------------------------------  
 def Mouse.position
   return @pos == nil ? [0, 0] : @pos
 end
 #--------------------------------------------------------------------------  
 def Mouse.global_pos
   pos = [0, 0].pack('ll')
   if Cursor_Pos.call(pos) != 0
     return pos.unpack('ll')
   else
     return nil
   end
 end
 #--------------------------------------------------------------------------  
 def Mouse.pos
   x, y = Mouse.screen_to_client(*Mouse.global_pos)
   width, height = Mouse.client_size
   begin
     if (x >= 0 and y >= 0 and x < width and y < height)
       return x, y
     else
       return nil
     end
   rescue
     return nil
   end
 end
 #--------------------------------------------------------------------------  
 def Mouse.update
   @pos = Mouse.pos
 end
 #--------------------------------------------------------------------------  
 def Mouse.screen_to_client(x, y)
   return nil unless x and y
   pos = [x, y].pack('ll')
   if Scr2cli.call(Mouse.hwnd, pos) != 0
     return pos.unpack('ll')
   else
     return nil
   end
 end
 #--------------------------------------------------------------------------  
 def Mouse.hwnd
   game_name = "\0" * 256
   Readini.call('Game','Title','',game_name,255,".\\Game.ini")
   game_name.delete!("\0")
   return Findwindow.call('RGSS Player',game_name)
 end
 #--------------------------------------------------------------------------  
 def Mouse.client_size
   rect = [0, 0, 0, 0].pack('l4')
   Client_rect.call(Mouse.hwnd, rect)
   right, bottom = rect.unpack('l4')[2..3]
   return right, bottom
 end
end