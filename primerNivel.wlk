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
    const defensor1 = new Defensores(x = 10,direccion = 1, y=5)
    const defensor2 = new Defensores(x = 5, direccion =-1, y=15)
    const zonaDeGol1 = new ZonaDeGol(x=1, y=8)
    const zonaDeGol2 = new ZonaDeGol(x=1, y=9)
    const zonaDeGol3 = new ZonaDeGol(x=1, y=10)
    const zonaDeGol4 = new ZonaDeGol(x=1, y=11)

    game.addVisual(zonaDeGol1)
    game.addVisual(zonaDeGol2)
    game.addVisual(zonaDeGol3)
    game.addVisual(defensor1)
    game.addVisual(defensor2)

    game.onTick(1000, "movimiento", { defensor1.mover() })
    game.onTick(1000, "movimiento", { defensor2.mover() })


    game.whenCollideDo(defensor1,{pelota => 
      game.stop()
      game.addVisual(perdiste)
    })

    game.whenCollideDo(defensor2,{pelota => 
      game.stop()
      game.addVisual(perdiste)
    })
    
        game.whenCollideDo(diego, { pelota =>
        pelota.seguirADiego()
    })

      game.whenCollideDo(zonaDeGol1, {pelota =>
      game.addVisual(gol)
  })

      game.whenCollideDo(zonaDeGol2, {pelota =>
      game.addVisual(gol)
  })

        game.whenCollideDo(zonaDeGol3, {pelota =>
      game.addVisual(gol)
  })
  
  game.whenCollideDo(zonaDeGol4, {pelota =>
      game.addVisual(gol)
  })
  }
}

