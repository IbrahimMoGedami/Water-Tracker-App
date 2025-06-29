//
//  MainView.swift
//  WaterTrackerApp
//
//  Created by Ibrahim Gedami on 28/06/2025.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    @StateObject private var router = Router()
    @StateObject private var dataStore = WaterDataStore()
    @State private var customAmount: Double = 250
    @AppStorage(" ") var startHour = 4
    @AppStorage("endHour") var endHour = 22
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                switch router.selectedTab {
                case .home:
                    HomeView(dataStore: dataStore, customAmount: $customAmount, router: router)
                case .history:
                    HistoryView(dataStore: dataStore)
                case .settings:
                    GoalSettingsView()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .goalSettings:
                    GoalSettingsView()
                case .history:
                    HistoryView(dataStore: dataStore)
                }
            }
            .safeAreaInset(edge: .bottom, spacing: 0) {
                CustomTabBar(selectedTab: $router.selectedTab)
            }
            .onAppear {
                NotificationManager.shared.scheduleRepeatingMinuteNotifications()
            }
        }
    }
}

struct WaterButton: View {
    
    enum Style {
        case blue, red
    }
    
    let title: String
    let icon: String
    let action: () -> Void
    let style: Style
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(style == .blue ? Color.blue : Color.red)
            .cornerRadius(12)
        }
    }
}

#Preview {
    
    MainView()
    
}
