//
//  AddEmployeeViewController.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 30/10/2023.
//

import UIKit
import IQKeyboardManager
import FlagPhoneNumber
import RealmSwift

class AddEmployeeViewController: UIViewController {
    
    //MARK: - OUTLETS -
    
    //UIImageView
    @IBOutlet weak var profileImage: UIImageView!
    //UITextField
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    @IBOutlet weak var txtDepartment: UITextField!
    @IBOutlet weak var txtDateOfBirth: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: FPNTextField!
    @IBOutlet weak var txtDateOfJoining: UITextField!
    
    //MARK: - VARIABLES -
    var designationPicker = UIPickerView()
    var departmentPicker = UIPickerView()
    var designations: [Designation] = []
    var departments: [Department] = []
    var isPhoneValid: Bool = false
    var phoneNumber: String?
    var image: String?
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTextFields()
        self.configurePicker()
        self.initialisePhoneNumber()
        self.setDesignation()
        self.setDepartment()
    }
    
    //MARK: - BACK BUTTON PRESSED -
    @IBAction func btnBackPressed(_ sender: Any) {
        Routing.shared.pop(navigationController: self.navigationController)
    }
    
    //MARK: - BUTTON CAMERA PRESSED -
    @IBAction func btnCameraPressed(_ sender: Any) {
        CameraHandler.shared.showActionSheet(viewC: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.profileImage?.image = image
            self.image = image.toJpegString(compressionQuality: 0.5)
        }
    }
    
    //MARK: - BUTTON ADD EMPLOYEE -
    @IBAction func btnAddEmployee(_ sender: Any) {
        if validation() {
            self.setEmployee()
        }
    }
}

//MARK: - FUNCTIONS -
extension AddEmployeeViewController {
    
    //MARK: - CONFIGURE TEXTFIELDS -
    func configureTextFields() {
        self.txtDesignation.inputView = designationPicker
        self.txtDepartment.inputView = departmentPicker
        self.txtDesignation?.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        self.txtDepartment?.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        self.txtDateOfBirth.setInputViewDatePicker(target: self, selector: #selector(tapDoneDOB))
        self.txtDateOfJoining.setInputViewDatePicker(target: self, selector: #selector(tabDoneJoining))
    }
    
    //MARK: - CONFIGURE PICKER -
    func configurePicker() {
        self.designationPicker.delegate = self
        self.departmentPicker.delegate = self
    }
    
    //MARK: - INITIALIZE PHONE NUMBER -
    func initialisePhoneNumber() {
        guard let txtPhone = self.txtPhone else {
            return
        }
        
        txtPhone.delegate = self
        txtPhone.tintColor = UIColor.appColor
        txtPhone.setFlag(key: .PK)
        txtPhone.displayMode = .list
        listController.setup(repository: txtPhone.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.txtPhone?.setFlag(countryCode: country.code)
        }
    }
    
    //MARK: - VALIDATION -
    func validation() -> Bool {
        var errorMessage: String?
        
        if txtName.text == "" {
            errorMessage = ErrorMessages.nameEmptyError
        } else if txtDesignation.text == "" {
            errorMessage = ErrorMessages.designationEmptyError
        } else if txtDepartment.text == "" {
            errorMessage = ErrorMessages.departmentEmptyError
        } else if txtDateOfBirth.text == "" {
            errorMessage = ErrorMessages.dateOfBirthEmptyError
        } else if txtEmail.text == "" {
            errorMessage = ErrorMessages.emailEmptyError
        } else if !txtEmail.isEmailValid() {
            errorMessage = ErrorMessages.emailValidationError
        } else if txtPhone.text == "" {
            errorMessage = ErrorMessages.phoneNumberEmptyError
        } else if !isPhoneValid {
            errorMessage = ErrorMessages.phoneNumberValidationError
        } else if txtDateOfJoining.text == "" {
            errorMessage = ErrorMessages.dateOfJoiningEmptyError
        } else if profileImage.image == UIImage(named: ImageConstants.imagePlaceHolder) {
            errorMessage = ErrorMessages.imageEmptyError
        }
        
        if let error = errorMessage {
            Utilities.shared.showAlert(title: StringConstants.error, message: error, viewController: self)
            return false
        }
        
        return true
    }
    
    //MARK: - DONE BUTTON CLICKED FOR DOB PICKER -
    @objc func tapDoneDOB() {
        guard let datePicker = self.txtDateOfBirth?.inputView as? UIDatePicker else { return }
        let date = datePicker.date
        if !date.is18Plus() {
            self.txtDateOfBirth.text = nil
            Utilities.shared.showAlert(title: StringConstants.error, message: ErrorMessages.employeeIsNot18Plus, viewController: self)
            return
        }
        
        self.txtDateOfBirth.text = date.getFormattedDate(format: DateFormat.eeee_mmm_d_yyyy)
        self.txtDateOfBirth.resignFirstResponder()
    }
    
    //MARK: - DONE BUTTON CLICKED FOR UIPICKERVIEW -
    @objc func doneButtonClicked(_ sender: UITextField) {
        if sender == txtDesignation {
            self.txtDesignation.text = self.designations[designationPicker.selectedRow(inComponent: 0)].designation
        } else {
            self.txtDepartment.text = self.departments[departmentPicker.selectedRow(inComponent: 0)].department
        }
    }
    
    //MARK: - DON BUTTON FOR DATE PICKER -
    @objc func tabDoneJoining() {
        guard let datePicker = self.txtDateOfJoining?.inputView as? UIDatePicker else { return }
        let date = datePicker.date
        self.txtDateOfJoining?.text = date.getFormattedDate(format: DateFormat.eeee_mmm_d_yyyy)
        self.txtDateOfJoining?.resignFirstResponder()
    }
}

//MARK: - UIPICKERVIEW DELEGATE METHODS -
extension AddEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == designationPicker {
            return designations.count
        } else {
            return departments.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == designationPicker {
            return designations[row].designation
        } else {
            return departments[row].department
        }
    }
}

//MARK: - FPNTEXTFIELD DELEGATE METHODS -
extension AddEmployeeViewController: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
//        self.selectedCountryCode = code
    }
    
    func fpnDisplayCountryList() {
        _ = UINavigationController(rootViewController: listController)
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(dismissCountries))
        
        listController.navigationItem.leftBarButtonItem = leftButton
        listController.title = StringConstants.countries
        
        self.present(self.navigationController!, animated: true, completion: nil)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        isPhoneValid = isValid
        if isValid {
            self.phoneNumber = textField.getFormattedPhoneNumber(format: .E164) ?? ""
        } else {
            self.phoneNumber = ""
        }
    }
    
    @objc func dismissCountries() {
        listController.dismiss(animated: true, completion: nil)
    }
}

