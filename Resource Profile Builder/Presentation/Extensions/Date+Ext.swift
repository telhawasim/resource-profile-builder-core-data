//
//  Date+Ext.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 30/10/2023.
//

import Foundation
import UIKit

extension Date {
    
    func is18Plus() -> Bool {
        let dateOfBirth = self
        let today = Date()
        guard let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian) else {return false}
        
        let age = gregorian.components(.year, from: dateOfBirth, to: today)
        if let year = age.year, year < 18 {
            return false
        }
        
        return true
    }
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
