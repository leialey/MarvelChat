//
//  AnswerCollectionViewCell.swift
//  MarvelChat
//
//  Created by Leialey on 28.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var answerButton: UIButton!
    var sendAnswer: ((String)->())?
    
    var answerData: Message? {
        didSet {
            answerButton.setTitle(answerData?.text, for: .normal)
        }
    }
    
    @IBAction func sendAnswer(_ sender: UIButton) {
        let message = sender.titleLabel?.text ?? ""
        sendAnswer?(message)
    }
}
