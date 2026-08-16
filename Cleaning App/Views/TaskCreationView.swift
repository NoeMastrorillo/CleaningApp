//
//  TaskCreationView.swift
//  Cleaning App
//
//  Created by Noé on 30/07/2026.
//

import Foundation
import SwiftUI

struct TaskCreationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var draftIcon: String? = nil
    @State var draftName: String = "Nouvelle tâche"
    @State var draftRecurrence: Int = 1
    @State var draftLastCompletion: Date = Date()
    
    let onSubmit: (CleaningTask) -> Void
    
    var body: some View {
        NavigationStack {
            TaskForm(
                draftIcon: $draftIcon,
                draftName: $draftName,
                draftRecurrence: $draftRecurrence,
                draftLastCompletion: $draftLastCompletion
            )
            .navigationTitle("Ajouter une tâche")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button (role: .cancel) { dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button (role: .confirm) {
                        let task = CleaningTask(name: draftName, recurrence: draftRecurrence, lastCompletion: draftLastCompletion)
                        onSubmit(task)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
        .presentationDragIndicator(.visible)
    }
}


#Preview {
    TaskCreationView { task in }
}
