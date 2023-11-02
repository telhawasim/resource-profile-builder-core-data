//
//  Department.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 01/11/2023.
//

import Foundation
import RealmSwift

class Department: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var department: String
    
    convenience init(department: String) {
        self.init()
        self.department = department
    }
}
