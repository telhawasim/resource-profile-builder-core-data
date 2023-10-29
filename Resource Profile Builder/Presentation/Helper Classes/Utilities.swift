//
//  Utilities.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 29/10/2023.
//

import Foundation
import UIKit

class Utilities {
    
    static var shared = Utilities()
    
    private init () {}
    
    //MARK: - SHOW ALERT -
    func showAlert(title: String, message: String, preferredStyle: UIAlertController.Style = .alert, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }

}
