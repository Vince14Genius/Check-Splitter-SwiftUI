//
//  EditNewItemView.swift
//  Check Splitter
//
//  Created by Vincent C. on 10/7/21.
//

import SwiftUI

struct EditNewItemView: View {
    @Binding var items: [Item]
    @State var newItemId: UUID?
    
    let selfID = UUID()
    
    var body: some View {
        if let id = newItemId {
            EditItemView(itemToEdit: $items[index(withID: id, in: items)])
        } else {
            Text("Creating new payer...")
                .onAppear {
                    guard newItemId == nil else { return }
                    let newItem = Item(name: "", cost: 9.99)
                    newItemId = newItem.id
                    self.items.append(newItem)
                }
        }
    }
}

struct EditNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditNewItemView(items: .constant([]))
    }
}
