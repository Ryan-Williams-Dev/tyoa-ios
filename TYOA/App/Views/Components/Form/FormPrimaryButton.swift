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
    let action: () -> Void
    
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
            .background(Color.primaryButton)
            .cornerRadius(12)
        }
        .disabled(isLoading)
    }
}

#Preview {
    FormPrimaryButton(title: "Submit", isLoading: .constant(true), action: {
        print(">>> Action triggered <<<")
    })
}
