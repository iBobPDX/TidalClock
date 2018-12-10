//
//  Tide.swift
//  TidalClock
//
//  Created by Robert Corlett on 12/8/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

struct Tide {
    var waterLevel: Float
    var lastUpdated: Date
}

extension Tide {
    init?(json: JSON) {
        guard let waterLevel = json["level"] as? Float, let lastUpdated = json["lastUpdated"] as? Date else {
            return nil
        }
        
        self.waterLevel = waterLevel
        self.lastUpdated = lastUpdated
    }
}
