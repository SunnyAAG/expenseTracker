//
//  expenseTrackerApp.swift
//  expenseTracker
//
//  Created by Artiom Gramatin on 07.10.2024.
//

import SwiftUI
import SwiftData

@main
struct expenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: UserProfile.self)
        }
    }
}
