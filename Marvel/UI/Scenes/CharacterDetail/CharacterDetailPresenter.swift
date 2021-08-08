//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Margaret López Calderón on 6/8/21.
//

import Foundation

protocol CharacterDetailPresenterProtocol {
    var view: CharacterDetailViewProtocol? { get set }
    func viewDidLoad()
    func saveFavourite(isFavourite: Bool)

}

final class CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    weak var view: CharacterDetailViewProtocol?
    private let viewModel: CharacterRepresentableViewModel
    private var favouriteSingleton = FavouriteCharactersSingleton.shared

    init(_ viewModel: CharacterRepresentableViewModel) {
        self.viewModel = viewModel
    }
    
    func viewDidLoad() {
        self.view?.show(viewModel)
    }
    
    func saveFavourite(isFavourite: Bool) {
        if isFavourite {
            self.favouriteSingleton.characters.append(viewModel)
        } else {
            guard let index = favouriteSingleton.characters.firstIndex(where: { $0.id == viewModel.id }) else { return }
            self.favouriteSingleton.characters.remove(at: index)
        }
    }
    
}
