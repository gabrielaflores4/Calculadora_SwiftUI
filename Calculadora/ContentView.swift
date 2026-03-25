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
        "C", "/", "x", "-",
        "7", "8", "9", "+",
        "4", "5", "6", "=",
        "1", "2", "3", "",
        "0", ".", "", ""
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
            
            Text(resultado).font(.largeTitle).frame(maxWidth: .infinity, alignment: .trailing).padding()
                
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
                        .gridCellColumns(boton == "0" ? 2 : 1)
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
