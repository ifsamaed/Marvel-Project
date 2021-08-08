//
//  Characters.swift
//  Marvel
//
//  Created by Margaret López Calderón on 6/8/21.
//

import Foundation

struct Characters: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: CharacterData?
}
