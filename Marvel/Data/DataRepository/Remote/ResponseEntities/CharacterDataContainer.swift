//
//  CharacterDataContainer.swift
//  Marvel
//
//  Created by Margaret López Calderón on 7/8/21.
//

import Foundation

struct CharacterDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [CharactersResult]?
}
