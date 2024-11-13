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

    game.whenCollideDo(diego,{pelota=>
      pelota.centrar()
    })
  }
}

object diego {

  var property position = game.center()

  method image() = "maradona.png"

}

object pelota {

  var property position = game.at(20,10)

  method centrar() {
    position = game.origin()
  }

  method image() = "bocha.png"

}

class Defensores {
    
    var property position = game.at(10,10)
    
    method image() = "defensor.png"

    method mover() {
      const y = 0.randomUpTo(game.height()).truncate(0)
      position = game.at(10,y)
  }
}

