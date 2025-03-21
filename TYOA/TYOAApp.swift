//
//  TYOAApp.swift
//  TYOA
//
//  Created by Ryan Williams on 2025-03-10.
//

import SwiftUI
import SwiftData

@main
struct TYOAApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
