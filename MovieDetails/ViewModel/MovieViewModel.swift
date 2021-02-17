//
//  MovieViewModel.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 15.02.2021.
//

import Foundation

struct MovieViewModel {

    private let movie: MovieModel
    
    init(_ movie: MovieModel) {
        self.movie = movie
    }
    
    var title: String {
        return self.movie.title
    }
    
    var poster: String? {
        return self.movie.poster
    }
    
    var overview: String? {
        return self.movie.overview
    }
    
    var id: Int? {
        return self.movie.id
    }

}
