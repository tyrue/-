class Sprite
	alias jingukang_jindow_initialize initialize
	def initialize(viewport = Viewport.new(0, 0, 640, 480), push = true)
		(viewport.jindow? and push) ? (viewport.item.push(self)) : 0 # 여기서 자동으로 스프라이트 생성이 되면 진도우에 item배열에 넣어짐
		jingukang_jindow_initialize(viewport)
	end
	
	alias jingukang_jindow_dispose dispose
	def dispose
		return if self.disposed?
		if viewport != nil
			viewport.jindow? ? (viewport.item.delete(self)) : 0
		end
		jingukang_jindow_dispose
	end
	
	def width
		return bitmap.width
	end
	
	def height
		return bitmap.height
	end
end
