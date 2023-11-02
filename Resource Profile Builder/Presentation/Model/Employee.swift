//
//  Employee.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 01/11/2023.
//

import Foundation
import RealmSwift

class Employee: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var designation: Designation?
    @Persisted var department: Department?
    @Persisted var dob: String = ""
    @Persisted var email: String = ""
    @Persisted var phoneNumber: String = ""
    @Persisted var dateOfJoining: String = ""
    @Persisted var profilePicture: String = ""
    
    convenience init(name: String, designation: Designation, department: Department, dob: String, email: String, phoneNumber: String, dateOfJoining: String, profilePicture: String) {
        self.init()
        self.name = name
        self.designation = designation
        self.department = department
        self.dob = dob
        self.email = email
        self.phoneNumber = phoneNumber
        self.dateOfJoining = dateOfJoining
        self.profilePicture = profilePicture
    }
}
