//
//  CharacterListCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 7/8/21.
//

import UIKit
import CoreData

protocol CharactersBaseCoordinator: Coordinator {
    func showDetail(viewModel: CharacterRepresentableViewModel)
    func showAdvancedSearch()
}

final class CharactersCoordinator: CharactersBaseCoordinator {
    var container: NSPersistentContainer?
    lazy var rootViewController: UIViewController = UIViewController()
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func start() -> UIViewController {
        let presenter = CharacterListPresenter(coordinator: self)
        let viewController = CharacterListViewController(presenter: presenter)
        self.rootViewController = UINavigationController(rootViewController: viewController)
        presenter.view = viewController
        return rootViewController
    }
    
    func showDetail(viewModel: CharacterRepresentableViewModel) {
        let presenter = CharacterDetailPresenter(viewModel, container: self.container!)
        let viewController = CharacterDetailViewController(presenter: presenter)
        presenter.view = viewController
        self.rootViewController.present(viewController, animated: true, completion: nil)
    }
    
    func showAdvancedSearch() {
        let viewController = AdvancedSearch()
        self.rootViewController.present(viewController, animated: true, completion: nil)
    }
}
