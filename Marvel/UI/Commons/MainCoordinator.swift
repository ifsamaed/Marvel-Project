//
//  MainCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 7/8/21.
//

import UIKit
import CoreData

final class MainCoordinator {
    lazy var rootViewController: UIViewController = UITabBarController()
    
    func start(container: NSPersistentContainer) -> UIViewController {
        let charactersViewController = CharactersCoordinator(container: container)
            .start()
        charactersViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        let favoriteViewController = FavouritesCoordinator(container: container)
            .start()
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.fill"), tag: 0)
        
        (rootViewController as? UITabBarController)?.viewControllers = [charactersViewController, favoriteViewController]
        
        self.rootViewController.view.backgroundColor = .white
        return rootViewController
    }
}
