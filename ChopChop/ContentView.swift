//
//  ContentView.swift
//  ChopChop
//
//  Created by Paras Tikoo on 02/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount=0.0
    @State private var numberOfPeople=2
    @State private var tipPercentage=0
    
    @FocusState private var amountIsFocused:Bool
    
    var perPersonShare: Double {
        let peopleCount=Double(numberOfPeople+2)
        let tipSelection=Double(tipPercentage)
        let tipValue=(checkAmount*tipSelection)/100
        let totalAmount=checkAmount+tipValue
        let totalPerPerson=(totalAmount/peopleCount)
        
        return totalPerPerson
    }
    
    var totalShare: Double {
        let tipSelection=Double(tipPercentage)
        let tipValue=(checkAmount*tipSelection)/100
        let totalAmount=checkAmount+tipValue
        
        return totalAmount
    }
        
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<101) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section{
                    Picker("Select Tip Percentage",selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0,format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Total Amount"){
                    Text(totalShare,format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total Amount Per Person:"){
                    Text(perPersonShare,format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("ChopChop")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
