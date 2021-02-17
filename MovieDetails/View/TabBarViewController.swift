//
//  TabBarViewController.swift
//  MovieDetails
//
//  Created by Alice Krutienko on 12.02.2021.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabOne = ListViewController()
        let tabOneBarItem = UITabBarItem(title: "List", image: UIImage(named: "list.png"), selectedImage: UIImage(named: "list.fill.png"))
        
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = FavouritesViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Favourites", image: UIImage(named: "star.png"), selectedImage: UIImage(named: "star.fill.png"))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        self.viewControllers = [tabOne, tabTwo]
    }
}
