//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import UIKit

protocol CharacterDetailViewProtocol: AnyObject {
    func show(_ viewModel: CharacterRepresentableViewModel)
}

class CharacterDetailViewController: UIViewController, CharacterDetailViewProtocol, UITableViewDelegate {
    
    @IBOutlet weak var characterImage: UIImageView! {
        didSet {
            self.characterImage.contentMode = .scaleAspectFill
            let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapImage))
             tap.numberOfTapsRequired = 2
            self.characterImage.addGestureRecognizer(tap)
            self.characterImage.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var heartButton: UIButton! {
        didSet {
            self.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heartForegroundImage: UIImageView! {
        didSet {
            self.heartForegroundImage.tintColor = .white
            self.heartForegroundImage.alpha = 0.0
            self.heartForegroundImage.layer.shadowColor = UIColor.black.cgColor
            self.heartForegroundImage.layer.shadowOpacity = 0.5
            self.heartForegroundImage.layer.shadowOffset = .zero
            self.heartForegroundImage.layer.shadowRadius = 5
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.separatorStyle = .none
            
        }
    }
    
    private var tableViewData = [[String]] ()
    private var hiddenSections = Set<Int>()
    private let presenter: CharacterDetailPresenterProtocol
    private var viewModel: CharacterRepresentableViewModel?
    
    enum SectionTable: Int {
        case comics
        case series
        case events
        
        func getTitle() -> String {
            switch self {
            case .comics: return "Comics"
            case .series: return "Series"
            case .events: return "Events"
            }
        }
    }
    init(presenter: CharacterDetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "CharacterDetailViewController", bundle: Bundle(for: CharacterDetailViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    func show(_ viewModel: CharacterRepresentableViewModel) {
        self.viewModel = viewModel
        self.characterImage.image = viewModel.image
        self.nameLabel.text = viewModel.name
        self.descriptionLabel.text = viewModel.description
        self.tableViewData.append(contentsOf:
                                    [viewModel.comics,
                                     viewModel.series,
                                     viewModel.events])
        self.heartButton.isSelected = viewModel.isFavourite
        self.tableView.reloadData()
    }
    
    @IBAction func didTapHeart(_ sender: Any) {
        self.heartButton.isSelected.toggle()
        self.updateFavourite()
    }
}

extension CharacterDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        
        return self.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionTable = SectionTable(rawValue: section) else { return UIView() }
        let sectionButton = UIButton()
        sectionButton.setTitle(String(sectionTable.getTitle() + " #\(self.tableViewData[section].count)"),
                               for: .normal)
        sectionButton.backgroundColor = .systemBlue
        sectionButton.tag = section
        sectionButton.addTarget(self,
                                action: #selector(self.hideSection(sender:)),
                                for: .touchUpInside)
        return sectionButton
    }
}

private extension CharacterDetailViewController {
    @objc
    func hideSection(sender: UIButton)  {
        let section = sender.tag
        var indexPath: [IndexPath] {
            var indexPaths = [IndexPath]()
            for row in 0 ..< self.tableViewData[section].count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.tableView.insertRows(at: indexPath, with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.tableView.deleteRows(at: indexPath, with: .fade)
        }
    }
    
    @objc
    func doubleTapImage() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.2, options: .allowUserInteraction, animations: {
            self.heartForegroundImage.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            self.heartForegroundImage.alpha = 1.0
        }) { finished in
            self.heartForegroundImage.alpha = 0.0
            self.heartForegroundImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        self.heartButton.isSelected.toggle()
        self.updateFavourite()
    }
    
    func updateFavourite() {
        self.viewModel?.isFavourite =  heartButton.isSelected
        self.presenter.saveFavourite(isFavourite: heartButton.isSelected)
    }
}
