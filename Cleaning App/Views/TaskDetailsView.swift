//
//  TaskDetailsView.swift
//  Cleaning App
//
//  Created by Noé on 29/07/2026.
//

import Foundation
import SwiftUI


struct TaskDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var task: CleaningTask
    
    @State var draftIcon: String? = nil
    @State var draftName: String
    @State var draftRecurrence: Int
    @State var draftLastCompletion: Date
    
    @State var showConfirmation: Bool = false
    
    let onDelete: () -> Void
    
    init(task: CleaningTask, onDelete: @escaping () -> Void) {
        self.task = task
        self.draftIcon = task.emojiIcon
        self.draftName = task.name
        self.draftRecurrence = task.recurrence
        self.draftLastCompletion = task.lastCompletion
        self.onDelete = onDelete
    }
    
    var body: some View {
        NavigationStack {
            TaskForm(
                draftIcon: $draftIcon,
                draftName: $draftName,
                draftRecurrence: $draftRecurrence,
                draftLastCompletion: $draftLastCompletion
            )
            .navigationTitle("Modifier '\(task.name)'")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button (role: .cancel) { dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button (role: .confirm) {
                        task.name = draftName.isEmpty ? task.name : draftName
                        task.recurrence = draftRecurrence
                        task.lastCompletion = draftLastCompletion
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Supprimer", role: .destructive) {
                        showConfirmation = true
                    }
                    .tint(.red)
                    .confirmationDialog(
                        "Supprimer définitivement '\(task.name)' ?",
                        isPresented: $showConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("Supprimer", role: .destructive) {
                            onDelete()
                            dismiss()
                        }
                    }
                }
            }
        }
        .presentationDragIndicator(.visible)
    }
}


#Preview {
    TaskDetailsView(task: CleaningTask(name: "Aspirateur", recurrence: 7, lastCompletion: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date())) { }
}
