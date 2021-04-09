//
//  TotalPaymentView.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 7/4/20.
//

import SwiftUI

struct TotalPaymentView: View {
    @State private var totalPaymentInput = ""
    @State private var isInputValid = false
    @State private var totalPayment: Double?
    
    private func updateTotalPayment() {
        guard let value = Double(totalPaymentInput) else {
            isInputValid = false
            totalPayment = nil
            return
        }
        isInputValid = true
        totalPayment = value
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Start by entering your total payment:")
                        .font(Font.system(.body))
                    TextField("0.00", text: $totalPaymentInput)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(.title))
                        .onChange(of: totalPaymentInput) { _ in
                            updateTotalPayment()
                        }
                    Divider()
                    Text(totalPayment == nil ? "" : String(totalPayment!))
                }
                Spacer()
                VStack(alignment: .center) {
                    Button {} label: {
                        Text("Continue")
                            .padding()
                    }
                    .disabled(!isInputValid)
                }
            }
            .padding()
            .buttonStyle(MyButtonStyle())
            .navigationTitle("Split your check!")
        }
    }
}

struct TotalPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        TotalPaymentView()
    }
}

