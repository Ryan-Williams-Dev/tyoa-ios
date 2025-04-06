//
//  MoodEnergySlider.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-04.
//

import SwiftUI
import UIKit

struct MoodEnergySlider: View {
    @Binding var sliderValue: CGPoint
    @State private var dragPosition: CGPoint = .zero
    @State private var lastFeedbackTime: Date = Date()
    
    private let selectionFeedback = UIImpactFeedbackGenerator(style: .medium)
    private let lineCount = 10
    
    var body: some View {
        SliderContent(
            sliderValue: $sliderValue,
            dragPosition: $dragPosition,
            lineCount: lineCount,
            selectionFeedback: selectionFeedback,
            lastFeedbackTime: $lastFeedbackTime
        )
        .onAppear {
            selectionFeedback.prepare()
        }
    }
}

// Split into a separate view for better performance
struct SliderContent: View {
    @Binding var sliderValue: CGPoint
    @Binding var dragPosition: CGPoint
    let lineCount: Int
    let selectionFeedback: UIImpactFeedbackGenerator
    @Binding var lastFeedbackTime: Date
    
    @State private var size: CGFloat = 0
    let handleRadius: CGFloat = 30
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                GridLines(lineCount: lineCount)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 0.5)
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 2)
                
                QuadrantLabels()
                
                Text("DRIVE")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .rotationEffect(.degrees(-90))
                    .position(x: 25, y: size / 2)
                
                Text("MOOD")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .position(x: size / 2, y: size - 25)

                Circle()
                    .fill(Color.primary)
                    .frame(width: handleRadius, height: handleRadius)
                    .position(
                        x: dragPosition.x,
                        y: dragPosition.y
                    )
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                handleDrag(value: value, size: size)
                            }
                    )
            }
            .onAppear {
                self.size = size
                updateHandlePosition()
            }
            .onChange(of: sliderValue) { _, _ in
                updateHandlePosition()
            }
            .onChange(of: size) { _, _ in
                updateHandlePosition()
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private func updateHandlePosition() {
        guard size > handleRadius else { return }
        dragPosition = CGPoint(
            x: (sliderValue.x * (size - handleRadius)) + handleRadius/2,
            y: (sliderValue.y * (size - handleRadius)) + handleRadius/2
        )
    }
    
    private func handleDrag(value: DragGesture.Value, size: CGFloat) {
        let clampedX = min(max(value.location.x, handleRadius/2), size - handleRadius/2)
        let clampedY = min(max(value.location.y, handleRadius/2), size - handleRadius/2)
        
        dragPosition = CGPoint(x: clampedX, y: clampedY)
        
        let normalizedX = (clampedX - handleRadius/2) / (size - handleRadius)
        let normalizedY = (clampedY - handleRadius/2) / (size - handleRadius)
        sliderValue = CGPoint(x: normalizedX, y: normalizedY)
        
        let now = Date()
        if now.timeIntervalSince(lastFeedbackTime) > 0.1 {
            selectionFeedback.impactOccurred()
            lastFeedbackTime = now
        }
    }
}

struct QuadrantLabels: View {
    var body: some View {
        VStack {
            HStack {
                Text("Low Mood\nHigh Drive")
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(12)
                Spacer()
                Text("Good Mood\nHigh Drive")
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(12)
            }
            Spacer()
            HStack {
                Text("Low Mood\nLow Drive")
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(12)
                Spacer()
                Text("Good Mood\nLow Drive")
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(12)
            }
        }
    }
}

struct GridLines: Shape {
    let lineCount: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let step = rect.width / CGFloat(lineCount)

        for i in 1..<lineCount {
            let y = step * CGFloat(i)
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: rect.width, y: y))
        }
        
        for i in 1..<lineCount {
            let x = step * CGFloat(i)
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: rect.height))
        }
        
        return path
    }
}

struct MoodEnergySlider_Previews: PreviewProvider {
    static var previews: some View {
        MoodEnergySlider(
            sliderValue: .constant(CGPoint(x: 0.5, y: 0.5))
        )
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
