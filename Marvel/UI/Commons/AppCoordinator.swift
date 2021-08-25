//
//  AppCoordinator.swift
//  Marvel
//
//  Created by Margaret López Calderón on 8/8/21.
//

import Foundation
import UIKit
import CoreData

protocol Coordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
}
