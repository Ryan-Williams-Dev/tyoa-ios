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
            FormHeaderView("Sign in")
            SignInFormView(email: $email, password: $password, isEmailFocused: $isEmailFocused, isPasswordFocused: $isPasswordFocused)
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


// MARK: - Form
struct SignInFormView: View {
    @Binding var email: String
    @Binding var password: String
    @FocusState.Binding var isEmailFocused: Bool
    @FocusState.Binding var isPasswordFocused: Bool
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            FormInput(text: $email, isFieldFocused: $isEmailFocused, placeholder: "Email Address")
            FormInput(text: $password, isFieldFocused: $isPasswordFocused, placeholder: "Password", isSecureTextEntry: true)
            FormPrimaryButton(title: "Next", isLoading: $authViewModel.isLoading, isDisabled: !formIsValid, action: {
                Task { try await authViewModel.signIn(withEmail: email, password: password) }
            })
            FormSeparator(text: "or")
            SocialSignInButton(image: "apple.logo", title: "Sign in with Apple", action: { })
            SocialSignInButton(image: "googleLogo", title: "Sign in with Google", isSFImage: false, action: { })
        }
        .padding()
    }
}


// MARK: - Form Validation
extension SignInFormView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}



// MARK: - Preview
#Preview {
    SignInView()
        .environmentObject(AuthViewModel())
}
