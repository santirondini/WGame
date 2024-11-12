import wollok.game.*
import juegoDelDiego.*
import personajes.*

object primerNivel{
  
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

