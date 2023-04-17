module Change_number_type
	NUMBER_TYPE = {}
	NUMBER_TYPE[0] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
	NUMBER_TYPE[1] = ["욜", "꾤", "쑐", "뾸", "쬴", "뚈", "욜", "꾤", "쑐", "뾸"]
end


def change_number_unit(num, type = 0)
	num = num.to_i
	str = ""
	count = 0
	
	while true
		str = Change_number_type::NUMBER_TYPE[type][num % 10].to_s + str
		#str = (num % 10).to_s + str
		num /= 10
		count += 1
		if count == 3
			str = "," + str if num > 0
			count = 0
		end
		break if num == 0
	end
	return str
end

# 한글 표시
def change_number_unit_han(num)
	unit = []
	unit.push("만")
	unit.push("억")
	unit.push("조")
	unit.push("경")
	
	num = num.to_i
	str = ""
	count = 0
	unit_idx = 0
	while true
		str = (num % 10).to_s + str
		num /= 10
		count += 1
		if count == 4
			if num > 0
				if unit_idx == 0
					str = unit[unit_idx] 
				else
					str = unit[unit_idx] + str
				end
			end
			count = 0
			unit_idx += 1
		end
		break if num == 0
	end
	return str
end

