//
//  TaskForm.swift
//  Cleaning App
//
//  Created by Noé on 31/07/2026.
//

import Foundation
import SwiftUI

struct TaskForm: View {
    @Binding var draftName: String
    @Binding var draftRecurrence: Int
    @Binding var draftLastCompletion: Date
    
    var body: some View {
        Form {
            LabeledContent("Nom") {
                TextField("Entrer un nom", text: $draftName)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
            LabeledContent("Récurrence") {
                Picker("Entrer une récurrence", selection: $draftRecurrence) {
                    ForEach(1...365, id: \.self) { number in
                        Text("Tous les \(number == 1 ? "" : "\(number) ")jours")
                    }
                }
                .pickerStyle(.menu)
                .labelsHidden()
            }
            LabeledContent("Complétion") {
                DatePicker(
                    "Entrer une date",
                    selection: $draftLastCompletion,
                    in: ...Date(),
                    displayedComponents: [.date]
                )
                .labelsHidden()
            }
        }
    }
}

#Preview {
    @Previewable @State var name = "Aspirateur"
    @Previewable @State var recurrence = 7
    @Previewable @State var lastCompletion = Date()
    
    TaskForm(draftName: $name, draftRecurrence: $recurrence, draftLastCompletion: $lastCompletion)
}
