//
//  Constants.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 30/10/2023.
//

import Foundation

struct DateFormat {
    static var yy_mm_dd = "yy-MM-dd"
    static let dateFormatyyyMMddTZHHmmss = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static var yyyy_mm_dd = "yyyy-MM-dd"
    static var MMM_yyyy = "MMM yyyy"
    static var eeee_mmm_d_yyyy = "EEEE MMM d, yyyy"
}

struct ArrayConstant {
    static let designations = ["Intern", "Associate Software Engineer", "Software Engineer", "Senior Software Engineer", "Team Lead", "Principal Software Engineer"]
    static let departments = ["Engineering", "Finance", "HR", "Corporate", "Manager"]
}

struct StringConstants {
    static let error = "Error"
    static let countries = "Countries"
}

struct ErrorMessages {
    static let employeeIsNot18Plus = "Employee must be 18+"
    static let nameEmptyError = "Name cannot be empty"
    static let designationEmptyError = "Designation cannot be empty"
    static let departmentEmptyError = "Department cannot be empty"
    static let dateOfBirthEmptyError = "Date of Birth cannot be empty"
    static let emailEmptyError = "Email cannot be empty"
    static let emailValidationError = "Email must be valid"
    static let phoneNumberEmptyError = "Phone number cannot be empty"
    static let phoneNumberValidationError = "Phone number must be valid"
    static let dateOfJoiningEmptyError = "Date of joining cannot be empty"
    static let imageEmptyError = "Image cannot be empty"
}

struct ImageConstants {
    static let imagePlaceHolder = "image_placeholder"
}
