import claseNivel.Nivel


object diegoGanador {

  method image() = "diegoConLaCopa.jpg"
}

class Enfermera {

  var posEnfermeraX
  var posEnfermeraY
  
  method image() = "enfermera94.png"

  var position = game.at(posEnfermeraX,posEnfermeraY)

  method position() = position
  
  method buscandoAdiego() {
    posEnfermeraX = 0.randomUpTo(game.width()).truncate(0)
    posEnfermeraY = 0.randomUpTo(game.height()).truncate(0)
    position = game.at(posEnfermeraX,posEnfermeraY)
  }
}

class Ferrari {

  const posFerrariX
  const posFerrariY

  var property agarrada = false

  const diego 

  method fueAgarradaPorDiego() {
    agarrada = true 
    diego.agarroFerrari() 
  }

  method image() = "ferrar165x165.png"

  method position() = game.at(posFerrariX,posFerrariY) 

}
class Temporizador {

  var tiempoRestante

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

class Diego {

  const ubicacionDiegoX
  
  const ubicacionDiegoY

  const imagen 

  var property agarroFerrari = false 

  // centro de cancha (23,10)
  var property position = game.at(ubicacionDiegoX,ubicacionDiegoY)

  method position() = position 

  method image() = imagen


}

class Zona {
      const x
      const y
  	  method position() = game.at(x, y)
}

class Pelota {

  const posicionX
  const posicionY

  const patearPara
  
  // nivel 1 = (20,10)
  var property position = game.at(posicionX,posicionY)
  var property siguiendoADiego = false

  method image() = "labocha4.png"

  method seguirADiego() {
      siguiendoADiego = true
      game.onTick(25, "sincronizar", { self.sincronizarConDiego() })
  }

  const diegoAsociado

method sincronizarConDiego() {
    if (siguiendoADiego) {
      position = diegoAsociado.position()
    }
  }

  method moverHorizontalmente(){
    siguiendoADiego = false 
    position = position.left(patearPara)
  }  
}

object paleta {
  const property verde = "00FF00FF"
  const property rojo = "FF0000FF"
  const property negro = "00000000"
  const property amarillo = "FFFC00CC"
}

object perdiste {

  method position() = game.origin()

  method image() = "Derrota.jpeg" 
}


class Defensor {

    const x 
    const y
    var property position = game.at(x, y)
    var direccion  // 1 para abajo, -1 para arriba

    method image() = "defensor.png"

    method mover() {
        // Obtenemos la posición actual en y
        const yActual = position.y()

        // Calculamos la nueva posición en y
        const nuevaY = yActual + direccion

        // Cambiamos de dirección si llegamos a los bordes del tablero
        if (nuevaY <= 5 || nuevaY >= game.height()-5) {
            direccion = direccion * -1
        }

        // Actualizamos la posición del defensor
        position = game.at(x, nuevaY)
    }
}

class Transicion{

    const imagen
    method position() = game.origin()
    method image() = imagen
}

