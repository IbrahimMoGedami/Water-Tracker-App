//
//  HistoryView.swift
//  WaterTrackerApp
//
//  Created by Ibrahim Gedami on 28/06/2025.
//

import Foundation
import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var dataStore: WaterDataStore
    
    var body: some View {
        List(dataStore.history.sorted(by: { $0.date > $1.date })) { entry in
            VStack(alignment: .leading) {
                Text(entry.date, style: .date)
                    .font(.headline)
                Text("Drank: \(Int(entry.amount)) ml")
            }
        }
        .navigationTitle("History")
    }

}
