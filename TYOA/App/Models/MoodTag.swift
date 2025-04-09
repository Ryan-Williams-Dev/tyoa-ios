//
//  MoodTag.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-04-09.
//

import Foundation

struct MoodTag: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let iconName: String?
    let slug: String
    let oppositeSlug: String
    
    init(name: String, iconName: String? = nil, slug: String, oppositeSlug: String) {
        self.id = UUID()
        self.name = name
        self.iconName = iconName
        self.slug = slug
        self.oppositeSlug = oppositeSlug
    }
}
