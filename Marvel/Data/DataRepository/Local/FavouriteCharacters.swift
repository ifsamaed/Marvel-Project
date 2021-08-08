//
//  FavouriteCharacters.swift
//  Marvel
//
//  Created by Margaret López Calderón on 8/8/21.
//

import Foundation

final class FavouriteCharactersSingleton {
    var characters: [CharacterRepresentableViewModel] = []
    
    static var shared: FavouriteCharactersSingleton = {
        let instance = FavouriteCharactersSingleton()
        
        return instance
    }()
    
    private init() {}

    
}
