//
//  Network.swift
//  Library
//
//  Created by Edgar Barocio on 7/23/23.
//

import Foundation

/// Open Library endpoint. Used to generate the search URL. Search is by title only
struct NetworkConstants {
    static let titleSearchURL = "https://openlibrary.org/search.json?title=%@"
}

/// Protocol with the signature for the base service call. Used this to allow for dependency injection
protocol ServiceProtocol {
    func fetchBookSearch(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

class ServiceCalls: ServiceProtocol {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    typealias ServiceResult = (Data?, Error?) -> Void
        
    /**
    Function that uses URL session to perform a search
     
     - Parameters:
        - url: The library search URL 
        - completion: Closure that passes the resulting data, object response and error
     */
    func fetchBookSearch(url: URL, completion: @escaping ServiceResult) {
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            defer {
                self.dataTask = nil
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
            
        }
        
        dataTask?.resume()
    }
}
