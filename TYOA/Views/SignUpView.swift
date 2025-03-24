//
//  SignUpView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-21.
//

import SwiftUI

struct SignUpView: View {
    @State var email :String = ""
    
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
            .frame(maxWidth : .infinity)
            
            FormView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .edgesIgnoringSafeArea(.all)
    }
    
    var FormView: some View {
        Form {
            Section(header: Text("Sign in with email")) {
                TextField("Email address", text: $email)
                
            }
            
        }
        .background(Color.clear)
        .scrollContentBackground(.hidden)
        .scrollDisabled(true)
    }
}

#Preview {
    SignUpView()
}
