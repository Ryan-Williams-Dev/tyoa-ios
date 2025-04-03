//
//  HomeView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-11.
//

import SwiftUI


struct HomeView: View {
    @State var moodLevel: Double = 0.5
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            VStack(spacing: 8){
                Text("How would you rate your mood today?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text("Slide the bar to a level that feels right for you")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.secondaryText)
            }
            .padding()
            
            
            VStack  {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                Text(moodText)
                    .font(.title)
                    .padding()
                Slider(value: $moodLevel, in: 0...1) {
                }
                .padding()
                .tint(Color.primaryText)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            
            
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
            
            Button(action: {
                
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(Color.background)
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
    HomeView()
}
