//
//  UIImage+Ext.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 01/11/2023.
//

import Foundation
import UIKit

extension UIImage {
    
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
