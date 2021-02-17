//
//  NetworkManager.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 12.02.2021.
//

import Foundation
import Combine
import UIKit

var page = 1
let apiKey = "api_key=bf9fd22312452bbe8572f5b65dad0f35&language=en-US&page=1"
let baseURL = "https://api.themoviedb.org/3/movie/"
let baseImageURL = "https://image.tmdb.org/t/p/w500/"
let popular = "popular?"
let topRated = "top_rated?"
let upcoming = "upcoming?"
let groupMovie = [topRated,popular,upcoming]


//let apiKey = PlistService.getPlistKey(key: .apiKey)

class MovieAPI {
    
    static func searchMovie(groupMovie: String, page: Int) -> AnyPublisher<[MovieModel], Error> {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(groupMovie)api_key=bf9fd22312452bbe8572f5b65dad0f35&language=en-US&page=\(page )")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: { NSString(data: $0.data, encoding: String.Encoding.utf8.rawValue)! })
            .tryMap { try JSONDecoder().decode(MovieList<MovieModel>.self, from: $0.data).results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
      
    }
}
