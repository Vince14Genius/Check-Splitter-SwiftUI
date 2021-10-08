//
//  ProgressIndicator.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/19/21.
//

import SwiftUI

struct StepUnit: View {
    let number: Int
    let isCurrentStep: Bool
    
    var body: some View {
        Text("\(number)")
            .frame(width: 36, height: 36)
            .background(isCurrentStep ? Color.accentColor : Color(.secondarySystemBackground))
            .foregroundColor(Color(isCurrentStep ? .systemBackground : .secondaryLabel))
            .cornerRadius(18)
    }
}

struct ProgressIndicator: View {
    let stepsCount: Int
    let currentStep: Int
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(1..<stepsCount) { i in
                StepUnit(number: i, isCurrentStep: currentStep == i)
                Image(systemName: "chevron.forward")
            }
            StepUnit(number: stepsCount, isCurrentStep: currentStep == stepsCount)
            Spacer()
        }
            .font(.system(size: 18))
            .padding(.bottom)
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator(stepsCount: 3, currentStep: 1)
    }
}
