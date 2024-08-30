module Equip_Job_Type # 직업별 장비 착용 가능 여부 확인
	EQUIP_JOB_WEAPON = {}
	EQUIP_JOB_ARMOR = {}
	# [[직업 타입], 필요 차수, 필요 레벨]
	
	#----------
	# 주술사 전용
	#----------
	# 무기
	EQUIP_JOB_WEAPON[6] = [[1], 4] # 현자금봉
	EQUIP_JOB_WEAPON[13] = [[1], 4] # 영후단봉
	EQUIP_JOB_WEAPON[105] = [[1], 0] # 영혼마령봉
	EQUIP_JOB_WEAPON[107] = [[1], 0] # 불의영혼봉
	
	# 방어구
	EQUIP_JOB_ARMOR[31] = [[1], 0] # 초록색도포
	EQUIP_JOB_ARMOR[131] = [[1], 0] # 보라색도포
	EQUIP_JOB_ARMOR[132] = [[1], 0] # 구리도포
	
	EQUIP_JOB_ARMOR[32] = [[1], 3] # 현인의영혼
	
	#----------
	# 전사 전용
	#----------
	# 무기
	EQUIP_JOB_WEAPON[1] = [[2], 0] # 주작의검 신수
	EQUIP_JOB_WEAPON[2] = [[2], 0] # 백호의검 신수
	EQUIP_JOB_WEAPON[3] = [[2], 0] # 현무의검 신수
	EQUIP_JOB_WEAPON[4] = [[2], 0] # 청룡의검 신수
	EQUIP_JOB_WEAPON[7] = [[2], 4] # 검성기검
	EQUIP_JOB_WEAPON[12] = [[2], 4] # 구곡검
	EQUIP_JOB_WEAPON[106] = [[2], 0] # 현철중검
	EQUIP_JOB_WEAPON[120] = [[2], 0] # 흑철중검
	
	# 방어구
	EQUIP_JOB_ARMOR[34] = [[2, 4], 0] # 초록색남자갑주
	EQUIP_JOB_ARMOR[133] = [[2, 4], 0] # 보라색남자갑주
	EQUIP_JOB_ARMOR[134] = [[2, 4], 0] # 구리남자갑주
	EQUIP_JOB_ARMOR[41] = [[2], 3] # 검황의영혼
	
	#----------
	# 도사 전용
	#----------
	# 무기
	EQUIP_JOB_WEAPON[8] = [[3], 4] # 진선역봉
	EQUIP_JOB_WEAPON[11] = [[3], 4] # 대모홍접선
	EQUIP_JOB_WEAPON[133] = [[3], 0] # 해골죽장
	EQUIP_JOB_WEAPON[137] = [[3], 0] # 영혼죽장
	
	# 방어구
	EQUIP_JOB_ARMOR[52] = [[3], 3] # 진인의영혼
	EQUIP_JOB_ARMOR[59] = [[3], 0] # 초록장삼
	EQUIP_JOB_ARMOR[135] = [[3], 0] # 보라색장삼
	EQUIP_JOB_ARMOR[136] = [[3], 0] # 구리장삼
	
	#----------
	# 도적 전용
	#----------
	# 무기
	EQUIP_JOB_WEAPON[9] = [[4], 4] # 태성태도
	EQUIP_JOB_WEAPON[14] = [[4], 4] # 협가검
	EQUIP_JOB_WEAPON[24] = [[4], 0] # 야월도
	EQUIP_JOB_WEAPON[25] = [[4], 0] # 흑월도
	
	# 방어구
	EQUIP_JOB_ARMOR[54] = [[4], 3] # 귀검의영혼
	
	#----------
	# 전직업
	#----------
	# 무기
	EQUIP_JOB_WEAPON[15] = [[0], 1] # 석단장
	EQUIP_JOB_WEAPON[16] = [[0], 2] # 백사도
	EQUIP_JOB_WEAPON[17] = [[0], 3] # 음양도
	EQUIP_JOB_WEAPON[22] = [[0], 0] # 비철단도
	EQUIP_JOB_WEAPON[23] = [[0], 0] # 철도
	EQUIP_JOB_WEAPON[26] = [[0], 0] # 녹호박별검
	EQUIP_JOB_WEAPON[27] = [[0], 0] # 철검
	
	EQUIP_JOB_WEAPON[31] = [[0], 0] # 활
	
	
	EQUIP_JOB_WEAPON[101] = [[0], 0] # 목도
	EQUIP_JOB_WEAPON[102] = [[0], 0] # 목검
	EQUIP_JOB_WEAPON[103] = [[0], 0] # 사두목도
	EQUIP_JOB_WEAPON[104] = [[0], 0] # 사두목검
	EQUIP_JOB_WEAPON[108] = [[0], 0, 85] # 백화검
	EQUIP_JOB_WEAPON[109] = [[0], 0] # 이벤트백화검
	EQUIP_JOB_WEAPON[110] = [[0], 0, 75] # 현랑부
	EQUIP_JOB_WEAPON[111] = [[0], 0] # 이벤트현랑부
	EQUIP_JOB_WEAPON[112] = [[0], 0, 90] # 양첨목봉
	EQUIP_JOB_WEAPON[113] = [[0], 0] # 이벤트양첨목봉
	EQUIP_JOB_WEAPON[114] = [[0], 0, 99] # 주작의검
	EQUIP_JOB_WEAPON[115] = [[0], 3] # 심판의낫
	EQUIP_JOB_WEAPON[116] = [[0], 0] # 진일신검손상
	EQUIP_JOB_WEAPON[117] = [[0], 2] # 괴력선창
	EQUIP_JOB_WEAPON[118] = [[0], 0] # 철단도
	
	EQUIP_JOB_WEAPON[121] = [[0], 0] # 흑철중검
	EQUIP_JOB_WEAPON[122] = [[0], 0] # 초심자의목도
	EQUIP_JOB_WEAPON[123] = [[0], 3] # 현무염도
	EQUIP_JOB_WEAPON[124] = [[0], 0, 99] # 얼음검
	EQUIP_JOB_WEAPON[125] = [[0], 0] # 일월대도
	EQUIP_JOB_WEAPON[126] = [[0], 0, 99] # 참마도
	EQUIP_JOB_WEAPON[127] = [[0], 3] # 청룡신검
	EQUIP_JOB_WEAPON[128] = [[0], 0] # 용량제구봉?
	EQUIP_JOB_WEAPON[129] = [[0], 0, 80] # 도깨비방망이
	EQUIP_JOB_WEAPON[130] = [[0], 0, 99] # 뇌령진도
	EQUIP_JOB_WEAPON[131] = [[0], 0, 99] # 다문창
	EQUIP_JOB_WEAPON[132] = [[0], 0, 99] # 인어장군지팡이
	EQUIP_JOB_WEAPON[134] = [[0], 3] # 일화접선
	EQUIP_JOB_WEAPON[135] = [[0], 3] # 진일신검
	EQUIP_JOB_WEAPON[136] = [[0], 1] # 이가닌자의검
	EQUIP_JOB_WEAPON[138] = [[0], 3] # 청일기창
	
	EQUIP_JOB_WEAPON[141] = [[0], 0, 99] # 용마제일검
	EQUIP_JOB_WEAPON[142] = [[0], 1] # 용마제사검
	EQUIP_JOB_WEAPON[143] = [[0], 2] # 용마제칠검
	EQUIP_JOB_WEAPON[144] = [[0], 3] # 용마제팔검
	EQUIP_JOB_WEAPON[145] = [[0], 4] # 용마제구검
	EQUIP_JOB_WEAPON[146] = [[0], 0, 99] # 용랑제일봉
	EQUIP_JOB_WEAPON[147] = [[0], 1] # 용랑제사봉
	EQUIP_JOB_WEAPON[148] = [[0], 2] # 용랑제칠봉
	EQUIP_JOB_WEAPON[149] = [[0], 3] # 용랑제팔봉
	EQUIP_JOB_WEAPON[150] = [[0], 4] # 용랑제구봉
	
	EQUIP_JOB_WEAPON[152] = [[0], 2] # 용마제칠검(손상)
	EQUIP_JOB_WEAPON[153] = [[0], 3] # 용마제칠검(손상)
	EQUIP_JOB_WEAPON[154] = [[0], 2] # 용랑제칠봉(손상)
	EQUIP_JOB_WEAPON[155] = [[0], 3] # 용랑제팔봉(손상)
	
	# 방어구
	EQUIP_JOB_ARMOR[1] = [[0], 0] # 초심자의갑주
	EQUIP_JOB_ARMOR[2] = [[0], 0] # 지력의투구1
	EQUIP_JOB_ARMOR[3] = [[0], 0] # 파란색반지
	EQUIP_JOB_ARMOR[4] = [[0], 0, 35] # 사각방패
	EQUIP_JOB_ARMOR[5] = [[0], 0] # 금장투구
	EQUIP_JOB_ARMOR[6] = [[0], 0] # 연두색투구
	EQUIP_JOB_ARMOR[7] = [[0], 0] # 초심자의투구
	EQUIP_JOB_ARMOR[8] = [[0], 0] # 초심자의반지
	EQUIP_JOB_ARMOR[9] = [[0], 0] # 다람쥐화서
	EQUIP_JOB_ARMOR[10] = [[0], 0] # 토끼화서
	EQUIP_JOB_ARMOR[11] = [[0], 0] # 죄수복
	EQUIP_JOB_ARMOR[12] = [[0], 2] # 주술갑옷
	EQUIP_JOB_ARMOR[13] = [[0], 0, 99] # 남자타라의 옷
	EQUIP_JOB_ARMOR[14] = [[0], 3] # 해골갑옷
	EQUIP_JOB_ARMOR[15] = [[0], 0, 90] # 수선도사의머리띠
	EQUIP_JOB_ARMOR[16] = [[0], 0] # 수정귀걸이
	EQUIP_JOB_ARMOR[17] = [[0], 0] # 용왕의반지모조
	EQUIP_JOB_ARMOR[18] = [[0], 0] # 용왕의투구모조
	EQUIP_JOB_ARMOR[19] = [[0], 0, 99] # 청선투구
	EQUIP_JOB_ARMOR[20] = [[0], 0, 99] # 청선팔찌
	EQUIP_JOB_ARMOR[21] = [[0], 0, 2] # 해골목걸이
	EQUIP_JOB_ARMOR[22] = [[0], 4] # 황금투구
	EQUIP_JOB_ARMOR[23] = [[0], 4] # 황금팔찌
	EQUIP_JOB_ARMOR[24] = [[0], 0] # 용왕둔갑두루마리
	EQUIP_JOB_ARMOR[25] = [[0], 0] # 강건부
	EQUIP_JOB_ARMOR[26] = [[0], 0] # 암사슴화서
	EQUIP_JOB_ARMOR[27] = [[0], 0] # 숫사슴화서
	EQUIP_JOB_ARMOR[28] = [[0], 0] # 보무의목걸이
	EQUIP_JOB_ARMOR[29] = [[0], 0] # 투명구두
	EQUIP_JOB_ARMOR[30] = [[0], 4] # 가릉빈가의날개옷
	EQUIP_JOB_ARMOR[33] = [[0], 0] # 도깨비부적
	EQUIP_JOB_ARMOR[35] = [[0], 0] # 망또
	EQUIP_JOB_ARMOR[36] = [[0], 0] # 기원부
	EQUIP_JOB_ARMOR[37] = [[0], 0] # 보라색반지
	EQUIP_JOB_ARMOR[38] = [[0], 0] # 연두색남자갑주
	EQUIP_JOB_ARMOR[39] = [[0], 2] # 정화의방패
	EQUIP_JOB_ARMOR[40] = [[0], 2] # 여신의방패
	EQUIP_JOB_ARMOR[42] = [[0], 4] # 황혼의갑주
	EQUIP_JOB_ARMOR[43] = [[0], 4] # 산신의정화
	EQUIP_JOB_ARMOR[44] = [[0], 1] # 황혼의활복
	EQUIP_JOB_ARMOR[45] = [[0], 0] # 인어반지
	EQUIP_JOB_ARMOR[46] = [[0], 0] # 진주반지
	EQUIP_JOB_ARMOR[57] = [[0], 0, 99] # 호박투구
	EQUIP_JOB_ARMOR[58] = [[0], 1] # 진호박투구
	EQUIP_JOB_ARMOR[60] = [[0], 2] # 황금호박투구
	
	EQUIP_JOB_ARMOR[47] = [[0], 0, 49] # 망또1
	EQUIP_JOB_ARMOR[48] = [[0], 0, 59] # 망또2
	EQUIP_JOB_ARMOR[49] = [[0], 0, 79] # 망또3
	EQUIP_JOB_ARMOR[55] = [[0], 0, 89] # 망또4
	EQUIP_JOB_ARMOR[56] = [[0], 0, 99] # 망또5
	
	EQUIP_JOB_ARMOR[50] = [[0], 3] # 용왕의반지'진
	EQUIP_JOB_ARMOR[51] = [[0], 3] # 용왕의투구'진
	EQUIP_JOB_ARMOR[53] = [[0], 0] # 힘의투구1
	
	EQUIP_JOB_ARMOR[61] = [[0], 2] # 연청투구
	EQUIP_JOB_ARMOR[62] = [[0], 2] # 연홍투구
	EQUIP_JOB_ARMOR[63] = [[0], 0] # 비취의목걸이
	EQUIP_JOB_ARMOR[64] = [[0], 0] # 수정의목걸이
	EQUIP_JOB_ARMOR[70] = [[0], 2] # 주술투구
	EQUIP_JOB_ARMOR[71] = [[0], 2] # 주술팔찌
	EQUIP_JOB_ARMOR[72] = [[0], 1] # 해골목걸이
	EQUIP_JOB_ARMOR[73] = [[0], 4] # 가릉빈가의날개옷'진
	EQUIP_JOB_ARMOR[74] = [[0], 4] # 황금투구
	EQUIP_JOB_ARMOR[75] = [[0], 4] # 황금팔찌
	
	EQUIP_JOB_ARMOR[80] = [[0], 0] # 지력의반지1
	EQUIP_JOB_ARMOR[81] = [[0], 0] # 지력의반지2
	EQUIP_JOB_ARMOR[82] = [[0], 0] # 지력의반지3
	EQUIP_JOB_ARMOR[83] = [[0], 0] # 지력의투구2
	EQUIP_JOB_ARMOR[84] = [[0], 0] # 민첩의반지1
	EQUIP_JOB_ARMOR[85] = [[0], 0] # 민첩의반지2
	EQUIP_JOB_ARMOR[86] = [[0], 0] # 민첩의반지3
	EQUIP_JOB_ARMOR[87] = [[0], 0] # 민첩의투구2
	EQUIP_JOB_ARMOR[88] = [[0], 0] # 힘의반지1
	EQUIP_JOB_ARMOR[89] = [[0], 0] # 힘의반지2
	EQUIP_JOB_ARMOR[90] = [[0], 0] # 힘의반지3
	EQUIP_JOB_ARMOR[91] = [[0], 0] # 힘의투구2
	EQUIP_JOB_ARMOR[92] = [[0], 0] # 손재주의반지1
	EQUIP_JOB_ARMOR[93] = [[0], 0] # 손재주의반지2
	EQUIP_JOB_ARMOR[94] = [[0], 0] # 손재주의반지3
	EQUIP_JOB_ARMOR[95] = [[0], 0] # 손재주의투구2
	EQUIP_JOB_ARMOR[96] = [[0], 0] # 힘의반지4
	EQUIP_JOB_ARMOR[97] = [[0], 0] # 방어의반지4
	EQUIP_JOB_ARMOR[98] = [[0], 0] # 재생의부적
