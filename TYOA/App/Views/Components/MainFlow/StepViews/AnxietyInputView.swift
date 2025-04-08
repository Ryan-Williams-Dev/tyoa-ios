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
        VStack(spacing: 24) {
            Text("How anxious are you feeling?")
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            SliderView(
                value: $anxietyLevel,
                minLabel: "Anxious",
                maxLabel: "Calm",
                minIcon: "waveform.path.ecg.rectangle",
                maxIcon: "heart.circle"
            )
            
            Spacer()
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
