//
//  ViewController.swift
//  Library
//
//  Created by Edgar Barocio on 7/22/23.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
      var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
      return recognizer
    }()
    
    private var searchResults: [BookModel.Docs] = [BookModel.Docs]()
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
        setupCallbacks()
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    @objc func dismissKeyboard() {
      searchField.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        search(entry: searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
      view.removeGestureRecognizer(tapRecognizer)
    }
    
    func search(entry: String) {
        viewModel?.fetchBookSearch(searchTerm: entry)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BookTableViewCell(style: .subtitle, reuseIdentifier: "bookCell")
        
        let cellModel = BookCellViewModel(bookTitle: self.searchResults[indexPath.row].title ?? "NO TITLE AVAILABLE",
                                          authorName: self.searchResults[indexPath.row].author?.first ?? "NO AUTHOR AVAILABLE",
                                          firstPublished: String(self.searchResults[indexPath.row].published ?? 0))
        
        cell.configureCell(viewModel: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
}

private extension SearchViewController {
    
    func setupCallbacks() {
        self.viewModel?.showLoading = { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.startAnimating()
            self.activityIndicator.isHidden = false
        }
        
        self.viewModel?.dismissLoading = { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
        
        self.viewModel?.didGetSearchResults = { [weak self] results in
            guard let self = self else { return }
            
            self.searchResults = results
            self.tableView.reloadData()
        }
        
        self.viewModel?.showConnectionError = { [weak self] errorMessage in
            guard let self = self else { return }
            self.buildAlert(errorMessage)
        }
        
        self.viewModel?.showGenericError = { [weak self] errorMessage in
            guard let self = self else { return }
            self.buildAlert(errorMessage)
        }
    }
    
    private func buildAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok",
            style: .default,
            handler: nil)

        alertController.addAction(actionOk)

        self.present(alertController, animated: true, completion: nil)
    }
}
