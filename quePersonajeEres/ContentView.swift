//
//  ContentView.swift
//  quePersonajeEres
//
//  Created by Bryan Sandoval on 08/07/25.
//

import SwiftUI


struct Heroe {
    let nombre: String
    let esMarvel: Bool
    let esHumano: Bool
    let tieneMascara: Bool
    let puedeVolar: Bool
    let tieneSuperpoderes: Bool
    let imageUrl: String
}

struct ContentView: View {
    @State private var showResult = false
    @State private var resultText = ""
    @State private var personajeAdivinado = ""
    @State private var respuestas: [Bool] = []
    @State private var preguntaActual = 0

    let preguntas = [
        "¿Es de Marvel?",
        "¿Es humano?",
        "¿Utiliza máscara o casco?",
        "¿Puede volar?",
        "¿Tiene superpoderes?"
    ]
    
    let heroes: [Heroe] = [
        Heroe(nombre: "Spider-Man", esMarvel: true, esHumano: true, tieneMascara: true, puedeVolar: false, tieneSuperpoderes: true, imageUrl: "spiderman"),
        Heroe(nombre: "IronMan", esMarvel: true, esHumano: true, tieneMascara: true, puedeVolar: true, tieneSuperpoderes: false, imageUrl: "ironman"),
        Heroe(nombre: "Superman", esMarvel: false, esHumano: false, tieneMascara: false, puedeVolar: true, tieneSuperpoderes: true, imageUrl: "superman"),
        Heroe(nombre: "Hulk", esMarvel: true, esHumano: true, tieneMascara: false, puedeVolar: false, tieneSuperpoderes: true, imageUrl: "hulk"),
    ]
    
    var body: some View {
            VStack(spacing: 30) {
                
                if showResult {
                    
                    Text(resultText)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                    Image(personajeAdivinado)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
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
            let posibles = heroes.filter { heroe in
                return
                heroe.esMarvel == respuestas[0] &&
                    heroe.esHumano == respuestas[1] &&
                    heroe.tieneMascara == respuestas[2] &&
                    heroe.puedeVolar == respuestas[3] &&
                    heroe.tieneSuperpoderes == respuestas[4]
            }
            
            if let heroe = posibles.first {
                resultText = "¡Estás pensando en  \(heroe.nombre)!"
                personajeAdivinado = heroe.imageUrl
                
            } else {
                resultText = "No encontré ningún heroe con esas características. 🤔"
            }
            
            showResult = true
        }
    }

   #Preview {
       ContentView()
   }
