//
//  CharacterListCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 7/8/21.
//

import UIKit

final class CharactersCoordinator: CharactersBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()

    func start() -> UIViewController {
        let presenter = CharacterListPresenter(coordinator: self)
        let viewController = CharacterListViewController(presenter: presenter)
        self.rootViewController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        return rootViewController
    }
    
    func showDetail(viewModel: CharacterRepresentableViewModel) {
        let presenter = CharacterDetailPresenter(viewModel)
        let viewController = CharacterDetailViewController(presenter: presenter)
        presenter.view = viewController
        self.rootViewController.present(viewController, animated: true, completion: nil)
    }    
}
