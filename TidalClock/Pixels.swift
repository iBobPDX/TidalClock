//
//  Pixels.swift
//  CollectionView
//
//  Created by Robert Corlett on 12/5/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import Foundation
import UIKit

protocol DisplayDelegate: class {
    func didUpdatePixels()
}

class Pixels {
    var pixelArray: [[UIColor?]] = LightHouse.scene
    var lightTimer: Timer?
    weak var delegate: DisplayDelegate?
    
    func setColor(_ color: UIColor, forItemAt indexPath: IndexPath) {
        pixelArray[indexPath.section][indexPath.row] = color
    }
    
    func setWaterLevel(_ level: TideLevel) {
        flashLight(5)
        pixelArray = LightHouse.scene
        
        guard let height = level.waterHeight, height > 0.5 else {
            self.delegate?.didUpdatePixels()
            return
        }
        
        let bars = waterBarsForLevel(height)
        
        for l in 1...bars {
            let index = self.pixelArray.count - l
            self.pixelArray[index] = self.pixelArray[index].map { (color) -> UIColor in
                return LightHouse.blue
            }
        }
        
        self.delegate?.didUpdatePixels()
    }
    
    func waterBarsForLevel(_ level: Float) -> Int {
        print("Tide Level = \(level)")
        let bars = Int(ceil(level))
        print("Water Bars = \(bars)")
        return bars
    }
    
    func flashLight(_ seconds: Int) {
        DispatchQueue.main.async {
            self.startFlashingLight()
        
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds)) {
                self.stopFlashingLight()
            }
        }
    }
    
    func startFlashingLight() {
        if let _ = lightTimer {
            stopFlashingLight()
        }

        lightTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] (timer) in
            print("timer fired")
            if let strongSelf = self {
                strongSelf.lampIsLit() ? strongSelf.dimLamp() : strongSelf.lightLamp()
                strongSelf.delegate?.didUpdatePixels()
            }
        }
    }
    
    func stopFlashingLight() {
        lightTimer?.invalidate()
        lightTimer = nil
    }
    
    // This is total nonsense. Should prob think about this for 5 min sometime
    func lightLamp() {
        self.pixelArray[18][11] = LightHouse.lightYellow
        self.pixelArray[18][12] = LightHouse.lightYellow
        self.pixelArray[19][11] = LightHouse.lightYellow
        self.pixelArray[19][12] = LightHouse.lightYellow
    }
    
    func dimLamp() {
        self.pixelArray[18][11] = LightHouse.yellow
        self.pixelArray[18][12] = LightHouse.yellow
        self.pixelArray[19][11] = LightHouse.yellow
        self.pixelArray[19][12] = LightHouse.yellow
    }
    
    func lampIsLit() -> Bool {
        return self.pixelArray[18][11] == LightHouse.lightYellow
    }
}
