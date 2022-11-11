def change_number_unit(num)
	num = num.to_i
	str = ""
	count = 0
	while true
		str = (num % 10).to_s + str
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