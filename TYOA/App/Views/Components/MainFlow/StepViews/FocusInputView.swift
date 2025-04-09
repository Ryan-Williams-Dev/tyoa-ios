//
//  FocusInputView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct FocusInputView: View {
    @Binding var focusLevel: Double
    
    var body: some View {
        CustomSliderCard(
            value: $focusLevel,
            prompt: "How focused do you feel today?",
            sliderName: "Focus Level",
            imageName: "figure.archery",
            isSystemImage: true,
            minLabel: "Scattered",
            maxLabel: "Locked In",
            minIcon: "brain.head.profile",
            maxIcon: "scope"
        )
    }
}


struct FocusInputView_Previews: PreviewProvider {
    @State static var focus: Double = 0.5
    
    static var previews: some View {
        FocusInputView(focusLevel: $focus)
            .padding()
            .withAppBackground()
    }
}
