//
//  SignUpView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-21.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""

    var body: some View {
        VStack {
            SignUpHeaderView()
            SignUpFormView(email: $email)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .background(Color.background)
    }
}

// MARK: - Header
struct SignUpHeaderView: View {
    var body: some View {
        VStack(spacing: 32) {
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
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            FormInputView(text: $email, placeholder: "Email Address")
            PrimaryButton(title: "Next", action: { isLoggedIn = true })
            Separator()
            SocialSignInButton(image: "apple.logo", title: "Sign in with Apple", action: { isLoggedIn = true })
            SocialSignInButton(image: "googleLogo", title: "Sign in with Google", isSFImage: false, action: { isLoggedIn = true })
        }
        .padding()
    }
}

// MARK: - Components

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primaryButtonText)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.primaryButton)
                .cornerRadius(12)
        }
    }
}

struct Separator: View {
    var body: some View {
        HStack {
            Rectangle().frame(height: 1).foregroundColor(.secondary).padding(.trailing, 8)
            Text("or").foregroundColor(.secondary)
            Rectangle().frame(height: 1).foregroundColor(.secondary).padding(.leading, 8)
        }
        .frame(maxWidth: .infinity)
    }
}

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
    SignUpView()
}
