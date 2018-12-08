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
    
    func setWaterLevel(_ level: Tide) {
        flashLight(5)
        pixelArray = LightHouse.scene
        
        guard level.waterLevel > 0.5 else {
            self.delegate?.didUpdatePixels()
            return
        }
        
        let bars = waterBarsForLevel(level.waterLevel)
        
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
            if let strongSelf = self {
                strongSelf.lampIsLit() ? strongSelf.dimLamp() : strongSelf.lightLamp()
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
        self.delegate?.didUpdatePixels()
    }
    
    func dimLamp() {
        self.pixelArray[18][11] = LightHouse.yellow
        self.pixelArray[18][12] = LightHouse.yellow
        self.pixelArray[19][11] = LightHouse.yellow
        self.pixelArray[19][12] = LightHouse.yellow
        self.delegate?.didUpdatePixels()
    }
    
    func lampIsLit() -> Bool {
        return self.pixelArray[18][11] == LightHouse.lightYellow
    }
    
    func errorLamp() {
        self.pixelArray[18][11] = .red
        self.pixelArray[18][12] = .red
        self.pixelArray[19][11] = .red
        self.pixelArray[19][12] = .red
        self.delegate?.didUpdatePixels()
    }
}
