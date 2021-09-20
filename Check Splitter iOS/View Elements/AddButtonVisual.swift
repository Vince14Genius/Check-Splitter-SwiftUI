//
//  AddButtonVisual.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/20/21.
//

import SwiftUI

struct AddButtonVisual: View {
    var body: some View {
        Image(systemName: "plus")
            .frame(width: 22, height: 22)
            .background(Color.green)
            .foregroundColor(Color(.systemBackground))
            .cornerRadius(11)
            .padding(.leading, 1)
    }
}

struct AddButtonVisual_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonVisual()
    }
}
