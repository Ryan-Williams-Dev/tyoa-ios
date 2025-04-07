//
//  HomeView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-11.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var currentStep = 0
    @State private var navigationPath = NavigationPath()
    @State private var moodLevel = 0.5
    
    var body: some View {
        if let user = authViewModel.currentUser {
            NavigationStack(path: $navigationPath) {
                VStack {
                    Text("""
                         Hello, \(user.firstName).
                         How are you feeling today?
                         """)
                    .font(.title)
                    .padding(.top)
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("How would you rate your overall mood level today?")
                    .font(.headline)
                    .foregroundStyle(.secondaryText)
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Slider(value: $moodLevel)
                    
                    Spacer()
                    
                    NextInFlowButton(
                        "Next",
                        navigationPath: $navigationPath,
                        destination: "step-2"
                    )
                    StepProgressIndicator(currentStep: currentStep, totalSteps: 5).padding()
                }
                .padding(.horizontal, 32)
                .withAppBackground()
                .customNavigationBar(navigationPath: $navigationPath)
                .onAppear {
                    currentStep = 0
                }
                
                .navigationDestination(for: String.self) { route in
                    switch route {
                    case "profile":
                        ProfileView(navigationPath: $navigationPath)
                            .environmentObject(authViewModel)
                    case "step-2":
                        EnergyInputView(navigationPath: $navigationPath, currentStep: $currentStep)
                    default:
                        Text("Unknown route")
                    }
                }
            }
            .tint(.primary)
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
    
    return HomeView()
        .environmentObject(mockViewModel)
}
