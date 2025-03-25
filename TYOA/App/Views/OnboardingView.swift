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
        NavigationStack {
            ZStack {

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
                    Spacer()
                    Spacer()
                }
                .padding(32)
                
                VStack {
                    NavigationLink(destination: SignUpView()) {
                        Text("Get Started")
                    }
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color.primaryButton)
                    .foregroundColor(Color.primaryButtonText)
                    .cornerRadius(12)
                    .padding(.bottom, 56)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }.background(Color.background)
                .tint(Color.primary)
        }
        .tint(Color.primary)
        
    }
}

#Preview {
    OnboardingView()
}
