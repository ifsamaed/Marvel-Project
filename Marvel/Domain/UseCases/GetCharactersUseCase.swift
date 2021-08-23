//
//  GetCharactersUseCase.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import Foundation

final class GetCharactersUseCase {
    private let dataRepository: DataRepositoryProtocol
    
    init(repository: DataRepositoryProtocol) {
        self.dataRepository = repository
    }
    
    func execute(offset: Int) throws -> CharactersViewModel {
        return try dataRepository.getAllCharacters(offset: offset)
    }
}
