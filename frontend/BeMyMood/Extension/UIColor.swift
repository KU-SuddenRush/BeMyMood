//
//  UIColor.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/07.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
    
    static let grayBeige = UIColor(hex:"#EAE9E5")
    static let orange = UIColor(hex:"#FF8A00")
    static let black_50 = UIColor(hex:"#808080")
    static let black_30 = UIColor(hex:"#B3B3B3")
    static let darkBrown_30 = UIColor(hex: "#DAD9D6")
    static let darkBrown_50 = UIColor(hex: "#BAB9B8")
    static let darkBrown_80 = UIColor(hex: "#999999")
    static let darkBrown = UIColor(hex: "#595352")
}
