//
//  Enums.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 17.02.2021.
//

import Foundation

enum APIError: Error {
    case unknownError
    case invalidURL
    case invalidResponse
    case invalidData
    case decodeError
}
