//
//  FormInputView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-24.
//

import SwiftUI

struct FormInput: View {
    @Binding var text: String
    @FocusState.Binding var isFieldFocused: Bool
    
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

struct FormInput_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var text = ""
        @FocusState private var isFieldFocused: Bool

        var body: some View {
            FormInput(text: $text, isFieldFocused: $isFieldFocused, placeholder: "Email Address")
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
