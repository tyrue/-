#==============================================================================
# ** 게임오버 업데이트
#------------------------------------------------------------------------------
#  이스크립트는 게임오버 화면을 바꿔주는 스크립트입니다
#  수정: 류천 (gustnaos56)
#==============================================================================

class Scene_Gameover
  # 죽엇니?
  $losegold = false # TRUE = yes //\\\\ FALSE = no
  $loseexp = false # TRUE = yes //\\\\ FALSE = no
  $map_id = 1 # 마을부활시 , 이동할 맵 아이디
  $map_x = 5 # 이동할 맵 좌표 x
  $map_y = 5 # 이동할 맵 좌표 y

 
  #--------------------------------------------------------------------------
  # * 메인 프로세스
  #--------------------------------------------------------------------------
  def main
    @spriteset = Spriteset_Map.new
    # PK 갱신
    # 도표에 게임을 만드십시오
    # 옵션 목록을 만드십시오                                                                                        
    @options = Window_Command.new(160, $selectable)
    @options.x = 640 / 2
    @options.y = 640 / 2
   # @Gameover = Window_GameOver.new
    # 저에 놀이 게임
    $game_system.me_play($data_system.gameover_me)
    # 과도를 수행하세요
    Graphics.transition(120)
    # 메인 루프
    loop do
      # 게임 스크린 갱신
      Graphics.update
      # 갱신은 정보를 입력
      Input.update
      # 프레임 갱신
      update
      # 스크린이 바꾸어지는 경우에 비행 루프를 중지한다.
      if $scene != self
        break
      end
    end
    # 과도를 위해 준비
    Graphics.freeze
    # 도표에 게임을 처분
    @spriteset.dispose
    # 선택권을 처분
    @options.dispose
    # 과도를 수행
    Graphics.transition(40)
    # 과도를 위해 준비
    Graphics.freeze
    # 만약에 전투인 경우에 테스트 한다.
    if $BTEST
      $scene = nil
    end
  end
  #--------------------------------------------------------------------------
  # * 프레임 업데이트
  #--------------------------------------------------------------------------
  def update
    @options.update
    @spriteset.update
    # C 버튼이 눌러진 경우
    if Input.trigger?(Input::C)
      case @options.index
      when 1  # 마을로이동
        if $losegold
        $gameover_gold = (($game_party.gold.to_i * 10) / 100 / 5) # 돈을 5%를 잃는다.
        $game_party.lose_gold($gameover_gold)
        end
     
      if $loseexp
        $game_actors[1].exp -= (($game_actors[1].level.to_i * 10) / 5) #경험치 잃는다
      end
      when 2  # 현재맵에서 부활
        if $losegold
        $gameover_gold = (($game_party.gold.to_i * 10) / 100 / 5) # 돈을 5%를 잃는다.
        $game_party.lose_gold($gameover_gold)
        end
     
      if $loseexp
        $game_actors[1].exp -= (($game_actors[1].level.to_i * 10) / 5) #경험치 잃는다
      end
        $map_new_id = $game_map.map_id
        $map_new_x = $game_player.x
        $map_new_y = $game_player.y
        $game_player.refresh
        $game_temp.player_new_map_id = $map_new_id # 아이디
        $game_temp.player_new_x = $map_new_x # 맵 x 좌표
        $game_temp.player_new_y = $map_new_y # 맵 y 좌표
        $game_map.setup($game_temp.player_new_map_id)
        $game_player.moveto($game_temp.player_new_x, $game_temp.player_new_y)
        $game_map.update
        $game_actors[1].hp = $game_actors[1].maxhp
        $game_actors[1].sp = $game_actors[1].maxsp
        $game_temp.gameover = false
        $game_temp.player_transferring = false
        $game_temp.transition_processing = false
        $scene = Scene_Map.new
      when 3  # 걍 게임종료
        $scene = nil
      end
    end
  end
end

