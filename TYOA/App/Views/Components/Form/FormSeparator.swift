//
//  FormSeparator.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-25.
//
import SwiftUI

struct FormSeparator: View {
    var text: String
    
    var body: some View {
        HStack {
            Rectangle().frame(height: 1).foregroundColor(.secondary).padding(.trailing, 8)
            Text(text).foregroundColor(.secondary)
            Rectangle().frame(height: 1).foregroundColor(.secondary).padding(.leading, 8)
        }
        .frame(maxWidth: .infinity)
    }
}
