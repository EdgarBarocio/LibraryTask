//
//  JsonSerializerTests.swift
//  LibraryTests
//
//  Created by Edgar Barocio on 7/28/23.
//

import XCTest
@testable import Library

final class SerializerTests: XCTestCase {
    
    var sut: JsonSerializer?
    
    override func setUpWithError() throws {
        sut = JsonSerializer()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_JSONSerializer_CorrectJson() throws {
        
        let correctData = fetchSuccessJson()
        
        let evaluation = sut?.serializeResponse(response: correctData)
        XCTAssertNotNil(evaluation, "Empty json should return data")
        XCTAssertEqual(1, evaluation?.count, "Evaluation should have one element")
    }
    
    func fetchSuccessJson() -> Data {
        let json = """
        {
        "numFound": 810,
        "start": 0,
        "numFoundExact": true,
        "docs": [ {
            "title": "The Lord of the Rings",
            "author_name": [
                            "J.R.R. Tolkien"
                            ],
            "first_publish_year": 1954
            }],
        "num_found": 810,
        "q": "the lord of the rings",
        "offset": null
        }
        """
        
        let data = Data(json.utf8)
        return data
    }
}
