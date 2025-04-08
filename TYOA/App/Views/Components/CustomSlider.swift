//
//  CustomSlider.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI
import UIKit

struct CustomSlider: View {
    @Binding var value: Double
    let minLabel: String
    let maxLabel: String
    let minIcon: String
    let maxIcon: String
    @State private var isDragging = false
    @State private var leftIconEffect = false
    @State private var rightIconEffect = false
    
    // Haptic feedback generator for end stops
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        VStack {
            HStack {
                Text(minLabel)
                    .font(.headline)
                    .opacity(0.8)
                
                Spacer()
                
                Text(maxLabel)
                    .font(.headline)
                    .opacity(0.8)
            }
            
            HStack(spacing: 12) {
                Image(systemName: minIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundColor(.primary.opacity(1 - value))
                    .symbolEffect(.wiggle, options: .repeat(1), isActive: leftIconEffect)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // Track background
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 8)
                            .cornerRadius(4)
                            .frame(maxHeight: .infinity)
                        
                        // Active track
                        Rectangle()
                            .fill(Color.primary)
                            .frame(width: max(0, min(geometry.size.width, geometry.size.width * CGFloat(value))), height: 8)
                            .cornerRadius(4)
                            .frame(maxHeight: .infinity)
                        
                        // Handle
                        Circle()
                            .fill(Color.primary)
                            .frame(width: 24, height: 24)
                            .shadow(radius: isDragging ? 3 : 1)
                            .position(
                                x: max(12, min(geometry.size.width - 12, geometry.size.width * CGFloat(value))),
                                y: geometry.size.height / 2
                            )
                    }
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { drag in
                                isDragging = true
                                let width = geometry.size.width
                                let clampedX = min(max(0, drag.location.x), width)
                                let newValue = Double(clampedX / width)
                                
                                checkForExtremeValues(oldValue: self.value, newValue: newValue)
                                
                                self.value = newValue
                            }
                            .onEnded { _ in
                                withAnimation(.easeOut(duration: 0.1)) {
                                    isDragging = false
                                }
                            }
                    )
                }
                .frame(height: 44)
                .onAppear {
                    // Prepare haptic engine
                    feedbackGenerator.prepare()
                }
                
                Image(systemName: maxIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundColor(.primary.opacity(value))
                    .symbolEffect(.wiggle, options: .repeat(1), isActive: rightIconEffect)
            }
            .padding(.vertical, 10)
        }
        .padding()
        .background(Color.cardBackground)
        .cornerRadius(16)
    }
    
    private func checkForExtremeValues(oldValue: Double, newValue: Double) {
        if newValue <= 0.01 && oldValue > 0.01 {
            triggerIconEffect(isLeft: true)
            triggerHaptic()
        }
        
        if newValue >= 0.99 && oldValue < 0.99 {
            triggerIconEffect(isLeft: false)
            triggerHaptic()
        }
    }
    
    private func triggerIconEffect(isLeft: Bool) {
        if isLeft {
            leftIconEffect = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                leftIconEffect = false
            }
        } else {
            rightIconEffect = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                rightIconEffect = false
            }
        }
    }
    
    // Trigger haptic feedback
    private func triggerHaptic() {
        feedbackGenerator.impactOccurred(intensity: 0.8)
    }
}
