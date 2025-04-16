//
//  MoodEntryViewModel.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-07.
//

import Foundation
import SwiftUI

class MoodEntryViewModel: ObservableObject {
    // MARK: - Step Management
    
    enum EntryStep: Int, CaseIterable {
        case mood = 0
        case energy
        case focus
        case anxiety
        case tags
        case adviceText
        
        var title: String {
            switch self {
            case .mood: return "Mood"
            case .energy: return "Energy"
            case .focus: return "Focus"
            case .anxiety: return "Anxiety"
            case .tags: return "Tags"
            case .adviceText: return "Advice"
            }
        }
    }
    
    @Published var currentStep = 0
    
    var totalSteps: Int {
        return EntryStep.allCases.count
    }
    
    // MARK: - Entry Data
    
    @Published private(set) var moodLevel: Double = 0.5
    @Published private(set) var energyLevel: Double = 0.5
    @Published private(set) var focusLevel: Double = 0.5
    @Published private(set) var anxietyLevel: Double = 0.5
    @Published private var selectedTags: Set<String> = []
    @Published private(set) var adviceText: String = ""
    @Published var userId: String = ""
    @Published var recentEntries: [MoodEntry] = []
    
    var onEntrySaved: ((MoodEntry) -> Void)?
    
    // MARK: - Computed Properties
    
    var canMoveToPreviousStep: Bool {
        return currentStep > 0
    }
    
    var isLastStep: Bool {
        return currentStep == totalSteps - 1
    }
    
    var currentStepType: EntryStep? {
        return EntryStep(rawValue: currentStep)
    }
    
    // MARK: - Navigation Methods
    
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
    
    func goToStep(_ step: EntryStep) {
        currentStep = step.rawValue
    }
    
    // MARK: - Slider Methods
    enum LevelType {
        case mood, energy, focus, anxiety
    }
    
    func updateValue(of levelType: LevelType, to value: Double) {
        switch levelType {
        case .mood:
            self.moodLevel = value
        case .energy:
            self.energyLevel = value
        case .focus:
            self.focusLevel = value
        case .anxiety:
            self.anxietyLevel = value
        }
    }
    
    // MARK: - Tag Methods
    
    func getTags() -> [MoodTag] {
        return TagsRepository.shared.availableTags
    }
    
    func tagIsSelected(_ tag: MoodTag) -> Bool {
        return self.selectedTags.contains(tag.slug)
    }
    
    func toggleTag(_ tag: MoodTag) {
        if self.selectedTags.contains(tag.slug) {
            self.selectedTags.remove(tag.slug)
        } else {
            self.selectedTags.insert(tag.slug)
        }
    }
    
    var selectedMoodTags: [MoodTag] {
        return self.selectedTags.compactMap { slug in
            TagsRepository.shared.findTag(bySlug: slug)
        }
    }
    
    // MARK: - Advice Text Methods
    func updateAdviceText(to inputText: String) {
        self.adviceText = inputText
    }
    
    // MARK: - Data Submission
    
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
        // Implement database saving logic here
    }
    
    func resetFlow() {
        currentStep = 0
        moodLevel = 0.5
        energyLevel = 0.5
        focusLevel = 0.5
        anxietyLevel = 0.5
        selectedTags = []
        adviceText = ""
    }
}
