//
//  SearchViewModelTests.swift
//  SearchViewModelTests
//
//  Created by Edgar Barocio on 7/22/23.
//

import XCTest
@testable import Library

final class SearchViewModelTests: XCTestCase {

    var mockServices: MockServiceCalls?
    var sut: SearchViewModel?
    
    var showLoadingCalled: Bool = false
    var dismissLoadingCalled: Bool = false
    var getSearchResultsCalled: Bool = false
    var showErrorCalled: Bool = false
    var showSearchErrorCalled: Bool = false
    
    override func setUpWithError() throws {
        mockServices = MockServiceCalls()
        sut = SearchViewModel(serviceCalls: mockServices!)
        setupCallbacks()
    }
    
    override func tearDownWithError() throws{
        mockServices = nil
        sut = nil
    }
    
    func setupCallbacks() {
        self.sut?.showLoading = { [weak self] in
            guard let self = self else { return }
            
            self.showLoadingCalled = true
        }
        
        self.sut?.dismissLoading = { [weak self] in
            guard let self = self else { return }
            
            self.dismissLoadingCalled = true
        }
        
        self.sut?.didGetSearchResults = { [weak self] _ in
            guard let self = self else { return }
            
            self.getSearchResultsCalled = true
        }
        
        self.sut?.showConnectionError = { [weak self] _ in
            guard let self = self else { return }
            
            self.showSearchErrorCalled = true
        }
        
        self.sut?.showGenericError = { [weak self] _ in
            guard let self = self else { return }
            
            self.showErrorCalled = true
        }
    }

    func test_StocksViewModel_shouldHaveInfo() async throws {
        // setting up expectation
        let dataLoadedExpectation = expectation(description: "Data fetched")
        
        // simulating the enviornment
        mockServices?.error = nil
        
        let json = """
        {
            "docs": []
        }
        """
        let data = Data(json.utf8)
        mockServices?.data = data
        
        sut?.fetchBookSearch(searchTerm: "Cthulhu")
        sleep(5)
        dataLoadedExpectation.fulfill()
        
        XCTAssertTrue(self.showLoadingCalled, "Should have hit the loading callback")
        XCTAssertTrue(self.dismissLoadingCalled, "Should have hit the dismiss loading callback")
        XCTAssertTrue(self.getSearchResultsCalled, "Should have hit the success callback")
        XCTAssertFalse(self.showErrorCalled, "Should not have hit the error callback")
        XCTAssertFalse(self.showSearchErrorCalled, "Should not have hit the error callback")
        
        await fulfillment(of: [dataLoadedExpectation],timeout: 15, enforceOrder: true)
    }
    
    func test_StocksViewModel_failedFetch() async throws {
        // setting up expectation
        let errorOccuredExpectation = expectation(description: "Service Error")
        
        // simulating the enviornment
        mockServices?.error = MockServiceError.invalidResponse
        mockServices?.data = nil
        
        sut?.fetchBookSearch(searchTerm: "Cthulhu")
        sleep(5)
        errorOccuredExpectation.fulfill()
        
        XCTAssertTrue(self.showLoadingCalled, "Should have hit the loading callback")
        XCTAssertTrue(self.dismissLoadingCalled, "Should have hit the dismiss loading callback")
        XCTAssertFalse(self.getSearchResultsCalled, "Should not have hit the success callback")
        XCTAssertFalse(self.showErrorCalled, "Should have hit the error callback")
        XCTAssertTrue(self.showSearchErrorCalled, "Should have hit the error callback")
       
        await fulfillment(of: [errorOccuredExpectation],timeout: 15, enforceOrder: true)
    }
}
