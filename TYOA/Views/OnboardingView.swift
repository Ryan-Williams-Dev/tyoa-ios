//
//  OnboardingView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-20.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to TYOA")
                .font(.largeTitle.bold())

            Text("Track your mood and improve your well-being.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Button("Get Started") {
                isLoggedIn = true  // Marks user as logged in
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}
