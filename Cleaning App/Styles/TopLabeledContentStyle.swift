//
//  TopLabeledContentStyle.swift
//  Cleaning App
//
//  Created by Noé on 16/08/2026.
//

import Foundation
import SwiftUI


struct TopLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 16) {
            configuration.label.foregroundStyle(.primary)
            configuration.content
        }
    }
}
