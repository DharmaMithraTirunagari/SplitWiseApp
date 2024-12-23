//
//  ContentView.swift
//  SwiftUiPractice2
//
//  Created by Srikanth Kyatham on 12/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numbeOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 30]
    var totalPerPerson: Double {
        let people = Double(numbeOfPeople + 2)
        let tipAmount = checkAmount * Double(tipPercentage) / 100
        let totalAmount = checkAmount + tipAmount
        return totalAmount / people
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Enter Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountFocused)
                    
                    Picker("Number of People", selection: $numbeOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                Section{
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("How much tip you want to leave")
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("SplitWise")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
