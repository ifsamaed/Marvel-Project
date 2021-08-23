//
//  AdvancedSearch.swift
//  Marvel
//
//  Created by Margaret López Calderón on 14/8/21.
//

import UIKit


class AdvancedSearch: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = "No favourite found"
        return cell
    }
}

private extension AdvancedSearch {
    func configureTableView() {
        
    }
}
