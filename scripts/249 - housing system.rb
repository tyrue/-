
#----------------------하우징 시스템 ---------------------------------


def 하우징a
    Network::Main.socket.send("<house1>하우징시스템|#{Network::Main.name}|#{$game_party.actors[0].name}|</house1>\n")
end


def 하우징b
    Network::Main.socket.send("<house2>하우징시스템|#{Network::Main.name}|#{$game_party.actors[0].name}|</house2>\n")
  end
  
  
def 하우징c
    Network::Main.socket.send("<house3>하우징시스템|#{Network::Main.name}|#{$game_party.actors[0].name}|</house3>\n")
  end
  
  
def 하우징d
    Network::Main.socket.send("<house4>하우징시스템|#{Network::Main.name}|#{$game_party.actors[0].name}|</house4>\n")
  end
  
  
  def a번하우징
    Network::Main.socket.send("<housere1>0</housere1>\n")
  end
  
    def b번하우징
    Network::Main.socket.send("<housere2>0</housere2>\n")
  end
  
    def c번하우징
    Network::Main.socket.send("<housere3>0</housere3>\n")
  end
  
    def d번하우징
    Network::Main.socket.send("<housere4>0</housere4>\n")
end