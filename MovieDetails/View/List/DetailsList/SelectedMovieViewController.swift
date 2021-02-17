//
//  SelectedMovieViewController.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 14.02.2021.
//

import UIKit

class SelectedMovieViewController: UIViewController {

    static let reuseId = "SelectedMovieViewController"
    var movieId: Int?
    var viewModel: SelectedMovieViewModel?
    var backdropUrl: String?
    
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImageView.contentMode = .scaleAspectFill

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadMovieDetails()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SelectedMovieViewController {
    
    private func loadMovieDetails(){
        guard let movieId = movieId else { return }
        
        MovieService.shared.getSelectedMovie(movieId: movieId) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                //self.viewModel = self.SelectedMovieModel
                self.yearLabel.text = self.viewModel?.release_date
                self.textLabel.text = self.viewModel?.overview
            }
        }
        
        guard let posterURL = backdropUrl else { return }
        MovieService.shared.getImage(from: posterURL, completed: { image in
            DispatchQueue.main.async {
                self.posterImageView.image = image != nil ? image : Images.emptyImage
            }
        })
    }
}
