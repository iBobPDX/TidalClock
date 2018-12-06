//
//  LightHouse.swift
//  TidalClock
//
//  Created by Robert Corlett on 12/6/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import Foundation
import UIKit

struct LightHouse {
    static let blue = UIColor(rgb: 0x00ADFF)
    static let black = UIColor(rgb: 0x000000)
    static let gray = UIColor(rgb: 0xCFCFCF)
    static let red = UIColor(rgb: 0xA22208)
    static let yellow = UIColor(rgb: 0xDCD41C)
    static let lightYellow = UIColor(rgb: 0xfcf34b)
    
    static let scene: [[UIColor?]] = [
/*      0       1       2       3       4       5       6       7       8       9       10      11      12      13      14      15  */
/* 0 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    yellow, yellow, yellow, yellow, yellow, yellow, yellow],
/* 1 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    yellow, yellow, yellow, yellow, yellow, yellow],
/* 2 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    yellow, yellow, yellow, yellow, yellow],
/* 3 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    yellow, yellow, yellow, yellow],
/* 4 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    yellow, yellow, yellow],
/* 5 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    yellow, yellow],
/* 6 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    yellow],
/* 7 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil],
/* 8 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil],
/* 9 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil],
/*10 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil],
/*11 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil],
/*12 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil],
/*13 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil],
/*14 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil],
/*15 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil],
/*16 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    gray,   gray,   nil,    nil,    nil],
/*17 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    gray,   gray,   gray,   gray,   nil,    nil],
/*18 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    yellow, yellow, nil,    nil,    nil],
/*19 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    yellow, yellow, nil,    nil,    nil],
/*20 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    gray,   gray,   gray,   gray,   nil,    nil],
/*21 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    red,    red,    red,    red,    nil,    nil],
/*22 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    gray,   gray,   gray,   gray,   nil,    nil],
/*23 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    gray,   gray,   gray,   gray,   nil,    nil],
/*24 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    red,    red,    red,    red,    nil,    nil],
/*25 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    gray,   gray,   gray,   gray,   nil,    nil],
/*26 */ [nil,   nil,    nil,     nil,    nil,    nil,    nil,    nil,    nil,    gray,   gray,   gray,   gray,   gray,   gray,   nil],
/*27 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    nil,    red,    red,    red,    red,    red,    red,    nil],
/*28 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    nil,    gray,   gray,   gray,   gray,   gray,   gray,   gray,   gray],
/*29 */ [nil,   nil,    nil,    nil,    nil,    nil,    nil,    black,  black,  black,  black,  black,  black,  black,  black,  black],
/*30 */ [nil,   nil,    nil,    nil,    black,  black,  black,  black,  black,  black,  black,  black,  black,  black,  black,  black],
/*31 */ [nil,   nil,    nil,    nil,    black,  black,  black,  black,  black,  black,  black,  black,  black,  black,  black,  black],
]
}
