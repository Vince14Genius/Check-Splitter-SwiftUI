//
//  FinalCalculationView.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/18/21.
//

import SwiftUI

struct FinalCalculationView: View {
    @Binding var isSheetPresented: Bool
    
    let totalPayment: Amount
    let payersWithItems: [PayerWithItems]
    
    var body: some View {
        FinalCalculationInnerView(totalPayment: totalPayment,  payersWithItems: payersWithItems)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isSheetPresented = false
                    }
                    ProgressIndicator(currentStep: 3, stepsCount: 3)
                }
            }
    }
}

struct FinalCalculationInnerView: View {
    let totalPayment: Amount
    let payersWithItems: [PayerWithItems]
    
    var result: SplitResult {
        return splitCheck(totalPayment: totalPayment, payers: payersWithItems)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                let resultList = result.result
                
                ForEach(resultList.indices) { i in
                    VStack {
                        HStack {
                            Text(resultList[i].name.withDefaultOption("Unnamed Payer"))
                            Spacer()
                            Text(String(describing: resultList[i].amount))
                                .bold()
                        }
                        .font(.title3)
                        
                        let items = payersWithItems[index(withID: resultList[i].id, in: payersWithItems)].items
                        ForEach(items.indices) { j in
                            let item = items[j]
                            HStack {
                                Text(item.name.withDefaultOption("Unnamed item"))
                                Spacer()
                                Text(item.multiplyByFractionText)
                                    .foregroundColor(Color(.tertiaryLabel))
                            }
                        }
                        .foregroundColor(Color(.secondaryLabel))
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                }
                
                if result.remainder > 0 {
                    Divider()
                    HStack {
                        Text("Sum of payments: ")
                        Spacer()
                        Text(String(describing: sumOfAmounts(payers: result.result)))
                            .bold()
                    }
                    .padding([.leading, .trailing])
                    HStack {
                        Text("Remainder: ")
                        Spacer()
                        Text(String(describing: result.remainder))
                            .bold()
                    }
                    .padding([.leading, .trailing])
                }
                
                Divider()
                HStack {
                    Text("Total: ")
                    Spacer()
                    Text(String(describing: totalPayment))
                        .bold()
                }
                .font(.title3)
                .padding([.leading, .trailing])
            }
        }
        .padding()
        .buttonStyle(MyButtonStyle())
        .navigationTitle("Your results")
    }
}

struct FinalCalculationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FinalCalculationInnerView(
                totalPayment: 114.52,
                payersWithItems: [
                    PayerWithItems(
                        name: "You",
                        items: [
                            Item(name: "Latte Deluxe", cost: 13.02),
                        ]
                    ),
                    PayerWithItems(
                        name: "YJSNPI",
                        items: [
                            Item(name: "CURRY", cost: 0),
                            Item(name: "RAMEN", cost: 50.03),
                        ]
                    ),
                    PayerWithItems(
                        name: "KMR",
                        items: [
                            Item(name: "RAMEN", cost: 47.17),
                        ]
                    ),
                ]
            )
        }
    }
}
