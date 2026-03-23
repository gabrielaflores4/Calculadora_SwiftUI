//
//  ContentView.swift
//  Calculadora
//
//  Created by Gabriela Flores on 17/3/26.
//

import SwiftUI

struct ContentView: View {
    @State var resultado = "0"
    @State var num1: Double = 0
    @State var num2: Double = 0
    @State var operacion = ""
    @State var estaEscribiendo = false
    
    let botones = [
        ["C", "/", "x", "-"],
        ["7", "8", "9", "+"],
        ["4", "5", "6", "="],
        ["1", "2", "3", "0"]
    ]
    
    
    var body: some View {
        VStack(spacing: 10) {
            
            // Pantalla
            Text(resultado)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            
            // Botones
            ForEach(0..<botones.count, id: \.self) { i in
                HStack(spacing: 10) {
                    ForEach(0..<botones[i].count, id: \.self) { j in
                        let boton = botones[i][j]
                        
                        Button(action: {
                            botonPresionado(boton)
                        }) {
                            Text(boton)
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func botonPresionado(_ texto: String) {
        
        if Double(texto) != nil {
            if estaEscribiendo {
                resultado += texto
            } else {
                resultado = texto
                estaEscribiendo = true
            }
            return
        }
        
        if texto == "C" {
            resultado = "0"
            num1 = 0
            num2 = 0
            operacion = ""
            estaEscribiendo = false
            return
        }
        
        if texto == "+" || texto == "-" || texto == "x" || texto == "/" {
            num1 = Double(resultado) ?? 0
            operacion = texto
            estaEscribiendo = false
            return
        }
        
        if texto == "=" {
            num2 = Double(resultado) ?? 0
            
            switch operacion {
            case "+":
                resultado = "\(num1 + num2)"
            case "-":
                resultado = "\(num1 - num2)"
            case "x":
                resultado = "\(num1 * num2)"
            case "/":
                resultado = num2 == 0 ? "Error" : "\(num1 / num2)"
            default:
                break
            }
            
            estaEscribiendo = false
        }
    }
}

#Preview {
    ContentView()
}
