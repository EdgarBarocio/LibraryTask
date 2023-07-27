//
//  BookTableViewCell.swift
//  Library
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
    
    func configureCell(viewModel: BookCellViewModel) {
        
        self.textLabel?.text = viewModel.bookTitle
        self.textLabel?.numberOfLines = 0
        
        self.detailTextLabel?.text = "Author: " + viewModel.authorName + "\nFirst Published: " + viewModel.firstPublished
        self.detailTextLabel?.numberOfLines = 0
        
    }
}
