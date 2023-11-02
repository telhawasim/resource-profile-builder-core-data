//
//  Designation.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 30/10/2023.
//

import Foundation
import UIKit
import RealmSwift

class Designation: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var designation: String
    
    convenience init(designation: String) {
        self.init()
        self.designation = designation
    }
}
