module Hwnd
	module_function
	
	@data = []
	
	def [](id)
		return @data[id]
	end
	
	def []=(id, value)
		@data[id] = value
	end
	
	def push(value)
		@data.push(value)
	end
	
	def index(value)
		@data.index(value)
	end
	
	def delete(value)
		@data.delete(value)
	end
	
	def size
		return @data.size
	end
	
	def include?(value, type = 0)
		if value.string?
			for i in @data
				i.jindow? ? 0 : next
				i.hwnd == value ? 0 : next
				case type
				when 0
					return true
				when 1
					return i
				end
			end
			return false
		elsif value.jindow?
			for i in @data
				i == value ? 0 : next
				case type
				when 0
					return true
				when 1
					return i
				end
			end
			return false
		else
		end
	end
	
	def update
		@data.size == 0 ? return : 0
		highlight
		for i in @data
			i.update
		end
	end
	
	def hide(val = false)
		if val.jindow?
			val.hide
		elsif val.string?
			for i in @data
				if i.hwnd == val
					i.hide
				end
			end
		else
			for i in @data
				i.hide
			end
		end
	end
	
	def show(val = false)
		if val.jindow?
			val.show if !val.disposed?
		elsif val.string?
			for i in @data
				if i.hwnd == val
					i.show
				end
			end
		else
			for i in @data
				i.show if i != nil
			end
		end
	end
	
	def dispose(val = false)
		if val.jindow?
			val.dispose
			@data.delete val
			val = nil
		elsif val.string?
			for i in @data
				if i.hwnd == val
					i.dispose
					@data.delete i
					i = nil
				end
			end
		else
			for i in @data
				i.dispose
				i = nil
			end
			@data = []
		end
	end
	
	# 해당 진도우가 살아 있으면 false 없으면 true
	def hudle(jindow)
		i = @data.size - 1
		while i >= 0
			if @data[i].jindow? and @data[i].arrive?
				@data[i] == jindow ? (return false) : (return true)
			end
			i -= 1
		end
		return true
	end
	
	def mouse_in_window
		for d in @data
			if d.arrive? 
				return true 
			end
		end
		return false
	end
	
	
	def highlight()
		Input.mouse_lbutton ? 0 : return
		i = @data.size - 1
		@highlight = false
		while i >= 0
			if @data[i].arrive?
				@highlight = @data[i]
				break
			end
			i -= 1
		end
		
		@highlight ? 0 : return
		@highlight == @data[@data.size - 1] ? return : 0
		@data.delete(@highlight)
		@data.push @highlight
		for i in @data
			i.highlight
		end
	end
	
	def highlight?
		return @data[@data.size - 1]
	end
	
	def dis_highlight(item)
		@data.delete(item)
		@data.unshift(item)
	end
	
	def highlight=(item)
		@highlight = item
		@data.delete(item)
		@data.push item
	end
	
	def link(alpha, beta)
		alpha.link.push beta
		beta.linked = true
		beta.linked_window = alpha
		@data.index(alpha) < @data.index(beta) ? 0 : return
		jindow = beta
		@data[@data.index(beta)] = alpha
		@data[@data.index(alpha)] = jindow
	end
end
