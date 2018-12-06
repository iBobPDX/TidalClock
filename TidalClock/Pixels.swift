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
    var pixelArray: [[UIColor?]] = LightHouse.scene
//    var lightTimer: Timer?
    
    func setColor(_ color: UIColor, forItemAt indexPath: IndexPath) {
        pixelArray[indexPath.section][indexPath.row] = color
    }
    
    func setWaterLevel(_ level: TideLevel, _ completion: @escaping () -> Void) {
        pixelArray = LightHouse.scene
        
        guard let height = level.waterHeight, height > 0.5 else {
            completion()
            return
        }
        
        let bars = waterBarsForLevel(height)
        
        for l in 1...bars {
            pixelArray[pixelArray.count - l] = pixelArray[pixelArray.count - l].map { (color) -> UIColor in
                return LightHouse.blue
            }
        }
        
        completion()
    }
    
    func waterBarsForLevel(_ level: Float) -> Int {
        print("Tide Level = \(level)")
        let bars = Int(ceil(level))
        print("Water Bars = \(bars)")
        return bars
    }
    
//    func flashLight(_ completion: @escaping () -> Void) {
//        if let t = lightTimer {
//            t.invalidate()
//            lightTimer = nil
//            return
//        }
//
//        lightTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
//            self?.pixelArray[18][11] = (self?.pixelArray[18][11] == Pixels.lightYellow) ? Pixels.yellow : Pixels.lightYellow
//            self?.pixelArray[18][12] = (self?.pixelArray[18][12] == Pixels.lightYellow) ? Pixels.yellow : Pixels.lightYellow
//            self?.pixelArray[19][11] = (self?.pixelArray[19][11] == Pixels.lightYellow) ? Pixels.yellow : Pixels.lightYellow
//            self?.pixelArray[19][12] = (self?.pixelArray[19][12] == Pixels.lightYellow) ? Pixels.yellow : Pixels.lightYellow
//            completion()
//        }
//    }
}
