//
//  String+Ext.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 01/11/2023.
//

import Foundation
import UIKit

extension String {
    
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
