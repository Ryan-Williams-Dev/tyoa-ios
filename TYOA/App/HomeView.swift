//
//  HomeView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-11.
//

import SwiftUI


public struct HomeView: View {
    @State var moodLevel: Double = 0.5
    @Environment(\.colorScheme) var colorScheme
    
    var backgroundColor: Color {
            let opacity = abs(moodLevel - 0.5) * 2

        return colorScheme == .dark
            ? Color(
                red: 0.10 + (0.15 - 0.10) * moodLevel,
                green: 0.12 + (0.18 - 0.12) * moodLevel,
                blue: 0.14 + (0.12 - 0.14) * moodLevel
            ).opacity(opacity)
            : Color(
                red: 0.80 + (0.83 - 0.80) * moodLevel,
                green: 0.82 + (0.85 - 0.82) * moodLevel,
                blue: 0.84 + (0.80 - 0.84) * moodLevel
            ).opacity(opacity)

        }

    
    public var body: some View {
        VStack {
            Text("How would you rate your mood today?")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            VStack  {
                Image("smile")
                    .resizable()
                    .scaledToFit()
                Text("I Feel \(Int(moodLevel * 100))% Happy")
                    .font(.title)
                    .padding()
            }
            
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Slider(value: $moodLevel, in: 0...1) {
            }
                .padding()
                .tint(Color.primaryText)
            
            
                Button(action: {
                    print("Next tapped")
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(Color.primaryButtonText)
                        .padding()
                        .padding(.horizontal, 16)
                        .background(Color.primaryButton)
                        .cornerRadius(25)
                }
                .padding(.horizontal, 40)
            
        }
        .padding()
        .background(backgroundColor)
    }
}


#Preview {
    HomeView()
}
