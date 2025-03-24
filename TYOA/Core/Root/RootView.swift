//
//  RootView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-20.
//

import SwiftUI

struct RootView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        if isLoggedIn {
            HomeView() // Main screen for logged-in users
        } else {
            OnboardingView()
        }
    }
}

