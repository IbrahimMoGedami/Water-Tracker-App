//
//  DailyWaterEntry.swift
//  WaterTrackerApp
//
//  Created by Ibrahim Gedami on 28/06/2025.
//

import Foundation

struct DailyWaterEntry: Codable, Identifiable {
    
    var id = UUID()
    let date: Date
    var amount: Double

}
