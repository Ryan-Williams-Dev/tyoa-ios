//
//  AnxietyInputView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct AnxietyInputView: View {
    @Binding var anxietyLevel: Double
    
    var body: some View {
        VStack() {
            CustomSliderCard(
                value: $anxietyLevel,
                prompt: "How anxious are you feeling today?",
                sliderName: "Anxiety Level",
                imageName: "figure.mind.and.body",
                isSystemImage: true,
                minLabel: "Anxious",
                maxLabel: "Cool as a cucumber",
                minIcon: "waveform.path.ecg.rectangle",
                maxIcon: "heart.circle"
            )
        
        }
    }
}

struct AnxietyInputView_Previews: PreviewProvider {
    @State static var anxiety: Double = 0.5
    
    static var previews: some View {
        AnxietyInputView(anxietyLevel: $anxiety)
            .padding()
            .withAppBackground()
    }
}
