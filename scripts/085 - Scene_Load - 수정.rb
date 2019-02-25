#==============================================================================
# ■ Scene_Load
#------------------------------------------------------------------------------
# 　로드 화면의 처리를 실시하는 클래스입니다.
#==============================================================================

class Scene_Load < Scene_File
  #--------------------------------------------------------------------------
  # ● 오브젝트 초기화
  #--------------------------------------------------------------------------
  def initialize
    # 텐포라리오브제크트를 재작성
    $game_temp = Game_Temp.new
    # 타임 스탬프가 최신의 파일을 선택
    $game_temp.last_file_index = 0
    latest_time = Time.at(0)
    for i in 0..3
      filename = make_filename(i)
      if FileTest.exist?(filename)
        file = File.open(filename, "r")
        if file.mtime > latest_time
          latest_time = file.mtime
          $game_temp.last_file_index = i
        end
        file.close
      end
    end
    super("어느 파일을 로드합니까?")
  end
  #--------------------------------------------------------------------------
  # ● 결정시의 처리
  #--------------------------------------------------------------------------
  def on_decision(filename)
    # 파일이 존재하지 않는 경우
    unless FileTest.exist?(filename)
      # 버저 SE 를 연주
      $game_system.se_play($data_system.buzzer_se)
      return
    end
    # 로드 SE 를 연주
    $game_system.se_play($data_system.load_se)
    # 세이브 데이터의 기입
    file = File.open(filename, "rb")
    read_save_data(file)
    file.close
    # BGM, BGS 를 복귀
    $game_system.bgm_play($game_system.playing_bgm)
    $game_system.bgs_play($game_system.playing_bgs)
    # 맵을 갱신 (병렬 이벤트 실행)
    $game_map.update
    # 맵 화면으로 전환해
    $scene = Scene_Map.new
  end
  #--------------------------------------------------------------------------
  # ● 캔슬시의 처리
  #--------------------------------------------------------------------------
  def on_cancel
    # 캔슬 SE 를 연주
    $game_system.se_play($data_system.cancel_se)
    # 타이틀 화면으로 전환해
    $scene = Scene_Title.new
  end
  #--------------------------------------------------------------------------
  # ● 세이브 데이터의 읽기
  #     file : 읽기용 파일 오브젝트 (오픈이 끝난 상태)
  #--------------------------------------------------------------------------
  def read_save_data(file)
    # 세이브 파일 묘화용의 캐릭터 데이터를 읽어들인다
    characters = Marshal.load(file)
    # 플레이 시간 계측용의 프레임 카운트를 읽어들인다
    Graphics.frame_count = Marshal.load(file)
    # 각종 게임 오브젝트를 읽어들인다
    $game_system        = Marshal.load(file)
    $game_switches      = Marshal.load(file)
    $game_variables     = Marshal.load(file)
    $game_self_switches = Marshal.load(file)
    $game_screen        = Marshal.load(file)
    $game_actors        = Marshal.load(file)
    $game_party         = Marshal.load(file)
    $game_troop         = Marshal.load(file)
    $game_map           = Marshal.load(file)
    $game_player        = Marshal.load(file)
    데이터 = Marshal.load(file)
    #----------------------------------------------
    # * 세이브 에디터 사용 감지
    #----------------------------------------------
    for i in 0..4999
      if 데이터[0][i] != $game_switches[i+1]
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[1][i] != $game_variables[i+1]
        raise "세이브 에디터의 사용을 감지하였습니다."
      end
    end
    for i in 0..$game_party.actors.size-1
      if 데이터[2][i] != $game_party.actors[i].name
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[3][i] != $game_party.actors[i].level
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[4][i] != $game_party.actors[i].exp
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[5][i] != $game_party.actors[i].hp
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[6][i] != $game_party.actors[i].maxhp
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[7][i] != $game_party.actors[i].sp
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[8][i] != $game_party.actors[i].maxsp
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[9][i] != $game_party.actors[i].str
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[10][i] != $game_party.actors[i].agi
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[11][i] != $game_party.actors[i].dex
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[12][i] != $game_party.actors[i].int
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[15][i] != $game_party.actors[i].atk
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[16][i] != $game_party.actors[i].pdef
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[17][i] != $game_party.actors[i].mdef
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[18] != $game_map.map_id
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[19] != $game_player.x
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[20] != $game_player.y
        raise "세이브 에디터의 사용을 감지하였습니다."
      elsif 데이터[21][i] != $game_party.actors[i].class_id
        raise "세이브 에디터의 사용을 감지하였습니다."
      end
    end
    if 데이터[13] != $game_party.gold.to_s
      raise "세이브 에디터의 사용을 감지하였습니다."
    end
    if 데이터[14] != $game_party.steps.to_s
      raise "세이브 에디터의 사용을 감지하였습니다."
    end
        # magic number-가 세이브시와 다른 경우
    # (에디터로 편집이 더해지고 있는 경우)
    if $game_system.magic_number != $data_system.magic_number
      # 맵을 리로드
      $game_map.setup($game_map.map_id)
      $game_player.center($game_player.x, $game_player.y)
    end
    $game_party.refresh
  end
end
