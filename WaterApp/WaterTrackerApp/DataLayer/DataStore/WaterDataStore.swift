//
//  WaterDataStore.swift
//  WaterTrackerApp
//
//  Created by Ibrahim Gedami on 28/06/2025.
//

import Foundation
import SwiftUI

class WaterDataStore: ObservableObject {
    
    @AppStorage("dailyGoal") var dailyGoal: Double = 4000
    @Published var todayAmount: Double = 0
    @Published var history: [DailyWaterEntry] = []
    
    private let key = "water_history"
    
    init() {
        loadHistory()
    }
    
    func add(amount: Double) {
        todayAmount += amount
    }
    
    func saveToday() {
        let today = Calendar.current.startOfDay(for: Date())
        if let index = history.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
            history[index].amount = todayAmount
        } else {
            history.append(.init(date: today, amount: todayAmount))
        }
        saveHistory()
    }
    
    func resetToday() {
        todayAmount = 0
    }
    
    func loadHistory() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([DailyWaterEntry].self, from: data) else {
            return
        }
        self.history = decoded
        
        // Restore today's progress
        if let todayEntry = history.first(where: { Calendar.current.isDateInToday($0.date) }) {
            self.todayAmount = todayEntry.amount
        }
    }
    
    func saveHistory() {
        if let data = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

}
