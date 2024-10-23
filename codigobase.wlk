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
      pelota.seguirADiego()
    })
  }
}

object diego {

  var property position = game.center()

  method position() = position 

  method image() = "maradona.png"

}

object pelota {

  var property position = game.at(20,10)
  var property siguiendoADiego = false

  method image() = "labocha.png"

  method seguirADiego() {
      siguiendoADiego = true
      game.onTick(100, "sincronizar", { self.sincronizarConDiego() })
  }

method sincronizarConDiego() {
    if (siguiendoADiego) {
      position = diego.position()
    }
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

