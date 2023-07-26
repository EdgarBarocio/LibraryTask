//
//  SearchViewModel.swift
//  Library
//
//  Created by Edgar Barocio on 7/23/23.
//

import Foundation

class SearchViewModel {
    private var serviceCalls: ServiceCalls
    
    init(serviceCalls: ServiceCalls) {
        self.serviceCalls = serviceCalls
    }
    
    func fetchBookSearch(urlString: String) {
        
        guard let url = URL(string: urlString) else {
            self.returnFailedSearch(errorString: "Bad search term, please try again")
            return
        }
        
        serviceCalls.fetchBookSearch(url: url) { [weak self] data in
            guard let self = self else { return }
            
            self.parseResults(resultsData: data)
        }
    }
    
    func returnFailedSearch(errorString: String) {
        
    }
    
    func parseResults(resultsData: Data) {
        let serializer = JsonSerializer()
        
        let result = serializer.serializeResponse(response: resultsData)
    }
}
