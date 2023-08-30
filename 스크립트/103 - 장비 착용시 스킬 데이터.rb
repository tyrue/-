sec = 60 # 1초

# -------------------------무기 격 스킬----------------------------#
WEAPON_SKILL = {} # 무기 격 스킬 : 데미지, 애니메이션 id, 확률
# 신수둔각도
WEAPON_SKILL[1] = [1000, 154, 5]   		# 주작의검
WEAPON_SKILL[2] = [1000, 154, 5]   		# 백호의검
WEAPON_SKILL[3] = [1000, 154, 5]   		# 현무의검
WEAPON_SKILL[4] = [1000, 154, 5]   		# 청룡의검

# 4차 무기
WEAPON_SKILL[6] = [50000, 165, 20]   		# 현자금봉
WEAPON_SKILL[7] = [50000, 165, 20]   		# 검성기검
WEAPON_SKILL[8] = [50000, 165, 20]   		# 진선역봉
WEAPON_SKILL[9] = [50000, 165, 20]   		# 태성태도

# 중국무기
WEAPON_SKILL[11] = [700000, 115, 15]   		# 대모홍접선
WEAPON_SKILL[12] = [700000, 117, 15]   		# 구곡검
WEAPON_SKILL[13] = [700000, 166, 15]   		# 영후단봉
WEAPON_SKILL[14] = [700000, 125, 15]   		# 협가검

WEAPON_SKILL[15] = [50000, 125, 40]   		# 석단장
WEAPON_SKILL[16] = [100000, 125, 70]   		# 백사도
WEAPON_SKILL[17] = [200000, 196, 95]   		# 음양도

# 기타 검
WEAPON_SKILL[114] = [3000, 153, 40]   		# 주작의검
WEAPON_SKILL[115] = [1000000, 194, 5] 		# 심판의 낫
WEAPON_SKILL[117] = [100000, 120, 15] 		# 괴력선창
WEAPON_SKILL[124] = [500, 162, 40]   		# 얼음검
WEAPON_SKILL[126] = [7000, 154, 40]   		# 참마도
WEAPON_SKILL[127] = [60000, 184, 40]   		# 청룡신검
WEAPON_SKILL[123] = [100000, 192, 40]   		# 현무염도
WEAPON_SKILL[130] = [9000, 126, 20]   		# 산적왕의칼

# 일본
WEAPON_SKILL[136] = [15000, 1, 40]   		# 이가닌자의검
WEAPON_SKILL[134] = [400000, 170, 30]   		# 일화접선
WEAPON_SKILL[135] = [400000, 171, 30]   		# 진일신검
WEAPON_SKILL[138] = [400000, 164, 30]   		# 청일기창

# 용무기
WEAPON_SKILL[142] = [1000, 123, 10]   		# 용마제사검
WEAPON_SKILL[143] = [50000, 123, 10]   		# 용마제칠검
WEAPON_SKILL[144] = [400000, 123, 5]   		# 용마제팔검
WEAPON_SKILL[145] = [4000000, 174, 5]   		# 용마제구검

WEAPON_SKILL[147] = [1000, 141, 10]   		# 용랑제사봉
WEAPON_SKILL[148] = [50000, 141, 10]   		# 용랑제칠봉
WEAPON_SKILL[149] = [400000, 141, 5]   		# 용랑제팔봉
WEAPON_SKILL[150] = [4000000, 176, 5]   		# 용랑제구봉
# //////////////////////////end///////////////////////////////#

# -------------------------장비 착용시 효과----------------------------#
EQUIP_EFFECTS = {} # 특정 장비 착용시 효과 : [[효과 주기, 효과, 값(%)], [...], ..]
# 장신구
EQUIP_EFFECTS[28] = [[1 * sec, "buff", 46], [1 * sec, "buff", 47]] # 보무의목걸이
EQUIP_EFFECTS[29] = [[0.5 * sec, "buff", 131]] # 투명구두
EQUIP_EFFECTS[72] = [[10 * sec, "hp", 2], [10 * sec, "sp", 2]] # 해골목걸이
EQUIP_EFFECTS[75] = [[10 * sec, "hp", 4], [10 * sec, "sp", 4]] # 황금팔찌

# 방패 
EQUIP_EFFECTS[36] = [[10 * sec, "sp", 3]] # 기원부
EQUIP_EFFECTS[25] = [[10 * sec, "hp", 3]] # 강건부
EQUIP_EFFECTS[33] = [[10 * sec, "hp", 2], [10 * sec, "sp", 2]] # 도깨비부적
EQUIP_EFFECTS[39] = [[5 * sec, "hp", 1], [5 * sec, "sp", 1]] # 정화의방패
EQUIP_EFFECTS[40] = [[5 * sec, "hp", 2], [5 * sec, "sp", 2]] # 여신의방패
EQUIP_EFFECTS[98] = [[3 * sec, "hp", 3], [3 * sec, "sp", 3]] # 재생의부적

# 갑옷
EQUIP_EFFECTS[30] = [[1 * sec, "buff", 136]] # 가릉빈가의날개옷
EQUIP_EFFECTS[73] = [[1 * sec, "buff", 136]] # 가릉빈가의날개옷'진

# 투구
EQUIP_EFFECTS[61] = [[10 * sec, "sp", 3]] # 연청투구
EQUIP_EFFECTS[62] = [[10 * sec, "hp", 3]] # 연홍투구
EQUIP_EFFECTS[74] = [[10 * sec, "hp", 4], [10 * sec, "sp", 4]] # 황금투구
# //////////////////////////end///////////////////////////////#