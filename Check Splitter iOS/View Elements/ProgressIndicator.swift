//
//  ProgressIndicator.swift
//  Check Splitter iOS
//
//  Created by Vincent C. on 9/19/21.
//

import SwiftUI

struct ProgressIndicator: View {
    let currentStep: Int
    let stepsCount: Int
    
    var body: some View {
        GeometryReader { geometry in
            let strokeWidth = geometry.size.width * 0.2
            ZStack {
                Circle()
                    .stroke(
                        Color(.secondarySystemFill),
                        style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
                    )
                Circle()
                    .trim(from: 0, to: Double(currentStep) / Double(stepsCount))
                    .stroke(
                        Color.accentColor,
                        style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
                    )
                    .rotationEffect(Angle(degrees: -90))
            }
        }
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 16) {
            ProgressIndicator(currentStep: 0, stepsCount: 3)
            ProgressIndicator(currentStep: 1, stepsCount: 3)
            ProgressIndicator(currentStep: 2, stepsCount: 3)
            ProgressIndicator(currentStep: 3, stepsCount: 3)
        }
        .padding()
    }
}
