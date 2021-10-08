//
//  TotalPaymentView.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 7/4/20.
//

import SwiftUI

struct TotalPaymentView: View {
    @Binding var isSheetPresented: Bool

    @State var totalPayment: Amount?
    @State var isInputValid = false
    
    var body: some View {
        VStack {
            ProgressIndicator(stepsCount: 3, currentStep: 1)
            Divider()
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Start by entering your total payment:")
                        .font(Font.system(.body))
                    AmountNumericField(amount: $totalPayment, isInputValid: $isInputValid)
                    Divider()
                    Text(totalPayment == nil ? "" : String(describing: totalPayment!))
                }
                    .padding()
            }
            .onTapGesture {
                hideKeyboard()
            }
            
            Spacer()
            NavigationLink("Continue", destination: AddPayerView(
                            isSheetPresented: $isSheetPresented,
                            totalPayment: totalPayment ?? 8964.0)
            )
                .disabled(!isInputValid)
                .padding()
        }
        .buttonStyle(MyButtonStyle())
        .navigationTitle("Total payment")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button("Cancel") {
                    isSheetPresented = false
                }
            }
        }
    }
}

struct TotalPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TotalPaymentView(isSheetPresented: .constant(true))
        }
    }
}
