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
        VStack(spacing: 24) {
            Text("How focused are you feeling?")
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            SliderView(
                value: $focusLevel,
                minLabel: "Scattered",
                maxLabel: "Focused",
                minIcon: "brain.head.profile",
                maxIcon: "scope"
            )
            
            Spacer()
        }
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
