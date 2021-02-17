//
//  CustomCollectionViewCell.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 12.02.2021.
//

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let resuseId = "ListCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ListCell", bundle: nil)
    }
    
    var movieViewModel: MovieViewModel? {
        didSet{
            nameLabel.text = movieViewModel?.title
            guard let url = movieViewModel?.poster else { return }
            loadImage(fromURL: url)
        }
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = UIView.ContentMode.scaleAspectFit
        image.backgroundColor = UIColor.lightGray
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let name = UILabel(frame: .zero)
        name.contentMode = UIView.ContentMode.scaleAspectFit
        name.backgroundColor = UIColor.white
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let imageWidth = CGFloat(frame.width * 0.80)
        let imageHeight = CGFloat(imageWidth/1.77)
        backgroundColor = UIColor.darkGray

        imageView.frame.size.width = imageWidth
        imageView.frame.size.height = imageHeight
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        //contentView.addSubview(releaseDateLabel)

        imageView.snp.makeConstraints { make in
           make.size.equalTo(CGSize(width: imageWidth, height: imageHeight))
           make.top.equalTo(20)
           make.centerX.equalTo(contentView)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(40)
            make.centerX.equalTo(contentView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = 0.5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.imageView.image = Images.emptyImage
    }
    
    private func loadImage(fromURL: String) {
        MovieService.shared.getImage(from: fromURL, completed: { image in
            DispatchQueue.main.async {
                self.imageView.image = image != nil ? image : Images.emptyImage
            }
        })
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}
