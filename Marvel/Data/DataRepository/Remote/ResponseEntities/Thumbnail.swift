//
//  Thumbnail.swift
//  Marvel
//
//  Created by Margaret López Calderón on 6/8/21.
//

import Foundation

struct Thumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
