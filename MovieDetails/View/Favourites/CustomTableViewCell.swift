//
//  CustomTableViewCell.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 15.02.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let resuseId = "FavouritesCell"

    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = 0.5
    }
    
    var movieViewModel: MovieViewModel? {
        didSet{
            nameLabel.text = movieViewModel?.title
            guard let url = movieViewModel?.poster else { return }
            loadImage(fromURL: url)
        }
    }
    
    private func loadImage(fromURL: String) {
        MovieService.shared.getImage(from: fromURL, completed: { image in
            DispatchQueue.main.async {
                self.movieImageView.image = image != nil ? image : Images.emptyImage
            }
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
