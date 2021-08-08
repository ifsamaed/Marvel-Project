//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import UIKit


protocol CharacterViewUpdatable: AnyObject {
    func loadedImage(fetchedItem: CharacterRepresentableViewModel, image: UIImage)
}

protocol CharacterListViewProtocol: AnyObject {
    func showCharacters(_ viewModels: [CharacterRepresentableViewModel])
    func appendNewCharacters(_ characters: [CharacterRepresentableViewModel])
}

class CharacterListViewController: UITableViewController, CharacterListViewProtocol {
    
    // MARK: - Value Types
    typealias DataSource = UITableViewDiffableDataSource<CharactersSection, CharacterRepresentableViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CharactersSection, CharacterRepresentableViewModel>
    
    private var tableViewDataSource: DataSource?
    private let presenter: CharacterListPresenterProtocol
    private var characters: [CharacterRepresentableViewModel] = []
    private var filterCharacters: [CharacterRepresentableViewModel] = []
    private var isFilteringEnable = false
    private var isFetchingMore: Bool = false
    
    enum Section: Int {
        case character = 0
    }
    
    init(presenter: CharacterListPresenterProtocol) {
        self.presenter = presenter
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.loadDataSource()
        self.presenter.viewDidLoad()
    }
    
    func showCharacters(_ viewModels: [CharacterRepresentableViewModel]) {
        self.characters = viewModels
        self.updateDataSource(animatingDifferences: false)
    }
    
    func appendNewCharacters(_ characters: [CharacterRepresentableViewModel]) {
        self.characters.append(contentsOf: characters)
        self.isFetchingMore = false
        self.updateDataSource(animatingDifferences: false)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchHeaderView") as? SearchHeaderView
        view?.delegate = self
        view?.configureView()
        return view
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            if !isFetchingMore && !isFilteringEnable {
                self.beginBatchFetch()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCharacters =  self.tableViewDataSource?.itemIdentifier(for: indexPath) else { return }
        self.presenter.didTapCharacter(selectedCharacters)
    }
}

private extension CharacterListViewController {
    func loadDataSource() {
        self.tableViewDataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            if self.isFilteringEnable {
                guard self.filterCharacters.indices.contains(indexPath.row) else { return UITableViewCell() }
                cell.configure(self.filterCharacters[indexPath.row])
            } else {
                cell.configure(self.characters[indexPath.row])
            }
            cell.loadImage()
            return cell
        })
    }
    
    func updateDataSource(_ characters: [CharacterRepresentableViewModel]) {
        var snapShot = Snapshot()
        snapShot.appendSections([.main])
        snapShot.appendItems(characters)
        self.tableViewDataSource?.apply(snapShot, animatingDifferences: false)
    }
    
    func updateDataSource(animatingDifferences: Bool) {
        var snapShot = Snapshot()
        snapShot.appendSections([.main])
        snapShot.appendItems(characters)
        self.tableViewDataSource?.apply(snapShot, animatingDifferences: animatingDifferences)
    }
    
}

private extension CharacterListViewController {
    func beginBatchFetch() {
        self.isFetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.presenter.loadMoreCharacters()
        }
    }
    
    func registerCells() {
        self.tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        self.tableView.register(UINib(nibName: "SearchHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchHeaderView")
        self.tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "LoadingTableViewCell")
    }
    
    func configureTableView() {
        self.registerCells()
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear
    }
}

extension CharacterListViewController: CharacterViewUpdatable {
    func loadedImage(fetchedItem: CharacterRepresentableViewModel, image: UIImage) {
        if fetchedItem.image != image && !isFilteringEnable {
            if var updatedSnapshot = self.tableViewDataSource?.snapshot(),
               let datasourceIndex = updatedSnapshot.indexOfItem(fetchedItem),
               self.characters.indices.contains(datasourceIndex) {
                let character = self.characters[datasourceIndex]
                character.image = image
                updatedSnapshot.reloadItems([character])
                self.tableViewDataSource?.apply(updatedSnapshot, animatingDifferences: false)
                
            }
        }
    }
}

extension CharacterListViewController: SearchResultsDelegate {
    func updateSearchResults(_ searchText: String) {
        guard !searchText.isEmpty else {
            self.isFilteringEnable = false
            self.updateDataSource(characters)
            self.tableView.scrollToTop(animated: true)
            return
        }
        self.filterCharacters = self.characters.filter { $0.name.contains(searchText) }
        self.isFilteringEnable = true
        self.updateDataSource(filterCharacters)
        self.tableView.scrollToTop(animated: true)
    }
}

private extension UITableView {
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func scrollToTop(animated: Bool) {
        let indexPath = IndexPath(row: 0, section: 0)
        if self.hasRowAtIndexPath(indexPath: indexPath) {
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
}
