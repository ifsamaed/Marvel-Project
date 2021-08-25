//
//  CharacterViewModel.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import Foundation
import UIKit

enum CharactersSection: Hashable {
    case main
}

class CharacterRepresentableViewModel: Hashable {
    let characterID: Int
    let name: String
    let description: String?
    var image: UIImage?
    let url: NSURL?
    let comics: [String]
    let series: [String]
    let events: [String]
    var isFavourite: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.characterID)
        hasher.combine(self.name)
    }
    
    static func == (lsh: CharacterRepresentableViewModel, rhs: CharacterRepresentableViewModel) -> Bool {
        return
            lsh.characterID == rhs.characterID &&
            lsh.name == rhs.name
    }
    
    init(characterID: Int, name: String, description: String, url: String, comics: [String], series: [String], events: [String]) {
        self.characterID = characterID
        self.name = name
        self.description = description.isEmpty ? "This character doesn't have any description at this moment" : description
        self.url = NSURL(string: url)
        self.comics = comics
        self.series = series
        self.events = events
    }
}
