//
//  MoodEntry.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-25.
//

import Foundation

struct MoodEntry: Identifiable, Codable {
    var id: UUID
    var userId: UUID
    var date: Date
    var moodRatings: [String: Double]
    var text: String
}
