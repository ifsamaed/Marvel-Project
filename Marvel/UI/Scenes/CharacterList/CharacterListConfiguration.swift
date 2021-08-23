//
//  CharacterListConfiguration.swift
//  Marvel
//
//  Created by Margaret López Calderón on 23/8/21.
//

import Foundation

struct CharacterListConfiguration {
    
    static let repository: DataRepositoryProtocol = DataRepository(dataSource: NetworkingDataSource())
    
    
}
