//
//  DataSource.swift
//  MovieDemoApp
//
//  Created by Ibrahim Mo Gedami on 22/08/2025.
//

import Foundation
import AppBase
import CombineNetwork

protocol MovieDataSourceProtocol {
    
    func searchMovies(text: String) -> NetworkPublisher<MovieResponse>
    func popularMovies() -> NetworkPublisher<MovieResponse>
    
}

class MovieDataSource: MovieDataSourceProtocol {
    
    private let network: NetworkWrapperProtocol
    
    init(network: NetworkWrapperProtocol = NetworkWrapper()) {
        self.network = network
    }
    
    func searchMovies(text: String) -> NetworkPublisher<MovieResponse> {
        network.makeRequest(url: .full(Endpoint.searchMovies(text).fullURL), method: .get, body: nil)
    }
    
    func popularMovies() -> NetworkPublisher<MovieResponse> {
        network.makeRequest(url: .full(Endpoint.popularMovies.fullURL), method: .get, body: nil)
    }
    
}
