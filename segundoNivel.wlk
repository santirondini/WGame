import wollok.game.*
import juegoDelDiego.*
import personajes.*

object segundoNivel{
  
  method iniciar(){
    game.width(41)
    game.height(20)
    game.boardGround("canchaOchoBit.jpg")
    game.addVisualCharacter(diego)
    game.addVisual(pelota)
    game.addVisual(temporizador)
    game.addVisual(zonaDeGol) 
    temporizador.iniciarTiempo()
    const defensor1 = new Defensores(x = 10,direccion = 1, y=5)

    game.addVisual(defensor1)

    game.onTick(1000, "movimiento", { defensor1.mover() })


    game.whenCollideDo(defensor1,{pelota => 
      game.stop()
      game.addVisual(perdiste)
    })
    
        game.whenCollideDo(diego, { pelota =>
      pelota.seguirADiego()
    })

    /*
      keyboard.p().onPressDo { 
        pelota.siguiendoADiego = false 
        pelota.moverHorizontalmente() 
        } 
  */
  }
}

