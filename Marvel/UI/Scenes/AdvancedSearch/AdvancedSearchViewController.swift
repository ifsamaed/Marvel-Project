//
//  AdvancedSearchViewController.swift
//  Marvel
//
//  Created by Margaret López Calderón on 25/8/21.
//

import UIKit

protocol AdvancedSearchViewProtocol: AnyObject {
    
}

protocol AdvancedSearchDelegate: AnyObject {
    func search(name: String?, nameStartWithLabel: String?, comics: Int?)
    func showAllCharacters()
}

class AdvancedSearchViewController: UIViewController, AdvancedSearchViewProtocol {

    @IBOutlet weak var searchTitleLabel: UILabel! {
        didSet {
            self.searchTitleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            self.searchTitleLabel.text =
                "AdvancedSearchViewController.title.label".localized
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            self.nameLabel.font =  UIFont.systemFont(ofSize: 20, weight: .medium)
            self.nameLabel.text = "AdvancedSearchViewController.name.label".localized
        }
    }
    @IBOutlet weak var nameStartWithLabel: UILabel! {
        didSet {
            self.nameStartWithLabel.font =  UIFont.systemFont(ofSize: 20, weight: .medium)
            self.nameStartWithLabel.text = "AdvancedSearchViewController.name.start.with.label".localized
        }
    }
    @IBOutlet weak var comics: UILabel! {
        didSet {
            self.comics.font =  UIFont.systemFont(ofSize: 20, weight: .medium)
            self.comics.text = "AdvancedSearchViewController.comics".localized
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameStartWithTextField: UITextField!
    @IBOutlet weak var comicsTextField: UITextField! {
        didSet {
            comicsTextField.keyboardType = .numberPad
        }
    }
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            self.searchButton.layer.cornerRadius = 15.0
            self.searchButton.setTitle("search.button.title".localized, for: .normal)
            self.searchButton.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.8)
            self.searchButton.tintColor = .white
        }
    }
    
    @IBOutlet weak var showAllCharactersButton: UIButton! {
        didSet {
            self.showAllCharactersButton.layer.cornerRadius = 15.0
            self.showAllCharactersButton.setTitle("AdvancedSearchViewController.show.all.characters.button".localized, for: .normal)
            self.showAllCharactersButton.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
            self.showAllCharactersButton.tintColor = .white
        }
    }
    
    weak var delegate: AdvancedSearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private let presenter: AdvancedSearchPresenterProtocol
    
    init(presenter: AdvancedSearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "AdvancedSearchViewController", bundle: Bundle(for: AdvancedSearchViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hasSomeValue() -> Bool {
        return ([
            self.nameTextField.text,
            self.nameStartWithTextField.text,
            self.comicsTextField.text
        ] as [String?])
        .contains(where: { $0 != "" })
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
        if hasSomeValue() {
            self.dismiss(animated: true) {
                self.delegate?.search(name: self.nameTextField.text,
                                      nameStartWithLabel: self.nameStartWithTextField.text,
                                      comics: Int(self.comicsTextField.text ?? ""))
            }
        } else {
            self.showError("AdvancedSearchViewController.alert.description.empty.value".localized)
        }
    }
    
    @IBAction func didTapShowALL(_ sender: Any) {
        self.presenter.didTapClose()
    }

    func showError(_ error: String) {
        let alert = UIAlertController(title: "AdvancedSearchViewController.alert.title.empty.value".localized,
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "AdvancedSearchViewController.alert.accept".localized, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
