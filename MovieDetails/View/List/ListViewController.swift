//
//  ListViewController.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 12.02.2021.
//

import Foundation
import UIKit

class ListViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var movieViewModelList = [MovieViewModel]()
   
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //movieViewModelList.eventDelegate = self
        setupLongGestureRecognizerOnCollection()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadMovies(){
        
        MovieService.init().getMovies() { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView?.addGestureRecognizer(longPressedGesture)
    }

    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }

        let p = gestureRecognizer.location(in: collectionView)

        if let indexPath = collectionView?.indexPathForItem(at: p) {
            print("Long press at item: \(indexPath.row)")
//            add to favouriets
        }
    }
}

//MARK: - CollectionView Delegate & DataSource

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !movieViewModelList.isEmpty{
            return movieViewModelList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.movieViewModel = movieViewModelList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if !movieViewModelList.isEmpty{
            let selectedMovieVC = SelectedMovieViewController(nibName: SelectedMovieViewController.reuseId, bundle: nil)
            selectedMovieVC.movieId = movieViewModelList[indexPath.row].id
            self.present(selectedMovieVC, animated: true, completion: nil)
        }
    }
}

extension ListViewController: EventDelegate {
    func systemDidUpdate() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
