#--------------------------------------------------------------------------
# Aqui é o Método de configuração para os equips para adcionar os icones
# relacionado ao ID da arma coloque:
#   return ['equip\\icone_da_arma, o] if id == id_do_item_no_database
# E a mesma coisa com armaduras, porem devem ser adcionados depois do "else"
#   return ['equip\\Icone_defesa', 0] if id == id_do_equip_no_database
#--------------------------------------------------------------------------
if User_Edit::VISUAL_EQUIP_ACTIVE
	def equip_character(type, id)
		if type == 2
			# 무기
			return ['(착용)주작의검'] 		if id == 1 # 신수둔각도(주작)
			return ['(착용)녹호박별검'] 	if id == 2 # 신수둔각도(백호)
			return ['(착용)현무염도'] 		if id == 3 # 신수둔각도(현무)
			return ['(착용)청룡신검'] 		if id == 4 # 신수둔각도(청룡)
			
			return ['(착용)현자금봉']		if id == 6  #현자금봉
			return ['(착용)검성기검']		if id == 7  #검성기검
			return ['(착용)진선역봉']		if id == 8  #진선역봉
			return ['(착용)태성태도']		if id == 9  #태성태도
			
			return ['(착용)철도'] 			if id == 22 or id == 23  #비철단도, 철도
			return ['(착용)야월도'] 			if id == 24   #야월도
			return ['(착용)흑월도'] 			if id == 25   #흑월도
			
			return ['(착용)목도'] 			if id == 101 	#목도
			return ['(착용)목도'] 			if id == 102 	#목검
			return ['(착용)목도'] 			if id == 103 	#사두목도
			return ['(착용)목도'] 			if id == 104 	#사두목검
			return ['(착용)영혼마령봉'] 	if id == 105 	#영혼마령봉
			return ['(착용)현철중검'] 		if id == 106 	#현철중검
			return ['(착용)불의영혼봉'] 	if id == 107 	#불의영혼봉
			return ['(착용)백화검'] 			if id == 108 	#백화검
			return ['(착용)백화검'] 			if id == 109 	#이벤트백화검
			return ['(착용)현랑부'] 			if id == 110  #현랑부
			return ['(착용)현랑부'] 			if id == 111  #이벤트현랑부
			return ['(착용)양첨목봉'] 		if id == 112  #양첨목봉
			return ['(착용)양첨목봉'] 		if id == 113  #이벤트양첨목봉
			return ['(착용)주작의검'] 		if id == 114  #주작의검
			return ['(착용)심판의낫'] 		if id == 115  #심판의낫
			return ['(착용)진일신검'] 		if id == 116  #진일신검
			return ['(착용)괴력선창'] 		if id == 117  #괴력선창
			return ['(착용)철도'] 			if id == 118 	#철단도
			return ['(착용)철도'] 			if id == 119  #비철단도
			return ['(착용)현철중검'] 		if id == 120 	#흑철중검
			return ['(착용)목도'] 			if id == 121 	#초심자의목도
			return ['(착용)용마제구검'] 	if id == 122  #용마제팔검
			return ['(착용)현무염도'] 		if id == 123  #현무염도
			return ['(착용)철도'] 			if id == 124  #얼음검
			return ['(착용)일월대도'] 		if id == 125  #일월대도
			return ['(착용)참마도']			if id == 126  #참마도
			return ['(착용)청룡신검'] 		if id == 127  #청룡신검
			return ['(착용)용랑제구봉'] 	if id == 128  #용량제육봉
			return ['(착용)현철중검'] 		if id == 129  #도깨비방망이
			return ['(착용)영웅의칼\'뇌']	if id == 130  #산적왕의칼
			return ['(착용)다문창'] 			if id == 131  #다문창
			return ['(착용)영혼죽장'] 		if id == 132  #인어장군지팡이
			return ['(착용)해골죽장'] 		if id == 133  #해골죽장
			return ['(착용)일화접선'] 		if id == 134  #일화접선
			return ['(착용)진일신검'] 		if id == 135  #진일신검
			return ['(착용)이가닌자의검'] 	if id == 136  #이가닌자의 검
			return ['(착용)영혼죽장']		if id == 137  #영혼죽장
			
			# 용무기
			return ['(착용)용마제일검'] 	if id == 141  #용마제일검
			return ['(착용)용마제사검'] 	if id == 142  #용마제사검
			return ['(착용)용마제칠검'] 	if id == 143  #용마제칠검
			return ['(착용)용마제팔검'] 	if id == 144  #용마제팔검
			return ['(착용)용마제구검'] 	if id == 145  #용마제구검

			return ['(착용)용랑제일봉'] 	if id == 146  #용랄제일봉
			return ['(착용)용랑제사봉'] 	if id == 147  #용랄제사봉
			return ['(착용)용랑제칠봉'] 	if id == 148  #용랄제칠봉
			return ['(착용)용랑제팔봉'] 	if id == 149  #용랄제팔봉
			return ['(착용)용랑제구봉'] 	if id == 150  #용랄제구봉
			
			# 중국무기
			return ['(착용)대모홍접선'] 	if id == 11  #대모홍접선
			return ['(착용)구곡검'] 			if id == 12  #구곡검
			return ['(착용)영후단봉'] 		if id == 13  #영후단봉
			return ['(착용)협가검'] 			if id == 14  #협가검
			return ['(착용)석단장'] 			if id == 15  #석단장
			return ['(착용)백사도'] 			if id == 16  #백사도
			return ['(착용)음양도'] 			if id == 17  #음양도
			
		else
			# 방어구
			return ['(착용)연두갑주'] 			if id == 1  	#초심자의갑주
			#return ['(착용)다람쥐화서']			if id == 9  	#다람쥐화서
			#return ['(착용)토끼화서'] 			if id == 10 	#토끼화서
			return ['(착용)죄수복'] 				if id == 11 	#죄수복
			return ['(착용)주술갑옷'] 			if id == 12 	#주술갑옷
			return ['(착용)남자타라의옷'] 		if id == 13 	#남자타라의옷
			return ['(착용)해골갑옷'] 			if id == 14 	#해골갑옷
			return ['(착용)가릉빈가의날개옷'] 	if id == 30 	#가릉빈가의날개옷
			return ['(착용)초록색도포'] 		if id == 31 	#초록색도포
			return ['(착용)현인의영혼'] 		if id == 32 	#현인의영혼
			return ['(착용)초록갑주'] 			if id == 34 	#초록색남자갑주
			return ['(착용)망또'] 				if id == 35 	#망또
			return ['(착용)연두갑주'] 			if id == 38  	#연두색남자갑주
			return ['(착용)정화의방패'] 		if id == 39  	#정화의방패
			return ['(착용)여신의방패'] 		if id == 40  	#여신의방패
			return ['(착용)검황의영혼'] 		if id == 41  	#검황의영혼
			return ['(착용)황혼의갑주'] 		if id == 42  	#황혼의갑주
			return ['(착용)산신의정화'] 		if id == 43  	#산신의정화
			return ['(착용)여명의도복'] 		if id == 44  	#여명의도복
			return ['(착용)망또1'] 				if id == 47  	#망또1
			return ['(착용)망또2'] 				if id == 48  	#망또2
			return ['(착용)망또3'] 				if id == 49  	#망또3
			return ['(착용)현인의영혼'] 		if id == 52  	#진인의영혼
			return ['(착용)검황의영혼'] 		if id == 54  	#귀검의영혼
			return ['(착용)초록장삼'] 			if id == 59  	#초록장삼
		end
		
		return false
	end
end