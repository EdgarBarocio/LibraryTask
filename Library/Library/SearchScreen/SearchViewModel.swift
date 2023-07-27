//
//  SearchViewModel.swift
//  Library
//
//  Created by Edgar Barocio on 7/23/23.
//

import Foundation

class SearchViewModel {
    private var serviceCalls: ServiceCalls
    
    var showLoading: (() -> Void)?
    var dismissLoading: (() -> Void)?
    var showConnectionError: ((String) -> Void)?
    var showGenericError: ((String) -> Void)?
    var didGetSearchResults: (([BookModel.Docs]) -> Void)?
    
    init(serviceCalls: ServiceCalls) {
        self.serviceCalls = serviceCalls
    }
    
    private func searchParameterEncoding(search: String) -> URL? {
        let encodedString = search.replacingOccurrences(of: " ", with: "+")
        let urlString = String(format: NetworkConstants.titleSearchURL, encodedString)
        
        return URL(string: urlString)
    }
    
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
    
    func returnFailedSearch(errorString: String) {
        self.showGenericError?(errorString)
    }
    
    func parseResults(resultsData: Data) {
        let serializer = JsonSerializer()
        
        if let result = serializer.serializeResponse(response: resultsData) {
            self.didGetSearchResults?(result)
        } else {
            self.returnFailedSearch(errorString: "No results found")
        }
    }
}
