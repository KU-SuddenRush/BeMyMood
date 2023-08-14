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
    
    
    
    //무드보드 선택 컬러
    static let color0 = UIColor(hex: "#6C6C6C")
    static let color1 = UIColor(hex: "#393939")
    static let color2 = UIColor(hex: "#000000")
    static let color3 = UIColor(hex: "#BEBEBE")
    static let color4 = UIColor(hex: "#FFFFFF")
    static let color5 = UIColor(hex: "#FF5252")
    static let color6 = UIColor(hex: "#FFDA59")
    static let color7 = UIColor(hex: "#45E87C")
    static let color8 = UIColor(hex: "#5690FF")
    static let color9 = UIColor(hex: "#FF70E8")
    static let color10 = UIColor(hex: "#8E0DA3")
    
    static let colorList : [UIColor] = [color0,color1,color2,color3,color4,color5,color6,color7,color8,color9,color10]
}
