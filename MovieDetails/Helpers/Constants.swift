//
//  Constant.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 15.02.2021.
//

import Foundation
import UIKit

struct Images {
    static let emptyImage = UIImage(named: "film-reel")
}

struct ApiURL {
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let selectedMovie = baseURL
    static let image = "https://image.tmdb.org/t/p/"
}
