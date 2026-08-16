//
//  CleaningTask.swift
//  Cleaning App
//
//  Created by Noé on 01/08/2026.
//

import Foundation
import SwiftData


extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return end - start
    }
}


@Model
class CleaningTask {
    var id: UUID
    var name: String
    var recurrence: Int
    var lastCompletion: Date
    var emojiIcon: String? = nil
    
    init(id: UUID = UUID(), name: String, recurrence: Int, lastCompletion: Date, emojiIcon: String? = nil) {
        self.id = id
        self.name = name
        self.recurrence = recurrence
        self.lastCompletion = lastCompletion <= Date() ? lastCompletion : Date()
        self.emojiIcon = emojiIcon
    }
    
    var nextDueDate: Date {
        Calendar.current.date(byAdding: .day, value: recurrence, to: lastCompletion) ?? lastCompletion
    }
    
    var daysRemaining: Int {
        nextDueDate.interval(ofComponent: .day, fromDate: Date())
    }
    
    var daysOverdue: Int {
        Date().interval(ofComponent: .day, fromDate: nextDueDate)
    }
    
    var progress: Double {
        let duration = nextDueDate.timeIntervalSince(lastCompletion)
        guard duration > 0 else { return 1.0 }
        
        let elapsed = Date().timeIntervalSince(lastCompletion)
        let calculatedProgress = elapsed / duration
        return min(calculatedProgress, 1.0)
    }
}
