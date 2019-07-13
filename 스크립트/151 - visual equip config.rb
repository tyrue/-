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
			return ['(착용)철도', 2] 			if id == 1 or id == 2 or id == 3 or id == 4	#신수둔각도
			
			return ['(착용)목도', 2] 			if id == 101 	#목도
			return ['(착용)목도', 2] 			if id == 102 	#목검
			return ['(착용)목도', 2] 			if id == 103 	#사두목도
			return ['(착용)목도', 2] 			if id == 104 	#사두목검
			return ['(착용)영혼마령봉', 2] 	if id == 105 	#영혼마령봉
			return ['(착용)현철중검', 2] 	if id == 106 	#현철중검
			return ['(착용)불의영혼봉', 2] 	if id == 107 	#불의영혼봉
			return ['(착용)백화검', 2] 		if id == 108 	#백화검
			return ['(착용)백화검', 2] 		if id == 109 	#이벤트백화검
			return ['(착용)현랑부', 2] 		if id == 110  #현랑부
			return ['(착용)현랑부', 2] 		if id == 111  #이벤트현랑부
			return ['(착용)양첨목봉', 2] 	if id == 112  #양첨목봉
			return ['(착용)양첨목봉', 2] 	if id == 113  #이벤트양첨목봉
			return ['(착용)주작의검', 2] 	if id == 114  #주작의검
			return ['(착용)심판의낫', 2] 	if id == 115  #심판의낫
			return ['(착용)진일신검', 2] 	if id == 116  #진일신검
			return ['(착용)진일신검', 2] 	if id == 117  #괴력선창
			return ['(착용)철도', 2] 			if id == 118 	#철단도
			return ['(착용)철도', 2] 			if id == 119  #비철단도
			return ['(착용)현철중검', 2] 	if id == 120 	#흑철중검
			return ['(착용)목도', 2] 			if id == 121 	#초심자의목도
			return ['(착용)용마제팔검', 2] 	if id == 122  #용마제팔검
			return ['(착용)용마제팔검', 2] 	if id == 123  #현무염도
			return ['(착용)철도', 2] 			if id == 124  #얼음검
			return ['(착용)철도', 2] 			if id == 125  #일월대도
			return ['(착용)녹호박별검', 2]	if id == 126  #참마도
			return ['(착용)영웅의칼\'뇌', 2] 	if id == 127  #청룡신검
			return ['(착용)진일신검', 2] 	if id == 128  #용량제육봉
			return ['(착용)현철중검', 2] 	if id == 129  #도깨비방망이
			return ['(착용)영웅의칼\'뇌', 2] 	if id == 130  #산적왕의칼
			return ['(착용)해골죽장', 2] 	if id == 131  #다문창
			return ['(착용)영혼죽장', 2] 	if id == 132  #인어장군지팡이
			return ['(착용)해골죽장', 2] 	if id == 133  #해골죽장
			return ['(착용)일화접선', 2] 	if id == 134  #일화접선
		else
			# 방어구
			return ['(착용)연두갑주', 2] 		if id == 1  	#초심자의갑주
			return ['(착용)다람쥐화서', 2]		if id == 9  	#다람쥐화서
			return ['(착용)토끼화서', 2] 		if id == 10 	#토끼화서
			return ['(착용)죄수복', 2] 			if id == 11 	#죄수복
			return ['(착용)주술갑옷', 2] 		if id == 12 	#주술갑옷
			return ['(착용)남자타라의옷', 2] 	if id == 13 	#남자타라의옷
			return ['(착용)해골갑옷', 2] 		if id == 14 	#해골갑옷
			return ['(착용)가릉빈가의날개옷', 2] if id == 30 	#가릉빈가의날개옷
			return ['(착용)초록색도포', 2] 		if id == 31 	#초록색도포
			return ['(착용)현인의영혼', 2] 		if id == 32 	#현인의영혼
			return ['(착용)초록갑주', 2] 		if id == 34 	#초록색남자갑주
			return ['(착용)망또', 2] 				if id == 35 	#망또
			return ['(착용)연두갑주', 2] 		if id == 38  	#연두색남자갑주
			return ['(착용)정화의방패', 2] 		if id == 39  	#정화의방패
			return ['(착용)여신의방패', 2] 		if id == 40  	#여신의방패
			return ['(착용)검황의영혼', 2] 		if id == 41  	#검황의영혼
			return ['(착용)황혼의갑주', 2] 		if id == 42  	#황혼의갑주
			return ['(착용)산신의정화', 2] 		if id == 43  	#산신의정화
			return ['(착용)여명의도복', 2] 		if id == 44  	#여명의도복
			return ['(착용)망또1', 2] 		if id == 47  	#망또1
			return ['(착용)망또2', 2] 		if id == 48  	#망또2
			return ['(착용)망또3', 2] 		if id == 49  	#망또3
			return ['(착용)현인의영혼', 2] 		if id == 52  	#진인의영혼
		end
		
		#Mulher
		if $genero == 2
			if type == 2
				# GRAFICOS DA ARMA
				# Adcione aqui os equipamentos de ataque
				return ['Mulher\\Arma3', 0] if id == 1
				return ['Mulher\\Arma3', 0] if id == 2
				return ['Mulher\\Arma3', 0] if id == 3
				return ['Mulher\\Arma3', 0] if id == 4
				return ['Mulher\\arco_0', 0] if id == 17
				return ['Mulher\\arco_0', 0] if id == 18
				return ['Mulher\\arco_0', 0] if id == 19
				return ['Mulher\\arco_0', 0] if id == 20
				return ['Mulher\\spear_0', 0] if id == 5
				return ['Mulher\\spear_0', 0] if id == 6
				return ['Mulher\\spear_0', 0] if id == 7
				return ['Mulher\\spear_0', 0] if id == 8
				return ['Mulher\\weapon-stick01', 0] if id == 29
				return ['Mulher\\weapon-stick01', 0] if id == 30
				return ['Mulher\\weapon-stick01', 0] if id == 31
				return ['Mulher\\weapon-stick01', 0] if id == 32
				return ['Mulher\\mazza_0', 0] if id == 25
				return ['Mulher\\mazza_0', 0] if id == 26
				return ['Mulher\\mazza_0', 0] if id == 27
				return ['Mulher\\mazza_0', 0] if id == 28
				#return ['Mulher\\ascia_1', 0] if id == 9
				#return ['Mulher\\ascia_1', 0] if id == 10
				#return ['Mulher\\ascia_1', 0] if id == 11
				#return ['Mulher\\ascia_1', 0] if id == 12
			else
				# Armaduras, Elmos, escudos etc..
				return ['Mulher\\Bronze Shield', 0] if id == 1
				return ['Mulher\\Shield2', 0] if id == 2
			end
		end 
		
		
		return false
	end
end