//
//  FavouritesCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 8/8/21.
//

import Foundation
import UIKit
import CoreData


protocol FavouritesBaseCoordinator: Coordinator {
    var container: NSPersistentContainer? { get set }
}

final class FavouritesCoordinator: FavouritesBaseCoordinator {
    var container: NSPersistentContainer?
    lazy var rootViewController: UIViewController = UIViewController()

    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func start() -> UIViewController {
        guard let container = container else { return UIViewController() }
        let presenter = FavouriteCharacterPresenter(container: container)
        let viewController = FavouriteCharacterTableViewController(presenter: presenter)
        rootViewController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        return rootViewController
    }
}
