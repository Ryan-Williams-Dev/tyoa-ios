//
//  DummyData.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-09.
//


import Foundation

struct DummyData {
    static let moodTags: [MoodTag] = [
        MoodTag(name: "Confident", iconName: "hand.thumbsup", slug: "confident", oppositeSlug: "insecure"),
        MoodTag(name: "Insecure", iconName: "hand.thumbsdown", slug: "insecure", oppositeSlug: "confident"),
        MoodTag(name: "Happy", iconName: "smiley", slug: "happy", oppositeSlug: "sad"),
        MoodTag(name: "Sad", iconName: "cloud.rain", slug: "sad", oppositeSlug: "happy"),
        MoodTag(name: "Focused", iconName: "eye", slug: "focused", oppositeSlug: "distracted"),
        MoodTag(name: "Distracted", iconName: "wand.and.stars", slug: "distracted", oppositeSlug: "focused"),
        MoodTag(name: "Excited", iconName: "star", slug: "excited", oppositeSlug: "bored"),
        MoodTag(name: "Bored", iconName: "hourglass", slug: "bored", oppositeSlug: "excited"),
        MoodTag(name: "Relaxed", iconName: "leaf", slug: "relaxed", oppositeSlug: "stressed"),
        MoodTag(name: "Stressed", iconName: "bolt", slug: "stressed", oppositeSlug: "relaxed"),
        MoodTag(name: "Motivated", iconName: "flame", slug: "motivated", oppositeSlug: "tired"),
        MoodTag(name: "Tired", iconName: "zzz", slug: "tired", oppositeSlug: "motivated")
    ]
}
