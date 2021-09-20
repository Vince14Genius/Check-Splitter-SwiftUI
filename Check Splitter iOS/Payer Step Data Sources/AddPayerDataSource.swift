//
//  AddPayerDataSource.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/19/21.
//

import SwiftUI

class AddPayerDataSource: ObservableObject {
    @Published var payersWithItems = [PayerWithItems]()
    
    convenience init(payersWithItems: [PayerWithItems]) {
        self.init()
        self.payersWithItems = payersWithItems
    }
}
