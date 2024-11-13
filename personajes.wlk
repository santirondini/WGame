
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

  var property position = game.at(23,10)

  method position() = position 

  method image() = "maradona.png"


/*
  method patear() {
    if (pelota.siguiendoADiego()) {
      pelota.moverPelota(zonaDeGol.position())
    }
  }
  */
}

class ZonaDeGol {
      const x
      const y
  	  method position() = game.at(x, y)
}

object pelota {

  var property position = game.at(20,10)
  var property siguiendoADiego = false

  method image() = "labocha4.png"

  method seguirADiego() {
      siguiendoADiego = true
      game.onTick(50, "sincronizar", { self.sincronizarConDiego() })
  }

method sincronizarConDiego() {
    if (siguiendoADiego) {
      position = diego.position()
    }
  }

  method moverHorizontalmente(){

    game.onTick(50,"movimiento", { 
      position = position.left(1)
    })

  }
  
}

object paleta {
  const property verde = "00FF00FF"
  const property rojo = "FF0000FF"
  const property negro = "00000000"
}

object gol {

  method position() = game.center()

  method text() = " ¡¡¡ GOOOOOOOOOOOOOOOOOOL !!! " 

  method textColor() = paleta.negro()

}



object perdiste {

  method position() = game.center()

  method text() = "PERDISTE. ME COMENTAN QUE EL DIEGO NO RESISTIÓ" 

  method textColor() = paleta.rojo()

}


class Defensores {

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
        if (nuevaY <= 0 || nuevaY >= game.height()) {
            direccion = direccion * -1
        }

        // Actualizamos la posición del defensor
        position = game.at(x, nuevaY)
    }
}

