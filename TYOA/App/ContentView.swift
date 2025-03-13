//
//  ContentView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-10.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) var colorScheme
    @State private var moodLevel: Double = 0.5
    var moodOptions: [String] = ["Very Unhappy", "Unhappy", "Neutral", "Happy", "Very Happy"]
    
    private var emoji: String {
            switch moodLevel {
            case 0..<0.2:
                return "emoji-verySad"
            case 0.20..<0.4:
                return "emoji-littleSad"
            case 0.4..<0.6:
                return "emoji-content"
            case 0.6..<0.8:
                return "emoji-good"
            case 0.8...1:
                return "emoji-fantastic"
            default:
                return "emoji-content"
            }
        }
    
    var body: some View {
            ZStack {
                Color(Color.background)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 24) {
                    headerText()
                    moodCard()
                    nextButton()
                }
                .padding(.horizontal, 24)
            }
        }

        func headerText() -> some View {
            VStack(spacing: 5) {
                Text("How do you feel about your well-being today?")
                    .font(.title.bold()) // Semi-bold title
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.primaryText)

                Text("Slide the bar to a level closest to how you are feeling right now.")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondaryText) // Lighter text
                    .multilineTextAlignment(.center)
            }
        }

        func moodCard() -> some View {
            VStack(spacing: 16) {
                Text(moodText)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Color.primaryText)

                Image(emoji)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundColor(Color.primaryText)
                    
                
                Slider(value: $moodLevel, in: 0...1)
                    .tint(Color.primaryText)
                    
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 24)
            .background(Color.cardBackground)
            .cornerRadius(28)
            .overlay(RoundedRectangle(cornerRadius: 28).stroke(Color.secondaryText, lineWidth: colorScheme == .dark ? 0 : 1))
            
        }

        func nextButton() -> some View {
            Button(action: {
                print("Next tapped")
            }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding()
                    .padding(.horizontal, 16)
                    .background(Color.primaryButton)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 40)
        }
    
        private var moodText: String {
            switch moodLevel {
            case 0..<0.2:
                return "I feel very sad"
            case 0.20..<0.4:
                return "I feel a bit down"
            case 0.4..<0.6:
                return "I feel content"
            case 0.6..<0.8:
                return "I feel good"
            default:
                return "I feel fantastic!"
        }
        
        
    }
    }


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
