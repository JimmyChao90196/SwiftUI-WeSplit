//
//  ContentView.swift
//  WeSplit
//
//  Created by JimmyChao on 2024/3/6.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var focus: Bool
    
    private var amountPerPerson: Double {
        var result = checkAmount + checkAmount * (Double(tipPercentage) / 100)
        result = result / Double(numOfPeople + 2)
        return result
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(code: currencyCode))
                    .focused($focus)
                    
                    Picker("Number of people", selection: $numOfPeople) {
                        ForEach(2..<50) { num in
                            Text("\(num) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("How much do you wanna tip") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(amountPerPerson, format: .currency(code: currencyCode))
                }
            }
            .keyboardType(.decimalPad)
            .navigationTitle("WeSplit")
            .toolbar{
                if focus { 
                    Button("Done") { focus = false }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
