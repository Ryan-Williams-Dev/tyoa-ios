//
//  CustomSliderCard.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct CustomSliderCard: View {
    @Binding var value: Double
    let prompt: String
    let sliderName: String
    let imageName: String
    var isSystemImage: Bool
    let minLabel: String
    let maxLabel: String
    let minIcon: String
    let maxIcon: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(prompt)
                .font(.title2)
                .multilineTextAlignment(.center)
            
            Group {
                if isSystemImage {
                    Image(systemName: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .font(.system(size: 100))
                        .fontWeight(.thin)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(.primary)
                } else {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .frame(maxWidth: 200, maxHeight: 200)
            .padding()
            
            Text(sliderName)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
            
            CustomSlider(
                value: $value,
                minLabel: minLabel,
                maxLabel: maxLabel,
                minIcon: minIcon,
                maxIcon: maxIcon
            )
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(16)
    }
}
