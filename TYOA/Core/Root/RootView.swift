//
//  RootView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-20.
//

import SwiftUI

struct RootView: View {
    @State var splashScreenShown: Bool = true
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if splashScreenShown {
            SplashView().onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation{
                        splashScreenShown = false
                    }
                }
            }
        } else {
            if authViewModel.isLoading {
                LoadingView()
            } else {
                if authViewModel.userSession != nil {
                    HomeView()
                } else {
                    OnboardingView()
                }
            }
            
        }
        
    }
}

