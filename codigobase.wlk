import wollok.game.*
import juegoDelDiego.*

object juego{
  
  method iniciar(){
    game.width(41)
    game.height(20)
    game.boardGround("canchaOchoBit.jpg")
    game.addVisualCharacter(diego)
    game.addVisual(pelota)
    const defensor1 = new Defensores()
    game.addVisual(defensor1)
    game.onTick(1000, "movimiento", { defensor1.mover() })
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

  method image() = "labocha.png"

  method mover() {
    position = position.right(1)
  }

}

class Defensores {
    
    var property position = game.at(10,10)
    
    method image() = "defensor.png"

    method mover() {
      const y = 0.randomUpTo(game.height()).truncate(0)
      position = game.at(10,y)
  }
}

