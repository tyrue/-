module Hwnd
	module_function
	
	@data = []
	
	def [](id)
		@data[id]
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
		@data.size
	end
	
	def include?(value, type = 0)
		@data.each do |i|	
			next unless valid_jindow?(i, value)
			
			return type == 1 ? i : true
		end
		false
	end
	
	def update
		return if @data.empty?
		
		highlight
		for i in @data
			i.update
		end
	end
	
	def hide(val = false)
		handle_visibility(val, :hide)
	end
	
	def show(val = false)
		handle_visibility(val, :show)
	end
	
	def dispose(val = false)
		return dispose_single(val) if val
		
		@data.each do |i|
			i.dispose
		end
		@data.clear
	end
	
	def hudle(jindow)
		i = @data.size - 1
		while i >= 0
			if @data[i].jindow? and @data[i].arrive?
				return @data[i] != jindow
			end
			i -= 1
		end
		return true
	end
	
	def mouse_in_window
		for d in @data
			return true if d.arrive?
		end
		return false
	end
	
	def highlight
		return unless Input.mouse_lbutton
		
		i = @data.size - 1
		@highlight = false
		while i >= 0
			if @data[i].arrive?
				@highlight = @data[i]
				break
			end
			i -= 1
		end
		
		return unless @highlight && @highlight != @data.last
		
		@data.delete(@highlight)
		@data.push(@highlight)
		for i in @data
			i.highlight
		end
	end
	
	def highlight?
		@data.last
	end
	
	def dis_highlight(item)
		@data.delete(item)
		@data.unshift(item)
	end
	
	def highlight=(item)
		@highlight = item
		@data.delete(item)
		@data.push(item)
	end
	
	def link(alpha, beta)
		alpha.link.push(beta)
		beta.linked = true
		beta.linked_window = alpha
		
		if @data.index(alpha) > @data.index(beta)
			@data[@data.index(beta)], @data[@data.index(alpha)] = alpha, beta
		end
	end
	
	def valid_jindow?(i, value)
		(i.jindow? && i.hwnd == value) || i == value
	end
	
	def handle_visibility(val, method)
		return @data.each {|i| i.send(method) } unless val
		
		if val.jindow?
			val.send(method)
		elsif val.string?
			@data.select { |i| i.hwnd == val }.each {|i| i.send(method) }
		end
	end
	
	def dispose_single(val)
		if val.jindow?
			val.dispose
			@data.delete(val)
		elsif val.string?
			for i in @data
				if i.hwnd == val
					i.dispose
					@data.delete(i)
				end
			end
		end
	end
end
