//
//  EnergyInputView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-06.
//

import SwiftUI

struct EnergyInputView: View {
    @Binding var driveLevel: Double
    
    var body: some View {
        VStack() {
            CustomSliderCard(
                value: $driveLevel,
                prompt: "How much energy do you have today?",
                sliderName: "Energy Level",
                imageName: "figure.run",
                isSystemImage: true,
                minLabel: "Lethargic",
                maxLabel: "Full of beans",
                minIcon: "tortoise",
                maxIcon: "hare"
            )
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}

//#Preview {
//    let mockViewModel = AuthViewModel()
//    mockViewModel.currentUser = User(
//        id: "test-user-id",
//        email: "test@example.com",
//        fullName: "Test User"
//    )
//    
//    return NavigationStack {
//        EnergyInputView(navigationPath: .constant(NavigationPath()), currentStep: .constant(1))
//            .environmentObject(mockViewModel)
//    }
//}
