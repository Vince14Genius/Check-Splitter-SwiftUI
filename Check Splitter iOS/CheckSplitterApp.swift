//
//  CheckSplitterApp.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/18/21.
//

import SwiftUI

@main
struct CheckSplitterApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WelcomeView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct CheckSplitterApp_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WelcomeView()
        }
    }
}

