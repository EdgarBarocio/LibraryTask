//
//  ViewController.swift
//  Library
//
//  Created by Edgar Barocio on 7/22/23.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var SearchField: UITextField!
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var searchResults: [BookModel] = [BookModel]()
    private var viewModel:SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "bookCell")
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Welcome to the Library"
        
        viewModel = SearchViewModel(serviceCalls: ServiceCalls())
        
        viewModel?.fetchBookSearch(urlString: "https://openlibrary.org/search.json?title=the+lord+of+the+rings")
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BookTableViewCell(style: .subtitle, reuseIdentifier: "bookCell")
        
        let tempModel = BookCellViewModel(bookTitle: "Placeholder Title",
                                          authorName: "Me",
                                          firstPublished: "2023")
        cell.configure(viewModel: tempModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
}

