//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Margaret López Calderón on 7/8/21.
//

import Foundation

protocol CharacterListPresenterProtocol: AnyObject {
    var view: CharacterListViewProtocol? { get set }
    func viewDidLoad()
    func loadMoreCharacters()
    func didTapCharacter(_ character: CharacterRepresentableViewModel)
    func didTapOnAdvancedSearch()
}

final class CharacterListPresenter: CharacterListPresenterProtocol {
    weak var view: CharacterListViewProtocol?
    private var coordinator: CharactersBaseCoordinator
    
    private var offset: Int = 0
    private var limit: Int = -1
    private var total: Int = 0
    private var count: Int = 0
    
    init(coordinator: CharactersBaseCoordinator) {
        self.coordinator = coordinator
    }

    func viewDidLoad() {
        let characters = self.loadCharacters()
        self.view?.showCharacters(characters)
    }
    
    func loadMoreCharacters() {
        let characters = self.loadCharacters()
        self.view?.appendNewCharacters(characters)
    }
    
    func didTapCharacter(_ character: CharacterRepresentableViewModel) {
        self.coordinator.showDetail(viewModel: character)
    }
    
    func didTapOnAdvancedSearch() {
        self.coordinator.showAdvancedSearch()
    }
}

private extension CharacterListPresenter {
    func loadCharacters() -> [CharacterRepresentableViewModel] {
        do {
            guard offset > limit else {
                return []
            }
            let charactersDomain = try GetCharactersUseCase(repository: DataRepository(dataSource: NetworkingDataSource()))
                .execute(offset: offset)
            let charactersViewModelRepresentable = charactersDomain
                .characters
                .map { CharacterRepresentableViewModel(
                    characterID: $0.characterID,
                    name: $0.name,
                    description: $0.description ?? "",
                    url: $0.thumbnail?.imageURL ?? "",
                    comics: $0.comics.items.map { $0.name ?? "" },
                    series: $0.series.items.map { $0.name ?? "" },
                    events: $0.event.items.map { $0.name ?? ""}
                )}
            self.offset += charactersViewModelRepresentable.count
            self.limit = charactersDomain.limit
            return charactersViewModelRepresentable
        } catch {
            return []
        }
    }
}
