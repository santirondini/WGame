import wollok.game.*
import juegoDelDiego.*
import personajes.*


object primerNivel {

  method iniciar() {
    game.width(41)
    game.height(20)
    game.boardGround("canchaOchoBit.jpg")
    game.addVisualCharacter(diego)
    game.addVisual(pelota)
    game.addVisual(temporizador)
    temporizador.iniciarTiempo()

    // Crear una lista de defensores
    const defensores = [
      new Defensor(x = 10, direccion = 1, y = 5),
      new Defensor(x = 5, direccion = -1, y = 15)
    ]
    
    // Crear una lista de zonas de gol
    const arco = [
      new Zona(x = 1, y = 8),
      new Zona(x = 1, y = 9),
      new Zona(x = 1, y = 10),
      new Zona(x = 1, y = 11)
    ]

    // Crear una lista de zona afuera
    const afuera = [
      new Zona(x = 1, y = 12),
      new Zona(x = 1, y = 7)
    ]


    // Agregar visuales de defensores y zonas de gol al juego
    defensores.forEach { defensor => game.addVisual(defensor) }
    arco.forEach { zona => game.addVisual(zona) }
    afuera.forEach {zona =>game.addVisual(zona)}

    // Configuración de movimiento de los defensores
    defensores.forEach { defensor =>
      game.onTick(500, "movimiento", { defensor.mover() })
    }

    // Configuración de colisiones para defensores
    defensores.forEach { defensor =>
      game.whenCollideDo(defensor, { pelota =>
        game.stop()
        game.addVisual(perdiste)
      })
    }

      afuera.forEach { defensor =>
      game.whenCollideDo(defensor, { pelota =>
        game.stop()
        game.addVisual(perdiste)
      })
    }

    // Configuración de colisión para Diego y la pelota
    game.whenCollideDo(diego, { pelota =>
      pelota.seguirADiego()
    })

    // Configuración de colisiones para zonas de gol
    arco.forEach { zona =>
      game.whenCollideDo(zona, { pelota =>
        game.addVisual(transicion)
        temporizador.nuevotiempo(30)
      })
    }
  }
}
