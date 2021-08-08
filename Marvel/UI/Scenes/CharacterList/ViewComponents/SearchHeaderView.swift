//
//  SearchHeaderView.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//


import UIKit

protocol SearchResultsDelegate: AnyObject {
    func updateSearchResults(_ searchText: String)
}

class SearchHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var moreButton: UIButton! {
        didSet {
            moreButton.setImage(UIImage(systemName: "plus"), for: .normal)
            moreButton.setImage(UIImage(systemName: "minus"), for: .selected)
        }
    }
    
    weak var delegate: SearchResultsDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        self.layer.backgroundColor = UIColor.white.withAlphaComponent(0.9).cgColor
    }
    
    func configureView() {
        self.searchBar.placeholder = "Filter by Name"
        self.searchBar.delegate = self
    }
    
    @IBAction func didTapOnMoreButton(_ sender: Any) {

    }
    
}

extension SearchHeaderView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.delegate?.updateSearchResults(searchText)
    }
}
