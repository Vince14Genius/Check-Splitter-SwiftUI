//
//  EditNewPayerView.swift
//  Check Splitter
//
//  Created by Vincent C. on 10/6/21.
//

import SwiftUI

struct EditNewPayerView: View {
    @Binding var payers: [PayerWithItems]
    @State var newPayerId: UUID?
    
    var body: some View {
        if let id = newPayerId {
            EditPayerView(payerToEdit: $payers[index(withID: id, in: payers)])
        } else {
            Text("Creating new payer...")
                .onAppear {
                    guard newPayerId == nil else { return }
                    let newPayer = PayerWithItems(name: "", items: [])
                    newPayerId = newPayer.id
                    self.payers.append(newPayer)
                }
        }
    }
}

struct EditNewPayerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditNewPayerView(payers: .constant([]))
        }
    }
}
