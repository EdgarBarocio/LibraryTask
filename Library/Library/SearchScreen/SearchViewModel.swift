//
//  SearchViewModel.swift
//  Library
//
//  Created by Edgar Barocio on 7/23/23.
//

import Foundation

/// View Model class for Search View Controller.
/// This formats the search term, calls the data parser and sends and sends it or sends error mesages for the
/// View Controller to display
class SearchViewModel {
    private var serviceCalls: ServiceProtocol
    
    /// closured used as callbacks of the view controller
    var showLoading: (() -> Void)?
    var dismissLoading: (() -> Void)?
    var showConnectionError: ((String) -> Void)?
    var showGenericError: ((String) -> Void)?
    var didGetSearchResults: (([BookModel.Docs]) -> Void)?
    
    init(serviceCalls: ServiceProtocol = ServiceCalls()) {
        self.serviceCalls = serviceCalls
    }
    
    /**
     Function that uses the services to perform a search of a book by title.
     Builds the search URL from the title typed on the Search Bar in the View Controller
     Uses the fetched info to decide if it calls the error message generator or the json serializer for data formatting.
     */
    func fetchBookSearch(searchTerm: String) {
        
        guard let url = searchParameterEncoding(search: searchTerm) else {
            self.showGenericError?("Invalid Search, please re-type your search")
            return
        }
        
        self.showLoading?()
        serviceCalls.fetchBookSearch(url: url) { [weak self] data, error  in
            guard let self = self else { return }
            self.dismissLoading?()
            if let data = data {
                self.parseResults(resultsData: data)
            }
            
            if let error = error {
                self.showConnectionError?(error.localizedDescription)
            }
        }
    }
   
    // MARK: - Private Functions
    /**
    Private function that generates the search URL. Replaces spaces with "+" signs
     
     - Parameters:
        - search: The Search term from the View controller
     - Returns:
        - URL: Optional url from the search term and the base url hosted on NetworkConstants
     */
    private func searchParameterEncoding(search: String) -> URL? {
        let encodedString = search.replacingOccurrences(of: " ", with: "+")
        let urlString = String(format: NetworkConstants.titleSearchURL, encodedString)
        
        return URL(string: urlString)
    }
    
    /**
    Private function that sends an error message to the View Controller
     
     - Parameters:
        - errorString: Error message to be displayed on the Callback
     */
    private func returnFailedSearch(errorString: String) {
        self.showGenericError?(errorString)
    }
    
    /**
    Private function that generates the Model objects from the fetched data. This then sends the parsed response or
     an error message
     
     - Parameters:
        - resultData: Data containing the service response
     - Returns:
     */
    private func parseResults(resultsData: Data) {
        let serializer = JsonSerializer()
        
        if let result = serializer.serializeResponse(response: resultsData) {
            self.didGetSearchResults?(result)
        } else {
            self.returnFailedSearch(errorString: "No results found")
        }
    }
}
