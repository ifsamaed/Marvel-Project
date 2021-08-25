//
//  CharacterDetailCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 25/8/21.
//

import UIKit
import CoreData

final class CharacterDetailCoordinator: Coordinator {
    var rootViewController: UIViewController = UIViewController()
    private let viewModel: CharacterRepresentableViewModel
    private let container: NSPersistentContainer
    
    init(viewModel: CharacterRepresentableViewModel, container: NSPersistentContainer) {
        self.viewModel = viewModel
        self.container = container
    }
    
    func start() -> UIViewController {
        let presenter = CharacterDetailPresenter(viewModel, container: container)
        let viewController = CharacterDetailViewController(presenter: presenter)
        presenter.view = viewController
        rootViewController = viewController
        return rootViewController
    }
}