end

class Game_Actor < Game_Battler
	# 직업별 착용 가능한 장비 설정
	def equippable?(item)		
		job_type = determine_job_type
    job_degree = determine_job_degree
		
		equip_data = item.is_a?(RPG::Weapon) ? Equip_Job_Type::EQUIP_JOB_WEAPON[item.id] : Equip_Job_Type::EQUIP_JOB_ARMOR[item.id]
    return false unless equip_data
		return false if equip_data[1] > job_degree 
		return false if !equip_data[0].include?(job_type) && !equip_data[0].include?(0)
    return false if level < item_level(item)
		return true
	end
	
	def determine_job_type
		return 1 if $game_switches[6] # 주술사
		return 2 if $game_switches[156] # 전사
		return 3 if $game_switches[144] # 도사
		return 4 if $game_switches[426] # 도적
		return 0 # Default: 평민
	end
	
	def determine_job_degree
		n = $game_party.actors[0].class_id
		case n
		when 3, 8, 11, 18 then 1
		when 5, 9, 12, 19 then 2
		when 6, 10, 13, 20 then 3
		when 14, 15, 16, 21 then 4
		else 0
		end
	end
	
	def item_level(item)
		return 0 unless item 
		
		text = item.description.dup 
		check = item.is_a?(RPG::Weapon) ? Equip_Job_Type::EQUIP_JOB_WEAPON[item.id] : Equip_Job_Type::EQUIP_JOB_ARMOR[item.id]
		return 0 unless check
		
		class_id, degree, req_level = check
		return 0 if class_id.nil? || degree.nil?
		
		req_level = degree >= 1 ? 99 : (req_level || 1)
		description = item.description.dup
		find_txt = description.scan(/\[[제재][한][레래][벨밸]:([0-9]+)\]/)
		
    if find_txt.empty?
      item.description += "[제한레벨:#{req_level}]"
    else
      find_level = find_txt[0][0].to_i
      
			if find_level < req_level
				item.description.gsub!(/\[[제재][한][레래][벨밸]:([0-9]+)\]/) { |s| s = "[제한레벨:#{req_level}]" } 
			else
				req_level = find_level
			end
    end

    req_level
	end
end