//
//  ContentView.swift
//  WeSplit
//
//  Created by Daniel Pérez Solís on 01/07/20.
//  Copyright © 2020 Daniel Pérez Solís. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 0

    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
            
        let grandTotal = orderAmount * (1 + (tipSelection / 100))

        return grandTotal
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let grandTotal = orderAmount * (1 + (tipSelection / 100))
        let amountPerPerson = peopleCount > 0 ? grandTotal / peopleCount : 0
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Monto", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Número de personas", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("¿Que porcentaje de propina deseas agregar?")) {
                    Picker("Propina", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total a pagar")) {
                    
                    Text("$\(Double(totalAmount), specifier: "%.2f")")
                }
                
                Section(header: Text("Total por persona")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
