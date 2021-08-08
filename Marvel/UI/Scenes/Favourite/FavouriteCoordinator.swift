//
//  FavouritesCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 8/8/21.
//

import Foundation
import UIKit

final class FavouritesCoordinator: Coordinator {
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()

    func start() -> UIViewController {
        let presenter = FavouriteCharacterPresenter()
        let viewController = FavouriteCharacterTableViewController(presenter: presenter)
        self.rootViewController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        return rootViewController
    }
}
