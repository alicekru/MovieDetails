//
//  MovieModel.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 12.02.2021.
//

import Foundation

struct MovieModel: Codable,Identifiable,Equatable {
    
    var id : Int?
    var poster : String
    var title : String
    var overview : String
    
    enum CodingKeys: String,CodingKey {
        case poster = "poster_path"
        case overview
        case title
    }
}

struct MovieList<T:Codable>: Codable {
    var page : Int
    let results : [MovieModel]
}




