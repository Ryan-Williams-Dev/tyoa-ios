//
//  User.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-27.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let fullName: String
    
    var firstName: String {
            let components = fullName.split(separator: " ")
            return components.first.map(String.init) ?? ""
        }
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static let MOCK_USER = User(id: UUID().uuidString, email: "test@example.com", fullName: "Dingus McGee")
}
