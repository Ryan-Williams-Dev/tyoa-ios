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
            VStack {
                Image("smile")
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("Log in or sign up")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            

            SignUpFormView(email: $email)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .background(Color.background)
    }
}

struct SignUpFormView: View {
    @Binding var email: String
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var nextStep: () -> Void = {}

    var body: some View {
        VStack (spacing: 16) {
            FormInputView(text: $email, placeholder: "Email Address")
            
            Button(action: nextStep) {
                Spacer()
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.primaryButtonText)
                Spacer()
            }
            .padding()
            .background(Color.primaryButton)
            .cornerRadius(12)
            .frame(maxWidth: .infinity)
            
            HStack {
                Spacer()
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.secondary).padding(.trailing, 16))
                Text("or")
                    .foregroundColor(.secondary)
                Spacer()
                    .overlay(Rectangle().frame(height: 1).foregroundColor(.secondary).padding(.leading, 16))
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                isLoggedIn = true;
            }) {
                Spacer()
                Image(systemName: "apple.logo")
                    .foregroundColor(.primaryText)
                Text("Sign in with Apple")
                    .font(.headline)
                    .foregroundColor(.primaryText)
                Spacer()
            }
            .padding()
            .background(Color.cardBackground)
            .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.primaryButton.opacity(0.2), lineWidth: 1)
                )
            .cornerRadius(12)
            .frame(maxWidth: .infinity)
            
        }
    }
                
}





#Preview {
    SignUpView()
}
