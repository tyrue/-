#--------------------------------------------------------------------------
# Aqui é o Método de configuração para os equips para adcionar os icones
# relacionado ao ID da arma coloque:
#   return ['equip\\icone_da_arma, o] if id == id_do_item_no_database
# E a mesma coisa com armaduras, porem devem ser adcionados depois do "else"
#   return ['equip\\Icone_defesa', 0] if id == id_do_equip_no_database
#--------------------------------------------------------------------------
module VisualEquipData
	VISUAL_EQUIP_DATA = {}
	# data[type][id] = [착용 캐릭터 이미지 이름, hud]
	# 갑옷
	VISUAL_EQUIP_DATA[0] = {}
	VISUAL_EQUIP_DATA[0][1] = ['(착용)연두갑주'] 					#초심자의갑주
	VISUAL_EQUIP_DATA[0][38] = ['(착용)연두갑주'] 			 		#연두색남자갑주
	                  
	VISUAL_EQUIP_DATA[0][31] = ['(착용)초록색도포'] 				#초록색도포
	VISUAL_EQUIP_DATA[0][131] = ['(착용)보라색도포'] 			 		#보라도포
	VISUAL_EQUIP_DATA[0][132] = ['(착용)구리도포'] 			 		#구리도포
	                  
	VISUAL_EQUIP_DATA[0][34] = ['(착용)초록갑주'] 					#초록색남자갑주
	VISUAL_EQUIP_DATA[0][133] = ['(착용)보라갑주'] 			 		#보라갑주
	VISUAL_EQUIP_DATA[0][134] = ['(착용)구리갑주'] 			 		#구리갑주
	                  
	VISUAL_EQUIP_DATA[0][59] = ['(착용)초록장삼'] 			 		#초록장삼
	VISUAL_EQUIP_DATA[0][135] = ['(착용)보라장삼'] 			 		#보라장삼
	VISUAL_EQUIP_DATA[0][136] = ['(착용)구리장삼'] 			 		#구리장삼
	                  
	VISUAL_EQUIP_DATA[0][11] = ['(착용)죄수복'] 						#죄수복
	VISUAL_EQUIP_DATA[0][12] = ['(착용)주술갑옷'] 					#주술갑옷
	VISUAL_EQUIP_DATA[0][13] = ['(착용)남자타라의옷'] 				#남자타라의옷
	VISUAL_EQUIP_DATA[0][14] = ['(착용)해골갑옷'] 					#해골갑옷
	VISUAL_EQUIP_DATA[0][30] = ['(착용)가릉빈가의날개옷'] 			#가릉빈가의날개옷
	VISUAL_EQUIP_DATA[0][73] = ['(착용)가릉빈가의날개옷\'진']		#가릉빈가의날개옷'진
	                  
	VISUAL_EQUIP_DATA[0][42] = ['(착용)황혼의갑주'] 		 		#황혼의갑주
	VISUAL_EQUIP_DATA[0][43] = ['(착용)산신의정화'] 		 		#산신의정화
	VISUAL_EQUIP_DATA[0][44] = ['(착용)여명의도복'] 		 		#여명의도복
	                  
	VISUAL_EQUIP_DATA[0][35] = ['(착용)망또'] 						#망또
	VISUAL_EQUIP_DATA[0][47] = ['(착용)망또1'] 				 		#망또1
	VISUAL_EQUIP_DATA[0][48] = ['(착용)망또2'] 				 		#망또2
	VISUAL_EQUIP_DATA[0][49] = ['(착용)망또3'] 				 		#망또3
	VISUAL_EQUIP_DATA[0][55] = ['(착용)망또3', 155] 		 	#망또4
	VISUAL_EQUIP_DATA[0][56] = ['(착용)망또3', 300] 		 	#망또5
	
	VISUAL_EQUIP_DATA[0][32] = ['(착용)현인의영혼'] 				#현인의영혼
	VISUAL_EQUIP_DATA[0][41] = ['(착용)검황의영혼'] 		 		#검황의영혼
	VISUAL_EQUIP_DATA[0][52] = ['(착용)현인의영혼'] 		 		#진인의영혼
	VISUAL_EQUIP_DATA[0][54] = ['(착용)검황의영혼'] 		 		#귀검의영혼
	
	# 무기류
	VISUAL_EQUIP_DATA[2] = {}
	VISUAL_EQUIP_DATA[2][1] = ['(착용)주작의검']		# 신수둔각
	VISUAL_EQUIP_DATA[2][2] = ['(착용)녹호박별검'] 	# 신수둔각
	VISUAL_EQUIP_DATA[2][3] = ['(착용)현무염도'] 	# 신수둔각
	VISUAL_EQUIP_DATA[2][4] = ['(착용)청룡신검'] 	# 신수둔각
	                  
	VISUAL_EQUIP_DATA[2][6] = ['(착용)현자금봉']	  #현자금봉
	VISUAL_EQUIP_DATA[2][7] = ['(착용)검성기검']	  #검성기검
	VISUAL_EQUIP_DATA[2][8] = ['(착용)진선역봉']	  #진선역봉
	VISUAL_EQUIP_DATA[2][9] = ['(착용)태성태도']	  #태성태도
		                
	VISUAL_EQUIP_DATA[2][11] = ['(착용)대모홍접선'] 		#대모홍
	VISUAL_EQUIP_DATA[2][12] = ['(착용)구곡검'] 			  #구곡검
	VISUAL_EQUIP_DATA[2][13] = ['(착용)영후단봉'] 		  #영후단
	VISUAL_EQUIP_DATA[2][14] = ['(착용)협가검'] 			  #협가검
	VISUAL_EQUIP_DATA[2][15] = ['(착용)석단장'] 			  #석단장
	VISUAL_EQUIP_DATA[2][16] = ['(착용)백사도'] 			  #백사도
	VISUAL_EQUIP_DATA[2][17] = ['(착용)음양도'] 			  #음양도
	                  
	VISUAL_EQUIP_DATA[2][22] = ['(착용)철단도'] 			# 비철단도
	VISUAL_EQUIP_DATA[2][23] = ['(착용)철도'] 			# 철도
	VISUAL_EQUIP_DATA[2][24] = ['(착용)야월도'] 			# 야월도
	VISUAL_EQUIP_DATA[2][25] = ['(착용)흑월도'] 			# 흑월도
	VISUAL_EQUIP_DATA[2][26] = ['(착용)녹호박별검'] 	# 녹호박별검
	VISUAL_EQUIP_DATA[2][27] = ['(착용)철도', 125] 			# 철도
	                  
	VISUAL_EQUIP_DATA[2][31] = ['(착용)활'] 	# 활
	                  
	VISUAL_EQUIP_DATA[2][101] = ['(착용)목도'] 			 	#목도
	VISUAL_EQUIP_DATA[2][102] = ['(착용)목도'] 			 	#목검
	VISUAL_EQUIP_DATA[2][103] = ['(착용)목도'] 			 	#사두
	VISUAL_EQUIP_DATA[2][104] = ['(착용)목도', 125] 	#사두목검
	VISUAL_EQUIP_DATA[2][105] = ['(착용)영혼마령봉'] 	 	#영혼마령봉
	VISUAL_EQUIP_DATA[2][106] = ['(착용)현철중검'] 		#현철중검
	VISUAL_EQUIP_DATA[2][107] = ['(착용)불의영혼봉'] 	 	#불의영혼봉
	VISUAL_EQUIP_DATA[2][108] = ['(착용)백화검'] 			#백화검
	VISUAL_EQUIP_DATA[2][109] = ['(착용)백화검'] 			#이벤트백화검
	VISUAL_EQUIP_DATA[2][110] = ['(착용)현랑부'] 			#현랑부
	VISUAL_EQUIP_DATA[2][111] = ['(착용)현랑부'] 			#이벤트현랑부
	VISUAL_EQUIP_DATA[2][112] = ['(착용)양첨목봉'] 		#양첨목봉
	VISUAL_EQUIP_DATA[2][113] = ['(착용)양첨목봉'] 		#이벤트양첨목봉
	VISUAL_EQUIP_DATA[2][114] = ['(착용)주작의검'] 		#주작의검
	VISUAL_EQUIP_DATA[2][115] = ['(착용)심판의낫'] 		#심판의낫
	VISUAL_EQUIP_DATA[2][116] = ['(착용)진일신검'] 		#진일신검
	VISUAL_EQUIP_DATA[2][117] = ['(착용)괴력선창'] 		#괴력선창
	VISUAL_EQUIP_DATA[2][118] = ['(착용)철단도'] 				#철단도
	                  
	VISUAL_EQUIP_DATA[2][120] = ['(착용)현철중검'] 	 	#흑철중검
	VISUAL_EQUIP_DATA[2][121] = ['(착용)목도'] 				#초심자의목도
	VISUAL_EQUIP_DATA[2][122] = ['(착용)용마제구검'] 		#용마제팔검
	VISUAL_EQUIP_DATA[2][123] = ['(착용)현무염도'] 	  #현무염도
	VISUAL_EQUIP_DATA[2][124] = ['(착용)얼음검'] 				#얼음검
	VISUAL_EQUIP_DATA[2][125] = ['(착용)일월대도'] 	  #일월대도
	VISUAL_EQUIP_DATA[2][126] = ['(착용)참마도']				#참마도
	VISUAL_EQUIP_DATA[2][127] = ['(착용)청룡신검'] 	  #청룡신검
	VISUAL_EQUIP_DATA[2][128] = ['(착용)용랑제구봉'] 		#용량제육봉
	VISUAL_EQUIP_DATA[2][129] = ['(착용)도깨비방망이'] 	  #도깨비방망이
	VISUAL_EQUIP_DATA[2][130] = ['(착용)영웅의칼\'뇌']  #산적왕의칼 
	VISUAL_EQUIP_DATA[2][131] = ['(착용)다문창'] 		  #다문창
	VISUAL_EQUIP_DATA[2][132] = ['(착용)영혼죽장'] 	  #인어장군지팡이
	VISUAL_EQUIP_DATA[2][133] = ['(착용)해골죽장'] 	  # 해골죽장
	VISUAL_EQUIP_DATA[2][137] = ['(착용)영혼죽장']			#영혼죽장
	                  
	VISUAL_EQUIP_DATA[2][134] = ['(착용)일화접선'] 	  #일화
	VISUAL_EQUIP_DATA[2][135] = ['(착용)진일신검'] 	  #진일
	VISUAL_EQUIP_DATA[2][138] = ['(착용)청일기창'] 	  #청일
	VISUAL_EQUIP_DATA[2][136] = ['(착용)이가닌자의검']   #이가
	                  
	VISUAL_EQUIP_DATA[2][141] = ['(착용)용마제일검'] 	  #용마일검
	VISUAL_EQUIP_DATA[2][142] = ['(착용)용마제사검'] 	  #용마사
	VISUAL_EQUIP_DATA[2][143] = ['(착용)용마제칠검'] 	  #용마칠
	VISUAL_EQUIP_DATA[2][144] = ['(착용)용마제팔검'] 	  #용마팔
	VISUAL_EQUIP_DATA[2][145] = ['(착용)용마제구검'] 	  #용마구
                    
	VISUAL_EQUIP_DATA[2][146] = ['(착용)용랑제일봉'] 	  #용랄일
	VISUAL_EQUIP_DATA[2][147] = ['(착용)용랑제사봉'] 	  #용랄사
	VISUAL_EQUIP_DATA[2][148] = ['(착용)용랑제칠봉'] 	  #용랄칠
	VISUAL_EQUIP_DATA[2][149] = ['(착용)용랑제팔봉'] 	  #용랄팔
	VISUAL_EQUIP_DATA[2][150] = ['(착용)용랑제구봉'] 	  #용랄구
	                  
	VISUAL_EQUIP_DATA[2][152] = ['(착용)용마제칠검'] 	  #용마칠
	VISUAL_EQUIP_DATA[2][153] = ['(착용)용마제팔검'] 	  #용마팔
	VISUAL_EQUIP_DATA[2][154] = ['(착용)용랑제칠봉'] 	  #용랄칠
	VISUAL_EQUIP_DATA[2][155] = ['(착용)용랑제팔봉'] 	  #용랄팔
	                  
	# 방패류
	VISUAL_EQUIP_DATA[3] = {}
	VISUAL_EQUIP_DATA[3][4] = ['(착용)사각방패'] 		 		#사각방패
	VISUAL_EQUIP_DATA[3][39] = ['(착용)정화의방패'] 		 		#정화의방패
	VISUAL_EQUIP_DATA[3][40] = ['(착용)여신의방패'] 		 		#여신의방패
end


if User_Edit::VISUAL_EQUIP_ACTIVE
	def equip_character(type, id)
		data = VisualEquipData::VISUAL_EQUIP_DATA[type]
		return false if data == nil
		return false if data[id] == nil
		return data[id]
	end
end