//
//  AdvancedSearchCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 25/8/21.
//

import UIKit

protocol AdvancedSearchBaseCoordinator: Coordinator {
    func dismiss()
}

final class AdvancedSearchViewCoordinator: AdvancedSearchBaseCoordinator {
    var rootViewController: UIViewController = UIViewController()
    var delegate: AdvancedSearchDelegate
    
    init(delegate: AdvancedSearchDelegate) {
        self.delegate = delegate
    }
    
    func start() -> UIViewController {
        let presenter = AdvancedSearchPresenter(coordinator: self)
        let viewController = AdvancedSearchViewController(presenter: presenter)
        viewController.delegate = delegate
        presenter.view = viewController
        self.rootViewController = viewController
        return rootViewController
    }
    
    func dismiss() {
        self.rootViewController.dismiss(animated: true) { [weak self] in
            self?.delegate.showAllCharacters()
        }
    }
    
}
