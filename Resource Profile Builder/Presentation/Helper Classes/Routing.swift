//
//  Routing.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 29/10/2023.
//

import Foundation
import UIKit

class Routing {
    
    static var shared = Routing()
    
    private init() {}
    
    //MARK: - NAVIGATE TO HOME SCREEN -
    func navigateToHomeScreen(navigationController: UINavigationController?) {
        let vc = UIStoryboard.getVC(from: .main, HomeViewController.className)
        navigationController?.pushViewController(vc, animated: true)
    }
}
