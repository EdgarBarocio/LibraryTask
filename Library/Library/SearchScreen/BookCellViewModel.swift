//
//  BookCellViewModel.swift
//  Library
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation

/// Class for The BookCellViewModel, formatting for TableView cell presentation
class BookCellViewModel {
    var bookTitle: String
    var authorName: String
    var firstPublished: String
    
    init(bookTitle: String, authorName: String, firstPublished: Int) {
        self.bookTitle = bookTitle
        self.authorName = authorName
        if firstPublished == 0 {
            self.firstPublished = "NO PUBLICATON YEAR AVAILABLE"
        } else {
            self.firstPublished = String(firstPublished)
        }
        
    }
}
