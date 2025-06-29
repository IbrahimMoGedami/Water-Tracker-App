//
//  SettingsView.swift
//  WaterTrackerApp
//
//  Created by Ibrahim Gedami on 28/06/2025.
//

import Foundation
import SwiftUI

struct GoalSettingsView: View {
    
    @AppStorage("dailyGoal") private var dailyGoal: Double = 4000
    
    var body: some View {
        Form {
            Section(header: Text("Daily Goal")) {
                Slider(value: $dailyGoal, in: 2000...6000, step: 250) {
                    Text("Goal")
                }
                Text("Goal: \(Int(dailyGoal)) ml")
            }
        }
        .navigationTitle("Settings")
    }

}
