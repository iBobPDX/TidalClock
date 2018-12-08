//
//  HttpClient.swift
//  TidalClock
//
//  Created by Robert Corlett on 12/8/18.
//  Copyright © 2018 Robert Corlett. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
}

final class HttpClient {
    private var baseUrl: String
    private var responseParser: ResponseParser
    
    init(baseUrl: String, responseParser: ResponseParser) {
        self.baseUrl = baseUrl
        self.responseParser = responseParser
    }
    
    func load(path: String, method: RequestMethod, params: JSON, completion: @escaping (Any?, Error?) -> ()) -> URLSessionDataTask? {
        // Maybe check for network connectivity here?
        
        let request = URLRequest(baseUrl: baseUrl, path: path, params: params, method: method)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
            var object: Any? = nil
            var tideLevelError: TideLevelError? = nil
            if let data = data {
                object = self.responseParser.parseData(data: data, error: &tideLevelError)
            }
            
            if error == nil {
                completion(object, nil)
            } else {
                completion(nil, error)
            }
        }
        
        task.resume()
        
        return task
    }
}


extension URL {
    init(baseUrl: String, path: String, params: JSON, method: RequestMethod) {
        var components = URLComponents(string: baseUrl)! //force unwrap?
        components.path += path
        switch method {
        case .get:
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        }
        
        self = components.url! //force unwrap?
    }
}

extension URLRequest {
    init(baseUrl: String, path: String, params: JSON, method: RequestMethod) {
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
