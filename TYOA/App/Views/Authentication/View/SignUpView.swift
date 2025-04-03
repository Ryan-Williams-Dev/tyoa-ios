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
                FormHeaderView("Sign up")
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
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            FormInput(text: $email, isFieldFocused: $isEmailFocused, placeholder: "Email Address")
            FormInput(text: $fullName, isFieldFocused: $isFullNameFocused, placeholder: "Full Name")
            FormInput(text: $password, isFieldFocused: $isPasswordFocused, placeholder: "Password", isSecureTextEntry: true)
            ZStack(alignment: .trailing) {
                FormInput(text: $confirmPassword, isFieldFocused: $isConfirmPasswordFocused, placeholder: "Confirm Password", isSecureTextEntry: true)
                if !confirmPassword.isEmpty && !password.isEmpty {
                    if password != confirmPassword {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.primary)
                            .imageScale(.large)
                            .padding(.trailing, 12)
                    } else {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .imageScale(.large)
                            .padding(.trailing, 12)
                    }
                }
            }
            FormPrimaryButton(title: "Next",isLoading: $authViewModel.isLoading, isDisabled: !formIsValid, action: {
                Task { try await authViewModel.createUser(withEmail: email, password: password, fullName: fullName) }
            })
            FormSeparator(text: "or")
            SocialSignInButton(image: "apple.logo", title: "Sign up with Apple", action: {  })
            SocialSignInButton(image: "googleLogo", title: "Sign up with Google", isSFImage: false, action: {  })
        }
        .padding()
    }
}

// MARK: - Form Validation

extension SignUpFormView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullName.isEmpty
        && confirmPassword == password
    }
}


// MARK: - Preview
#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
