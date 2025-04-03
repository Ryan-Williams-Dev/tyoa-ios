//
//  OnboardingView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-20.
//

import SwiftUI

struct OnboardingView: View {    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)

                Spacer().frame(height: 40)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Echo.")
                        .font(.largeTitle.bold())
                    
                    Text("Advice from your best self, delivered when you need it most.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.secondaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()

                PrimaryNavButton(text: "Get Started", destination: SignInView())
                
                Spacer()
                
            }
            .padding(32)
            .background(Color.background)
            .tint(Color.primary)
        }
        .tint(Color.primary)
        
    }
}

#Preview {
    OnboardingView()
}
