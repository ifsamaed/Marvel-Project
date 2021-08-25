//
//  FavouriteCharacterRepresentableViewModel.swift
//  Marvel
//
//  Created by Margaret López Calderón on 21/8/21.
//

import Foundation

protocol FavouriteItem {
    var id: Int32 { get }
    var image: Data? { get }
    var name: String? { get }

}

struct FavouriteCharacterRepresentableViewModel: Hashable, FavouriteItem {
    let id: Int32
    let image: Data?
    let name: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(image)
        hasher.combine(name)

    }
    
    static func == (lhs: FavouriteCharacterRepresentableViewModel, rhs: FavouriteCharacterRepresentableViewModel) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.image == rhs.image &&
            lhs.name == lhs.name
    }
}
