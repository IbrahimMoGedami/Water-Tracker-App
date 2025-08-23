//
//  ViewState.swift
//  MovieDemoApp
//
//  Created by Ibrahim Mo Gedami on 23/08/2025.
//

import Foundation

enum ViewState<Content>: Equatable where Content: Equatable {
    
    case idle
    case loading
    case success(Content)
    case error(String)
    
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var errorMessage: String? {
        if case .error(let message) = self { return message }
        return nil
    }
    
    var content: Content? {
        if case .success(let content) = self { return content }
        return nil
    }
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.success(let lhsContent), .success(let rhsContent)):
            return lhsContent == rhsContent
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        default:
            return false
        }
    }

}
