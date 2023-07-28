//
//  BookTableViewCell.swift
//  Library
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation
import UIKit

/// Class for BookTalbeViewCell. Shows the information of the search result
/// Formatted as a Cell with Title and Subtitle
class BookTableViewCell: UITableViewCell {
    static let identifier = "bookCell"
    
    /**
    Function that updates the table view cell with the searched Book information
     
     - Parameters:
        - viewModel: The BookCellViewModel containing all the info to display. Book title, the Author's name and the
                    firt year of publication
     */
    func configureCell(viewModel: BookCellViewModel) {
        self.textLabel?.text = viewModel.bookTitle
        self.detailTextLabel?.text = "Author: " + viewModel.authorName + "\nFirst Published: " + viewModel.firstPublished
    }
}
