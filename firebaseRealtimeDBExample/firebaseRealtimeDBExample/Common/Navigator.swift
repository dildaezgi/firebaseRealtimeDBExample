//
//  Navigator.swift
//  firebaseRealtimeDBExample
//
//  Created by Dilda Ezgi Metincan on 14.02.2023.
//

import Foundation
import UIKit

class Navigator: UINavigationController {
    var navController: UINavigationController?
    
    func navigateTo(_ viewController: UIViewController, animated: Bool) {
        navController?.pushViewController(viewController, animated: animated)
    }
    
    func back(animated: Bool) {
        navController?.popViewController(animated: animated)
    }
}
