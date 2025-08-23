//
//  ContentView.swift
//  MovieDemoApp
//
//  Created by Bhumika Patel on 18/06/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject private var viewModel = MovieViewModel()
    @State private var searchText = ""
    @Environment(\.modelContext) private var context
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            StatefulView(state: viewModel.movieState) { movies in
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(movies) { movie in
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                MovieCell(movie: movie)
                            }
                        }
                    }
                    .padding()
                }
            } loading: {
                loadingView
            } error: { errorMessage, _ in
                ErrorView(message: errorMessage) {
                    Task {
                        await viewModel.loadPopularMovies()
                    }
                }
            } idle: {
                idleView
            }
            .searchable(text: $searchText)
            .navigationTitle("Popular Movies")
            .onAppear {
                Task {
                    await viewModel.loadPopularMovies()
                }
            }
            .onChange(of: searchText) { _, newValue in
                if newValue.count > 2 {
                    Task {
                        await viewModel.searchMovies(text: newValue)
                    }
                } else if newValue.isEmpty {
                    Task {
                        await viewModel.loadPopularMovies()
                    }
                }
            }
        }
    }
    
    private var idleView: some View {
        VStack {
            Image(systemName: "film")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            Text("Search for movies or load popular ones")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
    
    private var loadingView: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            Text("Loading movies...")
                .foregroundColor(.secondary)
        }
    }
    
}

struct MovieCell: View {
    
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: movie.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            .clipped()
            .cornerRadius(10)
            
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)
            
            Text("⭐️ \(movie.vote_average, specifier: "%.1f")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
}

struct ErrorView: View {
    
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("Oops! Something went wrong")
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button("Try Again", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
    
}

#Preview {
    ContentView()
}
