//
//  CustomTabBar.swift
//  WaterTrackerApp
//
//  Created by Ibrahim Gedami on 28/06/2025.
//

import Foundation
import SwiftUI

enum Tab {
    
    case home, history, settings
    
}


struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            tabBarButton(tab: .home, icon: "house.fill", label: "Home")
            tabBarButton(tab: .history, icon: "calendar", label: "History")
            tabBarButton(tab: .settings, icon: "gearshape.fill", label: "Settings")
        }
        .padding(.top, 4)
        .padding(.horizontal, 20)
        .background(
            Color(UIColor.systemBackground)
                .shadow(color: Color.primary.opacity(0.1), radius: 5, y: -2)
                .edgesIgnoringSafeArea(.bottom)
        )
    }
    
    @ViewBuilder
    private func tabBarButton(tab: Tab, icon: String, label: String) -> some View {
        let isSelected = selectedTab == tab
        
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 6) {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 24, height: 24)
                    }
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(isSelected ? Color.blue : Color.gray)
                }
                
                Text(label)
                    .font(.footnote.weight(isSelected ? .bold : .regular))
                    .foregroundStyle(isSelected ? Color.blue : Color.gray)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
    }

}
