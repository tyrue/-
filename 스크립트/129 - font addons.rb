#============================================================================
#  New Font Addons 1.5
#----------------------------------------------------------------------------
#  Adds two new font properties: Underline and Strikethrough
#  Operates in just the same way as bold or italic.
#----------------------------------------------------------------------------
#  Yeyinde
#  12/15/06
#============================================================================


#============================================================================
#  Font Class
#----------------------------------------------------------------------------
#  Bitmap property; holds the flags for the font display modes.
#============================================================================

class Font
	#--------------------------------------------------------------------------
	# * Class Variable Decloration
	#--------------------------------------------------------------------------
	@@default_underline = false
	@@default_underline_full = false 
	@@default_strikethrough = false
	@@default_strikethrough_full = false
	@@default_shadow = false
	@@default_shadow_color = Color.new(0, 0, 0, 100)
	@@default_outline = false
	@@default_outline_color = Color.new(0, 0, 0)
	#--------------------------------------------------------------------------
	# * Public Instance Variables
	#--------------------------------------------------------------------------
	attr_accessor :underline, :underline_full
	attr_accessor :strikethrough, :strikethrough_full
	attr_accessor :shadow_color, :outline_color
	attr_reader :shadow, :outline 
	#--------------------------------------------------------------------------
	# * Object Aliasing
	#--------------------------------------------------------------------------
	if @yeyinde_font_alias.nil?
		alias yeyinde_font_int initialize
		@yeyinde_font_alias = true
	end
	#--------------------------------------------------------------------------
	# * Object Initialization
	#--------------------------------------------------------------------------
	def initialize(*args)
		yeyinde_font_int(*args)
		@underline = @@default_underline
		@underline_full = @@default_underline_full
		@strikethrough = @@default_strikethrough
		@strikethrough_full = @@default_strikethrough_full
		@shadow = @@default_shadow
		@shadow_color = @@default_shadow_color
		@outline = @@default_outline
		@outline_color = @@default_outline_color
	end
	#--------------------------------------------------------------------------
	# * default_underline=(bool)
	#     bool : set class variable (true/false)
	#--------------------------------------------------------------------------
	def self.default_underline=(bool)
		@@default_underline = bool
	end
	#--------------------------------------------------------------------------
	# * default_strikethrough=(bool)
	#     bool : set class variable (true/false)
	#--------------------------------------------------------------------------
	def self.default_strikethrough=(bool)
		@@default_strikethrough = bool
	end
	#--------------------------------------------------------------------------
	# * default_underline
	#--------------------------------------------------------------------------
	def self.default_underline
		return @@default_underline
	end
	#--------------------------------------------------------------------------
	# * default_strikethrough
	#--------------------------------------------------------------------------
	def self.default_strikethrough
		return @@default_strikethrough
	end
	#--------------------------------------------------------------------------
	# * default_underline_full=(bool)
	#     bool : set class variable (true/false)
	#--------------------------------------------------------------------------
	def self.default_underline_full=(bool)
		@@default_underline_full = bool
	end
	#--------------------------------------------------------------------------
	# * default_strikethrough_full=(bool)
	#     bool : set class variable (true/false)
	#--------------------------------------------------------------------------
	def self.default_strikethrough_full=(bool)
		@@default_strikethrough_full = bool
	end
	#--------------------------------------------------------------------------
	# * default_underline_full
	#--------------------------------------------------------------------------
	def self.default_underline_full
		return @@default_underline_full
	end
	#--------------------------------------------------------------------------
	# * default_strikethrough_full
	#--------------------------------------------------------------------------
	def self.default_strikethrough_full
		return @@default_strikethrough_full
	end
	#--------------------------------------------------------------------------
	# * default_shadow=(bool)
	#     bool : set class variable (true/false)
	#--------------------------------------------------------------------------
	def self.default_shadow=(bool)
		@@default_shadow = bool
		@@default_outline = false unless bool == false
	end
	#--------------------------------------------------------------------------
	# * default_shadow
	#--------------------------------------------------------------------------
	def self.default_shadow
		return @@default_shadow
	end
	#--------------------------------------------------------------------------
	# * default_shadow_color=(color)
	#     color : Color class (Color.new(r, g, b [, a]))
	#--------------------------------------------------------------------------
	def self.default_shadow_color=(color)
		raise(TypeError, 'Cannot use a non Color object for color.') unless color.is_a?(Color)
		@@default_shadow_color = color
	end
	#--------------------------------------------------------------------------
	# * default_shadow_color
	#--------------------------------------------------------------------------
	def self.default_shadow_color
		return @@default_shadow_color
	end
	#--------------------------------------------------------------------------
	# * default_outline=(bool)
	#     bool : set class variable (true/false)
	#--------------------------------------------------------------------------
	def self.default_outline=(bool)
		@@default_outline = bool
		@@default_shadow = false unless bool == false
	end
	#--------------------------------------------------------------------------
	# * default_shadow
	#--------------------------------------------------------------------------
	def self.default_outline
		return @@default_outline
	end
	#--------------------------------------------------------------------------
	# * default_shadow_color=(color)
	#     color : Color class (Color.new(r, g, b [, a])
	#--------------------------------------------------------------------------
	def self.default_outline_color=(color)
		raise(TypeError, 'Cannot use a non Color object for color.') unless color.is_a?(Color)
		@@default_outline_color = color
	end
	#--------------------------------------------------------------------------
	# * default_shadow_color
	#--------------------------------------------------------------------------
	def self.default_outline_color
		return @@default_outline_color
	end
	#--------------------------------------------------------------------------
	# * shadow=(bool)
	#     bool : set variable (true/false)
	#--------------------------------------------------------------------------
	def shadow=(bool)
		@shadow = bool
		@outline = false unless bool == false
	end
	#--------------------------------------------------------------------------
	# * outline=(bool)
	#     bool : set variable (true/false)
	#--------------------------------------------------------------------------
	def outline=(bool)
		@shadow = false unless bool == false
		@outline = bool
	end
