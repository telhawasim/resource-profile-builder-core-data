//
//  ViewController.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 29/10/2023.
//

import UIKit
import CoreData
import RealmSwift

class LoginViewController: UIViewController {

    //MARK: - OUTLETS -
    
    //UIButton
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnShowPassword: UIButton!
    //UITextField
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: - VARIABLES -
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()
        self.setupButton()
    }
    
    //MARK: - BUTTON LOGIN PRESSED -
    @IBAction func btnLoginPressed(_ sender: Any) {
        if self.validation() {
            self.fetchAdmin()
        }
    }
    
    //MARK: - BUTTON SHOW PASSWORD PRESSED -
    @IBAction func btnShowPasswordPressed(_ sender: Any) {
        self.showPassword()
    }
}

//MARK: - FUNCTIONS -
extension LoginViewController {
    
    //MARK: - SETUP TEXTFIELDS -
    func setupTextFields() {
        self.txtEmail.addTarget(self, action: #selector(disableButton), for: .editingChanged)
        self.txtPassword.addTarget(self, action: #selector(disableButton), for: .editingChanged)
    }
    
    //MARK: - SETUP BUTTONS -
    func setupButton() {
        self.btnLogin.isEnabled = false
        self.btnLogin.backgroundColor = UIColor.gray
    }
    
    //MARK: - TEXTFIELD VALIDATION -
    func validation() -> Bool {
        var showMessage: String?
        
        if txtEmail.text == "" {
            showMessage = "Email cannot be empty"
        } else if !txtEmail.isEmailValid() {
            showMessage = "Email must be valid"
        } else if txtPassword.text == "" {
            showMessage = "Password cannot be empty"
        }
        
        if let message = showMessage {
            Utilities.shared.showAlert(title: "Error", message: message, viewController: self)
            return false
        }
        return true
    }
    
    //MARK: - SHOW PASSWORD -
    func showPassword() {
        self.txtPassword.isSecureTextEntry.toggle()

        let buttonImage = txtPassword.isSecureTextEntry ? UIImage(named: "hide_password") : UIImage(named: "show_password")
        btnShowPassword.setImage(buttonImage, for: .normal)
    }
    
    //MARK: - CHECK WHETHERE ADMIN EXISTS -
    func adminExist(data: Admin) -> Bool {
        var errorMessage: String?
        
        if txtEmail.text != data.email {
            errorMessage = "User doesn't exist"
        } else if txtPassword.text != data.password {
            errorMessage = "Password is incorrect"
        }
        
        if let message = errorMessage {
            Utilities.shared.showAlert(title: "Error", message: message, viewController: self)
            return false
        }
        
        return true
    }
    
    //MARK: - SAVE DATA IN USER DEFAULTS -
    func saveInUserDefaults() {
        UserSettings.shared.userEmail = self.txtEmail.text
        UserSettings.shared.userPassword = self.txtPassword.text
    }
    
    //MARK: - DISABLE BUTTONS -
    @objc func disableButton() {
        let emailIsEmpty = txtEmail.text?.isEmpty ?? true
        let passwordIsEmpty = txtPassword.text?.isEmpty ?? true
        
        btnLogin.isEnabled = !emailIsEmpty && !passwordIsEmpty
        
        if btnLogin.isEnabled {
            btnLogin.backgroundColor = UIColor.appColor
        } else {
            btnLogin.backgroundColor = UIColor.gray
        }
    }
}

//MARK: - REALMS IMPLEMENTATION -
extension LoginViewController {
    
    //MARK: - FETCH ADMIN DATA -
    func fetchAdmin() {
        let realm = try! Realm()
        let admin = realm.objects(Admin.self)
        
        if admin.count == 0 {
            self.setAdmin()
        } else {
            if self.adminExist(data: admin[0]) {
                self.saveInUserDefaults()
                Routing.shared.navigateToHomeScreen(navigationController: self.navigationController)
            }
        }
    }
    
    //MARK: - SET ADMIN DATA -
    func setAdmin() {
        let realm = try! Realm()
        let admin = Admin(name: "Telha", email: "telhawasim@gmail.com", password: "12344321")
        try! realm.write{
            realm.add(admin)
            self.fetchAdmin()
        }
    }
}

