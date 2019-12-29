//
//  CharacterTableViewCell.swift
//  MarvelChat
//
//  Created by Leialey on 27.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import AlamofireImage

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    private let placeholderImage = UIImage(named: "alien")
    
    var characterData: Character? {
        didSet {
            if characterData == nil {
                characterName.text = nil
                characterImage.image = nil
                self.loadingIndicator.isHidden = false
                self.loadingIndicator.startAnimating()
                return
            }
            
            if let url = characterData?.imageURL {
                characterImage.af_setImage(withURL: url, placeholderImage: placeholderImage, imageTransition: .crossDissolve(0.2))
            } else {
                characterImage.image = placeholderImage
            }
            characterName.text = characterData?.name
            self.loadingIndicator.stopAnimating()
        }
    }
}
