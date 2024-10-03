import wollok.game.*
import juegoDelDiego.*

object juego{
  
  method iniciar(){
    game.width(35)
    game.height(15)
    game.boardGround("cancha.png")
    game.addVisualCharacter(diego)
    game.addVisual(pelota)
    const defensor1 = new Defensores()
    game.addVisual(defensor1)
  }
}

object diego {

  var property position = game.center()

  method image() = "maradona.png" 

  method subir() {
    position = position.up(1)
  }
  
}

object pelota {

  var property position = game.center()

  method image() = "pelota.png" 

  method mover() {
    position = position.right(1)
  }

}

class Defensores {
    
    var property position = game.origin()
    
    method image() = "romaña.png"
    
    method mover() {
      position = position.right(1)
    }
}

