//
//  MessageTableViewCell.swift
//  MarvelChat
//
//  Created by Leialey on 27.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import AlamofireImage

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var message: UILabel!
    private let placeholderImage = UIImage(named: "alien")
    private var character: Character?
    private var messageData: ChatMessage? {
        didSet {
            message.text = messageData?.message
        }
    }
    
    func setup(character: Character?, messageData: ChatMessage?)  {
        self.character = character
        self.messageData = messageData
        setupCell(for: messageData?.isUser ?? false)
    }
    
    private func setupCell(for isUser: Bool) {
        if isUser == true {
            self.backgroundColor = UIColor.white
            message.textAlignment = .right
            self.avatar.image = nil
            self.layer.borderWidth = 0
        } else {
            self.backgroundColor = UIColor.red
            message.textAlignment = .left
            self.layer.borderWidth = 5
            self.layer.borderColor = UIColor.red.cgColor
            if let url = character?.imageURL {
                avatar.af_setImage(withURL: url, placeholderImage: self.placeholderImage)
            } else {
                avatar.image = self.placeholderImage
            }
        }
    }
    
    
}
