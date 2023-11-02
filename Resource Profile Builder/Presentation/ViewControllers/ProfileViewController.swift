//
//  ProfileViewController.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 02/11/2023.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    
    //MARK: - OUTLETS -
    
    //UIImageView
    @IBOutlet weak var imgProfilePicture: UIImageView!
    //UILabel
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    //UITableView
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - VARIABLES -
    var employee: Employee?
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    //MARK: - BACK BUTTON PRESSED -
    @IBAction func btnBackPressed(_ sender: Any) {
        Routing.shared.pop(navigationController: self.navigationController)
    }
    
    //MARK: - ADD RESUME BUTTON PRESSED -
    @IBAction func btnAddResumePressed(_ sender: Any) {
        
    }
    
    //MARK: - BUTTON DELETE EMPLOYEE PRESSED -
    @IBAction func btnDeletePressed(_ sender: Any) {
        Routing.shared.navigateToDeletePopUp(viewController: self)
    }
    
    //MARK: - BUTTON EDIT EMPLOYEE PRESSED -
    @IBAction func btnEditPressed(_ sender: Any) {
        
    }
}

//MARK: - FUNCTIONS -
extension ProfileViewController {
    
    //MARK: - SETUP DATA -
    func setupData() {
        self.imgProfilePicture.image = employee?.profilePicture.toImage()
        self.lblName.text = employee?.name
        self.lblDesignation.text = employee?.designation?.designation
        self.lblEmail.text = employee?.email
    }
}

//MARK: - DELETE PROFILE DELEGATE METHODS -
extension ProfileViewController: DeleteProfileProtocol {
    
    //MARK: - DELETE EMPLOYEE -
    func deleteEmployee() {
        let realm = try! Realm()
        let deleteEmployee = realm.objects(Employee.self).filter{$0._id == self.employee?._id}.first
        
        if let employee = deleteEmployee {
            try! realm.write({
                realm.delete(employee)
                Routing.shared.pop(navigationController: self.navigationController)
            })
        }
    }
    
    
}
