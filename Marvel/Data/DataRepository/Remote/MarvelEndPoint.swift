//
//  MarvelEndPoint.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import Foundation

protocol ApiNetworkingProtocol {
    var baseUrl: String { get }
    var privateApiKey: String { get }
    var publicApiKey: String { get }
}

struct MarvelApi: ApiNetworkingProtocol {
    let baseUrl: String = "https://gateway.marvel.com"
    let privateApiKey = "32cd0c961ab7dacc0bd9057ecca957bd9f52924b"
    let publicApiKey = "4a8bd27d514a67676e8896637d3a75db"
}
