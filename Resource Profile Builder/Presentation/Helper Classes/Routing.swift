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
    
    //MARK: - DISMISS VIEW CONTROLLER -
    func dismiss(viewController: UIViewController?) {
        viewController?.dismiss(animated: true)
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
    
    //MARK: - NAVIGATE TO PROFILE -
    func navigateToProfile(navigationController: UINavigationController?, employee: Employee?) {
        let vc = UIStoryboard.getVC(from: .main, ProfileViewController.className) as! ProfileViewController
        vc.employee = employee
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - NAVIGATE TO DELETE EMPLOYEE POPUP -
    func navigateToDeletePopUp(viewController: UIViewController) {
        let vc = UIStoryboard.getVC(from: .main, DeleteProfileViewController.className) as! DeleteProfileViewController
        vc.delegate = (viewController as! any DeleteProfileProtocol)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        viewController.present(vc, animated: true)
    }
}
