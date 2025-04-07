//
//  EnergyInputView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-06.
//

import SwiftUI

struct EnergyInputView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var driveLevel = 0.5
    @Binding var navigationPath: NavigationPath
    @Binding var currentStep: Int
    
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack {
                Text("""
                     Next Step, \(user.firstName).
                     How driven are you today?
                     """)
                .font(.title)
                .padding(.top)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                Text("How would you rate your overall motivation today?")
                    .font(.headline)
                    .foregroundStyle(.secondaryText)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Slider(value: $driveLevel)
                
                Spacer()
                
                NextInFlowButton(
                    "Next",
                    navigationPath: $navigationPath,
                    destination: "step-1"
                )
                StepProgressIndicator(currentStep: currentStep, totalSteps: 5).padding()
            }
            .padding(.horizontal, 32)
            .withAppBackground()
            .tint(.primary)
            .customNavigationBar(navigationPath: $navigationPath)
            .onAppear {
                currentStep = 1
            }
        }
    }
}

#Preview {
    let mockViewModel = AuthViewModel()
    mockViewModel.currentUser = User(
        id: "test-user-id",
        email: "test@example.com",
        fullName: "Test User"
    )
    
    return NavigationStack {
        EnergyInputView(navigationPath: .constant(NavigationPath()), currentStep: .constant(1))
            .environmentObject(mockViewModel)
    }
}
