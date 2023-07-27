//
//  BookTableViewCell.swift
//  Library
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
    static let identifier = "bookCell"
    
    func configureCell(viewModel: BookCellViewModel) {
        self.textLabel?.text = viewModel.bookTitle
        self.detailTextLabel?.text = "Author: " + viewModel.authorName + "\nFirst Published: " + viewModel.firstPublished
    }
}
