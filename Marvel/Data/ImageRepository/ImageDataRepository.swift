//
//  ImageDataRepository.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import UIKit
import Foundation

final class ImageDataRepository {
    static let shared = ImageDataRepository()
    private var loadingResponses = [NSURL: [(CharacterRepresentableViewModel, UIImage?) -> Swift.Void]]()
    private var imageCache = ImageCache()
    private var imageNetworking = ImageNetworking()

    func load(url: NSURL, item: CharacterRepresentableViewModel, completion: @escaping (CharacterRepresentableViewModel, UIImage?) -> Swift.Void) {
        
        if let image = self.imageCache.load(url: url, item: item) {
            DispatchQueue.main.async {
                completion(item, image)
            }
            return
        }
        
        if self.loadingResponses[url] != nil {
            self.loadingResponses[url]?.append(completion)
        } else {
            self.loadingResponses[url] = [completion]
        }
        
        self.imageNetworking.load(url: url, item: item, loadingResponses: self.loadingResponses, cache: imageCache, completion: completion)
    }
}
