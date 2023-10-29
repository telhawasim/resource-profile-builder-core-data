//
//  NSObject+Ext.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 29/10/2023.
//

import Foundation
import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}
