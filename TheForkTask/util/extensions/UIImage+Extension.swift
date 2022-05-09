//
//  UIImage+Extension.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//


import UIKit

extension UIImage {
    
    @nonobjc class var placeholderImage: UIImage? {
        return UIImage(named: "placeholder_image")
    }
    
    @nonobjc class var filledHeartIcon: UIImage? {
        return UIImage(named: "filled_heart_icon")
    }
    
    @nonobjc class var emptyHeartIcon: UIImage? {
        return UIImage(named: "empty_heart_icon")
    }
}
