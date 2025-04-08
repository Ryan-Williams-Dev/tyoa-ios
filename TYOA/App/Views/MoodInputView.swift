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
        VStack {
            Text("How would you rate your overall mood level today?")
                .font(.headline)
                .foregroundStyle(.secondaryText)
                .multilineTextAlignment(.center)
            

            Slider(value: $moodLevel)
            

        }
    }
}
//
//#Preview {
//    MoodInputView()
//}
