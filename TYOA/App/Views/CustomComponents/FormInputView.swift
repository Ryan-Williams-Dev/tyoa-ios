//
//  FormInputView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-24.
//

import SwiftUI

struct FormInputView: View {
    @Binding var text: String
    @FocusState private var isFieldFocused: Bool
    
    let placeholder: String
    var isSecureTextEntry: Bool = false
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .padding()
                .background(isFieldFocused ? Color.cardBackground : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isFieldFocused ? Color.secondary : Color.primary, lineWidth: 1)
                )
                .focused($isFieldFocused)
        }
    }
}

struct FormInputView_Previews: PreviewProvider {
    static var previews: some View {
        FormInputView(text: .constant(""), placeholder: "Email Address")
    }
}
