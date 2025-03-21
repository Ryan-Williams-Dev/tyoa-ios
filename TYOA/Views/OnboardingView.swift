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
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image("smile")
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
                Spacer()
                Button("Get Started") {
                    isLoggedIn = true
                }
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
                .background(Color.primaryButton)
                .foregroundColor(Color.primaryButtonText)
                .cornerRadius(28)
                .padding(.bottom, 56)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    OnboardingView()
}
