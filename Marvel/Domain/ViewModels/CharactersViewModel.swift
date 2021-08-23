//
//  CharactersViewModel.swift
//  Marvel
//
//  Created by Margaret López Calderón on 7/8/21.
//

import Foundation

struct CharactersViewModel {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let characters: [CharacterViewModel]
    
    init(_ dto: Characters) {
        self.offset = dto.data?.offset ?? -1
        self.limit = dto.data?.offset ?? -1
        self.total = dto.data?.total ?? -1
        self.count = dto.data?.count ?? -1
        self.characters = dto.data?.results?
            .map { CharacterViewModel($0) } ?? []
    }
}

struct CharacterViewModel {
    let characterID: Int
    let name: String
    let description: String?
    let thumbnail: ThumbnailViewModel?
    let resourceURI: String?
    let comics: ItemViewModel
    let series: ItemViewModel
    let event: ItemViewModel
    let urls: [URLTypeViewModel]
    
    init(_ dto: CharactersResult) {
        self.characterID = dto.id ?? UUID().hashValue
        self.name = dto.name ?? ""
        self.description = dto.resultDescription
        self.thumbnail = ThumbnailViewModel(dto.thumbnail)
        self.resourceURI = dto.resourceURI
        self.comics = ItemViewModel(dto.comics)
        self.series = ItemViewModel(dto.series)
        self.event = ItemViewModel(dto.events)
        self.urls = dto.urls?.map { URLTypeViewModel($0) } ?? []
    }
}

struct ItemViewModel {
    let available: Int?
    let collectionURI: String?
    let items: [ItemDetailViewModel]
    
    init(_ dto: Comics?) {
        self.available = dto?.available
        self.collectionURI = dto?.collectionURI
        self.items = dto?.items?.map { ItemDetailViewModel($0) } ?? []
    }
}

struct ItemDetailViewModel {
    let resourceURI: String?
    let name: String?
    let type: String?
    
    init(_ dto: ComicsItem?) {
        self.resourceURI = dto?.resourceURI
        self.name = dto?.name
        self.type = nil
    }
}

struct ThumbnailViewModel {
    let path: String
    let thumbnailExtension: String
    
    init(_ dto: Thumbnail?) {
        self.path = dto?.path ?? ""
        self.thumbnailExtension = dto?.thumbnailExtension ?? ""
    }
    
    var imageURL: String {
        return path + "." + thumbnailExtension
    }
}

struct StoriesItemViewModel {
    let resourceURI: String?
    let name: String?
    let type: String?
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

struct URLTypeViewModel {
    let type: URLType?
    let url: String?
    
    init(_ dto: URLElement?) {
        self.type = URLType(rawValue: dto?.type ?? "")
        self.url = dto?.url ?? ""
    }
}
