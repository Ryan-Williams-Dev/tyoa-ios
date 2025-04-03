//
//  FormPrimaryButton.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-25.
//
import SwiftUI

struct FormPrimaryButton: View {
    let title: String
    @Binding var isLoading: Bool
    let isDisabled: Bool // Remove the optional and keep the default in the initializer
    let action: () -> Void
    
    // Use an initializer with default parameter value
    init(title: String, isLoading: Binding<Bool>, isDisabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self._isLoading = isLoading
        self.isDisabled = isDisabled
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primaryButtonText)
                    .opacity(isLoading ? 0 : 1)
                
                if isLoading {
                    ProgressView()
                        .tint(.primaryButtonText)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(isDisabled ? Color.primaryButton.opacity(0.9) : Color.primaryButton)
            .cornerRadius(12)
        }
        .disabled(isLoading || isDisabled)
    }
}

#Preview {
    FormPrimaryButton(title: "Submit", isLoading: .constant(false), isDisabled: true, action: {
        print(">>> Action triggered <<<")
    })
}
