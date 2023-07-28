//
//  JsonSerializer.swift
//  Library
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

class JsonSerializer {
    
    /**
    Function that reads the service response, serializes it usion JSONDecoder and creates an array of BookModel.Docs
     
     - Parameters:
        - response: Data representing the service response
     - Returns: Optional BookModel array.
     */
    func serializeResponse(response: Data) -> [BookModel.Docs]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(BookModel.self, from: response)
            return decoded.docs
        } catch {
            print(error)
            print(error.localizedDescription)
            return nil
        }
    }
}
