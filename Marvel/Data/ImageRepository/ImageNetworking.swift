//
//  ImageDownload.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import Foundation
import UIKit

final class ImageNetworking {
    
    func load(url: NSURL,
              item: CharacterRepresentableViewModel,
              loadingResponses: [NSURL: [(CharacterRepresentableViewModel, UIImage?) -> Swift.Void]],
              cache: ImageCache,
              completion: @escaping (CharacterRepresentableViewModel, UIImage?) -> Void) {
        
        ImageURLProtocol.urlSession().dataTask(with: url as URL) { (data, response, error) in
            guard error == nil,
                  let responseData = data, let image = UIImage(data: responseData),
                  let blocks = loadingResponses[url] else {
                DispatchQueue.main.async {
                    completion(item , nil)
                }
                return
            }
            // Cache the image.
            cache.setImage(image, url: url, responseData: responseData)
            for block in blocks {
                DispatchQueue.main.async {
                    block(item, image)
                }
                return
            }
        }.resume()
        
    }
}
