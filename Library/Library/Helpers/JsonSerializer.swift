//
//  JsonSerializer.swift
//  Library
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

class JsonSerializer {
    
    func serializeResponse(response: Data) -> [BookModel.Docs]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(BookModel.self, from: response)
            return decoded.docs
        } catch {
            print("Failed to decode JSON")
            return nil
        }
    }
}
