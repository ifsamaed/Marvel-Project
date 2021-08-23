//
//  FavouriteCharacterTableViewController.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import UIKit

protocol FavouriteCharacterViewProtocol: AnyObject {
    func showCharacters(_ characters: [FavouriteCharacterRepresentableViewModel])
    func updateDeleteCharacter(_ characters: [FavouriteCharacterRepresentableViewModel], index: IndexPath)
    func showError(_ error: String)
}

final class FavouriteCharacterTableViewController: UITableViewController, FavouriteCharacterViewProtocol {
    private var characters: [FavouriteCharacterRepresentableViewModel] = []
    private let presenter: FavouriteCharacterPresenterProtocol
    
    init(presenter: FavouriteCharacterPresenterProtocol) {
        self.presenter = presenter
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
    
    func showCharacters(_ characters: [FavouriteCharacterRepresentableViewModel]) {
        self.characters = characters
        self.tableView.reloadData()
    }

    func updateDeleteCharacter(_ characters: [FavouriteCharacterRepresentableViewModel], index: IndexPath) {
        self.characters = characters
        self.tableView.deleteRows(at: [index], with: .automatic)
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.isEmpty ? 0 : self.characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if characters.isEmpty {
            cell.textLabel?.text = "No favourite found"
        } else {
            cell.imageView?.image = UIImage(data: characters[indexPath.row].image ?? Data())
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 3
            cell.textLabel?.text = characters[indexPath.row].name
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && self.characters.indices.contains(indexPath.row) {
            self.presenter.removeFavourite(indexPath)
      }
    }
    
}

private extension FavouriteCharacterTableViewController {
    func configureTableView() {
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .none
    }
}
