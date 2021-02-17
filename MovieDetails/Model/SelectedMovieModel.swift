//
//  SelectedMovieModel.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 16.02.2021.
//

import Foundation

struct SelectedMovieModel: Codable {
    var title: String
    var release_date: String
    var genres: [Genre]
    var overview: String
}

struct Genre: Codable, Equatable {
    var id: Int
    var name: String
}
