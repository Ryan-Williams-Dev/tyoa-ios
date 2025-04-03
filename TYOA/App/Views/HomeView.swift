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
                        Image("logo").resizable().frame(width: 50, height: 50)
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
    
    private let selectionFeedback = UISelectionFeedbackGenerator()
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let handleRadius: CGFloat = 30
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
                    .frame(width: size, height: size)
                
                Circle()
                    .fill(Color.primary)
                    .frame(width: handleRadius, height: handleRadius)
                    .position(x: dragPosition.x, y: dragPosition.y)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Clamp the handle's position to remain within the square
                                let clampedX = min(max(value.location.x, 0), size)
                                let clampedY = min(max(value.location.y, 0), size)
                                dragPosition = CGPoint(x: clampedX, y: clampedY)
                                
                                // Update the binding with normalized values (0...1)
                                sliderValue = CGPoint(x: clampedX / size, y: clampedY / size)
                                
                                // Prepare and trigger haptic feedback
                                selectionFeedback.prepare()
                                selectionFeedback.selectionChanged()
                            }
                    )
                    .onAppear {
                        // Initialize the handle's position based on the current slider value
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
