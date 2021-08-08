//
//  AppCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 8/8/21.
//

import Foundation
import UIKit

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
}

protocol MainBaseCoordinator {
    var charactersCoordinator: CharactersBaseCoordinator { get }
}

protocol CharactersBaseCoordinator: Coordinator {
    func showDetail(viewModel: CharacterRepresentableViewModel)
}

protocol HomeBaseCoordinated {
    var coordinator: CharactersBaseCoordinator? { get }
}
