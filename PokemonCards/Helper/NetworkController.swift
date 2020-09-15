//
//  NetworkController.swift
//  PokemonCards
//
//  Created by a.a.mitrofanova on 14/09/2020.
//  Copyright © 2020 mngey. All rights reserved.
//

import Foundation


class NetworkController {
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Delete = "DELETE"
    }
    
    static func performRequest(for url: URL,
                            httpMethod: HTTPMethod,
                         urlParameters: [String : String]? = nil,
                                  body: Data? = nil,
                            completion: ((Data?, Error?) -> Void)? = nil){
        let requestURL = self.url(byAdding: urlParameters, to: url)
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion?(data, error)
            
        }
        dataTask.resume()
        
    }
    static func url(byAdding parameters: [String : String]?, to url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.compactMap{
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = components?.url else{
            fatalError("URL comp is nil")
        }
        return url
        
    }
    
    
}
