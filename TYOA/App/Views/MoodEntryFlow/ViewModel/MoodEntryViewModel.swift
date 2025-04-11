//
//  MoodEntryViewModel.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import Foundation
import SwiftUI

class MoodEntryViewModel: ObservableObject {
    private var previousStepValue = 0
    
    @Published var currentStep = 0 {
        didSet {
            isMovingForward = currentStep > previousStepValue
            previousStepValue = currentStep
        }
    }
    
    @Published private(set) var isMovingForward = true
    let totalSteps = 5
    
    @Published var moodLevel: Double = 0.5
    @Published var energyLevel: Double = 0.5
    @Published var focusLevel: Double = 0.5
    @Published var anxietyLevel: Double = 0.5
    @Published var selectedTags: Set<String> = []
    @Published var adviceText: String = ""
    @Published var userId: String = ""
    @Published var recentEntries: [MoodEntry] = []
    
    var onEntrySaved: ((MoodEntry) -> Void)?
    
    var canMoveToPreviousStep: Bool {
        return currentStep > 0
    }
    
    var isLastStep: Bool {
        return currentStep == totalSteps - 1
    }
    
    func goToNextStep() {
        if currentStep < totalSteps - 1 {
            currentStep += 1
        } else if isLastStep {
            submitEntryData()
        }
    }
    
    func goToPreviousStep() {
        if currentStep > 0 {
            currentStep -= 1
        }
    }
        
    func submitEntryData() {
        let newEntry = MoodEntry(
            moodLevel: moodLevel,
            energyLevel: energyLevel,
            focusLevel: focusLevel,
            anxietyLevel: anxietyLevel,
            selectedTags: selectedTags,
            adviceText: adviceText.isEmpty ? nil : adviceText,
            userId: userId
        )
        
        recentEntries.insert(newEntry, at: 0)
        saveEntryToDatabase(newEntry)
        onEntrySaved?(newEntry)
        resetFlow()
    }
    
    private func saveEntryToDatabase(_ entry: MoodEntry) {
        print("Saving mood entry to database: \(entry.id)")
    }
    
    func resetFlow() {
        previousStepValue = 0
        currentStep = 0
        moodLevel = 0.5
        energyLevel = 0.5
        focusLevel = 0.5
        anxietyLevel = 0.5
        selectedTags = []
        adviceText = ""
    }
}
