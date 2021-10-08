//
//  AddButton.swift
//  Check Splitter
//
//  Created by Vincent C. on 10/7/21.
//

import SwiftUI

struct AddButton<V: View>: View {
    @State var isNewItemSheetPresented = false
    
    let text: String
    let sheetTitle: String
    
    let sheetView: V
    
    var body: some View {
        Button {
            isNewItemSheetPresented = true
        } label: {
            HStack {
                AddButtonVisual()
                Text(self.text)
                    .padding(.leading, 10)
                Spacer()
            }
            .padding([.top, .bottom], 4)
        }
        .sheet(isPresented: $isNewItemSheetPresented) {
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Text(sheetTitle)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button("Done") {
                            isNewItemSheetPresented = false
                        }
                    }
                }.padding()
                sheetView
            }
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AddButton(text: "Add ___", sheetTitle: "New ___", sheetView: Text("a"))
        }
    }
}
