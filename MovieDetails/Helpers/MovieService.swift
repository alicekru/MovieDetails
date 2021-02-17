//
//  MovieService.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 16.02.2021.
//

import Foundation
import UIKit

class MovieService {
    
    //MARK: - Properties
    static let shared = MovieService()
    let cache = NSCache<NSString, UIImage>()
    
    func getMovies( completion: @escaping (Result<[MovieModel], APIError> ) -> Void) {
        
        guard let url = URL(string: ApiURL.baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        let queryItem = [URLQueryItem(name: apiKey,  value: apiKey)]
        urlComponents.queryItems = queryItem
        
        guard let finalURL = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: finalURL, completionHandler: {( data, response ,error) in
            if let _ = error {
                completion(.failure(.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let movieResponse = try JSONDecoder().decode(MovieList<MovieModel>.self, from: data)
                completion(.success(movieResponse.results))
            } catch {
                completion(.failure(.decodeError))
            }
        }).resume()
    }
    
    func getSelectedMovie(movieId: Int, completion: @escaping (Result< SelectedMovieModel, APIError> ) -> Void) {
        
        guard let url = URL(string: ApiURL.selectedMovie + "\(movieId)") else {
            completion(.failure(.invalidURL))
            return
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        
        let queryItem = [URLQueryItem(name: apiKey,  value: apiKey)]
        urlComponents.queryItems = queryItem
        
        guard let finalURL = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: finalURL, completionHandler: {( data, response ,error) in
            if let _ = error {
                completion(.failure(.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let movieResponse = try JSONDecoder().decode(SelectedMovieModel.self, from: data)
                completion(.success(movieResponse))
            } catch {
                completion(.failure(.decodeError))
            }
        }).resume()
    }
    
    
    func getImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
