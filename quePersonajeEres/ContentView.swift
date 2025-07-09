//
//  ContentView.swift
//  quePersonajeEres
//
//  Created by Bryan Sandoval on 08/07/25.
//

import SwiftUI


struct Animal {
    let nombre: String
    let viveEnAgua: Bool
    let esGrande: Bool
    let tienePelo: Bool
    let puedeVolar: Bool
    let haceSonidosFuertes: Bool
}

struct ContentView: View {
    @State private var showResult = false
    @State private var resultText = ""
    @State private var respuestas: [Bool] = []
    @State private var preguntaActual = 0

    let preguntas = [
        "¿Vive en el agua?",
        "¿Es grande?",
        "¿Tiene pelo?",
        "¿Puede volar?",
        "¿Hace sonidos fuertes?"
    ]
    
    let animales: [Animal] = [
        Animal(nombre: "Pez", viveEnAgua: true, esGrande: false, tienePelo: false, puedeVolar: false, haceSonidosFuertes: false),
        Animal(nombre: "Ballena", viveEnAgua: true, esGrande: true, tienePelo: false, puedeVolar: false, haceSonidosFuertes: true),
        Animal(nombre: "Perro", viveEnAgua: false, esGrande: false, tienePelo: true, puedeVolar: false, haceSonidosFuertes: true),
        Animal(nombre: "Águila", viveEnAgua: false, esGrande: true, tienePelo: false, puedeVolar: true, haceSonidosFuertes: true)
    ]
    
    var body: some View {
            VStack(spacing: 30) {
                
                if showResult {
                    Text(resultText)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button("Jugar otra vez") {
                        preguntaActual = 0
                        respuestas = []
                        showResult = false
                    }
                    .padding()
                    
                } else {
                    
                    Text(preguntas[preguntaActual])
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    HStack {
                        Button("Sí") {
                            responder(true)
                        }
                        .padding()
                        
                        Button("No") {
                            responder(false)
                        }
                        .padding()
                    }
                }
            }
        }
        
        func responder(_ respuesta: Bool) {
            respuestas.append(respuesta)
            
            if preguntaActual < preguntas.count - 1 {
                preguntaActual += 1
            } else {
                calcularResultado()
            }
        }
       
        func calcularResultado() {
            // Filtrar animales que coincidan con las respuestas
            let posibles = animales.filter { animal in
                return
                    animal.viveEnAgua == respuestas[0] &&
                    animal.esGrande == respuestas[1] &&
                    animal.tienePelo == respuestas[2] &&
                    animal.puedeVolar == respuestas[3] &&
                    animal.haceSonidosFuertes == respuestas[4]
            }
            
            if let animal = posibles.first {
                resultText = "¡Estás pensando en un \(animal.nombre)!"
            } else {
                resultText = "No encontré ningún animal con esas características. 🤔"
            }
            
            showResult = true
        }
    }

   #Preview {
       ContentView()
   }
