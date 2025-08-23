//
//  StatefulViewModifier.swift
//  MovieDemoApp
//
//  Created by Ibrahim Mo Gedami on 23/08/2025.
//

import SwiftUI

struct StatefulViewModifier<Content: Equatable, ContentView: View, Placeholder: View, LoadingView: View, ErrorView: View>: View {
    
    let state: ViewState<Content>
    let content: (Content) -> ContentView
    let placeholder: () -> Placeholder
    let loadingView: () -> LoadingView
    let errorView: (String, @escaping () -> Void) -> ErrorView
    
    init(
        state: ViewState<Content>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder loadingView: @escaping () -> LoadingView,
        @ViewBuilder errorView: @escaping (String, @escaping () -> Void) -> ErrorView
    ) {
        self.state = state
        self.content = content
        self.placeholder = placeholder
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    var body: some View {
        switch state {
        case .idle:
            placeholder()
        case .loading:
            loadingView()
        case .success(let contentData):
            content(contentData)
        case .error(let message):
            errorView(message, {})
        }
    }
    
}

// Extension for default parameters
extension StatefulViewModifier where Placeholder == DefaultPlaceholderView,
                                    LoadingView == DefaultLoadingView,
                                    ErrorView == DefaultErrorView {
    
    init(
        state: ViewState<Content>,
        @ViewBuilder content: @escaping (Content) -> ContentView
    ) {
        self.init(
            state: state,
            content: content,
            placeholder: { DefaultPlaceholderView() },
            loadingView: { DefaultLoadingView() },
            errorView: { message, retry in
                DefaultErrorView(message: message, retryAction: retry)
            }
        )
    }
}

// Default placeholder view
struct DefaultPlaceholderView: View {
    var body: some View {
        VStack {
            Image(systemName: "photo")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            Text("Content will appear here")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

// Default loading view
struct DefaultLoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            Text("Loading...")
                .foregroundColor(.secondary)
        }
    }
}

// Default error view
struct DefaultErrorView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            Text(message)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

extension View {
    
    @ViewBuilder
    func StatefulView<Content: Equatable>(
        state: ViewState<Content>,
        @ViewBuilder content: @escaping (Content) -> some View,
        @ViewBuilder loading: @escaping () -> some View = { DefaultLoadingView() },
        @ViewBuilder error: @escaping (String, @escaping () -> Void) -> some View = { message, retry in
            DefaultErrorView(message: message, retryAction: retry)
        },
        @ViewBuilder idle: @escaping () -> some View = { DefaultPlaceholderView() }
    ) -> some View {
        switch state {
        case .idle:
            idle()
        case .loading:
            loading()
        case .success(let contentData):
            content(contentData)
        case .error(let message):
            error(message, {})
        }
    }
    
}
