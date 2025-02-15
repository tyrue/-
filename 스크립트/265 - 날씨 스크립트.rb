#  ccoa's weather script
#
#  Weather Types:
#    1 - rain
#    2 - storm
#    3 - snow
#    4 - hail
#    5 - rain with thunder and lightning
#    6 - falling leaves (autumn)
#    7 - blowing leaves (autumn)
#    8 - swirling leaves (autumn)
#    9 - falling leaves (green)
#   10 - cherry blossom (sakura) petals
#   11 - rose petals
#   12 - feathers
#   13 - blood rain
#   14 - sparkles
#   15 - user defined
#   16 - blowing snow
#   17 - meteor shower
#   18 - falling ash
##  usage(사용법):

#    이벤트 커맨드에서 스크립트를 선택한 후, 다음과 같이 입력하세요:

#       $game_screen.weather(쓸 날씨효과 번호, 강도, 나타날때까지의시간)

#

#    ※날씨의 강도는 최대 40, 최소 0입니다.

#       0은 날씨 맑, 40은..... 날씨효과 최강

#

#    ※나타날때까지의 시간은 말 그대로입니다.

#       1이면 1프레임만에 뿅! 하고 튀어나오는 거고, 한 500쯤 하면 500프레임동안 천천히 나오는 거지요.

# 

#  Usage of user-defined weather(마지막 15번째 커스텀 사용법):

#    Look at the following globals(아래를 보세요):

#  Weather Power:
#    An integer from 0-50.  0 = no weather, 50 = 500 sprites
#
#  Transition:
#    The number of frames to "transition" the weather in
#
#  Usage:
#    Create a call script with the following:
#       $game_screen.weather(type, power, transition)
# 
#  Usage of user-defined weather:
#    Look at the following globals:

$WEATHER_UPDATE = false   # the $WEATHER_IMAGES array has changed, please update
$WEATHER_IMAGES = []      # the array of picture names to use
$WEATHER_X = 0            # the number of pixels the image should move horizontally (positive = right, negative = left)
$WEATHER_Y = 0            # the number of pizels the image should move vertically (positive = down, negative = up)
$WEATHER_FADE = 0         # how much the image should fade each update (0 = no fade, 255 = fade instantly)
$WEATHER_ANIMATED = false # whether or not the image should cycle through all the images

