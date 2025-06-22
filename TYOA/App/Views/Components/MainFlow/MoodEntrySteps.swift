//
//  MoodEntrySteps.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import SwiftUI

struct MoodEntrySteps: View {
    @EnvironmentObject var moodEntryVM: MoodEntryViewModel
    @State private var isDraggingSlider = false
    
    var body: some View {
        TabView(selection: $moodEntryVM.currentStep) {
            // Step 1: Mood
            EmotionInputView(levelType: .mood)
                .tag(MoodEntryViewModel.EntryStep.mood.rawValue)
            
            // Step 2: Energy
            EmotionInputView(levelType: .energy)
                .tag(MoodEntryViewModel.EntryStep.energy.rawValue)
            
            // Step 3: Focus
            EmotionInputView(levelType: .focus)
                .tag(MoodEntryViewModel.EntryStep.focus.rawValue)
            
            // Step 4: Anxiety
            EmotionInputView(levelType: .anxiety)
                .tag(MoodEntryViewModel.EntryStep.anxiety.rawValue)
            
            // Step 5: Tags
            TagSelectionView()
                .tag(MoodEntryViewModel.EntryStep.tags.rawValue)
            
            // Step6: Advice Entry or Delivered
            Group {
                if moodEntryVM.overallMood == .positive {
                    TextEntryView()
                        .tag(MoodEntryViewModel.EntryStep.adviceText.rawValue)
                } else {
                    ReceiveAdviceView()
                        .tag(MoodEntryViewModel.EntryStep.recieveAdvice.rawValue)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: moodEntryVM.currentStep)
        .gesture(DragGesture()
            .onChanged { _ in }
            .onEnded { _ in }
        , including: isDraggingSlider ? .subviews : .none)
    }
}
