//
//  MyButtonStyle.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 7/4/20.
//

import SwiftUI

public struct MyButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        MyButtonStyleView(configuration: configuration, backgroundColor: Color.accentColor)
    }
}

public struct RemoveButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        MyButtonStyleView(configuration: configuration, backgroundColor: Color.red)
    }
}

fileprivate struct MyButtonStyleView: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: MyButtonStyle.Configuration
    
    let backgroundColor: Color
    
    var body: some View {
    return configuration.label
        .font(Font.system(.headline))
        .frame(minWidth: 0, maxWidth: 640)
        .foregroundColor(Color.white)
        .padding()
        .background(isEnabled ? backgroundColor : Color.gray)
        .opacity(configuration.isPressed ? 0.67 : 1)
        .cornerRadius(16)
    }
}

struct DefaultButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center) {
            Button(action: {}) {
                Text("Continue")
            }
            .buttonStyle(MyButtonStyle())
            Button(action: {}) {
                Text("Continue")
            }
            .buttonStyle(MyButtonStyle())
            .disabled(true)
            Button(action: {}) {
                Text("Remove")
            }
            .buttonStyle(RemoveButtonStyle())
        }
        .padding()
    }
}
