//
//  FavouriteCharacterPresenter.swift
//  Marvel
//
//  Created by Margaret López Calderón on 8/8/21.
//

import Foundation

protocol FavouriteCharacterPresenterProtocol: AnyObject {
    var view: FavouriteCharacterViewProtocol? { get set }
    func viewWillAppear()
    func removeFavourite(_ index: IndexPath)
}

final class FavouriteCharacterPresenter: FavouriteCharacterPresenterProtocol {
    weak var view: FavouriteCharacterViewProtocol?
    private var favouriteSingleton = FavouriteCharactersSingleton.shared
    private var characters: [CharacterRepresentableViewModel] = []

    func viewWillAppear() {
        let local = FavouriteCharactersSingleton.shared
        self.characters = local.characters
        self.view?.showCharacters(self.characters)
    }
    
    func removeFavourite(_ index: IndexPath) {
        guard self.characters.indices.contains(index.row),
              let indexCharacter = favouriteSingleton.characters.firstIndex(where: { $0.id == characters[index.row].id }) else { return }
        self.favouriteSingleton.characters.remove(at: indexCharacter)
        self.characters = FavouriteCharactersSingleton.shared.characters
        self.view?.updateDeleteCharacter(FavouriteCharactersSingleton.shared.characters, index: index)
    }
}
