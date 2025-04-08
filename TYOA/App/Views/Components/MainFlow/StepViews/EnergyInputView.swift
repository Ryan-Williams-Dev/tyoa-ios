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
        VStack(spacing: 24) {
            Text("How's your energy level?")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top)
            
            CustomSlider(
                value: $driveLevel,
                minLabel: "Low",
                maxLabel: "High",
                minIcon: "battery.0",
                maxIcon: "battery.100"
            )
            
            Spacer()
        }
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
