//
//  MainCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 7/8/21.
//

import UIKit

final class MainCoordinator: MainBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var charactersCoordinator: CharactersBaseCoordinator = CharactersCoordinator()
    lazy var favouritesCoordinator = FavouritesCoordinator()
    lazy var rootViewController: UIViewController = UITabBarController()
    
    func start() -> UIViewController {
        let charactersViewController = charactersCoordinator.start()
        charactersCoordinator.parentCoordinator = self
        charactersViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let favoriteViewController = favouritesCoordinator.start()
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.fill"), tag: 0)
        
        (rootViewController as? UITabBarController)?.viewControllers = [charactersViewController, favoriteViewController]
        
        self.rootViewController.view.backgroundColor = .white
        return rootViewController
    }
}