end


#============================================================================
#  Bitmap Class
#----------------------------------------------------------------------------
#  Handles display and drawing data.  Needs a medium to be viewed.
#============================================================================

class Bitmap
	#--------------------------------------------------------------------------
	# * Object Aliasing
	#--------------------------------------------------------------------------
	if @yeyinde_us_alias.nil?
		alias yeyinde_us_draw_text draw_text
		@yeyinde_us_alias = true
	end
	#--------------------------------------------------------------------------
	# * draw_text (underline & strikethrough)
	#--------------------------------------------------------------------------
	def draw_text(*args)
		
		yeyinde_us_draw_text(*args)
		if self.font.underline
			u_color = self.font.color.dup
			if args[0].is_a?(Rect)
				u_x = args[0].x
				u_y = args[0].y + args[0].height / 2 + self.font.size / 3
				if self.font.underline_full
					u_width = args[0].width
				else
					u_width = self.text_size(args[1]).width
					case args[2]
					when 1
						u_x += args[0].width / 2 - u_width / 2
					when 2
						u_x += args[0].width - u_width
					end
				end
			else
				u_x = args[0]
				u_y = args[1] + args[3] / 2 + self.font.size / 3
				if self.font.underline_full
					u_width = args[2]
				else
					u_width = self.text_size(args[4]).width
					case args[5]
					when 1
						u_x += args[2] / 2 - u_width / 2
					when 2
						u_x += args[2] - u_width
					end
				end
			end
			self.fill_rect(u_x, u_y, u_width, 1, u_color)
		end
		if self.font.strikethrough
			s_color = self.font.color.dup
			if args[0].is_a?(Rect)
				s_x = args[0].x
				s_y = args[0].y + args[0].height / 2
				if self.font.strikethrough_full
					s_width = args[0].width
				else
					s_width = self.text_size(args[1]).width
					case args[2]
					when 1
						s_x += args[0].width / 2 - s_width / 2
					when 2
						s_x += args[0].width - s_width
					end
				end
			else
				s_x = args[0]
				s_y = args[1] + args[3] / 2
				if self.font.strikethrough_full
					s_width = args[0].width
				else
					s_width = self.text_size(args[4]).width
					case args[5]
					when 1
						s_x += args[2] / 2 - s_width / 2
					when 2
						s_x += args[2] - s_width
					end
				end
			end
			self.fill_rect(s_x, s_y, s_width, 1, s_color)
		end
	end
	#--------------------------------------------------------------------------
	# * Object Aliasing
	#--------------------------------------------------------------------------
	if @yeyinde_so_alias.nil?
		alias yeyinde_so_draw_text draw_text
		@yeyinde_so_alias = true
	end
	#--------------------------------------------------------------------------
	# * draw_text (shadow & outline)
	#--------------------------------------------------------------------------
	def draw_text(*args)
		if self.font.shadow
			orig_color = self.font.color.dup
			self.font.color = self.font.shadow_color
			if args[0].is_a?(Rect)
				s_x = args[0].x + 2
				s_y = args[0].y + 2
				s_w = args[0].width
				s_h = args[0].height
				s_t = args[1]
				s_a = args[2]
			else
				s_x = args[0] + 2
				s_y = args[1] + 2
				s_w = args[2]
				s_h = args[3]
				s_t = args[4]
				s_a = args[5]
			end
			s_a = 0 if s_a.nil?
			self.yeyinde_so_draw_text(s_x, s_y, s_w, s_h, s_t, s_a)
			self.font.color = orig_color
		end
		if self.font.outline
			orig_color = self.font.color.dup
			self.font.color = self.font.outline_color
			if args[0].is_a?(Rect)
				o_x = args[0].x
				o_y = args[0].y
				o_w = args[0].width
				o_h = args[0].height
				o_t = args[1]
				o_a = args[2]
			else
				o_x = args[0]
				o_y = args[1]
				o_w = args[2]
				o_h = args[3]
				o_t = args[4]
				o_a = args[5]
			end
			o_a = 0 if o_a.nil?
			self.yeyinde_so_draw_text(o_x + 1, o_y, o_w, o_h, o_t, o_a)
			self.yeyinde_so_draw_text(o_x - 1, o_y, o_w, o_h, o_t, o_a)
			self.yeyinde_so_draw_text(o_x, o_y + 1, o_w, o_h, o_t, o_a)
			self.yeyinde_so_draw_text(o_x, o_y - 1, o_w, o_h, o_t, o_a)
			self.yeyinde_so_draw_text(o_x + 1, o_y + 1, o_w, o_h, o_t, o_a)
			self.yeyinde_so_draw_text(o_x + 1, o_y - 1, o_w, o_h, o_t, o_a)
			self.yeyinde_so_draw_text(o_x - 1, o_y - 1, o_w, o_h, o_t, o_a)
			self.yeyinde_so_draw_text(o_x - 1, o_y + 1, o_w, o_h, o_t, o_a)
			self.font.color = orig_color
		end
		self.yeyinde_so_draw_text(*args)
	end
end