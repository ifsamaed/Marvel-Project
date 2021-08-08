//
//  MarvelRemoteDataSource.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import Foundation

enum RemoteDataSourceError: Error {
    case service
}

protocol RemoteDataSourceProtocol {
    func getAllCharacters(inputParam: GellAllCharactersInput?) throws -> Characters
}

final class MarvelRemoteDataSource: RemoteDataSourceProtocol {
    private let netClient = NetworkingClient()
    private let authenticationManager: AuthenticationManager
    private let api = MarvelApi()
    
    init () {
        self.authenticationManager = AuthenticationManager(apiNetworking: self.api)
    }
    
    func getAllCharacters(inputParam: GellAllCharactersInput?) throws -> Characters {
        let path = "/v1/public/characters"
        let base = api.baseUrl
        let parameters: [String: Any] = {
           let paramsAuth = self.authenticationManager
                .generateApiKeyParameters()
                .dictionary ?? [:]
            let inputParams = inputParam?.dictionary ?? [:]
            return paramsAuth.merging(inputParams) { $1 }
        }()
        
        let result = netClient
            .request(url: base + path,
                     queryParams: parameters,
                     method: .get)
        
        switch result {
        case .success(let response):
            return try JSONDecoder().decode(Characters.self, from: response.data)
        case .failure(let error):
            switch error {
            case .unknown, .timeout, .custom:
                throw RemoteDataSourceError.service
            }
        }
    }
}
