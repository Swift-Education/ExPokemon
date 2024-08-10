//
//  UIColor+DesignSystem.swift
//  ExPokemon
//
//  Created by 강동영 on 8/10/24.
//

import UIKit

struct PokeColor {
    static let pokeBackgroundColor = UIColor(r: 160, g: 58, b: 54, alpha: 1.0)
    static let detailBackgroundColor = UIColor(r: 102, g: 42, b: 37, alpha: 1.0)
}

extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexCodeFomatted: String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexCodeFomatted.hasPrefix("#") {
            hexCodeFomatted = String(hexCodeFomatted.dropFirst())
        }
        
        assert(hexCodeFomatted.count == 6, "Invalid hex code used")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexCodeFomatted).scanHexInt64(&rgbValue)
        
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat((rgbValue & 0x0000FF)) / 255.0,
            alpha: alpha
        )
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(
            red: r / 255,
            green: g / 255,
            blue: b / 255,
            alpha: alpha
        )
    }
}
