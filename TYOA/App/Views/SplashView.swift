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
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
            Text("Echo.")
                .font(.title.bold())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
    }
}

#Preview {
    SplashView()
}
