//
//  Designation.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 30/10/2023.
//

import Foundation
import UIKit

struct DesignationModel {
    var name: String?
    
    static func getDesignation() -> [DesignationModel] {
        let model = [
                DesignationModel(name: "Intern"),
                DesignationModel(name: "Associate Software Engineer"),
                DesignationModel(name: "Software Engineer"),
                DesignationModel(name: "Senior Software Engineer"),
                DesignationModel(name: "Team Lead"),
                DesignationModel(name: "Principal Software Engineer")
        ]
        
        return model
    }
    
    static func getDepartment() -> [DesignationModel] {
        let model = [
            DesignationModel(name: "Engineering"),
            DesignationModel(name: "Finance"),
            DesignationModel(name: "HR"),
            DesignationModel(name: "Corporate"),
            DesignationModel(name: "Managing")
        ]
        
        return model
    }
}
