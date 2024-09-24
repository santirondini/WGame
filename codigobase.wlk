import wollok.game.*
import juegoDelDiego.*

object juego{
  
  method iniciar(){
    game.width(35)
    game.height(15)
    game.boardGround("cancha.png")
    game.addVisualCharacter(diego)
    game.addVisual(pelota)
  }
}

object diego {

  var property position = game.origin()

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
