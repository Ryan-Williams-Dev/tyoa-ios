//
//  HomeView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-11.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var moodEnergy: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    var body: some View {
        if let user = authViewModel.currentUser {
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Echo.").fontWeight(.bold).font(.title2)
                        
                        Spacer()
                        
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "gearshape")
                                .foregroundColor(.primary)
                                .font(.title2)
                        }
                    }
                    
                    Text("""
                         Hello, \(user.firstName).
                         How are you feeling today?
                         """)
                    .font(.title)
                    .padding(.top)
                    
                    Spacer()
                    
                
                    MoodEnergySlider(sliderValue: $moodEnergy)
                    
                }
                .padding(32)
                .withAppBackground()
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
