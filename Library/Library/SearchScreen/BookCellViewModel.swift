//
//  BookCellViewModel.swift
//  Library
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

class BookCellViewModel {
    var bookTitle: String
    var authorName: String
    var firstPublished: String
    
    init(bookTitle: String, authorName: String, firstPublished: String) {
        self.bookTitle = bookTitle
        self.authorName = authorName
        if firstPublished == "0" {
            self.firstPublished = "No PUBLICATON YEAR AVAILABLE"
        } else {
            self.firstPublished = firstPublished
        }
        
    }
}
