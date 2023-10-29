//
//  UIStoryboard+Ext.swift
//  Resource Profile Builder
//
//  Created by Telha Wasim on 29/10/2023.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    // MARK: Generic Public/Instance Methods
    func loadViewController(withIdentifier identifier: String) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier)
    }

    // MARK: Class Methods to load Storyboards
    class func storyBoard(withName name: StoryboardType) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue, bundle: Bundle.main)
    }

    class func storyBoard(withTextName name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle.main)
    }

    class func getVC(from: StoryboardType, _ name: String) -> UIViewController {
        return UIStoryboard(name: from.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: name)
    }
}
