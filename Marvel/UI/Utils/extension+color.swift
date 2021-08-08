//
//  extension+color.swift
//  Marvel
//
//  Created by Margaret López Calderón on 7/8/21.
//

import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0...255),
                       green: CGFloat.random(in: 0...255),
                       blue: CGFloat.random(in: 0...255),
                       alpha: 1)
    }
}
