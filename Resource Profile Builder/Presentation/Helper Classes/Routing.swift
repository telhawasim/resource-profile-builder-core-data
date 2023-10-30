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
    
    //MARK: - POP VIEW CONTROLLER -
    func pop(navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - NAVIGATE TO HOME SCREEN -
    func navigateToHomeScreen(navigationController: UINavigationController?) {
        let vc = UIStoryboard.getVC(from: .main, HomeViewController.className)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - NAVIGATE TO ADD EMPLOYEES -
    func navigateToAddEmployee(navigationController: UINavigationController?) {
        let vc = UIStoryboard.getVC(from: .main, AddEmployeeViewController.className)
        navigationController?.pushViewController(vc, animated: true)
    }
}
