//
//  StepProgressIndicator.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-06.
//

import SwiftUI

struct StepProgressIndicator: View {
    let currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Capsule()
                    .fill(index <= currentStep ? Color.primary.opacity(0.8) : Color.secondary.opacity(0.3))
                    .frame(width: currentStep == index ? 20 : 8, height: 8)
                    .animation(.spring(), value: currentStep)
            }
        }
        .padding(.top, 8)
        
        Spacer()
    }
}

#Preview {
    StepProgressIndicator(currentStep: 2, totalSteps: 5)
}
