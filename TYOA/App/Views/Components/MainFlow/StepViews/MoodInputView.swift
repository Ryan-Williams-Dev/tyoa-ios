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
        VStack(spacing: 24) {
            Text("How are you feeling?")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top)
            
            CustomSlider(
                value: $moodLevel,
                minLabel: "Low",
                maxLabel: "High",
                minIcon: "cloud.rain",
                maxIcon: "sun.max"
            )
            
            Spacer()
        }
    }
}
//
//#Preview {
//    MoodInputView()
//}
