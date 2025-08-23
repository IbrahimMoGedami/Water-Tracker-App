//
//  HomeView.swift
//  WaterTrackerApp
//
//  Created by Ibrahim Gedami on 28/06/2025.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var dataStore: WaterDataStore
    @Binding var customAmount: Double
    @ObservedObject var router: Router
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("Today's Intake")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("\(Int(dataStore.todayAmount)) / \(Int(dataStore.dailyGoal)) ml")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                
                ProgressView(value: dataStore.todayAmount, total: dataStore.dailyGoal)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .frame(height: 20)
                    .clipShape(Capsule())
                    .padding(.horizontal)
            }
            
            VStack(spacing: 20) {
                Stepper("Amount: \(Int(customAmount)) ml", value: $customAmount, in: 100...1000, step: 50)
                    .padding(.horizontal)
                HStack {
                    WaterButton(title: "Add \(Int(customAmount)) ml", icon: "plus", action: {
                        dataStore.add(amount: customAmount)
                    }, style: .blue)
                    
                    WaterButton(title: "Reset", icon: "arrow.clockwise", action: {
                        dataStore.resetToday()
                    }, style: .red)
                }
                
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .navigationTitle("💧 Water Tracker")
        .onDisappear {
            dataStore.saveToday()
        }
    }

}

#Preview {
    MainView()
}
