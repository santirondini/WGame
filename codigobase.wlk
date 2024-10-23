import wollok.game.*
import juegoDelDiego.*

object juego{
  
  method iniciar(){
    game.width(41)
    game.height(20)
    game.boardGround("canchaOchoBit.jpg")
    game.addVisualCharacter(diego)
    game.addVisual(pelota)
    game.addVisual(temporizador)
    temporizador.iniciarTiempo()
    const defensor1 = new Defensores()

    game.addVisual(defensor1)

    game.onTick(1000, "movimiento", { defensor1.mover() })

    game.whenCollideDo(diego,{pelota=>
      pelota.seguirADiego()
    })

    game.whenCollideDo(defensor1,{pelota => 
      game.stop()
      game.addVisual(perdiste)
    })
  }
}

object temporizador {

  var property tiempoRestante = 30

  method position() = game.at(20,18)

  method text() = "Tiempo: " + tiempoRestante

  method textColor() = paleta.negro()

  method iniciarTiempo() {
    game.onTick(1000, "decrementarTiempo", { self.decrementar() })
  }

  method decrementar() {
    tiempoRestante = tiempoRestante - 1
    if (tiempoRestante <= 0) {
      game.stop()
      game.addVisual(perdiste)
    }
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
      game.onTick(50, "sincronizar", { self.sincronizarConDiego() })
  }

method sincronizarConDiego() {
    if (siguiendoADiego) {
      position = diego.position()
    }
  }
}

object paleta {
  const property verde = "00FF00FF"
  const property rojo = "FF0000FF"
  const property negro = "00000000"
}

object perdiste {

  method position() = game.center()

  method text() = "PERDISTE. ME COMENTAN QUE EL DIEGO NO RESISTIÓ" 

  method textColor() = paleta.rojo()

}


class Defensores {
    
    var property position = game.at(10,10)
    
    method image() = "defensor.png"

    method mover() {
      const y = 0.randomUpTo(game.height()).truncate(0)
      position = game.at(10,y)
  }

}

