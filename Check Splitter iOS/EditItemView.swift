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
    
    @State var divisorOptional: Amount?
    @State var isDivisorValid = false
    
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
            Section(header: Text("Divide By")) {
                AmountNumericField(rawInput: String(describing: itemToEdit.divisor), amount: $divisorOptional, isInputValid: $isDivisorValid)
                    .onAppear {
                        divisorOptional = itemToEdit.divisor
                    }
                    .onChange(of: divisorOptional) { _ in
                        if let newDivisor = divisorOptional {
                            itemToEdit.divisor = newDivisor == 0 ? 1 : newDivisor
                        } else {
                            itemToEdit.divisor = 1
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
