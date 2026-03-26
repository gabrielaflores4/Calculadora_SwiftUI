//
//  ContentView.swift
//  Calculadora
//
//  Created by Gabriela Flores on 17/3/26.
//

import SwiftUI

struct ContentView: View {
    @State var resultado = "0"
    @State var historial = ""
    @State var num1: Double = 0
    @State var num2: Double = 0
    @State var operacion = ""
    @State var estaEscribiendo = false
    
    let botones = [
        "C", "", "", "",
        "7", "8", "9", "/",
        "4", "5", "6", "x",
        "1", "2", "3", "-",
        "0", ".", "=", "+"
    ]
    
    let columnas = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(historial)
                    .font(.caption)
                Text(resultado)
                    .font(.largeTitle)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
                
            LazyVGrid(columns: columnas, spacing: 10) {
                ForEach(botones, id: \.self) { boton in
                    if boton == "" {
                        Color.clear.frame(height: 90)
                    } else {
                        Button(action: {
                            botonPresionado(boton)
                        }) {
                            Text(boton)
                                .frame(height: 90)
                                .frame(maxWidth: .infinity)
                                .background(colorBoton(boton))
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
            
            if operacion != "" {
                historial = "\(formatear(num1)) \(operacion) \(resultado)"
            }
            
            return
        }
        
        if texto == "." {
            if !estaEscribiendo {
                resultado = "0."
                estaEscribiendo = true
            } else if !resultado.contains(".") {
                resultado += "."
            }
            
            if operacion != "" {
                historial = "\(formatear(num1)) \(operacion) \(resultado)"
            }
            
            return
        }
        
        if texto == "C" {
            resultado = "0"
            historial = ""
            num1 = 0
            num2 = 0
            operacion = ""
            estaEscribiendo = false
            return
        }
        
        if texto == "+" || texto == "-" || texto == "x" || texto == "/" {
            if let valor = Double(resultado) {
                num1 = valor
            } else {
                resultado = "Error"
                return
            }
            
            operacion = texto
            historial = "\(formatear(num1)) \(texto)"
            estaEscribiendo = false
            return
        }
        
        if texto == "=" {
            if let valor = Double(resultado) {
                num2 = valor
            } else {
                resultado = "Error"
                return
            }
            
            var resultadoFinal: Double = 0
            
            switch operacion {
            case "+":
                resultadoFinal = num1 + num2
            case "-":
                resultadoFinal = num1 - num2
            case "x":
                resultadoFinal = num1 * num2
            case "/":
                if num2 == 0 {
                    resultado = "Error"
                    return
                } else {
                    resultadoFinal = num1 / num2
                }
            default:
                break
            }
            
            historial = "\(formatear(num1)) \(operacion) \(formatear(num2)) ="
            
            resultado = formatear(resultadoFinal)
            
            estaEscribiendo = false
            operacion = ""
        }
    }
    
    func formatear(_ numero: Double) -> String {
        return numero == floor(numero) ? "\(Int(numero))" : "\(numero)"
    }

    func colorBoton(_ boton: String) -> Color {
        if boton == "C" {
            return .red.opacity(0.6)
        }
        if boton == "=" {
            return .green.opacity(0.6)
        }
        if boton == "+" || boton == "-" || boton == "x" || boton == "/" {
            return .orange.opacity(0.6)
        }
        return Color.gray.opacity(0.2)
    }
}

#Preview {
    ContentView()
}
