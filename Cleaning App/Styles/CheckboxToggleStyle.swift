//
//  CheckboxToggleStyle.swift
//  Cleaning App
//
//  Created by Noé on 01/08/2026.
//

import Foundation
import SwiftUI


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundStyle(.blue)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isOn)
            .onTapGesture {
                configuration.isOn.toggle()
            }
    }
}
