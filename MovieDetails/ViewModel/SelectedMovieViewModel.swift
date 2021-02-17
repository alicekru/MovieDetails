//
//  SelectedMovieViewModel.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 17.02.2021.
//

import Foundation

struct SelectedMovieViewModel {
    private let selectedMovie: SelectedMovieModel
    
    init(_ selectedMovie: SelectedMovieModel) {
        self.selectedMovie = selectedMovie
    }
    
    var title: String {
        return self.selectedMovie.title
    }
    
    var release_date: String {
        return self.selectedMovie.release_date
    }
    
    var genres: [Genre] {
        return self.selectedMovie.genres
    }
    
    var overview: String {
        return self.selectedMovie.overview
    }
    
    var yearOfRelease: String {
        let originalDateFormat = DateFormatter()
        originalDateFormat.dateFormat = "yyyy-MM-dd"
        
        guard let date = originalDateFormat.date(from: self.selectedMovie.release_date) else { return "" }

        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "yyyy"
        
        return newDateFormat.string(from: date)
    }
    
    var allGenres: String {
        let genres = selectedMovie.genres
        
        var allGenres = ""
        for (index,genre) in genres.enumerated(){
            if index == 0 {
                allGenres = genre.name
            } else {
                allGenres += ", \(genre.name)"
            }
        }
        
        return allGenres
    }
}
