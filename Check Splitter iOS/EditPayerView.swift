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
            }
            Section(header: Text("Items to Pay")) {
                List {
                    Button {
                        payerToEdit.items.append(Item(name: "", cost: 9.99))
                    } label: {
                        HStack {
                            AddButtonVisual()
                            Text("Add item")
                                .padding(.leading, 10)
                            Spacer()
                        }
                    }
                    ForEach(payerToEdit.items) { item in
                        NavigationLink(destination: EditItemView(itemToEdit: $payerToEdit.items[index(withID: item.id, in: payerToEdit.items)])) {
                            HStack {
                                Text(item.name.withDefaultOption("Unnamed item"))
                                Text(item.divisor == 1 ? "" : "÷ \(String(describing: item.divisor))")
                                    .foregroundColor(Color(.secondaryLabel))
                                Spacer()
                                Text(String(describing: item.costAfterDivision))
                            }
                        }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            }
//            Section {
//                Button("Remove this payer") {
//                    // - TODO: Remove this payer
//                    presentationMode.wrappedValue.dismiss()
//                }
//                    .accentColor(.red)
//            }
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
