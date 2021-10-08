//
//  AddPayerView.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/18/21.
//

import SwiftUI

struct AddPayerView: View {
    @Binding var isSheetPresented: Bool
    
    @ObservedObject var dataSource = AddPayerDataSource()
    
    let totalPayment: Amount
    
    private var canContinue: Bool {
        return sumOfSubtotals(payers: dataSource.payersWithItems) != 0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                AddButton(text: "Add payer", sheetTitle: "New Payer", sheetView: EditNewPayerView(payers: $dataSource.payersWithItems))
                
                ForEach(dataSource.payersWithItems) { payerWithItems in
                    let items = payerWithItems.items
                    
                    NavigationLink(
                        destination:
                            EditPayerView(payerToEdit: $dataSource.payersWithItems[index(withID: payerWithItems.id, in: dataSource.payersWithItems)])
                    ) {
                        VStack {
                            HStack {
                                Text(payerWithItems.name.withDefaultOption("Unnamed Payer"))
                                    .font(.title2)
                                Spacer()
                            }
                            Group {
                                if items.isEmpty {
                                    HStack {
                                        Text("No items")
                                        Spacer()
                                    }
                                } else {
                                    VStack {
                                        ForEach(items) { item in
                                            HStack {
                                                Text(item.name.withDefaultOption("Unnamed item"))
                                                Text(item.multiplyByFractionText)
                                                    .foregroundColor(Color(.tertiaryLabel))
                                                Spacer()
                                                Text(String(describing: item.costAfterMultiplyingByFraction))
                                            }
                                        }
                                    }
                                }
                            }
                            .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            Divider()
            
            if !canContinue && !dataSource.payersWithItems.isEmpty {
                Text("Add an item with a price to continue.")
                    .padding()
            }
            
            NavigationLink(
                "Continue",
                destination: FinalCalculationView(
                    isSheetPresented: $isSheetPresented,
                    totalPayment: totalPayment,
                    payersWithItems: dataSource.payersWithItems
                )
            )
                .buttonStyle(MyButtonStyle())
                .disabled(!canContinue)
                .padding()
        }
        .navigationTitle("Add Payers")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                EditButton()
                ProgressIndicator(currentStep: 2, stepsCount: 3)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        dataSource.payersWithItems.remove(atOffsets: offsets)
    }
    
    func move(from a: IndexSet, to b: Int) {
        dataSource.payersWithItems.move(fromOffsets: a, toOffset: b)
    }
}

struct AddPayerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddPayerView(isSheetPresented: .constant(true), totalPayment: 8964)
        }
    }
}
