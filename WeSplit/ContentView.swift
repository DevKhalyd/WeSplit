//
//  ContentView.swift
//  WeSplit
//
//  Created by Rolando Garcia on 22/03/22.

import SwiftUI

// TODO: Upload this part of the code

struct ContentView: View {
    
    // The input user
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    // Here i dont understand why I dont have to initialized the data.
    @FocusState private var isFocused : Bool
    
    private let tipPercentages = [10,15,20,25,0]
    
    private let code = Locale.current.currencyCode ?? "USD"
    
    private var tipValue : Double {
        checkAmount / 100 * Double(tipPercentage)
    }
    
    private var totalAmount : Double {
        checkAmount + tipValue
    }
    
    // Those kind of values are Computed properties
    
    // Because the states of the above variables are states and two way binding this var is updated
    private var totalPerPerson : Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        //let tipSelection = Double(tipPercentage)
        //let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
            
        return amountPerPerson;
        
    }
    
    // Shorthand Getter Declaration. That why dont need a explicit return.
    var body: some View {
        // Allow to create many views as u want
        NavigationView {
            Form {
                Section{
                    // Because of the two-way binding is that the UI can be updated
                    TextField("Amount",value:$checkAmount, format: .currency(code: code))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Amount",selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            // Call the current index
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage",selection: $tipPercentage){
                        ForEach(0...100, id:
                            \.self) {
                            Text("\($0) %")
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code:code))
                    
                } header : {
                    Text("Amount per person")
                }
                
                Section {
                    Text(totalAmount,format: .currency(code: code))
                } header: {
                    Text("Total amount")
                }
                
            }.navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
