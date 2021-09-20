//
//  WelcomeView.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/18/21.
//

import SwiftUI

struct WelcomeView: View {
    @State var isSheetPresented = false
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("1")
                        .font(.system(size: 24))
                        .frame(width: 56, height: 56)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(28)
                    Text("Enter total payment")
                        .font(.title2)
                    Spacer()
                }
                Image(systemName: "chevron.down")
                    .padding()
                HStack {
                    Text("2")
                        .font(.system(size: 24))
                        .frame(width: 56, height: 56)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(28)
                    Text("Add items and original prices for each payer")
                        .font(.title2)
                    Spacer()
                }
                Image(systemName: "chevron.down")
                    .padding()
                HStack {
                    Text("3")
                        .font(.system(size: 24))
                        .frame(width: 56, height: 56)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(28)
                    Text("Calculate how much each person pays")
                        .font(.title2)
                    Spacer()
                }
            }
            Button("Start") {
                isSheetPresented = true
            }
        }
        .padding()
        .buttonStyle(MyButtonStyle())
        .navigationTitle("Split your check!")
        .sheet(isPresented: $isSheetPresented) {
            NavigationView {
                TotalPaymentView(
                    isSheetPresented: $isSheetPresented
                )
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WelcomeView()
        }
    }
}
