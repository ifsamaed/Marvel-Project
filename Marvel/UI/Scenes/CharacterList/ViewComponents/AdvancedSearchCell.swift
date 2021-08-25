//
//  AdvancedSearchCell.swift
//  Marvel
//
//  Created by Margaret López Calderón on 15/8/21.
//

import UIKit

struct AdvancedSearchViewModel: Hashable {
    let id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class AdvancedSearchCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
