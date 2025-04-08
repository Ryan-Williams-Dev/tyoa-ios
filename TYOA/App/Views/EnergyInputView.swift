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
        VStack {
            Text("How driven are you today?")
                .font(.headline)
                .foregroundStyle(.secondaryText)
                .multilineTextAlignment(.center)
            
            
            Slider(value: $driveLevel)
            

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
