//
//  MoodEntrySteps.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct MoodEntrySteps: View {
    @ObservedObject var viewModel: MoodEntryViewModel
    @State private var isDraggingSlider = false
    
    var body: some View {
        TabView(selection: $viewModel.currentStep) {
            // Step 1: Mood
            MoodInputView(moodLevel: $viewModel.moodLevel)
                .tag(0)
            
            // Step 2: Energy
            EnergyInputView(driveLevel: $viewModel.energyLevel)
                .tag(1)
            
            // Step 3: Focus
            FocusInputView(focusLevel: $viewModel.focusLevel)
                .tag(2)
            
            // Step 4: Anxiety
            AnxietyInputView(anxietyLevel: $viewModel.anxietyLevel)
                .tag(3)
            
            // Step 5: Tags
            TagSelectionView(selectedTags: $viewModel.selectedTags)
                .tag(4)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: viewModel.currentStep)
        .gesture(DragGesture()
            .onChanged { _ in }
            .onEnded { _ in }
        , including: isDraggingSlider ? .subviews : .none)  // Only capture gestures when a slider is being dragged
    }
}
