//
//  SocialSignInButton.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-02.
//

import SwiftUI

struct SocialSignInButton: View {
    let image: String
    let title: String
    var isSFImage: Bool = true
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if isSFImage {
                    Image(systemName: image)
                        .foregroundColor(.primaryText)
                } else {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primaryText)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(Color.primaryButton.opacity(0.2), lineWidth: 1)
            )
            .cornerRadius(12)
            .tint(Color.primary)
        }
    }
}
