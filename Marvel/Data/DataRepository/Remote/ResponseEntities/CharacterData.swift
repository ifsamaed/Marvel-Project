//
//  CharacterData.swift
//  Marvel
//
//  Created by Margaret López Calderón on 6/8/21.
//

import Foundation

struct CharacterData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    let results: [CharactersResult]?
}
