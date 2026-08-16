//
//  ContentView.swift
//  Cleaning App
//
//  Created by Noé on 28/07/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var tasks: [CleaningTask]
    @State private var presentedTask: CleaningTask?
    @State private var isCreatingTask: Bool = false
    
    var body: some View {
        NavigationStack {
            List(tasks.sorted {
                $0.daysRemaining < $1.daysRemaining
            }) { task in
                TaskView(task: task)
                    .onTapGesture {
                        presentedTask = task
                    }
            }
            .toolbar {
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    Button (role: .confirm) {
                        isCreatingTask = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $presentedTask) { task in
                TaskDetailsView(task: task) {
                    context.delete(task)
                }
            }
            .sheet(isPresented: $isCreatingTask) {
                TaskCreationView { task in context.insert(task) }
            }
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CleaningTask.self, configurations: config)
    
    container.mainContext.insert(CleaningTask(name: "Aspirateur", recurrence: 7, lastCompletion: Date(), emojiIcon: "💨"))
    container.mainContext.insert(CleaningTask(name: "Vitres", recurrence: 14, lastCompletion: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), emojiIcon: "🪟"))
    
    return ContentView().modelContainer(container)
}
