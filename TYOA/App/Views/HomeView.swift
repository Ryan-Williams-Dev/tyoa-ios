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
                    Text("""
                         Hello, \(user.firstName).
                         How are you feeling today?
                         """)
                    .font(.title)
                    .padding(.top)
                    .multilineTextAlignment(.center)
                    
                    TabView(selection: $moodEntryVM.currentStep) {
                        // Step 1
                        MoodInputView(moodLevel: $moodEntryVM.moodLevel)
                            .tag(0)
                        
                        // Step 2
                        EnergyInputView(driveLevel: $moodEntryVM.energyLevel)
                            .tag(1)
                        
                        // Step 3
                        Text("Step 3 Content: Focus")
                            .tag(2)
                        
                        // Step 4
                        Text("Step 4 Content: Anxiety")
                            .tag(3)
                        
                        // Step 5
                        Text("Step 5 Content: Tags")
                            .tag(4)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .animation(.easeInOut, value: moodEntryVM.currentStep)
//                    .disabled(true) // Disable swiping - Undecided
                    
                    navigationButtons
                    
                    StepProgressIndicator(currentStep: moodEntryVM.currentStep, totalSteps: moodEntryVM.totalSteps)
                        .padding()
                }
                .padding(.horizontal, 32)
                .withAppBackground()
                .customNavigationBar(navigationPath: $navigationPath)
                .onAppear {
                    moodEntryVM.userId = user.id
                    
                    moodEntryVM.onEntrySaved = { (entry: MoodEntry) in
                        print("Entry saved: \(entry.id)")
                    }
                }
                
                .navigationDestination(for: String.self) { route in
                    switch route {
                    case "settings":
                        SettingsView(navigationPath: $navigationPath)
                            .environmentObject(authViewModel)
                    default:
                        Text("Unknown route")
                    }
                }
            }
            .tint(.primary)
        }
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 16) {
            if moodEntryVM.canMoveToPreviousStep {
                Button(action: { moodEntryVM.goToPreviousStep() }) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding()
                        .foregroundColor(.primary)
                        .cornerRadius(12)
                }.overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundColor(.primary)
                }
            }
            
            Button(action: {
                if moodEntryVM.isLastStep {
                    moodEntryVM.submitEntryData()
                } else {
                    moodEntryVM.goToNextStep()
                }
            }) {
                Text(moodEntryVM.isLastStep ? "Submit" : "Next")
                    .fontWeight(.semibold)
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.primaryButton)
                    .foregroundColor(Color.primaryButtonText)
                    .cornerRadius(12)
            }
        }
        .padding(.vertical)
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
