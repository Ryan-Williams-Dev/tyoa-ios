//
//  MoodInputView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-06.
//

import SwiftUI

struct MoodInputView: View {
    @Binding var moodLevel: Double
    
    var body: some View {
        VStack() {
            CustomSliderCard(
                value: $moodLevel,
                prompt: "How is your mood today?",
                sliderName: "MoodLevel",
                imageName: "logo",
                isSystemImage: false,
                minLabel: "Awful",
                maxLabel: "Great",
                minIcon: "hand.thumbsdown",
                maxIcon: "hand.thumbsup"
            )
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
    }
}
//
//#Preview {
//    MoodInputView()
//}
