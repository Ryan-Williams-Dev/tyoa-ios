//
//  HomeView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-11.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var sliderValue: CGPoint = CGPoint(x: 0.5, y: 0.5)
    
    var body: some View {
        if let user = authViewModel.currentUser {
            NavigationStack {
                VStack(alignment: .leading) {
                    HStack {
//                        Image("logo").resizable().frame(width: 50, height: 50)
                        Text("Echo.").fontWeight(.bold).font(.title2)
                        
                        Spacer()
                        
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "gearshape")
                                .foregroundColor(.primary)
                                .font(.title2)
                        }
                    }
                    
                    Spacer()
                    Text("""
                         Hello, \(user.firstName).
                         How are you feeling today?
                         """)
                    .font(.title)
                    
                    TwoDSlider(sliderValue: $sliderValue)
                    
                    Spacer()
                    
                    
                }
                .padding(16)
                .withAppBackground()
            }
            .tint(.primary)
        }
    }
}

struct TwoDSlider: View {
    @State private var dragPosition: CGPoint = .zero
    @Binding var sliderValue: CGPoint
    @State private var lastFeedbackTime: Date = Date()
    
    private let feedbackThreshold: TimeInterval = 0.1
    private let selectionFeedback = UISelectionFeedbackGenerator()
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let handleRadius: CGFloat = 30
            
            ZStack {
                GridBackground(size: size, lineCount: 10)
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: size, height: size)
                
                Circle()
                    .fill(Color.primary)
                    .frame(width: handleRadius, height: handleRadius)
                    .position(x: dragPosition.x, y: dragPosition.y)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let clampedX = min(max(value.location.x, handleRadius/2), size - handleRadius/2)
                                let clampedY = min(max(value.location.y, handleRadius/2), size - handleRadius/2)
                                
                                let distance = hypot(dragPosition.x - clampedX, dragPosition.y - clampedY)
                                if distance > 1.0 {
                                    dragPosition = CGPoint(x: clampedX, y: clampedY)
                                    
                                    let normalizedX = (clampedX - handleRadius/2) / (size - handleRadius)
                                    let normalizedY = (clampedY - handleRadius/2) / (size - handleRadius)
                                    sliderValue = CGPoint(x: normalizedX, y: normalizedY)
                                    
                                    let now = Date()
                                    if now.timeIntervalSince(lastFeedbackTime) > feedbackThreshold {
                                        selectionFeedback.selectionChanged()
                                        lastFeedbackTime = now
                                    }
                                }
                            }
                    )
                    .onAppear {
                        selectionFeedback.prepare()
                        dragPosition = CGPoint(
                            x: sliderValue.x * size,
                            y: sliderValue.y * size
                        )
                    }
            }
            .frame(width: size, height: size)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

// Separate efficient grid component
struct GridBackground: View {
    let size: CGFloat
    let lineCount: Int
    
    var body: some View {
        Canvas { context, size in
            let width = size.width
            let height = size.height
            let step = width / CGFloat(lineCount)
            
            // Draw horizontal lines
            for i in 1..<lineCount {
                let y = step * CGFloat(i)
                let path = Path { p in
                    p.move(to: CGPoint(x: 0, y: y))
                    p.addLine(to: CGPoint(x: width, y: y))
                }
                context.stroke(path, with: .color(.gray.opacity(0.3)), lineWidth: 0.5)
            }
            
            // Draw vertical lines
            for i in 1..<lineCount {
                let x = step * CGFloat(i)
                let path = Path { p in
                    p.move(to: CGPoint(x: x, y: 0))
                    p.addLine(to: CGPoint(x: x, y: height))
                }
                context.stroke(path, with: .color(.gray.opacity(0.3)), lineWidth: 0.5)
            }
        }
        .frame(width: size, height: size)
    }
}


#Preview {
    let mockViewModel = AuthViewModel()
    mockViewModel.currentUser = User(
        id: "test-user-id",
        email: "test@example.com",
        fullName: "Test User"
    )
    
    return HomeView()
        .environmentObject(mockViewModel)
}
