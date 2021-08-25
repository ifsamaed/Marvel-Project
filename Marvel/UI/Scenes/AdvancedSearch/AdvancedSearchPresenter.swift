//
//  AdvancedSearchPresenter.swift
//  Marvel
//
//  Created by Margaret López Calderón on 25/8/21.
//

import Foundation

protocol AdvancedSearchPresenterProtocol: AnyObject {
    var view: AdvancedSearchViewProtocol? { get set }
    func didTapClose()
}

final class AdvancedSearchPresenter: AdvancedSearchPresenterProtocol {
    weak var view: AdvancedSearchViewProtocol?
    private let coordinator: AdvancedSearchBaseCoordinator
    
    init(coordinator: AdvancedSearchBaseCoordinator) {
        self.coordinator = coordinator
    }
    
    func didTapClose() {
        self.coordinator.dismiss()
    }

}
