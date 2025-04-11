//
//  MoodEntry.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-25.
//

import Foundation

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    let timestamp: Date
    
    let moodLevel: Double     // How happy/sad (0.0 to 1.0)
    let energyLevel: Double   // How energetic/tired (0.0 to 1.0)
    let focusLevel: Double    // How focused/distracted (0.0 to 1.0)
    let anxietyLevel: Double  // How anxious/calm (0.0 to 1.0)
    

    let selectedTags: Set<String>
    let adviceText: String?
    
    let userId: String
    
    init(
        id: UUID = UUID(),
        timestamp: Date = Date(),
        moodLevel: Double,
        energyLevel: Double,
        focusLevel: Double,
        anxietyLevel: Double,
        selectedTags: Set<String>,
        adviceText: String? = nil,
        userId: String
    ) {
        self.id = id
        self.timestamp = timestamp
        self.moodLevel = moodLevel
        self.energyLevel = energyLevel
        self.focusLevel = focusLevel
        self.anxietyLevel = anxietyLevel
        self.selectedTags = selectedTags
        self.adviceText = adviceText
        self.userId = userId
    }
}

extension MoodEntry {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
}
