//
//  UserGreeting.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct UserGreeting: View {
    let firstName: String
    
    var body: some View {
        Text("""
             Hello, \(firstName).
             Welcome back to Echo.
             """)
        .font(.title)
        .padding(.top)
        .padding(.horizontal, 24)
        .multilineTextAlignment(.center)
    }
}
