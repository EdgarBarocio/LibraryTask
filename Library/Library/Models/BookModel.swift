//
//  BookModel.swift
//  Library
//
//  Created by Edgar Barocio on 7/23/23.
//

import Foundation

struct BookModel: Codable {
    struct Docs: Codable {
        var title: String?
        var author: [String]?
        var published: Int?
        
        enum CodingKeys: String, CodingKey {
            case title
            case author = "author_name"
            case published = "first_publish_year"
        }
    }
    
    var docs: [Docs]
}

