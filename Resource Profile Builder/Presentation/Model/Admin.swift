//
//  Admin.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 01/11/2023.
//

import Foundation
import RealmSwift

class Admin: Object, Codable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var email: String = ""
    @Persisted var password: String = ""
    
    convenience init(name: String, email: String, password: String) {
        self.init()
        self.name = name
        self.email = email
        self.password = password
    }
}
