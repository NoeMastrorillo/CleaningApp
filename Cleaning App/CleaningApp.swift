//
//  CleaningApp.swift
//  Cleaning App
//
//  Created by Noé on 28/07/2026.
//

import SwiftUI
import SwiftData

@main
struct CleaningApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [CleaningTask.self])
        }
    }
}
