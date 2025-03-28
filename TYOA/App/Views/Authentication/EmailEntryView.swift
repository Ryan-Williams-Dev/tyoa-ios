//
//  EmailEntryView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-21.
//

import SwiftUI

struct EmailEntryView: View {
    @State private var email: String = ""
    @FocusState private var isEmailFocused: Bool
    
    var body: some View {
        
        VStack {
            SignUpHeaderView()
            SignUpFormView(email: $email, isEmailFocused: $isEmailFocused)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .background(Color.background)
        .onTapGesture {
            dismissKeyboard()
        }
        
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

// MARK: - Header
struct SignUpHeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
            Text("Log in or sign up")
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Form
struct SignUpFormView: View {
    @Binding var email: String
    @FocusState.Binding var isEmailFocused: Bool
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            FormInput(text: $email, isFieldFocused: $isEmailFocused, placeholder: "Email Address")
            FormPrimaryButton(title: "Next", action: { isLoggedIn = true })
            FormSeparator(text: "or")
            SocialSignInButton(image: "apple.logo", title: "Continue with Apple", action: { isLoggedIn = true })
            SocialSignInButton(image: "googleLogo", title: "Continue with Google", isSFImage: false, action: { isLoggedIn = true })
        }
        .padding()
    }
}

// MARK: - Components
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

// MARK: - Preview
#Preview {
    EmailEntryView()
}
