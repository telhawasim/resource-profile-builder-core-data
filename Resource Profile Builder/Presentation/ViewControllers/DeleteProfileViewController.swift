//
//  DeleteProfileViewController.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 02/11/2023.
//

import UIKit

protocol DeleteProfileProtocol {
    func deleteEmployee()
}

class DeleteProfileViewController: UIViewController {
    
    //MARK: - VARIABLES -
    var delegate: DeleteProfileProtocol?
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - BUTTON BACK PRESSED -
    @IBAction func btnBackPressed(_ sender: Any) {
        Routing.shared.dismiss(viewController: self)
    }
    
    //MARK: - BUTTON NO PRESSED -
    @IBAction func btnNoPressed(_ sender: Any) {
        Routing.shared.dismiss(viewController: self)
    }
    
    //MARK: - BUTTON YES PRESSED -
    @IBAction func btnYesPressed(_ sender: Any) {
        Routing.shared.dismiss(viewController: self)
        self.delegate?.deleteEmployee()
    }
    
}
