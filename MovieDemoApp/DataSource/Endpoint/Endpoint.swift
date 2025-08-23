//
//  ApiService.swift
//  MovieDemoApp
//
//  Created by Bhumika Patel on 18/06/25.
//

import SwiftUI
import Foundation

enum Endpoint {
    
    case searchMovies(String)
    case popularMovies
    
    static let baseURL = Constants.baseURL
    
    var fullURL: String {
        switch self {
        case .searchMovies(let text):
            return "\(Self.baseURL)/search/movie?api_key=\(Constants.apiKey)&query=\(text)"
        case .popularMovies:
            return "\(Self.baseURL)/movie/popular?api_key=\(Constants.apiKey)&language=en-US"
        }
    }
    
}

class Constants {
    
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiAccessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiM2M3YmM2NDg4Zjc2NThmMjllZGVmODA0YjQxZWYyNiIsIm5iZiI6MTY0MjQzNjEzNC4wNjgsInN1YiI6IjYxZTU5NjI2NmFhOGUwMDA4Y2MzMjU0OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hEgQE15xhVSuc2ZexmzXy4Nf-ckAFulmAmlpverMTHI"
    static let apiKey = "b3c7bc6488f7658f29edef804b41ef26"
    
}

struct MovieResponse: Codable {
    
    let results: [Movie]
    
}

struct Movie: Codable, Identifiable, Equatable {
    
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let release_date: String
    let vote_average: Double
    
    var posterURL: URL? {
        if let path = poster_path {
            return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
        }
        return nil
    }

}
