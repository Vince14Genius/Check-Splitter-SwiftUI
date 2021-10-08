//
//  EditPayerView.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/18/21.
//

import SwiftUI

struct EditPayerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var payerToEdit: PayerWithItems
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Payer Name", text: $payerToEdit.name)
                    .clearButton(text: $payerToEdit.name)
            }
            Section(header: Text("Items to Pay")) {
                List {
                    AddButton(text: "Add item", sheetTitle: "New Item", sheetView: EditNewItemView(items: $payerToEdit.items))
                    
                    ForEach(payerToEdit.items) { item in
                        NavigationLink(destination: EditItemView(itemToEdit: $payerToEdit.items[index(withID: item.id, in: payerToEdit.items)])) {
                            HStack {
                                Text(item.name.withDefaultOption("Unnamed item"))
                                Text(item.multiplyByFractionText)
                                    .foregroundColor(Color(.secondaryLabel))
                                Spacer()
                                Text(String(describing: item.costAfterMultiplyingByFraction))
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            }
        }
        .navigationTitle("Edit Payer")
        .toolbar {
            EditButton()
        }
    }
    
    func delete(at offsets: IndexSet) {
        payerToEdit.items.remove(atOffsets: offsets)
    }
    
    func move(from a: IndexSet, to b: Int) {
        payerToEdit.items.move(fromOffsets: a, toOffset: b)
    }
}

struct EditPayerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let testPayer = PayerWithItems(name: "fuckshit", items: [])
            
            EditPayerView(payerToEdit: .constant(testPayer))
        }
    }
}
