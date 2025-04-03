//
//  SwiftUIView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-27.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 16) {
            LogoHeader()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
    }
}

#Preview {
    SplashView()
}
