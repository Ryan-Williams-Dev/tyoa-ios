//
//  FormHeader.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-02.
//

import SwiftUI

struct FormHeaderView: View {
    let text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image("logo")
                .resizable()
                .frame(width: 200, height: 200)
            Text(text)
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    FormHeaderView("Hello, World!")
}
