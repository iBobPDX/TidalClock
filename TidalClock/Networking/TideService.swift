//
//  TideService.swift
//  TidalClock
//
//  Created by Robert Corlett on 12/8/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import Foundation

final class TideService {
    private let client = HttpClient(baseUrl: "https://tidesandcurrents.noaa.gov/api", responseParser: TideResponseParser())
    
    func loadTideData(completion: @escaping (Tide?, Error?) -> ()) -> URLSessionDataTask? {
        let params: JSON = [
            "date"          : "latest",
            "station"       : "8452660",
            "product"       : "water_level",
            "datum"         : "MLLW",
            "units"         : "english",
            "time_zone"     : "gmt",
            "application"   : "tidal_clock-corlettdotrobertatgmaildotcom",
            "format"        : "json"
        ]
        
        return client.load(path: "/datagetter", method: .get, params: params) { (result, error) in
            let dict = result as? JSON
            completion(dict.flatMap(Tide.init), error) // Inflate and return models from parsed json
        }
        
    }
}
