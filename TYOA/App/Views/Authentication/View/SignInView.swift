//
//  SignInView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-21.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    
    var body: some View {
        
        VStack {
            SignUpHeaderView()
            SignUpFormView(email: $email, password: $password, isEmailFocused: $isEmailFocused, isPasswordFocused: $isPasswordFocused)
            Spacer()
            HStack(spacing: 2) {
                Text("Don't have an account?")
                NavigationLink (destination: SignUpView(), label: {
                    Text("Sign up")
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                })
            }
            
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
            Text("Sign in")
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Form
struct SignUpFormView: View {
    @Binding var email: String
    @Binding var password: String
    @FocusState.Binding var isEmailFocused: Bool
    @FocusState.Binding var isPasswordFocused: Bool
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            FormInput(text: $email, isFieldFocused: $isEmailFocused, placeholder: "Email Address")
            FormInput(text: $password, isFieldFocused: $isPasswordFocused, placeholder: "Password", isSecureTextEntry: true)
            FormPrimaryButton(title: "Next", action: {
                Task { try await authViewModel.signIn(withEmail: email, password: password) }
            })
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
    SignInView()
}
