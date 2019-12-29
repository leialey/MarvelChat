//
//  ChatMessage.swift
//  MarvelChat
//
//  Created by Leialey on 27.12.2019.
//  Copyright © 2019 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import RealmSwift

class ChatMessage: Object {
    @objc dynamic var characterID : Int = 0
    @objc dynamic var message: String = ""
    @objc dynamic var date = Date()
    @objc dynamic var isUser: Bool = false
    
    convenience init(character: Character, message: String, isUser: Bool) {
        self.init()
        self.characterID = character.id
        self.message = message
        self.isUser = isUser
    }
}
