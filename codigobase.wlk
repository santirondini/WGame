import wollok.game.*
import juegoDelDiego.*

object juego{
  
  method iniciar(){
    game.width(20)
    game.height(15)
    game.cellSize(40)
    game.title("Juego del Diego")
    game.ground("fulbo.png")
    game.addVisualCharacter(diego)
  }
}

object diego {

  var property position = game.origin()

  method image() = "diegote.jpg" 

  method subir() {
    position = position.up(1)
  }
  
}
