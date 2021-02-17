//
//  GenreViewController.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 17.02.2021.
//

import UIKit

class GenreViewController: UIViewController {

    static let reuseId = "GenreViewController"
    var movieId: Int?
    var viewModel: SelectedMovieViewModel?
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadMovieDetails()
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension GenreViewController {
    
    private func loadMovieDetails(){
        guard let movieId = movieId else { return }
        
        MovieService.shared.getSelectedMovie(movieId: movieId) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                //self.viewModel = self.SelectedMovieModel
                self.nameLabel.text = self.viewModel?.title
                self.genreLabel.text = self.viewModel?.allGenres
            }
        }
    }
}
