//
//  Route.swift
//  WaterTrackerApp
//
//  Created by Ibrahim Gedami on 28/06/2025.
//

import SwiftUI

enum Route: Hashable {
    
    case goalSettings
    case history
    
}

@MainActor
class Router: ObservableObject {
    
    @Published var selectedTab: Tab = .home
    @Published var path = NavigationPath()
    
    func goTo(_ route: Route) {
        path.append(route)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }

}
