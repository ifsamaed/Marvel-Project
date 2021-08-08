//
//  Stories.swift
//  Marvel
//
//  Created by Margaret López Calderón on 6/8/21.
//

import Foundation

struct Stories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}
