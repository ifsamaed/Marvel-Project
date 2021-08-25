//
//  LoadingTableViewCell.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import UIKit

class LoadingTableViewCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        spinner.startAnimating()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinner.startAnimating()
        contentView.backgroundColor = .white
    }    
}
