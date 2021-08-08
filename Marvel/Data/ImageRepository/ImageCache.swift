//
//  ImageCache.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import Foundation
import UIKit

final class ImageCache {
    private let cachedImages = NSCache<NSURL, UIImage>()
    
    func getImage(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    func setImage(_ image: UIImage, url: NSURL, responseData: Data) {
        self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
    }
    
    func load(url: NSURL, item: CharacterRepresentableViewModel) -> UIImage? {
        if let cachedImage = getImage(url: url) {
            return cachedImage
        } else {
            return nil
        }
    }
}
