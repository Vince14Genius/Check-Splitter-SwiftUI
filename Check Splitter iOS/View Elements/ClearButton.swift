//
//  ClearButton.swift
//  Check Splitter
//
//  Created by Vincent C. on 10/7/21.
//

import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String
   
    public func body(content: Content) -> some View {
        HStack {
            content
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.secondary)
            }
            .font(.body)
            .buttonStyle(DefaultButtonStyle())
        }
    }
}

extension TextField {
    func clearButton(text: Binding<String>) -> some View {
        modifier(ClearButton(text: text))
    }
}
