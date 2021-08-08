//
//  EncodeDictProtocol.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self), let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return nil }
        return result as? [String: Any]
    }
}
