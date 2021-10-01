//
//  EditItemView.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/20/21.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var itemToEdit: Item
    
    @State var costOptional: Amount?
    @State var isCostValid = false
    
    @State var multiplier = 1
    @State var divisor = 1
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Item Name", text: $itemToEdit.name)
            }
            Section(header: Text("Price")) {
                AmountNumericField(rawInput: String(describing: itemToEdit.cost), amount: $costOptional, isInputValid: $isCostValid)
                    .onChange(of: costOptional) { _ in
                        itemToEdit.cost = costOptional ?? 0
                    }
            }
            Section(header: Text("Multiply by fraction")) {
                Stepper(value: $itemToEdit.multiplier) {
                    HStack {
                        Text("×")
                            .foregroundColor(Color(.secondaryLabel))
                        Spacer()
                        Text(String(itemToEdit.multiplier))
                            .bold()
                    }
                }
                Stepper(value: $itemToEdit.divisor, in: 1 ... .max) {
                    HStack {
                        Text("÷")
                            .foregroundColor(Color(.secondaryLabel))
                        Spacer()
                        Text("\(itemToEdit.divisor)")
                            .bold()
                    }
                }
            }
        }
        .navigationTitle("Edit Item")
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditItemView(itemToEdit: .constant(Item(name: "grass", cost: 0.19)))
        }
    }
}
