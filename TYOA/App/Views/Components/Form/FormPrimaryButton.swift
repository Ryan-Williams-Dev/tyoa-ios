//
//  FormPrimaryButton.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-25.
//
import SwiftUI

struct FormPrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primaryButtonText)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.primaryButton)
                .cornerRadius(12)
        }
    }
}
