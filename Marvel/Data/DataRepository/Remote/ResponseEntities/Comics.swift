//
//  Comics.swift
//  Marvel
//
//  Created by Margaret López Calderón on 7/8/21.
//

import Foundation

struct Comics: Codable {
    let available: Int?
    let collectionURI: String?
    let returned: Int?
    let items: [ComicsItem]?
}