module RPG
	class Weather
		def initialize(viewport = nil)
			@type = 0
			@max = 0
			@ox = 0
			@oy = 0
			@count = 0
			@current_pose = []
			@info = []
			@countarray = []
			
			make_bitmaps
			
			# **** ccoa ****
			for i in 1..500
				sprite = Sprite.new(viewport)
				sprite.z = 1000
				sprite.visible = false
				sprite.opacity = 0
				@sprites.push(sprite)
				@current_pose.push(0)
				@info.push(rand(50))
				@countarray.push(rand(15))
			end
		end
		
		def dispose
			for sprite in @sprites
				sprite.dispose
			end
			@rain_bitmap.dispose
			@storm_bitmap.dispose
			@snow_bitmap.dispose
			@hail_bitmap.dispose
			@petal_bitmap.dispose
			@blood_rain_bitmap.dispose
			for image in @autumn_leaf_bitmaps
				image.dispose
			end
			for image in @green_leaf_bitmaps
				image.dispose
			end
			for image in @rose_bitmaps
				image.dispose
			end
			for image in @feather_bitmaps
				image.dispose
			end
			for image in @sparkle_bitmaps
				image.dispose
			end
			for image in @user_bitmaps
				image.dispose
			end
			$WEATHER_UPDATE = true
		end
		
		def type=(type)
			return if @type == type
			@type = type
			case @type
			when 1 # rain
				bitmap = @rain_bitmap
			when 2 # storm
				bitmap = @storm_bitmap
			when 3 # snow
				bitmap = @snow_bitmap
			when 4 # hail
				bitmap = @hail_bitmap
			when 5 # rain w/ thunder and lightning
				bitmap = @rain_bitmap
				@thunder = true
			when 6 # falling autumn leaves
				bitmap = @autumn_leaf_bitmaps[0]
			when 7 # blowing autumn leaves
				bitmap = @autumn_leaf_bitmaps[0]
			when 8 # swirling autumn leaves
				bitmap = @autumn_leaf_bitmaps[0]
			when 9 # falling green leaves
				bitmap = @green_leaf_bitmaps[0]
			when 10 # sakura petals
				bitmap = @petal_bitmap
			when 11 # rose petals
				bitmap = @rose_bitmaps[0]
			when 12 # feathers
				bitmap = @feather_bitmaps[0]
			when 13 # blood rain 
				bitmap = @blood_rain_bitmap
			when 14 # sparkles
				bitmap = @sparkle_bitmaps[0]
			when 15 # user-defined
				bitmap = @user_bitmaps[rand(@user_bitmaps.size)]
			when 16 # blowing snow
				bitmap = @snow_bitmap
			when 17 # meteors
				bitmap = @meteor_bitmap
			when 18 # falling ash
				bitmap = @ash_bitmaps[rand(@ash_bitmaps.size)]
			else
				bitmap = nil
			end
			if @type != 5
				@thunder = false
			end
			# **** ccoa ****
			for i in 1..500
				sprite = @sprites[i]
				if sprite != nil
					sprite.visible = (i <= @max)
					sprite.bitmap = bitmap
				end
			end
		end
		
		def ox=(ox)
			return if @ox == ox;
			@ox = ox
			for sprite in @sprites
				sprite.ox = @ox
			end
		end
		
		def oy=(oy)
			return if @oy == oy;
			@oy = oy
			for sprite in @sprites
				sprite.oy = @oy
			end
		end
		
		def max=(max)
			return if @max == max;
			# **** ccoa ****
			@max = [[max, 0].max, 500].min
			for i in 1..500
				sprite = @sprites[i]
				if sprite != nil
					sprite.visible = (i <= @max)
				end
			end
		end
		
		def update
			return if @type == 0
			for i in 1..@max
				sprite = @sprites[i]
				if sprite == nil
					break
				end
				if @type == 1 or @type == 5 or @type == 13 # rain
					sprite.x -= 2
					sprite.y += 16
					sprite.opacity -= 8
					if @thunder and (rand(8000 - @max) == 0)
						$game_screen.start_flash(Color.new(255, 255, 255, 255), 5)
						Audio.se_play("Audio/SE/061-Thunderclap01", $game_variables[13])
					end
				end
				if @type == 2 # storm
					sprite.x -= 8
					sprite.y += 16
					sprite.opacity -= 12
				end
				if @type == 3 # snow
					sprite.x -= 2
					sprite.y += 8
					sprite.opacity -= 8
				end
				if @type == 4 # hail
					sprite.x -= 1
					sprite.y += 18
					sprite.opacity -= 15
				end
				if @type == 6 # falling autumn leaves
					@count = rand(20)
					if @count == 0
						sprite.bitmap = @autumn_leaf_bitmaps[@current_pose[i]]
						@current_pose[i] = (@current_pose[i] + 1) % @autumn_leaf_bitmaps.size
					end
					sprite.x -= 1
					sprite.y += 1
				end
				if @type == 7 # blowing autumn leaves
					@count = rand(20)
					if @count == 0
						sprite.bitmap = @autumn_leaf_bitmaps[@current_pose[i]]
						@current_pose[i] = (@current_pose[i] + 1) % @autumn_leaf_bitmaps.size
					end
					sprite.x -= 10
					sprite.y += (rand(4) - 2)
				end
				if @type == 8 # swirling autumn leaves
					@count = rand(20)
					if @count == 0
						sprite.bitmap = @autumn_leaf_bitmaps[@current_pose[i]]
						@current_pose[i] = (@current_pose[i] + 1) % @autumn_leaf_bitmaps.size
					end
					if @info[i] != 0
						if @info[i] >= 1 and @info[i] <= 10
							sprite.x -= 3
							sprite.y -= 1
						elsif @info[i] >= 11 and @info[i] <= 16
							sprite.x -= 1
							sprite.y -= 2
						elsif @info[i] >= 17 and @info[i] <= 20
							sprite.y -= 3
						elsif @info[i] >= 21 and @info[i] <= 30
							sprite.y -= 2
							sprite.x += 1
						elsif @info[i] >= 31 and @info[i] <= 36
							sprite.y -= 1
							sprite.x += 3
						elsif @info[i] >= 37 and @info[i] <= 40
							sprite.x += 5
						elsif @info[i] >= 41 and @info[i] <= 46
							sprite.y += 1
							sprite.x += 3
						elsif @info[i] >= 47 and @info[i] <= 58
							sprite.y += 2
							sprite.x += 1
						elsif @info[i] >= 59 and @info[i] <= 64
							sprite.y += 3
						elsif @info[i] >= 65 and @info[i] <= 70
							sprite.x -= 1
							sprite.y += 2
						elsif @info[i] >= 71 and @info[i] <= 81
							sprite.x -= 3
							sprite.y += 1
						elsif @info[i] >= 82 and @info[i] <= 87
							sprite.x -= 5
						end
						@info[i] = (@info[i] + 1) % 88
					else
						if rand(200) == 0
							@info[i] = 1
						end
						sprite.x -= 5
						sprite.y += 1
					end
				end
				if @type == 9 # falling green leaves
					if @countarray[i] == 0
						@current_pose[i] = (@current_pose[i] + 1) % @green_leaf_bitmaps.size
						sprite.bitmap = @green_leaf_bitmaps[@current_pose[i]]
						@countarray[i] = rand(15)
					end
					@countarray[i] = (@countarray[i] + 1) % 15
					sprite.y += 1
				end
				if @type == 10 # sakura petals
					if @info[i] < 25
						sprite.x -= 1
					else
						sprite.x += 1
					end
					@info[i] = (@info[i] + 1) % 50
					sprite.y += 1
				end
				if @type == 11 # rose petals
					@count = rand(20)
					if @count == 0
						sprite.bitmap = @rose_bitmaps[@current_pose[i]]
						@current_pose[i] = (@current_pose[i] + 1) % @rose_bitmaps.size
					end
					if @info[i] % 2 == 0
						if @info[i] < 10
							sprite.x -= 1
						elsif 
							sprite.x += 1
						end
					end
					sprite.y += 1
				end
				if @type == 12 # feathers
					if @countarray[i] == 0
						@current_pose[i] = (@current_pose[i] + 1) % @feather_bitmaps.size
						sprite.bitmap = @feather_bitmaps[@current_pose[i]]
					end
					@countarray[i] = (@countarray[i] + 1) % 15
					if rand(100) == 0
						sprite.x -= 1
					end
					if rand(100) == 0
						sprite.y -= 1
					end
					if @info[i] < 50
						if rand(2) == 0
							sprite.x -= 1
						else
							sprite.y -= 1
						end
					else
						if rand(2) == 0
							sprite.x += 1
						else
							sprite.y += 1
						end
					end
					@info[i] = (@info[i] + 1) % 100
				end
				if @type == 14 # sparkles
					if @countarray[i] == 0
						@current_pose[i] = (@current_pose[i] + 1) % @sparkle_bitmaps.size
						sprite.bitmap = @sparkle_bitmaps[@current_pose[i]]
					end
					@countarray[i] = (@countarray[i] + 1) % 15
					sprite.y += 1
					sprite.opacity -= 1
				end
				if @type == 15 # user-defined
					if $WEATHER_UPDATE
						update_user_defined
						$WEATHER_UPDATE = false
					end
					if $WEATHER_ANIMATED and @countarray[i] == 0
						@current_pose[i] = (@current_pose[i] + 1) % @user_bitmaps.size
						sprite.bitmap = @user_bitmaps[@current_pose[i]]
					end
					sprite.x += $WEATHER_X
					sprite.y += $WEATHER_Y
					sprite.opacity -= $WEATHER_FADE
				end
				if @type == 16 # blowing snow
					sprite.x -= 10
					sprite.y += 6
					sprite.opacity -= 4
				end
				if @type == 17 # meteors
					if @countarray[i] > 0
						if rand(20) == 0
							sprite.bitmap = @impact_bitmap
							@countarray[i] = -5
						else
							sprite.x -= 6
							sprite.y += 10
						end
					else
						@countarray[i] += 1
						if @countarray[i] == 0
							sprite.bitmap = @meteor_bitmap
							sprite.opacity = 0
							@count_array = 1
						end
					end
				end
				if @type == 18
					sprite.y += 2
					case @countarray[i] % 3
					when 0
						sprite.x -= 1
					when 1
						sprite.x += 1
					end
				end
				
				x = sprite.x - @ox
				y = sprite.y - @oy
				if sprite.opacity < 64 or x < -50 or x > 750 or y < -300 or y > 500
					sprite.x = rand(800) - 50 + @ox
					sprite.y = rand(800) - 200 + @oy
					sprite.opacity = 255
				end
			end
		end
		
		def make_bitmaps
			color1 = Color.new(255, 255, 255, 255)
			color2 = Color.new(255, 255, 255, 128)
			@rain_bitmap = Bitmap.new(7, 56)
			for i in 0..6
				@rain_bitmap.fill_rect(6-i, i*8, 1, 8, color1)
			end
			@storm_bitmap = Bitmap.new(34, 64)
			for i in 0..31
				@storm_bitmap.fill_rect(33-i, i*2, 1, 2, color2)
				@storm_bitmap.fill_rect(32-i, i*2, 1, 2, color1)
				@storm_bitmap.fill_rect(31-i, i*2, 1, 2, color2)
			end
			@snow_bitmap = Bitmap.new(6, 6)
			@snow_bitmap.fill_rect(0, 1, 6, 4, color2)
			@snow_bitmap.fill_rect(1, 0, 4, 6, color2)
			@snow_bitmap.fill_rect(1, 2, 4, 2, color1)
			@snow_bitmap.fill_rect(2, 1, 2, 4, color1)
			@sprites = []
			
			blueGrey  = Color.new(215, 227, 227, 150)
			grey      = Color.new(214, 217, 217, 150)
			lightGrey = Color.new(233, 233, 233, 250)
			lightBlue = Color.new(222, 239, 243, 250)
			@hail_bitmap = Bitmap.new(4, 4)
			@hail_bitmap.fill_rect(1, 0, 2, 1, blueGrey)
			@hail_bitmap.fill_rect(0, 1, 1, 2, blueGrey)
			@hail_bitmap.fill_rect(3, 1, 1, 2, grey)
			@hail_bitmap.fill_rect(1, 3, 2, 1, grey)
			@hail_bitmap.fill_rect(1, 1, 2, 2, lightGrey)
			@hail_bitmap.set_pixel(1, 1, lightBlue)
			
			
			color3 = Color.new(255, 167, 192, 255) # light pink
			color4 = Color.new(213, 106, 136, 255) # dark pink
			@petal_bitmap = Bitmap.new(4, 4) #This creates a new bitmap that is 4 x 4 pixels
			@petal_bitmap.fill_rect(0, 3, 1, 1, color3) # this makes a 1x1 pixel "rectangle" at the 0, 3 pixel of the image (upper left corner is 0, 0)
			@petal_bitmap.fill_rect(1, 2, 1, 1, color3)
			@petal_bitmap.fill_rect(2, 1, 1, 1, color3)
			@petal_bitmap.fill_rect(3, 0, 1, 1, color3)
			@petal_bitmap.fill_rect(1, 3, 1, 1, color4)
			@petal_bitmap.fill_rect(2, 2, 1, 1, color4)
			@petal_bitmap.fill_rect(3, 1, 1, 1, color4)
			
			
			brightOrange = Color.new(248, 88, 0, 255)   
			orangeBrown  = Color.new(144, 80, 56, 255) 
			burntRed     = Color.new(152, 0, 0, 255) 
			paleOrange   = Color.new(232, 160, 128, 255) 
			darkBrown    = Color.new(72, 40, 0, 255)
			@autumn_leaf_bitmaps = []
			@autumn_leaf_bitmaps.push(Bitmap.new(8, 8))
			# draw the first of the leaf1 bitmaps
			@autumn_leaf_bitmaps[0].set_pixel(5, 1, orangeBrown)
			@autumn_leaf_bitmaps[0].set_pixel(6, 1, brightOrange)
			@autumn_leaf_bitmaps[0].set_pixel(7, 1, paleOrange)
			@autumn_leaf_bitmaps[0].set_pixel(3, 2, orangeBrown)
			@autumn_leaf_bitmaps[0].fill_rect(4, 2, 2, 1, brightOrange)
			@autumn_leaf_bitmaps[0].set_pixel(6, 2, paleOrange)
			@autumn_leaf_bitmaps[0].set_pixel(2, 3, orangeBrown)
			@autumn_leaf_bitmaps[0].set_pixel(3, 3, brightOrange)
			@autumn_leaf_bitmaps[0].fill_rect(4, 3, 2, 1, paleOrange)
			@autumn_leaf_bitmaps[0].set_pixel(1, 4, orangeBrown)
			@autumn_leaf_bitmaps[0].set_pixel(2, 4, brightOrange)
			@autumn_leaf_bitmaps[0].set_pixel(3, 4, paleOrange)
			@autumn_leaf_bitmaps[0].set_pixel(1, 5, brightOrange)
			@autumn_leaf_bitmaps[0].set_pixel(2, 5, paleOrange)
			@autumn_leaf_bitmaps[0].set_pixel(0, 6, orangeBrown)
			@autumn_leaf_bitmaps[0].set_pixel(1, 6, paleOrange)
			@autumn_leaf_bitmaps[0].set_pixel(0, 7, paleOrange)
			
			# draw the 2nd of the leaf1 bitmaps
			@autumn_leaf_bitmaps.push(Bitmap.new(8, 8))
			@autumn_leaf_bitmaps[1].set_pixel(3, 0, brightOrange)
			@autumn_leaf_bitmaps[1].set_pixel(7, 0, brightOrange)
			@autumn_leaf_bitmaps[1].set_pixel(3, 1, orangeBrown)
			@autumn_leaf_bitmaps[1].set_pixel(4, 1, burntRed)
			@autumn_leaf_bitmaps[1].set_pixel(6, 1, brightOrange)
			@autumn_leaf_bitmaps[1].set_pixel(0, 2, paleOrange)
			@autumn_leaf_bitmaps[1].set_pixel(1, 2, brightOrange)
			@autumn_leaf_bitmaps[1].set_pixel(2, 2, orangeBrown)
			@autumn_leaf_bitmaps[1].set_pixel(3, 2, burntRed)
			@autumn_leaf_bitmaps[1].set_pixel(4, 2, orangeBrown)
			@autumn_leaf_bitmaps[1].set_pixel(5, 2, brightOrange)
			@autumn_leaf_bitmaps[1].fill_rect(1, 3, 3, 1, orangeBrown)
			@autumn_leaf_bitmaps[1].fill_rect(4, 3, 2, 1, brightOrange)
			@autumn_leaf_bitmaps[1].set_pixel(6, 3, orangeBrown)
			@autumn_leaf_bitmaps[1].set_pixel(2, 4, burntRed)
			@autumn_leaf_bitmaps[1].fill_rect(3, 4, 3, 1, brightOrange)
			@autumn_leaf_bitmaps[1].set_pixel(6, 4, burntRed)
			@autumn_leaf_bitmaps[1].set_pixel(7, 4, darkBrown)
			@autumn_leaf_bitmaps[1].set_pixel(1, 5, orangeBrown)
			@autumn_leaf_bitmaps[1].fill_rect(2, 5, 2, 1, brightOrange)
			@autumn_leaf_bitmaps[1].set_pixel(4, 5, orangeBrown)
			@autumn_leaf_bitmaps[1].set_pixel(5, 5, burntRed)
			@autumn_leaf_bitmaps[1].fill_rect(1, 6, 2, 1, brightOrange)
			@autumn_leaf_bitmaps[1].fill_rect(4, 6, 2, 1, burntRed)
			@autumn_leaf_bitmaps[1].set_pixel(0, 7, brightOrange)
			@autumn_leaf_bitmaps[1].set_pixel(5, 7, darkBrown)
			
			# draw the 3rd of the leaf1 bitmaps
			@autumn_leaf_bitmaps.push(Bitmap.new(8, 8))
			@autumn_leaf_bitmaps[2].set_pixel(7, 1, paleOrange)
			@autumn_leaf_bitmaps[2].set_pixel(6, 2, paleOrange)
			@autumn_leaf_bitmaps[2].set_pixel(7, 2, orangeBrown)
			@autumn_leaf_bitmaps[2].set_pixel(5, 3, paleOrange)
			@autumn_leaf_bitmaps[2].set_pixel(6, 3, brightOrange)
			@autumn_leaf_bitmaps[2].set_pixel(4, 4, paleOrange)
			@autumn_leaf_bitmaps[2].set_pixel(5, 4, brightOrange)
			@autumn_leaf_bitmaps[2].set_pixel(6, 4, orangeBrown)
			@autumn_leaf_bitmaps[2].fill_rect(2, 5, 2, 1, paleOrange)
			@autumn_leaf_bitmaps[2].set_pixel(4, 5, brightOrange)
			@autumn_leaf_bitmaps[2].set_pixel(5, 5, orangeBrown)
			@autumn_leaf_bitmaps[2].set_pixel(1, 6, paleOrange)
			@autumn_leaf_bitmaps[2].fill_rect(2, 6, 2, 1, brightOrange)
			@autumn_leaf_bitmaps[2].set_pixel(4, 6, orangeBrown)
			@autumn_leaf_bitmaps[2].set_pixel(0, 7, paleOrange)
			@autumn_leaf_bitmaps[2].set_pixel(1, 7, brightOrange)
			@autumn_leaf_bitmaps[2].set_pixel(2, 7, orangeBrown)
			
			# draw the 4th of the leaf1 bitmaps
			@autumn_leaf_bitmaps.push(Bitmap.new(8, 8))
			@autumn_leaf_bitmaps[3].set_pixel(3, 0, brightOrange)
			@autumn_leaf_bitmaps[3].set_pixel(7, 0, brightOrange)
			@autumn_leaf_bitmaps[3].set_pixel(3, 1, orangeBrown)
			@autumn_leaf_bitmaps[3].set_pixel(4, 1, burntRed)
			@autumn_leaf_bitmaps[3].set_pixel(6, 1, brightOrange)
			@autumn_leaf_bitmaps[3].set_pixel(0, 2, paleOrange)
			@autumn_leaf_bitmaps[3].set_pixel(1, 2, brightOrange)
			@autumn_leaf_bitmaps[3].set_pixel(2, 2, orangeBrown)
			@autumn_leaf_bitmaps[3].set_pixel(3, 2, burntRed)
			@autumn_leaf_bitmaps[3].set_pixel(4, 2, orangeBrown)
			@autumn_leaf_bitmaps[3].set_pixel(5, 2, brightOrange)
			@autumn_leaf_bitmaps[3].fill_rect(1, 3, 3, 1, orangeBrown)
			@autumn_leaf_bitmaps[3].fill_rect(4, 3, 2, 1, brightOrange)
			@autumn_leaf_bitmaps[3].set_pixel(6, 3, orangeBrown)
			@autumn_leaf_bitmaps[3].set_pixel(2, 4, burntRed)
			@autumn_leaf_bitmaps[3].fill_rect(3, 4, 3, 1, brightOrange)
			@autumn_leaf_bitmaps[3].set_pixel(6, 4, burntRed)
			@autumn_leaf_bitmaps[3].set_pixel(7, 4, darkBrown)
			@autumn_leaf_bitmaps[3].set_pixel(1, 5, orangeBrown)
			@autumn_leaf_bitmaps[3].fill_rect(2, 5, 2, 1, brightOrange)
			@autumn_leaf_bitmaps[3].set_pixel(4, 5, orangeBrown)
			@autumn_leaf_bitmaps[3].set_pixel(5, 5, burntRed)
			@autumn_leaf_bitmaps[3].fill_rect(1, 6, 2, 1, brightOrange)
			@autumn_leaf_bitmaps[3].fill_rect(4, 6, 2, 1, burntRed)
			@autumn_leaf_bitmaps[3].set_pixel(0, 7, brightOrange)
			@autumn_leaf_bitmaps[3].set_pixel(5, 7, darkBrown)
			
			@green_leaf_bitmaps = []
			darkGreen  = Color.new(62, 76, 31, 255)
			midGreen   = Color.new(76, 91, 43, 255)
			khaki      = Color.new(105, 114, 66, 255)
			lightGreen = Color.new(128, 136, 88, 255)
			mint       = Color.new(146, 154, 106, 255)
			
			# 1st leaf bitmap
			@green_leaf_bitmaps[0] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[0].set_pixel(1, 0, darkGreen)
			@green_leaf_bitmaps[0].set_pixel(1, 1, midGreen)
			@green_leaf_bitmaps[0].set_pixel(2, 1, darkGreen)
			@green_leaf_bitmaps[0].set_pixel(2, 2, khaki)
			@green_leaf_bitmaps[0].set_pixel(3, 2, darkGreen)
			@green_leaf_bitmaps[0].set_pixel(4, 2, khaki)
			@green_leaf_bitmaps[0].fill_rect(2, 3, 3, 1, midGreen)
			@green_leaf_bitmaps[0].set_pixel(5, 3, khaki)
			@green_leaf_bitmaps[0].fill_rect(2, 4, 2, 1, midGreen)
			@green_leaf_bitmaps[0].set_pixel(4, 4, darkGreen)
			@green_leaf_bitmaps[0].set_pixel(5, 4, lightGreen)
			@green_leaf_bitmaps[0].set_pixel(6, 4, khaki)
			@green_leaf_bitmaps[0].set_pixel(3, 5, midGreen)
			@green_leaf_bitmaps[0].set_pixel(4, 5, darkGreen)
			@green_leaf_bitmaps[0].set_pixel(5, 5, khaki)
			@green_leaf_bitmaps[0].set_pixel(6, 5, lightGreen)
			@green_leaf_bitmaps[0].set_pixel(4, 6, midGreen)
			@green_leaf_bitmaps[0].set_pixel(5, 6, darkGreen)
			@green_leaf_bitmaps[0].set_pixel(6, 6, lightGreen)
			@green_leaf_bitmaps[0].set_pixel(6, 7, khaki)
			
			# 2nd leaf bitmap
			@green_leaf_bitmaps[1] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[1].fill_rect(1, 1, 1, 2, midGreen)
			@green_leaf_bitmaps[1].fill_rect(2, 2, 2, 1, khaki)
			@green_leaf_bitmaps[1].set_pixel(4, 2, lightGreen)
			@green_leaf_bitmaps[1].fill_rect(2, 3, 2, 1, darkGreen)
			@green_leaf_bitmaps[1].fill_rect(4, 3, 2, 1, lightGreen)
			@green_leaf_bitmaps[1].set_pixel(2, 4, midGreen)
			@green_leaf_bitmaps[1].set_pixel(3, 4, darkGreen)
			@green_leaf_bitmaps[1].set_pixel(4, 4, khaki)
			@green_leaf_bitmaps[1].fill_rect(5, 4, 2, 1, lightGreen)
			@green_leaf_bitmaps[1].set_pixel(3, 5, midGreen)
			@green_leaf_bitmaps[1].set_pixel(4, 5, darkGreen)
			@green_leaf_bitmaps[1].set_pixel(5, 5, khaki)
			@green_leaf_bitmaps[1].set_pixel(6, 5, lightGreen)
			@green_leaf_bitmaps[1].set_pixel(5, 6, darkGreen)
			@green_leaf_bitmaps[1].fill_rect(6, 6, 2, 1, khaki)
			
			# 3rd leaf bitmap
			@green_leaf_bitmaps[2] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[2].set_pixel(1, 1, darkGreen)
			@green_leaf_bitmaps[2].fill_rect(1, 2, 2, 1, midGreen)
			@green_leaf_bitmaps[2].set_pixel(2, 3, midGreen)
			@green_leaf_bitmaps[2].set_pixel(3, 3, darkGreen)
			@green_leaf_bitmaps[2].set_pixel(4, 3, midGreen)
			@green_leaf_bitmaps[2].fill_rect(2, 4, 2, 1, midGreen)
			@green_leaf_bitmaps[2].set_pixel(4, 4, darkGreen)
			@green_leaf_bitmaps[2].set_pixel(5, 4, lightGreen)
			@green_leaf_bitmaps[2].set_pixel(3, 5, midGreen)
			@green_leaf_bitmaps[2].set_pixel(4, 5, darkGreen)
			@green_leaf_bitmaps[2].fill_rect(5, 5, 2, 1, khaki)
			@green_leaf_bitmaps[2].fill_rect(4, 6, 2, 1, midGreen)
			@green_leaf_bitmaps[2].set_pixel(6, 6, lightGreen)
			@green_leaf_bitmaps[2].set_pixel(6, 7, khaki)
			
			# 4th leaf bitmap
			@green_leaf_bitmaps[3] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[3].fill_rect(0, 3, 1, 2, darkGreen)
			@green_leaf_bitmaps[3].set_pixel(1, 4, midGreen)
			@green_leaf_bitmaps[3].set_pixel(2, 4, khaki)
			@green_leaf_bitmaps[3].set_pixel(3, 4, lightGreen)
			@green_leaf_bitmaps[3].set_pixel(4, 4, darkGreen)
			@green_leaf_bitmaps[3].set_pixel(7, 4, midGreen)
			@green_leaf_bitmaps[3].set_pixel(1, 5, darkGreen)
			@green_leaf_bitmaps[3].set_pixel(2, 5, midGreen)
			@green_leaf_bitmaps[3].set_pixel(3, 5, lightGreen)
			@green_leaf_bitmaps[3].set_pixel(4, 5, mint)
			@green_leaf_bitmaps[3].set_pixel(5, 5, lightGreen)
			@green_leaf_bitmaps[3].set_pixel(6, 5, khaki)
			@green_leaf_bitmaps[3].set_pixel(7, 5, midGreen)
			@green_leaf_bitmaps[3].fill_rect(2, 6, 2, 1, midGreen)
			@green_leaf_bitmaps[3].set_pixel(4, 6, lightGreen)
			@green_leaf_bitmaps[3].set_pixel(5, 6, khaki)
			@green_leaf_bitmaps[3].set_pixel(6, 6, midGreen)
			
			# 5th leaf bitmap
			@green_leaf_bitmaps[4] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[4].set_pixel(6, 2, midGreen)
			@green_leaf_bitmaps[4].set_pixel(7, 2, darkGreen)
			@green_leaf_bitmaps[4].fill_rect(4, 3, 2, 1, midGreen)
			@green_leaf_bitmaps[4].set_pixel(6, 3, khaki)
			@green_leaf_bitmaps[4].set_pixel(2, 4, darkGreen)
			@green_leaf_bitmaps[4].fill_rect(3, 4, 2, 1, khaki)
			@green_leaf_bitmaps[4].set_pixel(5, 4, lightGreen)
			@green_leaf_bitmaps[4].set_pixel(6, 4, khaki)
			@green_leaf_bitmaps[4].set_pixel(1, 5, midGreen)
			@green_leaf_bitmaps[4].set_pixel(2, 5, khaki)
			@green_leaf_bitmaps[4].set_pixel(3, 5, lightGreen)
			@green_leaf_bitmaps[4].set_pixel(4, 5, mint)
			@green_leaf_bitmaps[4].set_pixel(5, 5, midGreen)
			@green_leaf_bitmaps[4].set_pixel(2, 6, darkGreen)
			@green_leaf_bitmaps[4].fill_rect(3, 6, 2, 1, midGreen)
			
			# 6th leaf bitmap
			@green_leaf_bitmaps[5] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[5].fill_rect(6, 2, 2, 1, midGreen)
			@green_leaf_bitmaps[5].fill_rect(4, 3, 2, 1, midGreen)
			@green_leaf_bitmaps[5].set_pixel(6, 3, khaki)
			@green_leaf_bitmaps[5].set_pixel(3, 4, midGreen)
			@green_leaf_bitmaps[5].set_pixel(4, 4, khaki)
			@green_leaf_bitmaps[5].set_pixel(5, 4, lightGreen)
			@green_leaf_bitmaps[5].set_pixel(6, 4, mint)
			@green_leaf_bitmaps[5].set_pixel(1, 5, midGreen)
			@green_leaf_bitmaps[5].set_pixel(2, 5, khaki)
			@green_leaf_bitmaps[5].fill_rect(3, 5, 2, 1, mint)
			@green_leaf_bitmaps[5].set_pixel(5, 5, lightGreen)
			@green_leaf_bitmaps[5].set_pixel(2, 6, midGreen)
			@green_leaf_bitmaps[5].set_pixel(3, 6, khaki)
			@green_leaf_bitmaps[5].set_pixel(4, 6, lightGreen)
			
			# 7th leaf bitmap
			@green_leaf_bitmaps[6] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[6].fill_rect(6, 1, 1, 2, midGreen)
			@green_leaf_bitmaps[6].fill_rect(4, 2, 2, 1, midGreen)
			@green_leaf_bitmaps[6].fill_rect(6, 2, 1, 2, darkGreen)
			@green_leaf_bitmaps[6].fill_rect(3, 3, 2, 1, midGreen)
			@green_leaf_bitmaps[6].set_pixel(5, 3, khaki)
			@green_leaf_bitmaps[6].set_pixel(2, 4, midGreen)
			@green_leaf_bitmaps[6].set_pixel(3, 4, khaki)
			@green_leaf_bitmaps[6].set_pixel(4, 4, lightGreen)
			@green_leaf_bitmaps[6].set_pixel(5, 4, midGreen)
			@green_leaf_bitmaps[6].set_pixel(1, 5, midGreen)
			@green_leaf_bitmaps[6].set_pixel(2, 5, khaki)
			@green_leaf_bitmaps[6].fill_rect(3, 5, 2, 1, midGreen)
			@green_leaf_bitmaps[6].set_pixel(1, 6, darkGreen)
			@green_leaf_bitmaps[6].set_pixel(2, 6, midGreen)
			
			# 8th leaf bitmap
			@green_leaf_bitmaps[7] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[7].set_pixel(6, 1, midGreen)
			@green_leaf_bitmaps[7].fill_rect(4, 2, 3, 2, midGreen)
			@green_leaf_bitmaps[7].set_pixel(3, 3, darkGreen)
			@green_leaf_bitmaps[7].set_pixel(2, 4, darkGreen)
			@green_leaf_bitmaps[7].set_pixel(3, 4, midGreen)
			@green_leaf_bitmaps[7].fill_rect(4, 4, 2, 1, khaki)
			@green_leaf_bitmaps[7].set_pixel(1, 5, darkGreen)
			@green_leaf_bitmaps[7].set_pixel(2, 5, midGreen)
			@green_leaf_bitmaps[7].fill_rect(3, 5, 2, 1, lightGreen)
			@green_leaf_bitmaps[7].set_pixel(2, 6, midGreen)
			@green_leaf_bitmaps[7].set_pixel(3, 6, lightGreen)
			
			# 9th leaf bitmap
			@green_leaf_bitmaps[8] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[8].fill_rect(6, 1, 1, 2, midGreen)
			@green_leaf_bitmaps[8].fill_rect(4, 2, 2, 1, midGreen)
			@green_leaf_bitmaps[8].fill_rect(6, 2, 1, 2, darkGreen)
			@green_leaf_bitmaps[8].fill_rect(3, 3, 2, 1, midGreen)
			@green_leaf_bitmaps[8].set_pixel(5, 3, khaki)
			@green_leaf_bitmaps[8].set_pixel(2, 4, midGreen)
			@green_leaf_bitmaps[8].set_pixel(3, 4, khaki)
			@green_leaf_bitmaps[8].set_pixel(4, 4, lightGreen)
			@green_leaf_bitmaps[8].set_pixel(5, 4, midGreen)
			@green_leaf_bitmaps[8].set_pixel(1, 5, midGreen)
			@green_leaf_bitmaps[8].set_pixel(2, 5, khaki)
			@green_leaf_bitmaps[8].fill_rect(3, 5, 2, 1, midGreen)
			@green_leaf_bitmaps[8].set_pixel(1, 6, darkGreen)
			@green_leaf_bitmaps[8].set_pixel(2, 6, midGreen)
			
			# 10th leaf bitmap
			@green_leaf_bitmaps[9] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[9].fill_rect(6, 2, 2, 1, midGreen)
			@green_leaf_bitmaps[9].fill_rect(4, 3, 2, 1, midGreen)
			@green_leaf_bitmaps[9].set_pixel(6, 3, khaki)
			@green_leaf_bitmaps[9].set_pixel(3, 4, midGreen)
			@green_leaf_bitmaps[9].set_pixel(4, 4, khaki)
			@green_leaf_bitmaps[9].set_pixel(5, 4, lightGreen)
			@green_leaf_bitmaps[9].set_pixel(6, 4, mint)
			@green_leaf_bitmaps[9].set_pixel(1, 5, midGreen)
			@green_leaf_bitmaps[9].set_pixel(2, 5, khaki)
			@green_leaf_bitmaps[9].fill_rect(3, 5, 2, 1, mint)
			@green_leaf_bitmaps[9].set_pixel(5, 5, lightGreen)
			@green_leaf_bitmaps[9].set_pixel(2, 6, midGreen)
			@green_leaf_bitmaps[9].set_pixel(3, 6, khaki)
			@green_leaf_bitmaps[9].set_pixel(4, 6, lightGreen)
			
			# 11th leaf bitmap
			@green_leaf_bitmaps[10] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[10].set_pixel(6, 2, midGreen)
			@green_leaf_bitmaps[10].set_pixel(7, 2, darkGreen)
			@green_leaf_bitmaps[10].fill_rect(4, 3, 2, 1, midGreen)
			@green_leaf_bitmaps[10].set_pixel(6, 3, khaki)
			@green_leaf_bitmaps[10].set_pixel(2, 4, darkGreen)
			@green_leaf_bitmaps[10].fill_rect(3, 4, 2, 1, khaki)
			@green_leaf_bitmaps[10].set_pixel(5, 4, lightGreen)
			@green_leaf_bitmaps[10].set_pixel(6, 4, khaki)
			@green_leaf_bitmaps[10].set_pixel(1, 5, midGreen)
			@green_leaf_bitmaps[10].set_pixel(2, 5, khaki)
			@green_leaf_bitmaps[10].set_pixel(3, 5, lightGreen)
			@green_leaf_bitmaps[10].set_pixel(4, 5, mint)
			@green_leaf_bitmaps[10].set_pixel(5, 5, midGreen)
			@green_leaf_bitmaps[10].set_pixel(2, 6, darkGreen)
			@green_leaf_bitmaps[10].fill_rect(3, 6, 2, 1, midGreen)
			
			# 12th leaf bitmap
			@green_leaf_bitmaps[11] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[11].fill_rect(0, 3, 1, 2, darkGreen)
			@green_leaf_bitmaps[11].set_pixel(1, 4, midGreen)
			@green_leaf_bitmaps[11].set_pixel(2, 4, khaki)
			@green_leaf_bitmaps[11].set_pixel(3, 4, lightGreen)
			@green_leaf_bitmaps[11].set_pixel(4, 4, darkGreen)
			@green_leaf_bitmaps[11].set_pixel(7, 4, midGreen)
			@green_leaf_bitmaps[11].set_pixel(1, 5, darkGreen)
			@green_leaf_bitmaps[11].set_pixel(2, 5, midGreen)
			@green_leaf_bitmaps[11].set_pixel(3, 5, lightGreen)
			@green_leaf_bitmaps[11].set_pixel(4, 5, mint)
			@green_leaf_bitmaps[11].set_pixel(5, 5, lightGreen)
			@green_leaf_bitmaps[11].set_pixel(6, 5, khaki)
			@green_leaf_bitmaps[11].set_pixel(7, 5, midGreen)
			@green_leaf_bitmaps[11].fill_rect(2, 6, 2, 1, midGreen)
			@green_leaf_bitmaps[11].set_pixel(4, 6, lightGreen)
			@green_leaf_bitmaps[11].set_pixel(5, 6, khaki)
			@green_leaf_bitmaps[11].set_pixel(6, 6, midGreen)
			
			# 13th leaf bitmap
			@green_leaf_bitmaps[12] = Bitmap.new(8, 8)
			@green_leaf_bitmaps[12].set_pixel(1, 1, darkGreen)
			@green_leaf_bitmaps[12].fill_rect(1, 2, 2, 1, midGreen)
			@green_leaf_bitmaps[12].set_pixel(2, 3, midGreen)
			@green_leaf_bitmaps[12].set_pixel(3, 3, darkGreen)
			@green_leaf_bitmaps[12].set_pixel(4, 3, midGreen)
			@green_leaf_bitmaps[12].fill_rect(2, 4, 2, 1, midGreen)
			@green_leaf_bitmaps[12].set_pixel(4, 4, darkGreen)
			@green_leaf_bitmaps[12].set_pixel(5, 4, lightGreen)
			@green_leaf_bitmaps[12].set_pixel(3, 5, midGreen)
			@green_leaf_bitmaps[12].set_pixel(4, 5, darkGreen)
			@green_leaf_bitmaps[12].fill_rect(5, 5, 2, 1, khaki)
			@green_leaf_bitmaps[12].fill_rect(4, 6, 2, 1, midGreen)
			@green_leaf_bitmaps[12].set_pixel(6, 6, lightGreen)
			@green_leaf_bitmaps[12].set_pixel(6, 7, khaki)
			
			@rose_bitmaps = []
			brightRed = Color.new(255, 0, 0, 255)
			midRed    = Color.new(179, 17, 17, 255)
			darkRed   = Color.new(141, 9, 9, 255)
			
			# 1st rose petal bitmap
			@rose_bitmaps[0] = Bitmap.new(3, 3)
			@rose_bitmaps[0].fill_rect(1, 0, 2, 1, brightRed)
			@rose_bitmaps[0].fill_rect(0, 1, 1, 2, brightRed)
			@rose_bitmaps[0].fill_rect(1, 1, 2, 2, midRed)
			@rose_bitmaps[0].set_pixel(2, 2, darkRed)
			
			# 2nd rose petal bitmap
			@rose_bitmaps[1] = Bitmap.new(3, 3)
			@rose_bitmaps[1].set_pixel(0, 1, midRed)
			@rose_bitmaps[1].set_pixel(1, 1, brightRed)
			@rose_bitmaps[1].fill_rect(1, 2, 1, 2, midRed)
			
			@feather_bitmaps = []
			white = Color.new(255, 255, 255, 255)
			
			# 1st feather bitmap
			@feather_bitmaps[0] = Bitmap.new(3, 3)
			@feather_bitmaps[0].set_pixel(0, 2, white)
			@feather_bitmaps[0].set_pixel(1, 2, grey)
			@feather_bitmaps[0].set_pixel(2, 1, grey)
			
			# 2nd feather bitmap
			@feather_bitmaps[0] = Bitmap.new(3, 3)
			@feather_bitmaps[0].set_pixel(0, 0, white)
			@feather_bitmaps[0].set_pixel(0, 1, grey)
			@feather_bitmaps[0].set_pixel(1, 2, grey)
			
			# 3rd feather bitmap
			@feather_bitmaps[0] = Bitmap.new(3, 3)
			@feather_bitmaps[0].set_pixel(2, 0, white)
			@feather_bitmaps[0].set_pixel(1, 0, grey)
			@feather_bitmaps[0].set_pixel(0, 1, grey)
			
			# 4th feather bitmap
			@feather_bitmaps[0] = Bitmap.new(3, 3)
			@feather_bitmaps[0].set_pixel(2, 2, white)
			@feather_bitmaps[0].set_pixel(2, 1, grey)
			@feather_bitmaps[0].set_pixel(1, 0, grey)
			
			@blood_rain_bitmap = Bitmap.new(7, 56)
			for i in 0..6
				@blood_rain_bitmap.fill_rect(6-i, i*8, 1, 8, darkRed)
			end
			
			@sparkle_bitmaps = []
			
			lightBlue = Color.new(181, 244, 255, 255)
			midBlue   = Color.new(126, 197, 235, 255)
			darkBlue  = Color.new(77, 136, 225, 255)
			
			# 1st sparkle bitmap
			@sparkle_bitmaps[0] = Bitmap.new(7, 7)
			@sparkle_bitmaps[0].set_pixel(3, 3, darkBlue)
			
			# 2nd sparkle bitmap
			@sparkle_bitmaps[1] = Bitmap.new(7, 7)
			@sparkle_bitmaps[1].fill_rect(3, 2, 1, 3, darkBlue)
			@sparkle_bitmaps[1].fill_rect(2, 3, 3, 1, darkBlue)
			@sparkle_bitmaps[1].set_pixel(3, 3, midBlue)
			
			# 3rd sparkle bitmap
			@sparkle_bitmaps[2] = Bitmap.new(7, 7)
			@sparkle_bitmaps[2].set_pixel(1, 1, darkBlue)
			@sparkle_bitmaps[2].set_pixel(5, 1, darkBlue)
			@sparkle_bitmaps[2].set_pixel(2, 2, midBlue)
			@sparkle_bitmaps[2].set_pixel(4, 2, midBlue)
			@sparkle_bitmaps[2].set_pixel(3, 3, lightBlue)
			@sparkle_bitmaps[2].set_pixel(2, 4, midBlue)
			@sparkle_bitmaps[2].set_pixel(4, 4, midBlue)
			@sparkle_bitmaps[2].set_pixel(1, 5, darkBlue)
			@sparkle_bitmaps[2].set_pixel(5, 5, darkBlue)
			
			# 4th sparkle bitmap
			@sparkle_bitmaps[3] = Bitmap.new(7, 7)
			@sparkle_bitmaps[3].fill_rect(3, 1, 1, 5, darkBlue)
			@sparkle_bitmaps[3].fill_rect(1, 3, 5, 1, darkBlue)
			@sparkle_bitmaps[3].fill_rect(3, 2, 1, 3, midBlue)
			@sparkle_bitmaps[3].fill_rect(2, 3, 3, 1, midBlue)
			@sparkle_bitmaps[3].set_pixel(3, 3, lightBlue)
			
			# 5th sparkle bitmap
			@sparkle_bitmaps[4] = Bitmap.new(7, 7)
			@sparkle_bitmaps[4].fill_rect(2, 2, 3, 3, midBlue)
			@sparkle_bitmaps[4].fill_rect(3, 2, 1, 3, darkBlue)
			@sparkle_bitmaps[4].fill_rect(2, 3, 3, 1, darkBlue)
			@sparkle_bitmaps[4].set_pixel(3, 3, lightBlue)
			@sparkle_bitmaps[4].set_pixel(1, 1, darkBlue)
			@sparkle_bitmaps[4].set_pixel(5, 1, darkBlue)
			@sparkle_bitmaps[4].set_pixel(1, 5, darkBlue)
			@sparkle_bitmaps[4].set_pixel(5, 1, darkBlue)
			
			# 6th sparkle bitmap
			@sparkle_bitmaps[5] = Bitmap.new(7, 7)
			@sparkle_bitmaps[5].fill_rect(2, 1, 3, 5, darkBlue)
			@sparkle_bitmaps[5].fill_rect(1, 2, 5, 3, darkBlue)
			@sparkle_bitmaps[5].fill_rect(2, 2, 3, 3, midBlue)
			@sparkle_bitmaps[5].fill_rect(3, 1, 1, 5, midBlue)
			@sparkle_bitmaps[5].fill_rect(1, 3, 5, 1, midBlue)
			@sparkle_bitmaps[5].fill_rect(3, 2, 1, 3, lightBlue)
			@sparkle_bitmaps[5].fill_rect(2, 3, 3, 1, lightBlue)
			@sparkle_bitmaps[5].set_pixel(3, 3, white)
			
			# 7th sparkle bitmap
			@sparkle_bitmaps[6] = Bitmap.new(7, 7)
			@sparkle_bitmaps[6].fill_rect(2, 1, 3, 5, midBlue)
			@sparkle_bitmaps[6].fill_rect(1, 2, 5, 3, midBlue)
			@sparkle_bitmaps[6].fill_rect(3, 0, 1, 7, darkBlue)
			@sparkle_bitmaps[6].fill_rect(0, 3, 7, 1, darkBlue)
			@sparkle_bitmaps[6].fill_rect(2, 2, 3, 3, lightBlue)
			@sparkle_bitmaps[6].fill_rect(3, 2, 1, 3, midBlue)
			@sparkle_bitmaps[6].fill_rect(2, 3, 3, 1, midBlue)
			@sparkle_bitmaps[6].set_pixel(3, 3, white)
			
			# Meteor bitmap
			@meteor_bitmap = Bitmap.new(14, 12)
			@meteor_bitmap.fill_rect(0, 8, 5, 4, paleOrange)
			@meteor_bitmap.fill_rect(1, 7, 6, 4, paleOrange)
			@meteor_bitmap.set_pixel(7, 8, paleOrange)
			@meteor_bitmap.fill_rect(1, 8, 2, 2, brightOrange)
			@meteor_bitmap.set_pixel(2, 7, brightOrange)
			@meteor_bitmap.fill_rect(3, 6, 2, 1, brightOrange)
			@meteor_bitmap.set_pixel(3, 8, brightOrange)
			@meteor_bitmap.set_pixel(3, 10, brightOrange)
			@meteor_bitmap.set_pixel(4, 9, brightOrange)
			@meteor_bitmap.fill_rect(5, 5, 1, 5, brightOrange)
			@meteor_bitmap.fill_rect(6, 4, 1, 5, brightOrange)
			@meteor_bitmap.fill_rect(7, 3, 1, 5, brightOrange)
			@meteor_bitmap.fill_rect(8, 6, 1, 2, brightOrange)
			@meteor_bitmap.set_pixel(9, 5, brightOrange)
			@meteor_bitmap.set_pixel(3, 8, midRed)
			@meteor_bitmap.fill_rect(4, 7, 1, 2, midRed)
			@meteor_bitmap.set_pixel(4, 5, midRed)
			@meteor_bitmap.set_pixel(5, 4, midRed)
			@meteor_bitmap.set_pixel(5, 6, midRed)
			@meteor_bitmap.set_pixel(6, 5, midRed)
			@meteor_bitmap.set_pixel(6, 7, midRed)
			@meteor_bitmap.fill_rect(7, 4, 1, 3, midRed)
			@meteor_bitmap.fill_rect(8, 3, 1, 3, midRed)
			@meteor_bitmap.fill_rect(9, 2, 1, 3, midRed)
			@meteor_bitmap.fill_rect(10, 1, 1, 3, midRed)
			@meteor_bitmap.fill_rect(11, 0, 1, 3, midRed)
			@meteor_bitmap.fill_rect(12, 0, 1, 2, midRed)
			@meteor_bitmap.set_pixel(13, 0, midRed)
			
			# impact bitmap
			@impact_bitmap = Bitmap.new(22, 11)
			@impact_bitmap.fill_rect(0, 5, 1, 2, brightOrange)
			@impact_bitmap.set_pixel(1, 4, brightOrange)
			@impact_bitmap.set_pixel(1, 6, brightOrange)
			@impact_bitmap.set_pixel(2, 3, brightOrange)
			@impact_bitmap.set_pixel(2, 7, brightOrange)
			@impact_bitmap.set_pixel(3, 2, midRed)
			@impact_bitmap.set_pixel(3, 7, midRed)
			@impact_bitmap.set_pixel(4, 2, brightOrange)
			@impact_bitmap.set_pixel(4, 8, brightOrange)
			@impact_bitmap.set_pixel(5, 2, midRed)
			@impact_bitmap.fill_rect(5, 8, 3, 1, brightOrange)
			@impact_bitmap.set_pixel(6, 1, midRed)
			@impact_bitmap.fill_rect(7, 1, 8, 1, brightOrange)
			@impact_bitmap.fill_rect(7, 9, 8, 1, midRed)
			
			
			# Ash bitmaps
			@ash_bitmaps = []
			@ash_bitmaps[0] = Bitmap.new(3, 3)
			@ash_bitmaps[0].fill_rect(0, 1, 1, 3, lightGrey)
			@ash_bitmaps[0].fill_rect(1, 0, 3, 1, lightGrey)
			@ash_bitmaps[0].set_pixel(1, 1, white)
			@ash_bitmaps[1] = Bitmap.new(3, 3)
			@ash_bitmaps[1].fill_rect(0, 1, 1, 3, grey)
			@ash_bitmaps[1].fill_rect(1, 0, 3, 1, grey)
			@ash_bitmaps[1].set_pixel(1, 1, lightGrey)
			
			@user_bitmaps = []
			update_user_defined
		end
		
		def update_user_defined
			for image in @user_bitmaps
				image.dispose
			end
			
			#user-defined bitmaps
			for name in $WEATHER_IMAGES
				@user_bitmaps.push(RPG::Cache.picture(name))
			end
			for sprite in @sprites
				sprite.bitmap = @user_bitmaps[rand(@user_bitmaps.size)]
			end
		end
		
		attr_reader :type
		attr_reader :max
		attr_reader :ox
		attr_reader :oy
	end
end
