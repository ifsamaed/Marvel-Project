//
//  extension+image.swift
//  Marvel
//
//  Created by Margaret López Calderón on 14/8/21.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL, for item: CharacterRepresentableViewModel, completion: @escaping () -> Void) {
        UIImageLoader.share.load(url, item: item, for: self, completion: completion)
    }
    
    func cancelImageLoad() {
        UIImageLoader.share.cancel(for: self)
    }
}
