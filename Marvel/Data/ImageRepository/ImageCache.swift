//
//  ImageCache.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import UIKit

final class ImageCache {
    private let cachedImages = NSCache<NSURL, UIImage>()
    
    func setImage(_ image: UIImage, url: NSURL, responseData: Data) {
        cachedImages.setObject(image, forKey: url, cost: responseData.count)
    }
    
    func load(url: NSURL, item: CharacterRepresentableViewModel) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
}
