//
//  homeView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-11.
//

import SwiftUI


public struct MoodSelevtorView: View {
    @State var moodLevel: Double = 0.5
    
    var backgroundColor: Color {
            let opacity = abs(moodLevel - 0.5) * 2 // 1 at edges, 0 in middle

            return Color(
                red: 0.6 + (0.9 - 0.6) * moodLevel,
                green: 0.7 + (0.9 - 0.7) * moodLevel,
                blue: 0.9 + (0.5 - 0.9) * moodLevel
            ).opacity(opacity) // Fades in/out smoothly
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
                        .foregroundColor(Color.white)
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
    MoodSelevtorView()
}
