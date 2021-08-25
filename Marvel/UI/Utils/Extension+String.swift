//
//  Extension+String.swift
//  Marvel
//
//  Created by Margaret López Calderón on 25/8/21.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
