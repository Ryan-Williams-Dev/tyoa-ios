//
//  EmotionInputView.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-14.
//

import SwiftUI

struct EmotionInputView: View {
    @EnvironmentObject var viewModel: MoodEntryViewModel
    let levelType: MoodEntryViewModel.LevelType
    
    private var config: EmotionConfig {
        switch levelType {
        case .mood:
            return EmotionConfig(
                prompt: "How is your mood today?",
                sliderName: "Mood Level",
                imageName: "logo",
                isSystemImage: false,
                minLabel: "Awful",
                maxLabel: "Great",
                minIcon: "hand.thumbsdown",
                maxIcon: "hand.thumbsup"
            )
        case .energy:
            return EmotionConfig(
                prompt: "How much energy do you have today?",
                sliderName: "Energy Level",
                imageName: "figure.run",
                isSystemImage: true,
                minLabel: "Lethargic",
                maxLabel: "Full of beans",
                minIcon: "tortoise",
                maxIcon: "hare"
            )
        case .focus:
            return EmotionConfig(
                prompt: "How focused do you feel today?",
                sliderName: "Focus Level",
                imageName: "figure.archery",
                isSystemImage: true,
                minLabel: "Scattered",
                maxLabel: "Locked In",
                minIcon: "brain.head.profile",
                maxIcon: "scope"
            )
        case .anxiety:
            return EmotionConfig(
                prompt: "How anxious are you feeling today?",
                sliderName: "Anxiety Level",
                imageName: "figure.mind.and.body",
                isSystemImage: true,
                minLabel: "Anxious",
                maxLabel: "Cool as a cucumber",
                minIcon: "waveform.path.ecg.rectangle",
                maxIcon: "heart.circle"
            )
        }
    }
    
    private var currentValue: Double {
        switch levelType {
        case .mood: return viewModel.moodLevel
        case .energy: return viewModel.energyLevel
        case .focus: return viewModel.focusLevel
        case .anxiety: return viewModel.anxietyLevel
        }
    }
    
    var body: some View {
        VStack() {
            CustomSliderCard(
                value: currentValue,
                onValueChanged: { newValue in
                    viewModel.updateValue(of: levelType, to: newValue)
                },
                prompt: config.prompt,
                sliderName: config.sliderName,
                imageName: config.imageName,
                isSystemImage: config.isSystemImage,
                minLabel: config.minLabel,
                maxLabel: config.maxLabel,
                minIcon: config.minIcon,
                maxIcon: config.maxIcon
            )
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
    
    private struct EmotionConfig {
        let prompt: String
        let sliderName: String
        let imageName: String
        let isSystemImage: Bool
        let minLabel: String
        let maxLabel: String
        let minIcon: String
        let maxIcon: String
    }
}
