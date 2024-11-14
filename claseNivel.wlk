import wollok.game.*
import juegoDelDiego.*
import personajes.*

class Nivel {

  const diegoX
  const diegoY
  const imagenDiego

  const pelotaX
  const pelotaY

  const tiempoDeJuego
  const lineadegol
  const moverDefensor
  const arcoRival
  const velocidadDefensor

  var property gol = false
  var property terminado = false
  
  const diego = new Diego(ubicacionDiegoX = diegoX, ubicacionDiegoY = diegoY, imagen= imagenDiego) 
  const pelota = new Pelota(diegoAsociado = diego,posicionX = pelotaX, posicionY = pelotaY, patearPara = arcoRival)
  const temporizador = new Temporizador(tiempoRestante = tiempoDeJuego)

    const defensores = [
      new Defensor(x = 10+ moverDefensor, direccion = 1, y = 5),
      new Defensor(x = 5+ moverDefensor, direccion = -1, y = 15)
    ]
    
    // Crear una lista de zonas de gol
    const arco = [
      new Zona(x = lineadegol, y = 8),
      new Zona(x = lineadegol, y = 9),
      new Zona(x = lineadegol, y = 10),
      new Zona(x = lineadegol, y = 11)
    ]

    // Crear una lista de zona afuera
    const afuera = [
      new Zona(x = lineadegol, y = 12),
      new Zona(x = lineadegol, y = 7)
    ]

  method iniciar() {

    game.width(41)
    game.height(20)
    game.boardGround("canchaOchoBit.jpg")
    game.addVisualCharacter(diego)
    game.addVisual(pelota)
    game.addVisual(temporizador)
    temporizador.iniciarTiempo()

    // Agregar visuales de defensores y zonas de gol al juego
    defensores.forEach { defensor => game.addVisual(defensor) }
    arco.forEach { zona => game.addVisual(zona) }
    afuera.forEach {zona =>game.addVisual(zona)}

    // Configuración de movimiento de los defensores
    defensores.forEach { defensor =>
      game.onTick(velocidadDefensor, "movimiento", { defensor.mover() })
    }

    // Configuración de colisiones para defensores y enfermera
    defensores.forEach { defensor =>
      game.whenCollideDo(defensor, { pelota =>
        game.stop()
        game.addVisual(perdiste)
      })
    }

      afuera.forEach { defensor =>
      game.whenCollideDo(defensor, { diego =>
        game.stop()
        game.addVisual(perdiste)
      })
    }

    afuera.forEach { enfermera =>
      game.whenCollideDo(enfermera, { pelota =>
        game.stop()
        game.addVisual(perdiste)
      })
    }

    // Configuración de colisión para Diego y la pelota
    game.whenCollideDo(diego, {pelota =>
      pelota.seguirADiego()
    })

    // Configuración de colisiones para zonas de gol
    arco.forEach { zona =>
      game.whenCollideDo(zona, { pelota =>
        gol = true
      })
    }

    // Configuración de pegarle al arco. Si el diego agarro al ferrari, le pega el doble de rápido
    keyboard.p().onPressDo {
      game.onTick(150,"zurdazo maradoniano",{pelota.moverHorizontalmente()})
    }


    // Configuración para cuando el Diego agarra la ferrari negra 
    game.whenCollideDo(diego, {ferrariNegra => ferrariNegra.fueAgarradaPorDiego()}) // + la ferrari desaparezca 
 }

   method resetGol() {
      gol = false
  }

  method finalizar() {
      game.removeVisual(diego)
      game.removeVisual(pelota)
      game.removeVisual(temporizador)
    
    // Remover defensores, zonas de gol, y demás elementos visuales añadidos en iniciar()
      defensores.forEach { defensor => game.removeVisual(defensor) }
      arco.forEach { zona => game.removeVisual(zona) }
      afuera.forEach { zona => game.removeVisual(zona) }
  }
}