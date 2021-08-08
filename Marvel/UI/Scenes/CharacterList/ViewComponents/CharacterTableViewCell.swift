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
            self.characterImage.clipsToBounds = true
            self.characterImage.layer.cornerRadius = 10
            self.characterImage.contentMode = .scaleToFill
        }
    }
    @IBOutlet weak var containerDetailCharacterView: UIView! {
        didSet {
            self.containerDetailCharacterView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.containerDetailCharacterView.clipsToBounds = true
            self.containerDetailCharacterView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var characterName: UILabel! {
        didSet {
            self.characterName.numberOfLines = 2
            self.characterName.font = UIFont.boldSystemFont(ofSize: 18)
            self.characterName.textColor = .white
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var viewModel: CharacterRepresentableViewModel?
    weak var delegate: CharacterViewUpdatable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ viewModel: CharacterRepresentableViewModel) {
        self.viewModel = viewModel
        self.characterImage.image = viewModel.image
        self.characterName.text = viewModel.name
        if viewModel.image == nil {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }
    
    func loadImage() {
        guard let viewModel = self.viewModel,
              let url = viewModel.url else { return }
        ImageDataRepository.shared.load(url: url, item: viewModel) { fetchedItem, image in
            if let img = image, img != fetchedItem.image {
                self.delegate?.loadedImage(fetchedItem: fetchedItem, image: img)
            }
        }
    }
    
    func showImage(_ image: UIImage) {
        self.characterImage.image = image
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
    }
}

private extension CharacterTableViewCell {
    
}
