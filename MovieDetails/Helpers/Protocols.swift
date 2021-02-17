//
//  Protocols.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 16.02.2021.
//

import Foundation

protocol CustomCollectionViewCellDelegate {
    func loadMovie()
}

protocol EventDelegate: AnyObject {
    func systemDidUpdate()
}
