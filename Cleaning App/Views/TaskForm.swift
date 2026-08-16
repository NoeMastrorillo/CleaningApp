//
//  TaskForm.swift
//  Cleaning App
//
//  Created by Noé on 31/07/2026.
//

import Foundation
import SwiftUI
import ElegantEmojiPicker


struct TaskForm: View {
    @Binding var draftIcon: String?
    @Binding var draftName: String
    @Binding var draftRecurrence: Int
    @Binding var draftLastCompletion: Date
    
    @State private var isEmojiPickerPresented = false
    
    var body: some View {
        Form {
            Section {
                LabeledContent("Icône") {
                    if let icon = draftIcon {
                        HStack(spacing: 16) {
                            // Spacer
                            Button { } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .opacity(0)
                            
                            Button {
                                isEmojiPickerPresented.toggle()
                            } label: {
                                Text(icon)
                                    .font(.largeTitle)
                            }
                            
                            Button {
                                draftIcon = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.tertiary)
                            }
                            .buttonStyle(.plain)
                        }
                    } else {
                        Button {
                            isEmojiPickerPresented.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.primary)
                        }
                    }
                }
                .labeledContentStyle(TopLabeledContentStyle())
                .frame(maxWidth: .infinity, alignment: .center)
            }

            
            Section {
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
        .emojiPicker(
            isPresented: $isEmojiPickerPresented,
            selectedEmoji: Binding(
                get: { return nil },
                set: { selectedEmoji in draftIcon = selectedEmoji?.emoji }
            )
        )
    }
}

#Preview {
    @Previewable @State var icon: String? = "💨"
    @Previewable @State var name = "Aspirateur"
    @Previewable @State var recurrence = 7
    @Previewable @State var lastCompletion = Date()
    
    TaskForm(draftIcon: $icon, draftName: $name, draftRecurrence: $recurrence, draftLastCompletion: $lastCompletion)
}
