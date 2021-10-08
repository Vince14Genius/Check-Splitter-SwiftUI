//
//  AmountNumericField.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/20/21.
//

import SwiftUI

struct AmountNumericField: View {
    @State var rawInput = ""
    
    @Binding var amount: Amount?
    @Binding var isInputValid: Bool
    
    private var innerAmount: Amount? {
        guard let value = Double(rawInput) else { return nil }
        return Amount(value)
    }
    
    private var innerIsInputValid: Bool {
        return !(amount == nil)
    }
    
    private func updateStates() {
        amount = innerAmount
        isInputValid = innerIsInputValid
    }
    
    var body: some View {
        TextField("0.00", text: $rawInput)
            .clearButton(text: $rawInput)
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing)
            .font(.title)
            .onAppear(perform: updateStates)
            .onChange(of: rawInput) { _ in
                updateStates()
            }
            .foregroundColor(isInputValid ? Color(.label) : .red)
    }
}

struct AmountNumericField_Previews: PreviewProvider {
    static var previews: some View {
        AmountNumericField(amount: .constant(nil), isInputValid: .constant(false))
    }
}
