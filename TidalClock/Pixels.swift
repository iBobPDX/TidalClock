//
//  Pixels.swift
//  CollectionView
//
//  Created by Robert Corlett on 12/5/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import Foundation
import UIKit

class Pixels {
    static let blue = UIColor(rgb: 0x00ADFF)
    static let black = UIColor(rgb: 0x000000)
    static let gray = UIColor(rgb: 0xCFCFCF)
    static let red = UIColor(rgb: 0xA22208)
    static let yellow = UIColor(rgb: 0xDCD41C)
    
    static let scene: [[UIColor]] = [
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, gray, gray, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, gray, gray, gray, gray, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, yellow, yellow, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, .white, yellow, yellow, .white, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, gray, gray, gray, gray, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, red, red, red, red, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, gray, gray, gray, gray, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, gray, gray, gray, gray, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, red, red, red, red, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, .white, gray, gray, gray, gray, .white, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, gray, gray, gray, gray, gray, gray, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, .white, red, red, red, red, red, red, .white],
        [.white, .white, .white, .white, .white, .white, .white, .white, gray, gray, gray, gray, gray, gray, gray, gray],
        [.white, .white, .white, .white, .white, .white, .white, black, black, black, black, black, black, black, black, black],
        [.white, .white, .white, .white, black, black, black, black, black, black, black, black, black, black, black, black],
        [blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue, blue],
        ]
    
    var pixelArray: [[UIColor]] = scene
    
    func setColor(_ color: UIColor, forItemAt indexPath: IndexPath) {
        pixelArray[indexPath.section][indexPath.row] = color
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
