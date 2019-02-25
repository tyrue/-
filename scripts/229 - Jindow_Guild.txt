#==============================================================================
# ■ Jindow_Guild
#------------------------------------------------------------------------------
class Jindow_Guild < Jindow
  def initialize
    $game_system.se_play($data_system.decision_se)
    super(0, 0, 168, 180)
    self.name = '문파'
    @head = true
    @mark = true
    @drag = true
    @close = true
    self.refresh('Guild')
    self.x = 75
    self.y = 75

    texts = []
    texts.push("문파명 : " + $guild.to_s + "")
    text = Sprite.new(self)
    text.bitmap = Bitmap.new(self.width, texts.size * 18 + 12)
    text.bitmap.font.color.set(100, 150, 200, 240)
    for i in 0...texts.size
      text.bitmap.draw_text(10, i * 19, self.width, 32, texts[i])
    end
    text = Sprite.new(self)
    text.bitmap = Bitmap.new(self.width, 140)
    text.bitmap.font.color.set(255, 85, 68, 220)
    text.bitmap.draw_text(2, 15, self.width, 32, "  문파장 : " + $guild_master)
    text.bitmap.font.color.set(57, 200, 12, 210)
    text.bitmap.draw_text(2, 30, self.width, 32, "  문파 칭호 : " + $guild_group)
    text.bitmap.font.color.set(70, 65, 40, 255)
    text.bitmap.draw_text(5, 52, self.width, 32, "입력 :")
    @a = J::Button.new(self).refresh(79, '문파 초대')
    @a.y = 85
    @b = J::Button.new(self).refresh(79, '문파원 추방')
    @b.x = self.width - 79
    @b.y = 85
    @c = J::Button.new(self).refresh(79, '칭호 하사')
    @c.y = 107
    @d = J::Button.new(self).refresh(79, '문파 탈퇴')
    @d.y = 157
    @e = J::Button.new(self).refresh(79, '문파원 목록')
    @e.x = self.width - 79
    @e.y = 107
    @type_guild = J::Type.new(self).refresh(35, 60, self.width - 40, 16)
  end
  
  def update
    super
    if @a.click # 문파원 초대.
      guild = @type_guild.result
      $game_system.se_play($data_system.decision_se)
      if $guild_group == "문파장" or $guild_group == "부문파장"
          $console.write_line("#{guild.to_s}님에게 문파 초대를 하셨습니다.")
        Network::Main.socket.send "<Guild_Invite>#{guild},#{$guild},#{$guild_master}</Guild_Invite>\n"
      else
        $console.write_line("문파장 혹은 부문파장만 쓸 수 있는 기능 입니다.")
      end
    elsif @b.click # 문파원 추방.
      guild = @type_guild.result
      $game_system.se_play($data_system.decision_se)
      if $guild_group == "문파장"
        if guild.to_s != $game_party.actors[0].name
          Network::Main.socket.send "<Guild_Delete>#{guild},#{$guild}</Guild_Delete>\n"
        else
          $console.write_line("추방 시킬 수 없는 계급 입니다.")
        end
      else
          $console.write_line("문파장만 쓸 수 있는 기능 입니다.")
      end
    elsif @c.click # 문파원 계급 하사.
      $game_system.se_play($data_system.decision_se)
      if $guild_group == "문파장"
        Jindow_Guild_Nickname.new
      else
       $console.write_line("문파장만 쓸 수 있는 기능 입니다.")
      end
    elsif @d.click # 문파 탈퇴 /  폐쇄.
      $game_system.se_play($data_system.decision_se)
      if $guild != ""
        if $guild_group == "문파장"
          Jindow_Dialog.new(640 / 2 - 224 / 2, 480 / 2 - 82 / 2, 250,
          ["#{$guild} 문파를 정말 폐쇄 하겠습니까?"], ["예", "아니오"],
          ["Network::Main.socket.send '<Guild_Remove>#{$guild.to_s}</Guild_Remove>\n'; $guild = '""'; $guild_master = '""'; $guild_group = '""'; $chat.write ('◎ 문파를 폐쇄 하셨습니다.', Color.new(65,105, 0)); Hwnd.dispose(self)" ,
          "Hwnd.dispose(self)"], "문파 폐쇄")
        else
          Network::Main.socket.send "<Guild_Delete3>#{$guild.to_s},#{$game_party.actors[0].name}</Guild_Delete3>\n"
        end
      else
       $console.write_line("문파가 없습니다.")
      end
    elsif @e.click # 문파원 목록 불러오기
        Jindow_Guild_Member.new
    end
  end
end
