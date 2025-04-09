//
//  DummyData.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-09.
//


import Foundation

struct DummyData {
    static let moodTags: [MoodTag] = [
        MoodTag(name: "Confident", iconName: "hand.thumbsup.fill", slug: "confident", oppositeSlug: "insecure"),
        MoodTag(name: "Insecure", iconName: "hand.thumbsdown.fill", slug: "insecure", oppositeSlug: "confident"),
        MoodTag(name: "Happy", iconName: "smiley.fill", slug: "happy", oppositeSlug: "sad"),
        MoodTag(name: "Sad", iconName: "frown.fill", slug: "sad", oppositeSlug: "happy"),
        MoodTag(name: "Focused", iconName: "eye.fill", slug: "focused", oppositeSlug: "distracted"),
        MoodTag(name: "Distracted", iconName: "wand.and.stars", slug: "distracted", oppositeSlug: "focused")
    ]
}
