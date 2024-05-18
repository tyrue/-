module ChangeNumberType
	NUMBER_TYPES = {
		0 => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
		1 => ["욜", "꾤", "쑐", "뾸", "쬴", "뚈", "욜", "꾤", "쑐", "뾸"]
	}
end


def change_number_unit(num, type = 0)
	num = num.to_i
	str = ""
	count = 0
	negative = num < 0
	
	num = num.abs
	
	loop do
		str = ChangeNumberType::NUMBER_TYPES[type][num % 10].to_s + str
		num /= 10
		count += 1
		if count == 3
			str = "," + str if num > 0
			count = 0
		end
		break if num == 0
	end
	
	str = "-" + str if negative
	return str
end

# 한글 표시
def change_number_unit_han(num)
  unit = ["만", "억", "조", "경"]
  num = num.to_i
  str = ""
  count = 0
  unit_idx = 0

  loop do
    str = (num % 10).to_s + str
    num /= 10
    count += 1
    if count == 4
			if num > 0
				unit_idx == 0 ? str = unit[unit_idx] : str = unit[unit_idx] + str
			end
      count = 0
      unit_idx += 1
    end
    break if num == 0
  end

  return str
end

