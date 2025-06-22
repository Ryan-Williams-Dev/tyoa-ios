//
//  ReceiveAdviceView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-05-30.
//

import SwiftUI

struct ReceiveAdviceView: View {
    var body: some View {
        ScrollView {
            Text("Would you like to receive wisdom from a version of yourself that felt better about these things than you do now?")
                .font(.headline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ReceiveAdviceView()
}
