//
//  TideLevel.swift
//  TidalClock
//
//  Created by Robert Corlett on 12/6/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import Foundation

enum TideLevelError: Error {
    case DeserializationError
    case JsonParseError
}

struct TideLevel {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    var waterHeight: Float? = nil
    var updatedAt: Date? = nil
    var parseError: TideLevelError? = nil
    
    init(_ data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
            print("Error converting data to JSON")
            parseError = .DeserializationError
            return
        }
        
        guard let tideArray = json?["data"] as? [[String : Any]], let tideData = tideArray.first, let heightString = tideData["v"] as? String, let dateString = tideData["t"] as? String else {
            print("Error parsing data from json")
            parseError = .JsonParseError
            return
        }
        
        
        waterHeight = Float(heightString)
        updatedAt = dateFormatter.date(from: dateString)
    }
}
