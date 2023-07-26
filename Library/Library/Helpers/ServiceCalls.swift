//
//  Network.swift
//  Library
//
//  Created by Edgar Barocio on 7/23/23.
//

import Foundation

class ServiceCalls {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    typealias ServiceResult = (Data) -> Void
    
    func fetchBookSearch(url: URL, completion: @escaping ServiceResult) {
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            defer {
                self.dataTask = nil
            }
            
            if let error = error {
                print(error.localizedDescription)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                
                DispatchQueue.main.async {
                    completion(data)
                }
            }
            
        }
        
        dataTask?.resume()
    }
}
