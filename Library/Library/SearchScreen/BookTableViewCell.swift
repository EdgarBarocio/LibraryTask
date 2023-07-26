//
//  BookTableViewCell.swift
//  Library
//
//  Created by Edgar Barocio on 7/26/23.
//

import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
    
    func configure(viewModel: BookCellViewModel) {
        
        self.textLabel?.text = viewModel.bookTitle
        self.detailTextLabel?.text = viewModel.authorName + " published: " + viewModel.firstPublished
        
        
    }
}
