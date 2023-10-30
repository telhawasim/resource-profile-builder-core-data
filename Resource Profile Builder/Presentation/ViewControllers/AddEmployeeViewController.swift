//
//  AddEmployeeViewController.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 30/10/2023.
//

import UIKit
import IQKeyboardManager
import FlagPhoneNumber

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
    var designations = DesignationModel.getDesignation()
    var departments = DesignationModel.getDepartment()
    var isPhoneValid: Bool = false
    var phoneNumber: String?
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    
    //MARK: - LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTextFields()
        self.configurePicker()
        self.initialisePhoneNumber()
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
        }
    }
    
    //MARK: - BUTTON ADD EMPLOYEE -
    @IBAction func btnAddEmployee(_ sender: Any) {
        
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
    func validation() {
        
    }
    
    //MARK: - DONE BUTTON CLICKED FOR DOB PICKER -
    @objc func tapDoneDOB() {
        guard let datePicker = self.txtDateOfBirth?.inputView as? UIDatePicker else { return }
        let date = datePicker.date
        if !date.is18Plus() {
            self.txtDateOfBirth.text = nil
            Utilities.shared.showAlert(title: "Erro", message: "Employee must be 18+", viewController: self)
            return
        }
        
        self.txtDateOfBirth.text = date.getFormattedDate(format: DateFormat.eeee_mmm_d_yyyy)
        self.txtDateOfBirth.resignFirstResponder()
    }
    
    //MARK: - DONE BUTTON CLICKED FOR UIPICKERVIEW -
    @objc func doneButtonClicked(_ sender: UITextField) {
        if sender == txtDesignation {
            self.txtDesignation.text = self.designations[designationPicker.selectedRow(inComponent: 0)].name
        } else {
            self.txtDepartment.text = self.departments[departmentPicker.selectedRow(inComponent: 0)].name
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
            return designations[row].name
        } else {
            return departments[row].name
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
        listController.title = "Countries"
        
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
