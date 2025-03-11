//
//  Item.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-10.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
