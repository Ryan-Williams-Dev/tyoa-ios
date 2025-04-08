//
//  PrimaryButton.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-25.
//

import SwiftUI

struct PrimaryNavButton<Destination: View>: View {
    let text: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(text)
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
                .background(Color.primaryButton)
                .foregroundColor(Color.primaryButtonText)
                .cornerRadius(12)
        }
    }
}



//
