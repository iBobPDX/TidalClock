//
//  ResponseParser.swift
//  TidalClock
//
//  Created by Robert Corlett on 12/8/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import Foundation

enum TideLevelError: Error {
    case DeserializationError
    case JsonParseError
}

protocol ResponseParser {
    func parseData(data: Data, error: inout TideLevelError?) -> JSON?
}

struct TideResponseParser: ResponseParser {
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    func parseData(data: Data, error: inout TideLevelError?) -> JSON? {
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
            print("Error converting data to JSON")
            error = .DeserializationError
            return nil
        }
        
        guard let tideArray = json?["data"] as? [[String : Any]], let tideData = tideArray.first, let heightString = tideData["v"] as? String, let dateString = tideData["t"] as? String else {
            print("Error parsing data from json")
            error = .JsonParseError
            return nil
        }
        
        guard let height = Float(heightString), let date = dateFormatter.date(from: dateString) else {
            print("Error parsing data from json")
            error = .JsonParseError
            return nil
        }
            
            
        return ["level" : height, "lastUpdated" : date]
    }
}
