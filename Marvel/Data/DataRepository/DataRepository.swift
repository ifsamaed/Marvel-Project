//
//  DataRepository.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import Foundation

protocol DataRepositoryProtocol {
    func getAllCharacters(offset: Int) throws -> CharactersViewModel
}

final class DataRepository: DataRepositoryProtocol {
    let dataSource: RemoteDataSourceProtocol
    
    init() {
        self.dataSource = MarvelRemoteDataSource()
    }

    func getAllCharacters(offset: Int) throws -> CharactersViewModel {
        let response = try dataSource
            .getAllCharacters(inputParam: GellAllCharactersInput(offSet: offset ))
        return CharactersViewModel(response)
    }
}
