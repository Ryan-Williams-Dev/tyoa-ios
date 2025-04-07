//
//  NextInFlowButton.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct NextInFlowButton: View {
    var text: String = "Next"
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .fontWeight(.semibold)
            }
            .font(.title2)
            .fontWeight(.semibold)
            .padding()
            .background(Color.primaryButton)
            .foregroundColor(Color.primaryButtonText)
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Extension for programmatic navigation within flows
extension NextInFlowButton {
    /// Creates a flow button that navigates to the next step using navigation path
    /// - Parameters:
    ///   - text: Button text (defaults to "Next")
    ///   - navigationPath: Binding to the navigation path
    ///   - destination: Identifier for the next destination
    ///   - isLastStep: Whether this is the last step in a flow (removes arrow)
    init(
        _ text: String = "Next",
        navigationPath: Binding<NavigationPath>,
        destination: String
    ) {
        self.text = text
        self.action = {
            navigationPath.wrappedValue.append(destination)
        }
    }
}

//#Preview {
//    VStack(spacing: 20) {
//        @State var mockPath = NavigationPath()
//        
//        NextInFlowButton(text: "Continue") {
//            print("Button tapped")
//        }
//        
//        NextInFlowButton(text: "Complete", action: true) {
//            print("Last step button tapped")
//        }
//        
//        NextInFlowButton(navigationPath: $mockPath, destination: "next-step")
//        
//        NextInFlowButton("Finish", navigationPath: $mockPath, destination: "finish", isLastStep: true)
//    }
//    .padding()
//}
