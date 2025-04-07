//
//  AppBackgroundModifier.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-02.
//

import SwiftUI

struct AppBackgroundModifier: ViewModifier {
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            content
        }
    }
}

extension View {
    func withAppBackground() -> some View {
        self.modifier(AppBackgroundModifier(backgroundColor: Color.background))
    }
}
