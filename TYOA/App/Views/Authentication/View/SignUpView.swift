//
//  SignUpView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-27.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isFullNameFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isConfirmPasswordFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                SignUpHeaderView()
                SignUpFormView(email: $email,
                               fullName: $fullName,
                               password: $password,
                               confirmPassword: $confirmPassword,
                               isEmailFocused: $isEmailFocused,
                               isFullNameFocused: $isFullNameFocused,
                               isPasswordFocused: $isPasswordFocused,
                               isConfirmPasswordFocused: $isConfirmPasswordFocused
                )
                Spacer()
                HStack(spacing: 2) {
                    Text("Already have an account?")
                    NavigationLink (destination: SignInView(), label: {
                        Text("Sign in")
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
            
        }.background(Color.background)
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
            Text("Sign up")
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Form
struct SignUpFormView: View {
    @Binding var email: String
    @Binding var fullName: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @FocusState.Binding var isEmailFocused: Bool
    @FocusState.Binding var isFullNameFocused: Bool
    @FocusState.Binding var isPasswordFocused: Bool
    @FocusState.Binding var isConfirmPasswordFocused: Bool
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            FormInput(text: $email, isFieldFocused: $isEmailFocused, placeholder: "Email Address")
            FormInput(text: $fullName, isFieldFocused: $isFullNameFocused, placeholder: "Full Name")
            FormInput(text: $password, isFieldFocused: $isPasswordFocused, placeholder: "Password", isSecureTextEntry: true)
            FormInput(text: $confirmPassword, isFieldFocused: $isConfirmPasswordFocused, placeholder: "Confirm Password", isSecureTextEntry: true)
            FormPrimaryButton(title: "Next", action: {
                Task { try await authViewModel.createUser(withEmail: email, password: password, fullName: fullName) }
            })
            FormSeparator(text: "or")
            SocialSignInButton(image: "apple.logo", title: "Sign up with Apple", action: { isLoggedIn = true })
            SocialSignInButton(image: "googleLogo", title: "Sign up with Google", isSFImage: false, action: { isLoggedIn = true })
        }
        .padding()
    }
}

// MARK: - Components
struct SocialSignUpButton: View {
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
