//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Margaret López Calderón on 5/8/21.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterImage: UIImageView! {
        didSet {
            characterImage.clipsToBounds = true
            characterImage.layer.cornerRadius = 10
            characterImage.contentMode = .scaleToFill
        }
    }
    @IBOutlet weak var containerDetailCharacterView: UIView! {
        didSet {
            containerDetailCharacterView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            containerDetailCharacterView.clipsToBounds = true
            containerDetailCharacterView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var characterName: UILabel! {
        didSet {
            characterName.numberOfLines = 2
            characterName.font = UIFont.boldSystemFont(ofSize: 18)
            characterName.textColor = .white
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var viewModel: CharacterRepresentableViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImage.image = nil
        characterImage.cancelImageLoad()
        spinner.isHidden = true
    }
    
    func configure(_ viewModel: CharacterRepresentableViewModel) {
        self.viewModel = viewModel
        characterImage.image = viewModel.image
        characterName.text = viewModel.name
        if viewModel.image == nil {
            loadImage()
        }
    }
    
    func loadImage() {
        spinner.startAnimating()
        spinner.isHidden = false
        guard let viewModel = viewModel,
              let url = viewModel.url else { return }
        characterImage.loadImage(at: url as URL, for: viewModel) { [weak self] in
            self?.spinner.stopAnimating()
            self?.spinner.isHidden = true
        }
    }

}
