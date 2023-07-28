//
//  BlockCellViewModelTests.swift
//  LibraryTests
//
//  Created by Edgar Barocio on 7/28/23.
//

import XCTest
@testable import Library

final class BookCellViewModelTests: XCTestCase {
    
    var sut: BookCellViewModel?
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_ViewModelInit_ShouldHaveAllValue() {
        sut = BookCellViewModel(bookTitle: "The Book's Title",
                                authorName: "The one true author",
                                firstPublished: 2077)
        
        
        XCTAssertNotNil(sut?.bookTitle, "Title should have a value")
        XCTAssertNotNil(sut?.authorName, "Author Name should have a value")
        XCTAssertNotNil(sut?.firstPublished, "Year published should have a value")
    }
}
