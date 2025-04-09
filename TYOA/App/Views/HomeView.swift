//
//  HomeView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-11.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var moodEntryVM = MoodEntryViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        if let user = authViewModel.currentUser {
            NavigationStack(path: $navigationPath) {
                VStack {
                    // Header
                    UserGreeting(firstName: user.firstName)
                    
                    // Content steps
                    MoodEntrySteps(viewModel: moodEntryVM)
                                        
                    // Navigation
                    MoodEntryNavigation(viewModel: moodEntryVM)
                    
                    // Progress indicator
                    StepProgressIndicator(currentStep: moodEntryVM.currentStep,
                                         totalSteps: moodEntryVM.totalSteps)
                        .padding()
                }
                .padding(.horizontal, 24)
                .withAppBackground()
                .customNavigationBar(navigationPath: $navigationPath)
                .onAppear {
                    setupViewModel(userId: user.id)
                }
                .navigationDestination(for: String.self) { route in
                    handleNavigation(route)
                }
            }
            .tint(.primary)
        }
    }
    
    // Helper methods
    private func setupViewModel(userId: String) {
        moodEntryVM.userId = userId
        moodEntryVM.onEntrySaved = { entry in
            print("Entry saved: \(entry)")
            // To be implemented
        }
    }
    
    private func handleNavigation(_ route: String) -> some View {
        switch route {
        case "settings":
            return AnyView(SettingsView(navigationPath: $navigationPath)
                .environmentObject(authViewModel))
        default:
            return AnyView(Text("Unknown route"))
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
