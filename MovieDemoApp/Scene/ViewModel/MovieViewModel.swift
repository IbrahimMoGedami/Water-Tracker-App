//
//  MovieViewModel.swift
//  MovieDemoApp
//
//  Created by Ibrahim Mo Gedami on 22/08/2025.
//

import Foundation
import AppBase
import Combine

class MovieViewModel: ObservableObject {
    
    @Published var movieState: ViewState<[Movie]> = .idle
    
    private let dataSource: MovieDataSourceProtocol
    
    init(dataSource: MovieDataSourceProtocol = MovieDataSource()) {
        self.dataSource = dataSource
    }
    
    @MainActor
    func searchMovies(text: String) async {
        movieState = .loading
        do {
            let result = try await dataSource.searchMovies(text: text)
                .singleOutput()
            switch result {
            case .success(let movieResponses):
                let data = movieResponses?.content?.results ?? []
                movieState = .success(data)
            case .fail(let error):
                movieState = .error(error.localizedDescription)
            }
        } catch {
            movieState = .error(error.localizedDescription)
        }
    }
    
    @MainActor
    func loadPopularMovies() async {
        movieState = .loading
        do {
            let result = try await dataSource.popularMovies()
                .singleOutput()
            switch result {
            case .success(let movieResponses):
                let data = movieResponses?.content?.results ?? []
                movieState = .success(data)
            case .fail(let error):
                movieState = .error(error.localizedDescription)
            }
        } catch {
            movieState = .error(error.localizedDescription)
        }
    }
    
}
