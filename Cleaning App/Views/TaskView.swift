//
//  Task.swift
//  Cleaning App
//
//  Created by Noé on 28/07/2026.
//

import Foundation
import SwiftUI
import SwiftData


struct TaskView: View {
    let task: CleaningTask
    
    @State var completed: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 32) {
            VStack(alignment: .leading) {
                let (tint, label) = barStatus
                HStack {
                    Text(task.name)
                        .font(.title3.bold())
                        .foregroundStyle(.primary)
                        .bold()
                    Spacer()
                    Text(recurrenceLabel)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                ProgressView(value: task.progress)
                    .tint(tint)
                Text(label)
            }
            Toggle("Complete", isOn: $completed)
                .toggleStyle(CheckboxToggleStyle())
                .onChange(of: completed) { _, newValue in
                    if newValue {
                        task.lastCompletion = Date()
                        Task {
                            try? await Task.sleep(for: .seconds(0.5))
                            completed = false
                        }
                    }
                }
        }
        .padding()
        .contentShape(Rectangle())
    }
    
    private var recurrenceLabel: String {
        switch task.recurrence {
        case 1: return "Tous les jours"
        default: return "Tous les \(task.recurrence) jours"
        }
    }
    
    private var barStatus: (tint: Color, label: String) {
        switch task.daysRemaining {
        case ..<0:
            return (.red, "En retard de \(task.daysOverdue) jour" + (task.daysOverdue > 1 ? "s" : ""))
        case 0:
            return (.orange, "À faire aujourd'hui")
        case 1:
            return (.blue, "À faire demain")
        default:
            let s = task.daysRemaining > 1 ? "s" : ""
            return (.blue, "\(task.daysRemaining) jour\(s) restant\(s)")
        }
    }
}


#Preview {
    let task = CleaningTask(name: "Aspirateur", recurrence: 7, lastCompletion: Calendar.current.date(byAdding: .day, value: -4, to: Date()) ?? Date())
    TaskView(task: task)
}