//MARK: - REALMS IMPLEMENTATION -
extension AddEmployeeViewController {
    
    //MARK: - CHECK IF DESIGNATION IS EMPTY OR NOT -
    func setDesignation() {
        let realm = try! Realm()
        
        if realm.objects(Designation.self).isEmpty {
            
            try! realm.write({
                let defaultDesignations = ArrayConstant.designations
                
                for designation in defaultDesignations {
                    let newDesigation = Designation(designation: designation)
                    realm.add(newDesigation)
                }
            })
        }
        self.getDesignations()
    }
    
    //MARK: - GET DESIGNATIONS -
    func getDesignations() {
        let realm = try! Realm()
        let designations = realm.objects(Designation.self)
        
        if self.designations.isEmpty {
            self.designations.append(contentsOf: designations)
        }
    }
    
    //MARK: - CHECK IF DEPARTMENT IS EMPTY OR NOT -
    func setDepartment() {
        let realm = try! Realm()
        
        if realm.objects(Department.self).isEmpty {
            
            try! realm.write({
                let defaultDepartments = ArrayConstant.departments
                
                for department in defaultDepartments {
                    let newDeparment = Department(department: department)
                    realm.add(newDeparment)
                }
            })
        }
        self.getDepartments()
    }
    
    //MARK: - GET DEPARTMENTS -
    func getDepartments() {
        let realm = try! Realm()
        let departments = realm.objects(Department.self)
        
        if self.departments.isEmpty {
            self.departments.append(contentsOf: departments)
        }
    }
    
    
    //MARK: - SET EMPLOYEE DATA -
    func setEmployee() {
        let realm = try! Realm()
        let designation = realm.objects(Designation.self).filter{$0.designation == self.txtDesignation.text}.first
        let department = realm.objects(Department.self).filter{$0.department == self.txtDepartment.text}.first
        
        if let name = self.txtName.text,
           let designation = designation,
           let department = department,
           let dob = self.txtDateOfBirth.text,
           let email = self.txtEmail.text,
           let phoneNumber = self.phoneNumber,
           let dateOfJoining = self.txtDateOfJoining.text,
           let profilePicture = self.image {
            
            try! realm.write({
                let newEmployee = Employee(name: name, designation: designation, department: department, dob: dob, email: email, phoneNumber: phoneNumber, dateOfJoining: dateOfJoining, profilePicture: profilePicture)
                realm.add(newEmployee)
            })
        }
    }
}
