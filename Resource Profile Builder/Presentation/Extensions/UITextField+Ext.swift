//
//  UILabel+Ext.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 29/10/2023.
//

import Foundation
import UIKit

extension UITextField {
    
    func isEmailValid() -> Bool {
        guard let text = self.text else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: text)
    }
}
